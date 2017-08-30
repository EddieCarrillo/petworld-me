//
//  PetWorldTests.swift
//  PetWorldTests
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest

@testable import PetWorld

class PetWorldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserToJson(){
        let user = User(username: "Eddstah", email: "eddstah@hotmail.com", password: "pass")
      let data =  user.toJson()
       
        
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
            let username: String = jsonBody["username"] as! String
            let password: String = jsonBody["password"] as! String
            let email : String = jsonBody["email"] as! String
            XCTAssert(username == "Eddstah")
            XCTAssert(password == "pass")
            XCTAssert(email == "eddstah@hotmail.com")
        }else{
            XCTFail("Json body is nil")
        }
        
        
        
       
        
        //Data should not be nil
        XCTAssert(data != nil)
    
    }
    
    
    
    func testSignUp(){
        let expecting = expectation(description: "Should return a token after call")
        
        let user = User(username: "Eddstah", email: "eddstah@hotmail.com", password: "pass")
        
        UserAPI.signUp(new: user) { (token: String?, error: Error?) in
            
            if let token = token{
            }else if let error = error{
                XCTFail()
            }else {
                XCTFail()
            }
            
            expecting.fulfill()
        }
        
        
        waitForExpectations(timeout: 100) { (error: Error?) in
            if let error = error{
                 XCTFail("Took to long errors fam \(error)")
            }
        }
    
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
    
    func testPerformanceExample() {}
    
    
}
