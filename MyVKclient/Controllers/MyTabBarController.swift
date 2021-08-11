//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit

class MyTabBarController: UITabBarController {

    func  setupFriend() -> [friend] {
        var itogArray = [friend]()
   
        
        let firstFotoArray = [UIImage(named: "1_1")!, UIImage(named: "1_2")!, UIImage(named: "1_3")!, UIImage(named: "1_4")!, UIImage(named: "1_5")!]
        let firstFriend = friend(nameFriend: "Сергей Иванов", fotoArrayFriend: firstFotoArray, avaFriend: UIImage(named: "1_1")!)
        itogArray.append(firstFriend)
    
        let secondFotoArray = [UIImage(named: "2_1")!, UIImage(named: "2_2")!, UIImage(named: "2_3")!, UIImage(named: "2_4")!, UIImage(named: "2_5")!]
        let secondFriend = friend(nameFriend: "Андрей Тихонов", fotoArrayFriend: secondFotoArray, avaFriend: UIImage(named: "2_1")!)
        itogArray.append(secondFriend)
        
        let thirdFotoArray = [UIImage(named: "3_1")!, UIImage(named: "3_2")!, UIImage(named: "3_3")!, UIImage(named: "3_4")!, UIImage(named: "3_5")!]
        let thirdFriend = friend(nameFriend: "Антон Гришин", fotoArrayFriend: thirdFotoArray, avaFriend: UIImage(named: "3_1")!)
        itogArray.append(thirdFriend)
        
        let fourthFotoArray = [UIImage(named: "4_1")!, UIImage(named: "4_2")!, UIImage(named: "4_3")!, UIImage(named: "4_4")!, UIImage(named: "4_5")!]
        let fourthFriend = friend(nameFriend: "Иван Петров", fotoArrayFriend: fourthFotoArray, avaFriend: UIImage(named: "4_1")!)
        itogArray.append(fourthFriend)
        
        let fifthFotoArray = [UIImage(named: "5_1")!, UIImage(named: "5_2")!, UIImage(named: "5_3")!, UIImage(named: "5_4")!, UIImage(named: "5_5")!]
        let fifthFriend = friend(nameFriend: "Константин Серов", fotoArrayFriend: fifthFotoArray, avaFriend: UIImage(named: "5_1")!)
        itogArray.append(fifthFriend)
        
        
        return itogArray
    }
    
    
//    func  setupGroup() -> [groupFriends] {
//        var itogArray = [groupFriends]()
//   
//        
//        
//        let firstGroup = groupFriends(titleGroup: "Близкие друзья", avaGroup: UIImage(named: "1_3")!, variableDescriptionGroup: "Одноклассники")
//        itogArray.append(firstGroup)
//    
//        let secondGroup = groupFriends(titleGroup: "Товарищи", avaGroup: UIImage(named: "1_4")!, variableDescriptionGroup: "Одноклассники")
//        itogArray.append(secondGroup)
//        
//        return itogArray
//    }
//    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myFriendNavigationController = self.viewControllers?.first as? UINavigationController,
              let friendViewController = myFriendNavigationController.viewControllers.first as? MyFriendsViewController
              else {return}

        friendViewController.config(userArray: setupFriend())
      
        
 //       guard let groupNavigationController = self.viewControllers?[1] as? UINavigationController,
 //             let groupViewController = groupNavigationController.viewControllers.first as? groupViewController
 //             else {return}
        
    }
    

  

}
