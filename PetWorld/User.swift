//
//  User.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/26/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Foundation
import Parse

class User: NSObject {
    
   static  let auth_token_key = "auth_token"
    static var current: User?
    var username: String
    var email: String
    //Not super secure TODO: Fix this security issue
    var password: String
    
    var objectId: String?
    
    
    
    
    
    init(username: String, email: String, password: String){
        self.username = username
        self.email = email
        self.password = password
    }
    
    
    
    func toJson() -> Data?{
        
       
        let dictionary = ["username": self.username, "email": self.email, "password": self.password ]
        
        do{
            let jsonString: Data =  try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return jsonString
        }catch{
        
            print("JSON processing failed")
            return nil
        }
        
           
        
        
        
    }
    
    
    
    
    
    
    
   
    
  
}
