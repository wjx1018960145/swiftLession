//
//  WelcomScreenView.swift
//  SwiftUIClass
//
//  Created by wjx on 2023/9/22.
//

import SwiftUI

struct WelcomScreenView: View {
    var body: some View {
        Color("bgColor").edgesIgnoringSafeArea(.all)
     
        VStack {
            Image("onboard")
            ExtractedView(title: "开始使用")
            Text("登录")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryColor"))
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            
            HStack{
                Text("New Around here？")
                Text("登录").foregroundColor(Color("PrimaryColor"))
            }
            
        }
            
        
    }
}


