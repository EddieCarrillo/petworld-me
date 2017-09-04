//
//  AuthAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//


import UIKit


class AuthAPI{
    
    static var path = "/auth"
    static var postMethod = "POST"
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    

    
   class func login(username: String, password: String, onFinished: @escaping (String?, Error?) -> Void){
        let url = "\(NetworkAPI.authBaseUrl)/login"
        var user = User(username: username, email: "", password: password)
    guard let userJsonBody = user.toJson() else{
        onFinished(nil, NSError(domain: "Trouble serializing json", code: 404, userInfo: [:]))
        return;
    }
    
    GeneralNetworkAPI.post(urlString: url, requestBody: userJsonBody, token: nil) { (data: Data?, error: Error?) in
        if let error = error{
             onFinished(nil, error)
        }else if let data = data {
            var jsonBody: [String: Any]?
            do{
                
                jsonBody = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            }catch{
                onFinished(nil, NSError(domain: "Could not deserialize json", code: 404, userInfo: nil))
                
            }
            
            if let jsonBody = jsonBody{
                var token = jsonBody["token"] as? String
                onFinished(token, nil)
            }else {
                onFinished(nil, NSError(domain: "Could not deserialize json", code: 404, userInfo: nil) )
            }
        }
    }
   
    
    
    
    }

}

