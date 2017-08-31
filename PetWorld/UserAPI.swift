//
//  UserAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation


class UserAPI{
    
    
   static var postMethod = "POST"
    
    static let path = "/users"
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
   
    
    
    class func signUp(new user: User, onFinished: @escaping (String?,Error? ) -> Void){
        let url =  "\(NetworkAPI.apiBaseUrl)\(path)"
        guard var requestUserBody = user.toJson() else {
            onFinished(nil, NSError(domain: "Could not deserialize json", code: 404, userInfo: nil))
            return;
        }
        GeneralNetworkAPI.post(urlString: url, requestBody: requestUserBody, token: nil) { (data: Data?, error: Error?) in
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











