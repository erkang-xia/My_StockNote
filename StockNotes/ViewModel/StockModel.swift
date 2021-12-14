//
//  StockModel.swift
//  StockNote
//
//  Created by Erkang Xia on 12/12/21.
//

import Foundation

class StockModel: ObservableObject {
    @Published var appleList = [SearchResult]()
    @Published var searchText = ""
    init() {
        
        
    }
    
    
    
    
    
    
    //MARK: API Caller - Stock Search
    
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
        //let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //get urlsession
        
        let session = URLSession.shared
        
        //create data task
        let datatask = session.dataTask(with: url) { [self]data, urlResponce,error in
            //check that there isnt error
            guard let data = data, error == nil else {
                if error != nil {
                    print("something is wrong!")
                } else {
                    print("something is wrong!")
                }
                return
                
            }
            do {
                let result = try JSONDecoder().decode(SearchResponce.self, from: data)
                
                print("Hold on")
                print(result)
                
                DispatchQueue.main.async {
                    self.appleList = result.result ?? [SearchResult]()
                }
                
                
                print("Hold on")
                print(appleList)

            }catch{
                print(error)
            }
            
        }
        
        datatask.resume()
    }
    
    
    
    var searchResults: [String] {
        if searchText.isEmpty {
                    return []
                } else {
                    let url = createURL(endpoint: "search",queryParameters: ["q":"apple"])
                    getStock(url: url!)
                    var stocks = [String]()
                    for stock in appleList {
                        stocks.append(stock.symbol ?? "")
                    }
                    return stocks
                }
    }
}

