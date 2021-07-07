//
//  LoginView.swift
//  Swift Login
//
//  Created by Sumesh Vs on 02/07/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication : Authentication
    @State private var slideAnimation = false
    @State private var isShowing = false
    
    
    
    var body: some View {
        
        
        ZStack {
            let gradient = Gradient(colors: [Color.init("Color1"), Color.init("Color2")])
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)  .onTapGesture {
                UIApplication.shared.endEditing()
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
                    .offset(y: slideAnimation ? -0 : -400)
                if authentication.biometricType() != .none {
                    Button(action: {
                        authentication.biometricUnlock { (result: Result<Credentials, Authentication.AuthenticationError>) in
                            switch result {
                            case .success(let credentials):
                                loginVM.credentials = credentials
                                loginVM.login { success in
                                    authentication.updateValidation(success: success)
                                }
                            case .failure(let error):
                                loginVM.error = error
                            }
                        }
                        
                    }, label: {
                        Image(systemName: authentication.biometricType() == .touchID ? "touchid" : "faceid").resizable().frame(width: 50, height: 50, alignment: .center).font(.title).foregroundColor(.white)
                    }).padding()
                    
                }
                
                
                TextField("Email", text : $loginVM.credentials.email).foregroundColor(Color("Color1"))
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding().shadow(radius: 5)
                SecureField("Password", text : $loginVM.credentials.password).foregroundColor(Color("Color1"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding().shadow(radius: 5)
                if loginVM.showProgressView {
                    ProgressView()
                }
                Button(action: {
                    loginVM.login { success in
                        authentication.updateValidation(success: success)
                    }
                }, label: {
                    Text("Log In").foregroundColor(Color("Color1")).font(.headline).padding(.leading,  40)
                        .padding(.trailing, 40)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .background(Capsule().shadow(radius: 2)).foregroundColor(.white)
                }).disabled(loginVM.loginDisabled)
                
                Button(action: {
                    isShowing = true
                }, label: {
                    Text("Create Account") .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .foregroundColor(Color("Color1")).font(.subheadline).background(Capsule().shadow(radius: 2)).foregroundColor(.white)
                })
                .sheet(isPresented: $isShowing) {
                    CreateAccount()
                }
                
                
                
                .padding()
                Spacer()
                Spacer()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            slideAnimation.toggle()
        })
        
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            if error == .unSavedCredential {
                return Alert(title: Text("Credentials Not Saved"), message: Text(error.localizedDescription), primaryButton: .default(Text("OK"), action: {
                    loginVM.storeCredentials = true
                }), secondaryButton: .cancel())
            } else {
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authentication())
    }
}
