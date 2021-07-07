//
//  ContentView.swift
//  Swift Login
//
//  Created by Sumesh Vs on 01/07/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authentication: Authentication
    

// MARK: - Firebase - Setup and Get Email function
    let auth = Auth.auth()
    func getEmail() -> String {
        if let currentusr = auth.currentUser {
            return currentusr.email ?? "Signed In"
        }
        return auth.currentUser?.email ?? "Signed In"
    }
// MARK: - View Started
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                HStack {
                    Menu {
                        Button {
                            authentication.updateValidation(success: false)
                           // MARK: - Firebase Sign Out
                            do{
                                try auth.signOut()
                            }catch {
                                print(error)
                            }
                        } label: {
                            Text("Logout")
                            Image(systemName: "rectangle.righthalf.inset.fill.arrow.right")
                        }
                    } //MENU
                    label: {
                        Image("sumesh").resizable().scaledToFit().frame(width: 64, height: 64).overlay(Circle().frame(width: 18, height: 18).offset(x: +20, y: +22).foregroundColor(.green).shadow(radius: 1))
                    }.padding()
                    
                    VStack (alignment: .leading){
                        
                        Text("Hi, Sumesh").font(.title3).foregroundColor(.gray).fontWeight(.semibold)
                        
                        Text("\(getEmail())").font(.subheadline).foregroundColor(.green)
                            .multilineTextAlignment(.leading)
                    }//VStack
                    Spacer()
                    Image(systemName: "bell").font(.title).padding().overlay(Circle().frame(width: 15, height: 15).offset(x: +8, y: -6).foregroundColor(.red).shadow(radius: 1))
                } //HStack
                
                VStack (alignment: .leading, spacing: 2) {
                    
                    HStack(spacing: 2){
                        Text("Clients").font(.headline).fontWeight(.bold).multilineTextAlignment(.leading).padding()
                        Spacer()
                        
                        ForEach (1...5, id: \.self) { photo in
                            Image("photo\(photo)").resizable().frame(width: 40, height: 40).clipShape(Circle()).shadow(radius: 1)
                        }
                    } //HStack
                    .padding(.trailing, 15)
                    .background(Capsule().stroke(Color.green))
                    .padding()
                    .padding(.bottom, 40)
                    HStack{
                        Text("Year 2021").padding(.leading, 30).foregroundColor(.blue).font(.subheadline)
                        Spacer()
                        Image(systemName: "slider.horizontal.3").padding(.trailing, 30)
                    } //HStack
                    HStack (alignment:.center){
                        Image("salepie").resizable().scaledToFit().padding().frame(width: 150, height: 150, alignment: .center).padding()
                        Image("bar1").resizable().scaledToFit().frame(width: 150, height: 100, alignment: .center).padding()
                    }//HStack
                    .background(RoundedRectangle(cornerRadius: 25).shadow(radius: 1)).foregroundColor(.white.opacity(0.8)).padding()
                } //VStack
                
                .padding(.top, 20)
                
                Spacer()
                
                HStack{
                    Text("Projects").padding(.leading, 30).foregroundColor(.blue).font(.subheadline)
                    Spacer()
                    Image(systemName: "slider.horizontal.3").padding(.trailing, 40
                    )
                }// HStack
                VStack {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach (1...3, id: \.self) { project in
                                Image("project-\(project)").resizable().scaledToFit().frame(width: 140, height: 250, alignment: .center)
                            }
                        } //Hstack
                    }//Scroll View
                    .padding()
                }
            }//VStack
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
        }//scroll
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
