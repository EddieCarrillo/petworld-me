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
    var username: String?
    var email: String?
    var objectId: String?
    
    
    
    
    init(username: String, email: String){
        self.username = username
        self.email = email
    }
    
    
    
    func toJson(with password: String) -> Data?{
        
       
        var dictionary = ["username": self.username, "email": email, "password": password ]
        
        print("transfer to json: \(dictionary)")
        
        
        do{
            
            
            let jsonString: Data =  try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            print(jsonString)
            return jsonString
        }catch{
        
            print("JSON processing failed")
            return nil
        }
        
           
        
        
        
    }
    
    
    
    
    
    
    
   
    
  
}
