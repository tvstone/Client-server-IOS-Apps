//
//  friend.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import SwiftyJSON

        struct Friend {


//            let response : String
            let items  :[String]
//            let count : Int
 //           let id       : String
            let firstName: String
            let lastName : String
            let avatarStr : String
           

            init(json: SwiftyJSON.JSON) {

  //              self.response = json["response"].stringValue ?? ""
                self.items = [json["items"].stringValue]
    //            self.count = json["count"].intValue
    //            self.id = json["items"]["id"].stringValue
                self.firstName = json["items"]["first_name"].stringValue
                self.lastName = json["items"]["last_name"].stringValue
                self.avatarStr = json["items"]["photo_200_orig"].string ?? ""


        }
   }



