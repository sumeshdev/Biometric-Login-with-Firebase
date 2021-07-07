//
//  Tabbar.swift
//  Swift Login
//
//  Created by Sumesh Vs on 02/07/21.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Gallery")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "plus").background(Color.green)
                    Text("")
                }
            LoginView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Location")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
