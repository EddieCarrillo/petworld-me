//
//  PostTests.swift
//  PetWorld
//
//  Created by my mac on 9/1/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld

class PostTests: XCTestCase {
    
    
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
    
    func testPostToJson(){
        let post = Post(caption: "#PUGLIF", mediaFileId: "garblegarble", authorId: "lemonlemon")
        var jsonPost = post.toJson()
        var dataPost: [String: Any]?
        do {
             dataPost = try JSONSerialization.jsonObject(with: jsonPost!, options: []) as? [String: Any]
        }catch{
             XCTFail("Could not desrialize json")
        }
        
        if let postJson = dataPost{
             var extractedPost = Post(jsonMap: postJson)
            if extractedPost.authorId == "lemonlemon" && extractedPost.caption == "#PUGLIF" && extractedPost.mediaId == "garblegarble"{
             //pass
            }else {
                XCTFail()
            }
        }else {
            XCTFail()
        }
       
    
    }
    
    
    func testCreatePost(){
         var expecting = expectation(description: "To return created post")
        let caption = "meCaptionEh"
        let authorId = "ScottishMate"
        let post = Post(caption: caption, authorId: authorId)
        
        PostsAPI.create(new: post, token: self.authToken) { (post: Post?, error: Error?) in
            if let error = error{
                XCTFail("networking error: \(error)")
            }else if let post = post{
                //Passed test
                expecting.fulfill()
            }else{
                //Something weird happened
                XCTFail("Something weird happened: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: { (error: Error?) in
            if let error = error{
                print("Request timed out")
            }
        })
        
        }
    
    
    func testGetPostById(){
        
         var expecting = expectation(description: "To return queried post")
        let postId = "59acba0674822e2e0f764f57"
        PostsAPI.get(post: postId) { (post: Post?, error: Error?) in
            if let error = error {
                XCTFail("error \(error)")
            }else if let post = post{
                //Found the post
                expecting.fulfill()
            }else{
                XCTFail("Something weird happened: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: { (error: Error?) in
            if let error = error{
                print("Request timed out")
            }
        })
        
        
        
    }
        
        
    }
    

