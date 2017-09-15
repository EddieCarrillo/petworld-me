//
//  AuthTests.swift
//  PetWorld
//
//  Created by my mac on 8/30/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld


class AuthTests: XCTestCase {
    

    func testLogin(){
        let expecting = expectation(description: "Should return a login token")
        var username: String = "JonRogawski"
        var password: String = "Mathprof123"
        
        AuthAPI.login(username: username, password: password) { (token: String?, error: Error?) in
            if let error = error {
                XCTFail("[ERROR]: \(error.localizedDescription)")
            }else if let token = token{
                //Success retrieved token
                expecting.fulfill()
                print("Recieved token")
            }else {
                XCTFail("Trouble receiving token")
            }
        }
        
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error{
                 XCTFail("Request timed out")
            }
        }
    
    }
    
    
    func testCheckValidToken() {
          let expecting = expectation(description: "Should not return an error")
        
        AuthAPI.checkValid(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OWE0ODkwOWIzYjgxZjEzMDQxNDc3OTgiLCJpYXQiOjE1MDUxNjUwNjAsImV4cCI6MTUwNTc2OTg2MH0.qda__vQj_VSUdijTTa7o33LA7zI_EQFFYSVWwmefG6c") { (freshUser: User?, error: Error?) in
            if let error = error {
                XCTFail("[ERROR] \(error)")
            }else if let user = freshUser {
                expecting.fulfill()
            }else {
                XCTFail("Token is invalid")
            }
        }
        
        
        waitForExpectations(timeout: 4) { (error: Error?) in
            if let error = error {
                print("[ERROR]: \(error)")
            }
        }
    }
    
    
   
    
}
