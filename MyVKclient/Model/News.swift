//
//  news.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 04.07.2021.
//


import UIKit
import RealmSwift

struct News{
    var titleNews : String
    var imageNews : String
}

final class NewsModel {
    public var newsArray = [News]()
    private var news : Results<RealmNews>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    init() {
        setupNews()
    }

    func setupNews() {

        news = realm.objects(RealmNews.self)

        for i in 0 ..< news.count {

            let textNews = news[i].textNews
            let imageNews = news[i].imageNews
            let newNews = News(titleNews: textNews, imageNews: imageNews)
            newsArray.append(newNews)
        }
        
        



    }
}

