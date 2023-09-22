//
//  ContentView.swift
//  SwiftUIClass
//
//  Created by wjx on 2023/9/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/){ item in
                
                NavigationLink (destination: Text("")){
                    HStack{
                        Image(systemName: "photo").cornerRadius(10)
                        VStack(alignment: .leading){
                            Text("长城")
                            Text("北京")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
             
               
            }
            .navigationTitle("视频")
        }
        
     
        
        
      
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}
