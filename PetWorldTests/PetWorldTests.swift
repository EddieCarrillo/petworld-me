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
        let queryString =  GeneralNetworkAPI.createQueryString(queryParams: queryParams)
        print("\(queryString)")
        
        XCTAssert(queryString == "?owner=Eddie&size=large&pet=lammy")
    
    }
    
    
    
}
