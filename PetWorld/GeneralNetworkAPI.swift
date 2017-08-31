//
//  GeneralNetworkAPI.swift
//  PetWorld
//
//  Created by my mac on 8/31/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation


class GeneralNetworkAPI{
    
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let authorization = "Authorization"
    static let bearer = "Bearer "
    
   class func get(urlString: String, token: String?, onFinished: @escaping (Data?, Error?) -> Void){
        guard let url = URL(string: urlString) else {
            onFinished(nil, NSError(domain: "Bad URL", code: 404, userInfo: nil))
            return;
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        //If we are trying to access protected resource
        
        if let token = token{
            request.setValue( "\(bearer)\(token)", forHTTPHeaderField: authorization)
        }
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                let code = response.statusCode
                if (code != 200 && code != 201){
                    onFinished(nil, error)
                }else if let data = data{
                    onFinished(data, nil)
                }
            }
        }
        
        task.resume()
        
    
    }
    
    class func post(urlString: String, requestBody: Data, token: String?,  onFinished: @escaping (Data?, Error?) -> Void){
         putOrPost(httpMethod: "POST", urlString: urlString, requestBody: requestBody, token: token, onFinished: onFinished)
    
    }
    
    class func put(urlString: String, requestBody: Data, token: String?,  onFinished: @escaping (Data?, Error?) -> Void){
        putOrPost(httpMethod: "PUT", urlString: urlString, requestBody: requestBody, token: token, onFinished: onFinished)
        
    }
    
    
    
    class func putOrPost(httpMethod: String, urlString: String, requestBody: Data, token: String?,  onFinished: @escaping (Data?, Error?) -> Void){
        guard let url = URL(string: urlString) else {
            onFinished(nil, NSError(domain: "Bad URL", code: 404, userInfo: nil))
            return;
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = httpMethod
        request.httpBody = requestBody
        //Sending json body
        request.setValue(applicationJson, forHTTPHeaderField: contentType)
        
        
        
        //If resource is protected
        if let token = token{
            request.setValue( "\(bearer)\(token)", forHTTPHeaderField: authorization)
        }
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                let code = response.statusCode
                if (code != 200 && code != 201){
                    onFinished(nil, error)
                }else if let data = data{
                    onFinished(data, nil)
                }
            }
        }
        
        task.resume()
        
        
        
        
        
    
    }


}
