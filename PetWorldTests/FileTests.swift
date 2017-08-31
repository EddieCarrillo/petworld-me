//
//  FileTests.swift
//  PetWorld
//
//  Created by my mac on 8/31/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
import UIKit

@testable import PetWorld

class FileTests: XCTestCase {
    
    func testFileUpload(){
        let expecting = expectation(description: "Server should say \"ok\" when finished uploading image")
        let imageName = "german_sheperd"
        let image = UIImage(named: imageName)
        FileAPI.post(image: image!, success: { 
            expecting.fulfill()
        }) { (error: Error) in
            XCTFail(error.localizedDescription)
        }
    
        
        waitForExpectations(timeout: 5) { (error: Error?) in
            if let error = error{
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testFileDownload(){
        let expecting = expectation(description: "Should get image data from the server")
        let testImage = "german_sheperd"
        let imageId = "59a83ed33d8a448c5aa5a979"
        let image =  UIImage(named: testImage)!
        
        FileAPI.get(imageId: imageId, success: { (image: UIImage) in
            print("Sucess callback")
            expecting.fulfill()
            
        }) { (error: Error) in
            print("error called")
            XCTFail(error.localizedDescription)
        }
     
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
    
}
