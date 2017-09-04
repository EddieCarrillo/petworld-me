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
    
    
   
    
}
