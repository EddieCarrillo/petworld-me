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
    
    //Because
    func testToQueryString(){
        let queryParams: [String: String] = ["pet": "lammy", "owner": "Eddie", "size": "large"]
        let queryString =  Query.createQueryString(queryParams: queryParams)
        print("\(queryString)")
        
        XCTAssert(queryString == "?owner=Eddie&size=large&pet=lammy")
    
    }
    
    func testEncodeJson(){
        
        let dictionary: [String: Any] = ["where": ["owner": "59aef169256ec2132ea6a392"], "include": "owner"]
        
        var jsonString: String = Query.stringifyJSON(dictionary: dictionary)
        print("[jsonstring]: \(jsonString)")
        print("string length: \(jsonString.characters.count)")
        XCTAssert(jsonString ?? "bad " != "")
        
        
    }
    
    
    func testContainedInQuery(){
        
        let expecting = expectation(description: "Return all posts belonging to ")
        let query = Query()
        query.whereKey(key: "author", containedIn: ["59a4890ab3b81f130414779b"])
        PostsAPI.getPosts(query: query) { (posts:[Post]?, error: Error?) in
            if let error = error {
                XCTFail("[ERROR: \(error)]")
            }else if let posts = posts {
                print("posts: \(posts)")
                expecting.fulfill()
            }
        }
        
        
        waitForExpectations(timeout: 5) { (error: Error?) in
            print("[ERROR]: \(error)")
        }
    
        
    }
    
    
    
}



    

