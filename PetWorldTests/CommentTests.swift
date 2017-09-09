//
//  CommentTests.swift
//  PetWorld
//
//  Created by my mac on 8/31/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld

class CommentTests: XCTestCase {

    
    
    var authToken: String = ""
    
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
    

   
    
    func testToJson(){
        let comment = Comment(text: "Blah, blah, blah", authorId: "1234", postId: "5678" )
        let jsonCommentBody = comment.toJson()!
        var extractedComment: [String: Any]?
        
        do{
            extractedComment = try JSONSerialization.jsonObject(with: jsonCommentBody, options: []) as? [String: Any]
        }catch{
             XCTFail("Trouble deserializing json")
        }
        
        if let extractedComment = extractedComment{
            let text = extractedComment["text"] as! String
            let authorId = extractedComment["author"] as! String
            let postId = extractedComment["post"] as! String
            
            XCTAssert(text == "Blah, blah, blah")
            XCTAssert(authorId == "1234")
            XCTAssert(postId == "5678")
            
        }else {
            XCTFail("Trouble deserializing json")

        }
        
        
        
    
    }
    

    func testGetComments(){
        var expecting = expectation(description: "To return all comments")
        let postId = ""
        CommentAPI.getComments(from: postId, queryParams: nil) { (comments: [Comment]?, error: Error?) in
            
            if let error = error{
                XCTFail("ERROR: \(error)")
            }else if let comments = comments{
                //Success
                print(comments)
                expecting.fulfill()
            }else{
                XCTFail("Something weird happened.")
            }
        }
        waitForExpectations(timeout: 4) { (error: Error?) in
            if let error = error {
                XCTFail("[ERROR] \(error)")
            }
        }
        
    }
    
    
    func testCreateComment(){
        var expecting = expectation(description: "To return created comment")
        
        let johnId = "59aef169256ec2132ea6a392"
        let postId = "59aef4fd256ec2132ea6a39b"
        
        let comment = Comment(text: "this is a comment", authorId: johnId, postId: postId )
        CommentAPI.create(comment: comment, token: authToken, for: postId) { (comment: Comment?, error: Error?) in
            if let error = error {
                XCTFail("\(error)")
            }else  if let comment = comment {
             //Success
                expecting.fulfill()
                
            }else{
                XCTFail("Something weird happened")
            }
        }
        
        waitForExpectations(timeout: 10, handler: { (error: Error?) in
            if let error = error{
                print("Request timed out")
            }
        })
        
    }

}
