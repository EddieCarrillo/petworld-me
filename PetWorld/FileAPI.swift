//
//  FileAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

let path = "/files"


/*This function creates a request body for
 mult-part form requests. (Primarily for image uploading)*/
private func createDataBody(withParameters params: [String: String]?, image: UIImage, boundary: String) -> Data{
    
    
    let lineBreak = "\r\n"
    var body = Data()
    
    if let params = params{
        
        for (key, value) in params {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; file=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value + lineBreak)")
        }
    }
    
    
    body.append("--\(boundary + lineBreak)")
    body.append("Content-Disposition: form-data; name=file; filename=petworld_icon.png\(lineBreak)")
    body.append("Content-Type: image/png\(lineBreak + lineBreak)")
    body.append(UIImagePNGRepresentation(image)!)
    body.append(lineBreak)
    
    
    body.append("--\(boundary)--\(lineBreak)")
    
    return body
    
    
    
    
}


private func generateBoundary() -> String{
    return "Boundary-\(NSUUID().uuidString)"
}


extension Data{
    mutating func append(_ string: String){
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}



