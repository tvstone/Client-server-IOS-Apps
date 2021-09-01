//
//  friend.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import Foundation
import SwiftyJSON

        struct Friend {


//            let response : String
            let items  :[String]
  //          let countOfFriend : Int
            let idFriend  : String
            let firstName: String
            let lastName : String
            let avatarStr : String
           

            init(json: SwiftyJSON.JSON) {

  //              self.response = json["response"].stringValue ?? ""
                self.items = [json["items"].stringValue]
     //           self.countOfFriend = json["count"].intValue
                self.idFriend = json["items"]["id"].stringValue
                self.firstName = json["items"]["first_name"].stringValue
                self.lastName = json["items"]["last_name"].stringValue
                self.avatarStr = json["items"]["photo_200_orig"].string ?? ""


        }
   }



