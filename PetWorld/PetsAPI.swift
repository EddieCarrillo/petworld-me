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
    
    
    
<<<<<<< HEAD
    class func getPets(queryParams: Query?, onFinished: @escaping ([Pet]? ,Error?) -> Void){
        GeneralNetworkAPI.get(urlString: "\(NetworkAPI.apiBaseUrl)\(path)", token: nil, queryParams: queryParams) { (data: Data?, error: Error?) in
=======
    class func getPets(onFinished: @escaping ([Pet]? ,Error?) -> Void){
        GeneralNetworkAPI.get(urlString: "\(NetworkAPI.apiBaseUrl)\(path)", token: nil) { (data: Data?, error: Error?) in
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
            if let error = error {
                onFinished(nil, error)
            }else if let data = data{
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
    
    
    
    ////////////////////////
   
    
    
<<<<<<< HEAD
=======
    //Params
    //owner - ID of the owner
    class func getPets(from owner: String, onFinished: @escaping (Pet?, Error?) -> Void ){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)")
    
    }
    
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
    
    
    class func getPet(with id: String, onFinished: @escaping (Pet? ,Error?) -> Void){
<<<<<<< HEAD
        let url = "\(NetworkAPI.apiBaseUrl)\(path)/id/\(id)"
        GeneralNetworkAPI.get(urlString: url, token: nil, queryParams: nil) { (data: Data?, error: Error?) in
=======
        let url = "\(NetworkAPI.apiBaseUrl)\(path)/\(id)"
        GeneralNetworkAPI.get(urlString: url, token: nil) { (data: Data?, error: Error?) in
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
            if let error = error {
                onFinished(nil, error)
            }else if let data = data{
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
    
    
    
    class func put(pet: Pet, withId: String, token: String, onFinished: @escaping (Pet?, Error?) -> Void){
        
<<<<<<< HEAD
        let url = "\(NetworkAPI.apiBaseUrl)\(path)/id/\(withId)"
=======
        let url = "\(NetworkAPI.apiBaseUrl)\(path)/\(withId)"
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
        guard let jsonPetBody = pet.toJson() else {
            onFinished(nil, NSError(domain: "Trouble parsing json", code: 404, userInfo: nil))
            return;
        }
        
        GeneralNetworkAPI.put(urlString: url, requestBody: jsonPetBody, token: token) { (data: Data?, error: Error?) in
            if let error = error{
                onFinished(nil, error)
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
            }
        }
        
    }
    
    class func postCreate(newPet: Pet, token: String, onFinished: @escaping (Pet?, Error?) -> Void){
        let url = "\(NetworkAPI.apiBaseUrl)\(path)"
        guard let petJsonBody = newPet.toJson() else {
            onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
            return;
        }
        GeneralNetworkAPI.post(urlString: url, requestBody: petJsonBody, token: token) { (data: Data?, error: Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let data = data {
                var newJsonPet: [String: Any]?
                
                do{
                    newJsonPet = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                }catch{
                    onFinished(nil, NSError(domain: "Bad request", code: 404, userInfo: nil))
                }
                
                if let newJsonPet = newJsonPet{
                    onFinished(Pet(jsonMap: newJsonPet), nil)
                }else {
                    onFinished(nil, NSError(domain: "Bad request", code: 404, userInfo: nil))
                }

            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    



}
