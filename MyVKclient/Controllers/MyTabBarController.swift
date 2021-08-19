//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class MyTabBarController: UITabBarController {

    private let network = NetworkLayer()
    private let realm = try! Realm()
    private var itemsRealm : Results<RealmDatabase>!
//    private var arrayFriend = [String]()

    func  setupFriend() -> [User] {

        var itogArray = [User]()

        itemsRealm = realm.objects(RealmDatabase.self)
        let count = itemsRealm.count

        for i in 0 ..< count {
            let name = itemsRealm[i].friendName
            let ava = itemsRealm[i].avatar
            let friend = User(nameFriend: name, avaFriend: ava) 
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

        guard let myFriendNavigationController = self.viewControllers?.first as? UINavigationController,
              let friendViewController = myFriendNavigationController.viewControllers.first as? MyFriendsViewController
        else {return}
        friendViewController.config(userArray: setupFriend())



    }

}

