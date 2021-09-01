//
//  NetworkNews.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 29.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkNews {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForNews = "method/wall.get"
    private var newsFoto = [String]()
    private var url = String()
    private var text = String()


    func pingMyNews(idGroup : String) {

        let parametersListPhotosFriend : Parameters = [
            "owner_id" : "-\(idGroup)",
            "count" : "3",
            "access_token" : token,
            "v" : "5.131"
        ]
        AF.request(scheme + host + pathForNews ,
                   method: .get,
                   parameters: parametersListPhotosFriend).responseJSON { [weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                        let items = clearJsonFriendFotos["response"]["items"].arrayValue

                        for i in 0 ..< items.count {
                            let text1 = items[i]["text"].stringValue
                            let text2 = items[i]["attachments"]["title"].stringValue
                            if text1 != "" {
                                self.text = text1
                            } else {self.text = text2}
                            let attachments = items[i]["attachments"].arrayValue
                            let count = attachments.count

                            for j in 0 ..< count{
                                let size = attachments[j]["photo"]["sizes"].arrayValue
                                let size2 = attachments[j]["video"]["image"].arrayValue

                                if size != [] {
                                    guard let urlNews = size.last?["url"].stringValue else {return}
                                    self.url = urlNews
                                }
                                else {
                                    guard let urlNews = size2.last?["url"].stringValue else {return}
                                    self.url = urlNews
                                }
                                self.saveMyNewsToRealm(idGroup: idGroup, foto: self.url, text: self.text)
                            }
                        }
                    }
            }
    }

    func saveMyNewsToRealm (idGroup : String, foto : String, text : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadNewsInRealm = RealmNews(idGroup: idGroup, textNews: text, imageNews: foto)
            
            realm.add(loadNewsInRealm)
            realm.refresh()

            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func deleteMyNewsToRealm (remainingGroupsId : [String]){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let delNewsInRealm = realm.objects(RealmNews.self)
                realm.delete(delNewsInRealm)
            for i in 0 ..< remainingGroupsId.count {
                pingMyNews(idGroup: remainingGroupsId[i])
            }
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }


}

