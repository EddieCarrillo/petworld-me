//
//  PetTests.swift
//  PetWorld
//
//  Created by my mac on 8/30/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld
import UIKit

class PetTests: XCTestCase {
    
    
    var authToken: String?
    
    override func setUp() {
        super.setUp()
        var expecting = expectation(description: "To return an auth token")
        
        
        let username = "JonRogawski"
        let password = "Mathprof123"
        AuthAPI.login(username: username, password: password) { (token:
            String?, error:Error?) in
            if let error = error {
                print(error)
            }else if let token = token{
                self.authToken = token
                expecting.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 10, handler: { (error: Error?) in
            if let error = error{
                print("Request timed out")
            }
        })
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetPets(){
        let expecting = expectation(description: "Should return a list of pets after call")
        
        
        PetsAPI.getPets { (pets: [Pet]?, error: Error?) in
            
            if let error = error{
                print(error)
                XCTFail("Trouble getting posts")
            }else if let pets = pets{
                //Pets were returned (not a failure)
                
            }else{
                XCTFail("No pets returned")
            }
            
            expecting.fulfill()
            
        }
        
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error{
                XCTFail("Took to long errors fam \(error)")
            }
        }
    }
    
    
    
    func testGetPetWithId(){
        let lemonId = "59a4890ab3b81f130414779b"
        let expecting = expectation(description: "Should return a pet object with a given id")
        PetsAPI.getPet(with: lemonId) { (pet: Pet?, error: Error?) in
            
            if let error = error{
                print(error)
                XCTFail("Trouble getting posts")
            }else if let pet = pet{
                //Pets were returned (not a failure)
                if let name = pet.name{
                    print("name: \(name)")
                }
                
            }else{
                XCTFail("No pets returned")
            }
            
            expecting.fulfill()
        }
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error{
                XCTFail("Took to long errors fam \(error)")
            }
        }
    }
    
    func testPetToJson(){
        let name = "ChickenFace"
        let ownerId = "BlahBlah"
        var pet = Pet(name: name, ownerId: ownerId)
       var data =  pet.toJson()
        
        var jsonBody: [String: Any]?
        do{
            if let data = data {
                jsonBody = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
            }else {
                XCTFail("Bad data")
            }
            
        }catch{
            XCTFail("bad json string")
            
        }
        
        if let jsonBody = jsonBody{
            print("jsonbody: \(jsonBody)")
            let extractedName: String = jsonBody["name"] as! String
            let extractedId: String = jsonBody["owner"] as! String
            XCTAssert(name == extractedName )
            XCTAssert(ownerId == extractedId)
           
        }else{
            XCTFail("Json body is nil")
        }
        
        
        
        
        
    }
    
    func testPutPetWithId(){
        let expecting = expectation(description: "Should return a change the  object with a given id")
        
        //Change pet name from Lemon -> SimonLimon on the server
        let pet = Pet(name: "SimonLimon", ownerId: "59a48909b3b81f1304147798")
        pet.objectId = "59a4890ab3b81f130414779b"
        
        
        
        if let token = authToken{
            print("token: \(token)")
            PetsAPI.put(pet: pet, withId: pet.objectId!, token: token, onFinished: { (pet: Pet?, error: Error?) in
                if let pet = pet{
                    if pet.name == "SimonLimon"{
                        expecting.fulfill()
                    }else {
                         XCTFail("Did not change pet name")
                    }
                }
            })
        }else {
            XCTFail("No token")
        }
        
        
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error{
                XCTFail("Took to long errors fam \(error)")
            }
        }
        
        
        
    }
    
    
    
    func testPostCreatePets(){
        let expecting = expectation(description: "Should returned newly created pet resource.")
        
        //Change pet name from Lemon -> SimonLimon on the server
        let chicken = Pet(name: "chicken", ownerId: "59a48909b3b81f1304147798") //JonRogawski
      
        
        
        
        if let token = authToken{
            print("token: \(token)")
            PetsAPI.postCreate(newPet: chicken, token: token) { (pet: Pet?, error: Error?) in
                if let error = error{
                    XCTFail("\(error.localizedDescription)")
                }else if let pet = pet{
                    expecting.fulfill()
                }else{
                    XCTFail("Some failure")
                }
            }
        
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error{
                XCTFail("Took to long errors fam \(error)")
            }
        }
        
    
    
    }
    
}

}
