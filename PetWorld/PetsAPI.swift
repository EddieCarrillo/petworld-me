//
//  PetsAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation


class PetsAPI{
    
    static var path: String = "/pets"
    static var getMethod: String = "GET"
    static var postMethod: String = "POST"
    static var putMethod: String = "PUT"
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let authorization = "Authorization"
    static let bearer = "Bearer "
    
    
    
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
    
    
    
    class func put(pet: Pet, withId: String, token: String, onFinished: @escaping (Pet?, Error?) -> Void){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)/\(withId)")!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        var jsonPetBody = pet.toJson()
        request.addValue(applicationJson, forHTTPHeaderField: contentType)
        request.addValue("\(bearer)\(token)", forHTTPHeaderField: authorization)
        
        request.httpMethod = "PUT"
        request.httpBody = jsonPetBody
        
    
        
        
        print("REQUEST: \(request)")
        
        
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                if let response = response{
                    print("ERROR RESPONSE: \(response)")
                }
                onFinished(nil, error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                print("RESPONSE: \(response)")
                let statusCode = response.statusCode
                if (statusCode != 200 && statusCode != 201){
                    print("Bad response, withCode:  \(statusCode)")
                    onFinished(nil, NSError(domain: "Bad response", code: 404, userInfo: nil))
                }else if let data = data{
                    var petBody: [String: Any]?
                    do {
                        petBody = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    }catch{
                        onFinished(nil,NSError(domain: "Couldnt deserialize json", code: 404, userInfo: nil) )
                    }
                    if let petBody = petBody{
                        print("PETBODY: \(petBody)")
                        let pet = Pet(jsonMap: petBody)
                        onFinished(pet, nil)
                    }else{
                        onFinished(nil, NSError(domain: "Couldnt deserialize json", code: 404, userInfo: nil))
                    }
                    
                }else{
                    onFinished(nil, NSError(domain: "Bad response", code: 404, userInfo: nil))
                }
            }
        }
        
        task.resume()
        
        
    
    }
    
    
    
    
    
    
    
    
    
    
    



}
