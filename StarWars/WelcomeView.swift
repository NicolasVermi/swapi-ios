//
//  WelcomeView.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        //Spacer()
        NavigationView{
            ZStack {
                Image("sky")
                NavigationLink(destination: FilmConteinerView()) {
                    Text("STAR WARS")
                        
                        .foregroundColor(.yellow)
                        .bold()
                        .font(.system(size: 50))
                        .navigationBarTitle("Welcome")
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
