//
//  NetworkLayer.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 10.08.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import RealmSwift

class NetworkLayer {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForFriends = "method/friends.get"
    private let url = "https://api.vk.com/method/friends.get"
    private let realm = try! Realm()
    private var dataRealm = RealmDatabase()
    private var countRealmBase = 0
    private var allBase = [String]()

    func pingMyFriends(){

        let parameters: Parameters = [
            "user_id": id,
            "fields": "nickname,photo_200_orig",
            "order": "name",
            "count": "20",
            "access_token" : token,
            "v" : "5.131"
        ]
        AF.request(scheme + host + pathForFriends , method: .get, parameters: parameters).responseJSON { [self] response in

            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let clearJson = JSON(rawValue: data) else {return}
                let items = clearJson["response"]["items"].arrayValue
                let countItems = items.count
                countRealmBase = countItems

                for i in 0 ..< countItems {

                    let firstName = items[i]["first_name"].stringValue
                    let lastName = items[i]["last_name"].stringValue
                    let friendName = firstName + " " + lastName
                    let avatar = items[i]["photo_200_orig"].stringValue
                    saveFriensToRealm(friendName: friendName, avatar: avatar)
                }
            }
        }

    }


    func saveFriensToRealm (friendName name: String, avatar ava : String) {

        do {
            let realm = try Realm()
            realm.beginWrite()
            let loadFriendsInRealm = RealmDatabase(friendName: name, avatar: ava)
            realm.add(loadFriendsInRealm)
            realm.refresh()
            try realm.commitWrite()

        } catch {
            print(error)
        }


    }


//
//    func pingMyGroup() {
//
//        let parameters: Parameters = [
//            "user_id": id,
//            "extended": "1",
//            "count": "10",
//            "access_token" : token,
//            "v" : "5.131"
//        ]
//        let pathForGroups = "method/groups.get"
//
//        AF.request(scheme + host + pathForGroups , method: .get, parameters: parameters).responseJSON { response in
//            switch response.result {
//            case .failure(let error):
//                print(error)
//            case .success(let json):
//                print(json)
//            }
//        }
//
//    }

}


public extension Array where Element: Hashable{
    func  uniquid() -> [Element] {
        var seen = Set<Element>()
        return filter {seen.insert($0).inserted}
    }
}


