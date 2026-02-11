//
//  AppStrings.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation

enum AppStrings {
    
    enum Login {
        static let welcomeTitle = "Welcome Back"
        static let welcomeSubtitle = "Sign in to continue"
        
        static let emailLabel = "Email / User ID"
        static let emailPlaceholder = "Please enter your email / user id"
        
        static let passwordLabel = "Password / PIN"
        static let passwordPlaceholder = "••••••"
        
        static let loginButton = "Login"
        static let errorInvalidCredentials = "Invalid email or password"
        
        static let errorInvalidEmail = "Please enter a valid email address"
        static let errorPasswordMinLength = "Password must be at least 6 characters"
    }
    
    enum Home {
        static let greeting = "Md Rashed Pervez"
        static let accountID = "Account ID • 92837465"
        
        static let balanceTitle = "Available Balance"
        static let balanceAmount = "৳ 125,430.50"
        
        static let transactionHistory = "Transaction History"
        static let sendFunds = "Send Funds"
        static let logout = "Log Out"
    }
    
    struct SendFunds {
        static let title = "Send Funds"
        static let receiverLabel = "Receiver ID"
        static let receiverPlaceholder = "Enter Receiver ID"
        static let amountLabel = "Amount"
        static let amountPlaceholder = "Enter Amount"
        static let availableBalance = "Available balance"
        static let sendButton = "Send Money"
        static let successTitle = "Transfer Successful 🎉"
        static let successMessage = "sent successfully."
        static let insufficientBalance = "Amount exceeds available balance."
    }
    
}

