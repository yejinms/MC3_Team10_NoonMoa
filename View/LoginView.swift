//
//  LoginView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

// LoginView
import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "Gear")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            SignInWithAppleButton { (request) in
                // 로그인 전에 Counter 문서가 없는 경우 초기화
                loginData.initializeCountersIfNotExist()
                
                loginData.nonce = loginData.randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = loginData.sha256(loginData.nonce)
                
            } onCompletion: { (result) in
                switch result {
                case .success(let user):
                    print("success")
                    guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                        print("error with firebase")
                        return
                    }
                    
                    
                    loginData.authenticate(credential: credential)
                    viewRouter.currentView = .attendance
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .frame(width: 280, height: 45)
            .cornerRadius(10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
