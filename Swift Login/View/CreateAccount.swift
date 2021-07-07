//
//  CreateAccount.swift
//  Swift Login
//
//  Created by Sumesh Vs on 05/07/21.
//


import SwiftUI
import FirebaseAuth

struct CreateAccount: View {
    //@StateObject private var createVM = CreateViewModel()
    @State private var effects = false
    @EnvironmentObject var authentication : Authentication
    @Environment(\.presentationMode) var presentationMode
    @State private var showProgressView = false
    
    @State private var email = ""
    @State private var password = ""
    @State private var slideAnimation = false
    @State private var authType = false
    
    let auth = Auth.auth()
    
    func createUser() {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.authType = true
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
        ZStack {
            let gradient = Gradient(colors: [Color.init("Color1"), Color.init("Color2")])
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark").font(.system(size: 25)).foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.trailing, 30)
                    })
                    
                }
                Spacer()
            }
            VStack {
                Spacer()
                Image("secureLogo").resizable().renderingMode(.template).scaledToFit().foregroundColor(.white).frame(width: 180, height: 180, alignment: .center)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                    .zIndex(1)
                    .animation(Animation.easeInOut(duration: 1))
                    .opacity(slideAnimation ? 1 : 0)
                    .offset(y: slideAnimation ? -50 : -400)
                TextField("Email", text : $email).foregroundColor(Color("Color1"))
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                TextField("Password", text : $password).foregroundColor(Color("Color1"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                if showProgressView {
                    ProgressView()
                }
                Button(action: {
                    if email.isEmpty && password.isEmpty {
                        authentication.isAuthorized = false
                    }else {
                        self.createUser()
                        self.effects.toggle()
                        self.showProgressView = true
                    }
                }, label: {
                    Text("Create Account").foregroundColor(Color("Color1")).font(.headline).padding(.leading,  20)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .background(Capsule()).foregroundColor(.white)
                })
                
                
                .padding()
                Spacer()
                Spacer()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            slideAnimation.toggle()
        })
        // .disabled(createVM.showProgressView)
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
            .environmentObject(Authentication())
    }
}
