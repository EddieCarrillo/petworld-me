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
    
    //Because
    func testToQueryString(){
        let queryParams: [String: String] = ["pet": "lammy", "owner": "Eddie", "size": "large"]
<<<<<<< HEAD
        let queryString =  Query.createQueryString(queryParams: queryParams)
=======
        let queryString =  GeneralNetworkAPI.createQueryString(queryParams: queryParams)
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
        print("\(queryString)")
        
        XCTAssert(queryString == "?owner=Eddie&size=large&pet=lammy")
    
    }
    
<<<<<<< HEAD
    func testEncodeJson(){
        
        let dictionary: [String: Any] = ["where": ["owner": "59aef169256ec2132ea6a392"], "include": "owner"]
        
        var jsonString: String = Query.stringifyJSON(dictionary: dictionary)
        print("[jsonstring]: \(jsonString)")
        print("string length: \(jsonString.characters.count)")
        XCTAssert(jsonString ?? "bad " != "")
        
        
    }
    
}


=======
    
    
}
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
