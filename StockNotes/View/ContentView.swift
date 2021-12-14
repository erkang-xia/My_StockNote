//
//  ContentView.swift
//  StockNote
//
//  Created by Erkang Xia on 12/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model : StockModel
    @State var stock = ["AAPL", "ASML", "FB", "BILI","1","2","3","4","5","6","7","8","9"]
    @State var company = ["Apple", "ASML Inc", "FaceBook", "BiliBili"]
    @State private var searchText = ""
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        ForEach(searchResults, id: \.self) {stock in
                                NavigationLink {
                                    StockDetail()
                                } label: {
                                    Text(stock)
                                }

                            }

                        
                                            }
                header:{
                    Text("Stock")
                }
                    
                    
                    
                    
                    
                    Section{
                        ForEach(stock, id: \.self) {stock in
                            Text(stock)
                        }
                    }
                header:{
                    Text("Stock")
                }
                    
                }
                .listStyle(SidebarListStyle())
                .searchable(text: $searchText)
                
                
                
            }
            .navigationTitle("Stock")
        }
        
    }
    var searchResults: [String] {
        if searchText.isEmpty {
                    return stock
                } else {
                    return stock.filter { $0.contains(searchText) }
                }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
