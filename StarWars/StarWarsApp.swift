//
//  StarWarsApp.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import SwiftUI

@main
struct StarWarsApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}

struct StarWarsApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
