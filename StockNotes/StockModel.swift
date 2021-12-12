//
//  StockModel.swift
//  StockNote
//
//  Created by Erkang Xia on 12/12/21.
//

import Foundation

class StockModel: ObservableObject {
    
    init() {
        createURL(endpoint: "search",queryParameters: ["q":"apple"])
     
    }
    
    
    func createURL (endpoint : String,
                    queryParameters: [String:String]  = [:])
    -> URL?{
        
        var urlString = Constants.baseUrl + endpoint
        var queryItems = [URLQueryItem]()
        //add parameter
        for (name,value) in queryParameters{
            queryItems.append(.init(name: name, value: value))
        }
        //add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        //add all together
        urlString += "?" + queryItems.map{"\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        
        print(urlString)
        
        
        return URL(string: urlString)
    }
    
    func getStock(url:URL) {
        //create url request
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //get urlsession
        
        let session = URLSession.shared
        
        //create data task
        let datatask = session.dataTask(with: request) { data, urlResponce, error in
            //check that there isnt error
            if error == nil {
                print(urlResponce)
                
            }
        }
        
        datatask.resume()
    }
}

