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
    
    class func get(urlString: String, token: String?, queryParams: Query?, onFinished: @escaping (Data?, Error?) -> Void){
        
        guard var urlComponents: URLComponents = URLComponents(string: urlString) else {
            onFinished(nil, NSError(domain: "Bad URL", code: 404, userInfo: nil))
            return;
        }
        
        if let query = queryParams {
            urlComponents.queryItems = query.createQuery()
        }
       
        guard let url = urlComponents.url else {
            onFinished(nil, NSError(domain: "Bad URL", code: 404, userInfo: nil))
            return;
        }
        
 
//    
//    var queryParams: [String: String]?
//    if let queryParams = queryParams{
//        let queryString = createQueryString(queryParams: queryParams)
//        urlString = "\(urlString)\(queryString) "
//    }
       
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
              //  print("response: \(response)")
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
    
    
    
   private class func putOrPost(httpMethod: String, urlString: String, requestBody: Data, token: String?,  onFinished: @escaping (Data?, Error?) -> Void){
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
    
    
     
     class func createQueryString(queryParams: [String: String]) -> String{
        //Start of query
       var queryString = "?"
        for (key, value) in queryParams{
            //?key1=value&key2=value2&key3=value3
            queryString = "\(queryString)\(key)=\(value)&"
            print("queryString: \(queryString)")
        }
        print("size: \(queryString.characters.count)")
        print("endIndex \(queryString)" )
        //Remove the ampersand at the end
        queryString = queryString.substring(to: queryString.index(before: queryString.endIndex))
        
        return queryString
    }
    
    


}




