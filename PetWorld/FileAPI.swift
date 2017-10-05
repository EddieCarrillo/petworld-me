//
//  FileAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit




class FileAPI{
    
    
    
    static var path = "/files"
    static var getMethod = "GET"
    static var postMethod  = "POST"
    static var  uploadPathParam = "/upload"
    static var multipartForm = "multipart/form-data;"
    static var contentType = "Content-Type"
    
    
    
    
    
    class func get(imageId id: String, success: @escaping (UIImage) -> Void, fail: @escaping (Error) -> Void ){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)/id/\(id)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url!)
        
        request.httpMethod = getMethod
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error{
                fail(error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                print("RESPONSE: \(response)")
                let code = response.statusCode
                print(code)
                if (code != 200){
                    let error = NSError(domain: "Bad request", code: code, userInfo: nil)
                    fail(error)
                }else if let data = data{
                    //FIXED Threading bug.
                    let queue = OperationQueue()
                    queue.addOperation({ 
                        let image = UIImage(data: data)
                        print("sucess")
                        OperationQueue.main.addOperation {
                           success(image!)
                        }
                        
                    })
                   
                }
                
            }
            
            //            print("\n\n\n\n\nDATA:  \(data)")
            //            print("\n\n\n\n\nERROR:  \(error)")
            
        }

        
        task.resume()
    
    }
    
    
   class func post(image: UIImage,success: @escaping (String) -> Void, fail: @escaping (Error) -> Void){
        let url = URL(string: "\(NetworkAPI.apiBaseUrl)\(path)\(uploadPathParam)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: url!)
        // let imageData = UIImagePNGRepresentation(UIImage(named: "petworld_icon")!)
        let boundary = generateBoundary()
        
        
        urlRequest.httpMethod = postMethod
        urlRequest.setValue("\(multipartForm) boundary=\(boundary)", forHTTPHeaderField: contentType)
        
        
        urlRequest.httpBody = createDataBody(withParameters: nil, image: image , boundary: boundary)
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                fail(error)
            }else if let response = response{
                let response = response as! HTTPURLResponse
                let code = response.statusCode
                if code != 200 && code != 201{
                    fail(NSError(domain: "Bad response", code: code, userInfo: nil))
                }else if let data = data{
                    var jsonBody: [String: Any]?
                    
                    do{
                        jsonBody = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    }catch{
                        fail(NSError(domain: "Could not deserialize json", code: code, userInfo: nil))
                        
                    }
                    
                    if let jsonBody = jsonBody{
                        if let id = jsonBody["id"] as? String {
                            print("[JSONBODY]: \(jsonBody)")
                            success(id)
                        }
                        

                    }else{
                        fail(NSError(domain: "Could not deserialize json", code: code, userInfo: nil))
                        
                    }
                }
            }
        }
        
        
        task.resume()
    }
    
    /*This function creates a request body for
     mult-part form requests. (Primarily for image uploading)*/
    private class func createDataBody(withParameters params: [String: String]?, image: UIImage, boundary: String) -> Data{
        
        
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
    
    
    private class func generateBoundary() -> String{
        return "Boundary-\(NSUUID().uuidString)"
    }
    

}

extension Data{
    mutating func append(_ string: String){
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}
