//
//  LoginView.swift
//  SwiftUIClass
//
//  Created by wjx on 2023/9/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
            WelcomScreenView()
            
        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct ExtractedView: View {
    var title:String
    var body: some View {
      
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}

