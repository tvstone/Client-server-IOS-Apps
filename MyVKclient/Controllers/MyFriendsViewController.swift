//
//  MyFriendsViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit

class MyFriendsViewController: UIViewController {
    
   
    

    @IBOutlet weak var FriendsTableView: UITableView!
    
    
   let reuseIdentifireUniversalTableViewCell = "reuseIdentifireUniversalTableViewCell"
   let segueFriendsToFoto = "fromFriendsToFoto"
    
   
   var friendsArray = [friend]()
    
    func config(userArray:[friend]){
        
        self.friendsArray = userArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FriendsTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.FriendsTableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifireUniversalTableViewCell)
        
        FriendsTableView.delegate = self
        FriendsTableView.dataSource = self

    }
}

extension MyFriendsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifireUniversalTableViewCell, for: indexPath) as? UniversalTableViewCell else { return UITableViewCell()}
        
    //    cell.configureCell(title: friendsArray[indexPath.row].nameFriend, image: friendsArray[indexPath.row].avaFriend)
        
        cell.configureCell(user: friendsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == segueFriendsToFoto,
            let dst = segue.destination as? FotoController,
            let user = sender as? friend {
            dst.fotoArray = user.fotoArrayFriend
           
        }
 
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableViewCell,
              let cellObject = cell.saveObject as? friend
              else {return}
    performSegue(withIdentifier: segueFriendsToFoto, sender: cellObject)
    
    }
    
    
    
    
}
