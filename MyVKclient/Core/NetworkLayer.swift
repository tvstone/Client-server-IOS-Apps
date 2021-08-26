//
//  NetworkLayer.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 10.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkLayer {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForFriends = "method/friends.get"
    private let pathForFriendFoto = "method/photos.getAll"
    private var fotos = [String]()
    private var likesFriendFotoCount = String()
    private var friendsAll = [String]()

    func pingMyFriends(){

        let parametersListFriends: Parameters = [
            "user_id": id,
            "fields": "nickname,photo_200_orig",
            "order": "name",
            "count": "0",
            "access_token" : token,
            "v" : "5.131"
        ]
        AF.request(scheme + host + pathForFriends ,
                   method:.get,
                   parameters: parametersListFriends).responseJSON { [unowned self] response in

                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJson = JSON(rawValue: data) else {return}
                        let items = clearJson["response"]["items"].arrayValue
                        let countItems = items.count

                        for i in 0 ..< countItems {

                            let firstName = items[i]["first_name"].stringValue
                            let lastName = items[i]["last_name"].stringValue
                            let friendName = firstName + " " + lastName
                            let avatar = items[i]["photo_200_orig"].stringValue
                            let idFriend = items[i]["id"].stringValue
                            saveFriensToRealm(friendName: friendName, avatar: avatar, idFriend : idFriend)
                            friendsAll.append(idFriend)
                        }
                    }
                    pingMyFriendFotos()
                   }
    }


    func pingMyFriendFotos() -> [String] {

        for idFriend in friendsAll {

            usleep(400000)

            let parametersListPhotosFriend : Parameters = [
                "owner_id": idFriend, // id,
                "extended": "1",
                "no_service_albums": "0",
                "photo_sizes" : "0",
                "access_token" : token,
                "v" : "5.131"
            ]

            AF.request(scheme + host + pathForFriendFoto ,
                       method: .get,
                       parameters: parametersListPhotosFriend).responseJSON { response in
                        switch response.result {
                        case .failure(let error):
                            print(error)

                        case .success(let data):
                            print(data)
                            guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                            let items = clearJsonFriendFotos["response"]["items"].arrayValue
                            let countItemsFriendFotos = clearJsonFriendFotos["response"]["count"].intValue
                            let countFR = countItemsFriendFotos > 20 ? 20 : countItemsFriendFotos

                            for i in 0 ..< countFR {

                                let size = items[i]["sizes"].arrayValue
                                guard let url = size.last?["url"].stringValue else {return}
                                let idFoto = items[i]["id"].stringValue
                                let likeFoto = items[i]["likes"]["count"].stringValue
                                self.fotos.append(url)
                                self.saveFriendFotoToRealm(idFriend: idFriend,
                                                           foto: url,
                                                           idFoto: idFoto,
                                                           like: likeFoto )
                            }

                        }
                       }
        }
        return fotos
    }

    func saveFriensToRealm (friendName name: String, avatar ava : String, idFriend : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()

            let loadFriendsInRealm = RealmDatabase(friendName: name, avatar: ava, idFriend : idFriend)
            realm.add(loadFriendsInRealm, update: .modified)
            realm.refresh()
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func saveFriendFotoToRealm (idFriend : String, foto : String, idFoto : String, like : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()

            let loadFotosInRealm = Fotos(idFriend: idFriend, allFotosOfFriend: foto, idFoto: idFoto, like: like)
            realm.add(loadFotosInRealm, update: .modified)
            realm.refresh()
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
