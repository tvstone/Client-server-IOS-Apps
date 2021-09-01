//
//  NewsViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 06.07.2021.
//

import UIKit
import RealmSwift

final class NewsViewController: UIViewController {    
    
    @IBOutlet var newsTableView: UITableView!
    
    private let newsTableCellIdentifire = "newsTableCellIdentifire"
    private let networkNews = NetworkNews()
    private var newsModel = NewsModel()
    private var newsChangedToken : NotificationToken?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "NewsTableCell", bundle: nil),
                               forCellReuseIdentifier: newsTableCellIdentifire)
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        newsTableView.reloadData()

        do {
            let realm = try Realm()
            let news = realm.objects(RealmNews.self)
            newsChangedToken = news.observe { chenge  in
                switch chenge{
                case .initial(let initial):
                print(initial)
                case .update(let resoults, let deletions, let insertions, let modifications):
                    print(resoults,deletions, insertions, modifications)
                case .error( let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        newsModel.newsArray = [News]()
        newsModel.setupNews()
        if newsModel.newsArray.isEmpty { navigationItem.title = "Выберите группы"}
        else {navigationItem.title = "Новости"}
        newsTableView.reloadData()

    }

    override func viewDidAppear(_ animated: Bool) {
        newsTableView.reloadData()
    }
}



extension NewsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableCellIdentifire,
                                                       for: indexPath ) as? NewsTableCell
                                                       else { return UITableViewCell()}
        cell.config(meNews: newsModel.newsArray[indexPath.row])
      
        return cell
    }
    
    
    
}

