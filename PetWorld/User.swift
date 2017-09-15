//
//  User.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/26/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject {
    
   static  let auth_token_key = "auth_token"
    static var current: User?
    
    
    var username: String?
    
    var email: String?
    //Not super secure TODO: Fix this security issue
    var password: String?
    
    var objectId: String?
    
    var loggedIn: Bool = false
    
    
    
    
    
    init(username: String, email: String, password: String){
        self.username = username
        self.email = email
        self.password = password
    }
    
    init (jsonMap: [String: Any]){
        
        print("JSON: \(jsonMap)")
        if let username = jsonMap["username"] {
            self.username = username as? String
        }
        
        if let password = jsonMap["password"]{
            self.password = password as? String
        }
        
        if let email = jsonMap["email"]{
            self.email = email as? String
        }
        
        if let objectId = jsonMap["_id"]{
            self.objectId = objectId as? String
        }
    }
    
    
    
    func toJson() -> Data?{
        
        let dictionary =  ["username": self.username, "email": self.email, "password": self.password ]
        
        
        do{
            let jsonString: Data =  try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonString
        }catch{
        
            print("JSON processing failed")
            return nil
        }
     
    }
    
    //TODO: Finish login
    func login(){
        
        
    }
    
    
    
    
    
    
    
   
    
  
}
