//
//  LoginView.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - State
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    @EnvironmentObject private var appState: AppState
    @State private var isPasswordVisible = false
    
    
    
    enum Field {
        case email
        case password
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    
                    Spacer(minLength: 40)
                    
                    // MARK: - Logo
                    Image(systemName: "cube.fill")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    AppColors.gradientStart,
                                    AppColors.gradientEnd
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // MARK: - Title
                    VStack(spacing: 6) {
                        Text(AppStrings.Login.welcomeTitle)
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(AppColors.primaryText)
                        
                        Text(AppStrings.Login.welcomeSubtitle)
                            .font(.system(size: 15))
                            .foregroundColor(AppColors.secondaryText)
                    }
                    
                    // MARK: - Input Fields
                    VStack(spacing: 16) {
                        
                        //Email
                        VStack(alignment: .leading, spacing: 6) {
                            Text(AppStrings.Login.emailLabel)
                                .font(.system(size: 13))
                                .foregroundColor(AppColors.secondaryText)
                            
                            TextField(
                                AppStrings.Login.emailPlaceholder,
                                text: $viewModel.email
                            )
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusedField, equals: .email)
                            .padding()
                            .background(AppColors.card)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.border)
                            )
                            .onChange(of: viewModel.email) { _ in
                                viewModel.errorMessage = nil
                            }
                        }
                        
                        // Password
                        VStack(alignment: .leading, spacing: 6) {
                            Text(AppStrings.Login.passwordLabel)
                                .font(.system(size: 13))
                                .foregroundColor(AppColors.secondaryText)
                            
                            HStack {
                                Group {
                                    if isPasswordVisible {
                                        TextField(
                                            AppStrings.Login.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                    } else {
                                        SecureField(
                                            AppStrings.Login.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                    }
                                }
                                .font(.system(size: 16))
                                .focused($focusedField, equals: .password)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(AppColors.secondaryText)
                                }
                            }
                            .padding()
                            .background(AppColors.card)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.border)
                            )
                            .onChange(of: viewModel.password) { _ in
                                viewModel.errorMessage = nil
                            }
                        }
                        
                    }
                    
                    // MARK: - Error Message
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundColor(AppColors.errorText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // MARK: - Login Button
                    Button {
                        focusedField = nil
                        if viewModel.login() {
                            appState.isLoggedIn = true
                        }
                        
                    } label: {
                        Text(AppStrings.Login.loginButton)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                LinearGradient(
                                    colors: [
                                        AppColors.gradientStart,
                                        AppColors.gradientEnd
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                    }
                    .padding(.top, 6)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView()
            }
        }
    }
}

#Preview {
    LoginView()
}
