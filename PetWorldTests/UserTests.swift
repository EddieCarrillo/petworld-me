//
//  UserTests.swift
//  PetWorld
//
//  Created by my mac on 8/30/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld

class UserTests: XCTestCase {
    
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
    
  
}
