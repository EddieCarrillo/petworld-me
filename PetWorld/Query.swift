//
//  Query.swift
//  PetWorld
//
//  Created by me on 9/7/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation


//Query params
//Example of possible query...
/*?include=owner&where={
 "owner": {
 "$in": [x, y, z]
 }
 }
 */
class Query{
    
 
    private var includes: [String] = []
    private var whereConstraints: [String: Any] = [:]
    
    func includeKey(key: String){
        includes.append(key)
    }
    
    func includeKeys(keys: [String]){
        includes = keys
    }
    //For the $in monodb operator
    //Key is the resources property to be compared to
    //'containedIn' is the value to compare to resource property
    /*
     where:   {
     "key": { "$in": // containedIn [val1, val2, val3] },
     "anotherKey": ....,
     "andantherone": ...,
     }
     */
    func whereKey(key: String, containedIn: [String]){
        
        let operatorComparison = ["$in": containedIn]
        whereConstraints[key] = operatorComparison
    }
    
    func whereKey(key: String, equals: Any){
        whereConstraints[key] = equals
    }
    
    func whereKey(key: String, hasPrefix: String, caseInsensitive: Bool = true){
        var operatorComparison: [String: Any] = ["$regex": hasPrefix]
        
        if caseInsensitive {
            operatorComparison["$options"] = "i"
        }
        
        whereConstraints[key] = operatorComparison
    }
    
    
    /*Process include and where fields before adding them to url*/
    func createQuery() -> [URLQueryItem]{
        var queryItems: [URLQueryItem] = []
        //Add include fields
        let preparedIncludeKeys: String = prepIncludes()
        queryItems.append(URLQueryItem(name: "include", value: preparedIncludeKeys))
        
        //Added where fields
        
        //Convert dictionary to json string
        var unencodedJsonString = Query.stringifyJSON(dictionary: whereConstraints)
        //If not possible then stop
        if unencodedJsonString == "" {
            print("Could not stringify json correctly")
            return queryItems
        }
         //URL encode json string
        guard let encodedJsonString = Query.urlEncodeQueryParam(param: unencodedJsonString) else {
         print("Could not encode json string properly")
            return queryItems
            
        }
        
        queryItems.append(URLQueryItem(name: "where", value: encodedJsonString))
        
        return queryItems
        
    }
    
    
    
    class func createQueryString(queryParams: [String: String]) -> String{
        //Start of query
        var queryString = "?"
        for (key, value) in queryParams{
            //?key1=value&key2=value2&key3=value3
            queryString = "\(queryString)\(key)=\(value)&"
            print("queryString: \(queryString)")
        }
        print("size: \(queryString.characters.count)")
        print("endIndex \(queryString)" )
        //Remove the ampersand at the end
        queryString = queryString.substring(to: queryString.index(before: queryString.endIndex))
        
        return queryString
    }
    
    
    //Prepares include statements as  [includee command]=[val1],[val2],[val3]
    private func prepIncludes() -> String{
        var includeString = ""
        
        if self.includes.count <= 0 {
            return  "";
        }
        
        for property in self.includes{
            includeString.append("\(property),")
        }
        return includeString.substring(to: includeString.index(before: includeString.endIndex))
    }
    
    
    
    class func stringifyJSON(dictionary: Dictionary<String, Any>, pretty: Bool = true) -> String{
        guard  let jsonData = dictionary.toJson() else {
            return ""
        }
        if let jsonString  = String(data: jsonData, encoding: String.Encoding.utf8){
            print("jsonString: \(jsonString)")
            return jsonString as String
        }
        
        return ""
        
    }
    
    
    class func urlEncodeQueryParam(param: String) -> String?{
        return param.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    
    
    
    
    
    
}

extension Dictionary{
    
    func toJson() -> Data? {
        do{
            var jsonData: Data?  = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        }catch{
            return nil
        }
        return nil
        
    }
    
}
    





