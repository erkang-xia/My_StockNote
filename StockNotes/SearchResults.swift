//
//  SearchResults.swift
//  StockNotes
//
//  Created by Erkang Xia on 12/13/21.
//

import Foundation

struct SearchResult : Decodable,Hashable{
    let description : String?
    let displaySymbol : String?
    let symbol : String?
    let type : String?
}
