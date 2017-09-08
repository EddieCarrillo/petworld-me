//
//  FileTests.swift
//  PetWorld
//
//  Created by my mac on 8/31/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
<<<<<<< HEAD

=======
import UIKit
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31

@testable import PetWorld

class FileTests: XCTestCase {
    
    func testFileUpload(){
        let expecting = expectation(description: "Server should say \"ok\" when finished uploading image")
        let imageName = "german_sheperd"
        let image = UIImage(named: imageName)
        FileAPI.post(image: image!, success: { 
            expecting.fulfill()
        }) { (error: Error) in
<<<<<<< HEAD
            
            XCTFail("File error: \(error.localizedDescription)")
            
            XCTFail(error.localizedDescription)
            
=======
            XCTFail(error.localizedDescription)
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
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
<<<<<<< HEAD
        
        
        
        let imageId = "59aef4e5256ec2132ea6a398"
=======
        let imageId = "59a83ed33d8a448c5aa5a979"
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
        let image =  UIImage(named: testImage)!
        
        FileAPI.get(imageId: imageId, success: { (image: UIImage) in
            print("Sucess callback")
            expecting.fulfill()
            
        }) { (error: Error) in
            print("error called")
<<<<<<< HEAD
            XCTFail("ERROR: \(error.localizedDescription)" )
=======
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
            XCTFail(error.localizedDescription)
        }
     
        waitForExpectations(timeout: 10) { (error: Error?) in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
    
}
