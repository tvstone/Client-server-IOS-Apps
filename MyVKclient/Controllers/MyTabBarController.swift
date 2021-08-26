//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift
import Kingfisher

final class MyTabBarController: UITabBarController {

    private let network = NetworkLayer()

    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var itemsRealm : Results<RealmDatabase>!
    private var fotosRealm : Results<Fotos>!
    private var arrayFriend = [String]()
    private var likes = [String]()


    func  setupFriend() -> [User] {
        var itogArray = [User]()
        itemsRealm = realm.objects(RealmDatabase.self)
        fotosRealm = realm.objects(Fotos.self)
        let count = itemsRealm.count
        for i in 0 ..< count {

            let name = itemsRealm[i].friendName
            let ava = itemsRealm[i].avatar

            arrayFriend = [String]()
            likes = [String]()

            for j in 0 ..< fotosRealm.count{
                let fot = fotosRealm [j].allFotosOfFriend
                let like = fotosRealm[j].like
                if itemsRealm[i].idFriend == fotosRealm[j].idFriend {
          //          let like = fotosRealm[j].like
                    arrayFriend.append(fot)
                    likes.append(like)
                }
            }
            let friend = User(nameFriend: name, avaFriend: ava, fotos: arrayFriend, like: likes)
            itogArray.append(friend)
        }
        itogArray = Array(Set(itogArray))

                try! realm.write({
                    realm.deleteAll()
                    realm.refresh()
                })
        return itogArray
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        network.pingMyFriends()
        print(realm.configuration.fileURL)


        guard let myFriendNavigationController = self.viewControllers?.first as? UINavigationController,
              let friendViewController = myFriendNavigationController.viewControllers.first as? MyFriendsViewController
        else {return}
        friendViewController.config(userArray: setupFriend())
        
    }
}

