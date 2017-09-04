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
    
}
