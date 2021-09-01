//
//  RealmNews.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 29.08.2021.
//

import Foundation
import RealmSwift

final class RealmNews: Object  {

    @objc dynamic var idGroup = String()
    @objc dynamic var textNews = String()
    @objc dynamic var imageNews = String()


    convenience init(idGroup : String, textNews : String, imageNews : String) {
        self.init()
        self.idGroup = idGroup
        self.textNews = textNews
        self.imageNews = imageNews

    }

//override class func primaryKey () -> String?{
//    return "idGroup"
//}
}
