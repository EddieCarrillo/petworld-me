//
//  PetsAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation


class PetsAPI{
    
    static var path = "/pets"
    static var getMethod = "GET"
    static var postMethod = "POST"
    
    
    
   class func getPets(onFinished: @escaping ([Pet]? ,Error?) -> Void){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = getMethod
    
    let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error :Error?) in
        if let error = error{
             onFinished(nil, error)
        }else if let response = response{
            let response = response as! HTTPURLResponse
            let statusCode = response.statusCode
            if (statusCode != 200 && statusCode != 201){
                 onFinished(nil, NSError(domain: "Bad request", code: statusCode, userInfo: nil))
            }else if let data = data {
                
                var jsonBody: [[String: Any]]?
                do{
                    jsonBody = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    
                }catch{
                    onFinished(nil, NSError(domain: "Trouble deserializing data", code: 404, userInfo: nil))
                }
                
                if let jsonBody = jsonBody{
                    var pets: [Pet] = []
                    for object in jsonBody{
                        var pet = Pet(jsonMap: object)
                        pets.append(pet)
                    }
                    
                    onFinished(pets, nil)
                }else{
                    onFinished(nil, NSError(domain: "Trouble deserializing data", code: 404, userInfo: nil) )
                }
            }
        }
    }
    
    task.resume()
    
 }
    
    class func getPet(with id: String, onFinished: @escaping (Pet? ,Error?) -> Void){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)/\(id)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = getMethod
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error :Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                let statusCode = response.statusCode
                if (statusCode != 200 && statusCode != 201){
                    onFinished(nil, NSError(domain: "Bad request", code: statusCode, userInfo: nil))
                }else if let data = data {
                    
                    var jsonBody: [String: Any]?
                    do{
                        jsonBody = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                    }catch{
                        onFinished(nil, NSError(domain: "Trouble deserializing data", code: 404, userInfo: nil))
                    }
                    
                    if let jsonBody = jsonBody{
                        var pet: Pet = Pet(jsonMap: jsonBody)
                        onFinished(pet, nil)
                    }else{
                        onFinished(nil, NSError(domain: "Trouble deserializing data", code: 404, userInfo: nil) )
                    }
                }
            }
        }
        
        task.resume()
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



}
