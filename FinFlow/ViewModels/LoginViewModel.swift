//
//  LoginViewModel.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    private let authService = AuthService()
//    func login() -> Bool {
//        guard Validators.isValidEmail(email),
//              password.count >= 6 else {
//            errorMessage = AppStrings.Login.errorInvalidCredentials
//            return false
//        }
//        
//        if authService.login(email: email, password: password) {
//            errorMessage = nil
//            isLoggedIn = true   //TRIGGER NAVIGATION
//            return true
//        } else {
//            errorMessage = AppStrings.Login.errorInvalidCredentials
//            return false
//        }
//    }
    
    func login() -> Bool {

        guard Validators.isValidEmail(email) else {
            errorMessage = AppStrings.Login.errorInvalidEmail
            return false
        }

        guard password.count >= 6 else {
            errorMessage = AppStrings.Login.errorPasswordMinLength
            return false
        }

        if authService.login(email: email, password: password) {
            errorMessage = nil
            isLoggedIn = true
            return true
        } else {
            errorMessage = AppStrings.Login.errorInvalidCredentials
            return false
        }
    }

}
