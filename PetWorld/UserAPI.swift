//
//  UserAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation


class UserAPI{
    
    
    var username: String?
    var email: String?
    
    let path = "/users"
   
    
    
    class func signUp(new user: User, password: String, onFinished: @escaping (String?,Error? ) -> Void){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)/(path)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlRequest = URLRequest(url: url!)
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error :Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                print("RESPONSE: \(response)")
                let code = response.statusCode
                if (code != 200 || code != 201){
                    let error = NSError(domain: "Bad request", code: code, userInfo: nil)
                    onFinished(nil, error)
                }else if let data = data{
                    let token = String.init(data: data, encoding: String.Encoding.utf8)
                    onFinished(token, nil)
                }
        }
        
    
    }
        
        
        
        

}







}











