//
//  realm.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 15.08.2021.
//

import UIKit
import RealmSwift

class RealmDatabase: RealmSwift.Object  {
//    @objc dynamic var id = ""
    @objc dynamic var friendName = String() //[String]()
    @objc dynamic var avatar = String()

    convenience init(friendName : String, avatar : String) {
        self.init()
        self.friendName = friendName
        self.avatar = avatar

    }


}
