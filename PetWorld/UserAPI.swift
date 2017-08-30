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
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: url!)
        var requestUserBody = user.toJson()
        print("json string: \(requestUserBody)")
        
        urlRequest.httpMethod = postMethod
        urlRequest.addValue(applicationJson, forHTTPHeaderField: contentType)
        
        if let jsonBody = requestUserBody{
            urlRequest.httpBody = jsonBody
            print(urlRequest)
        }
        
        
        print("Task to be called!")
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error :Error?) in
            
            if let error = error{
                print("Error")
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                
                print("RESPONSE: \(response)")
                let code = response.statusCode
                if (code != 200 && code != 201){
                    let error = NSError(domain: "Bad request", code: code, userInfo: nil)
                    onFinished(nil, error)
                }else if let data = data{
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
        
        task.resume()
        
        
        
        

}







}











