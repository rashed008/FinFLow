
//  SendFundsView.swift
//  FinFlow
//  Created by RASHED on 2/11/26.
//

import SwiftUI

struct SendFundsView: View {
    
    @EnvironmentObject var service: TransactionService
    
    @State private var receiverID = ""
    @State private var amountText = ""
    @State private var showSuccessAlert = false
    @State private var errorMessage: String?
    @State private var lastTransferAmount: Double = 0
    
    @Environment(\.dismiss) private var dismiss
    
    private var amountValue: Double {
        Double(amountText) ?? 0
    }
    
    var body: some View {
        ZStack {
            
            Color(red: 0.97, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: Title
                Text(AppStrings.SendFunds.title)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Receiver ID
                VStack(alignment: .leading, spacing: 6) {
                    Text(AppStrings.SendFunds.receiverLabel)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    TextField(AppStrings.SendFunds.receiverPlaceholder, text: $receiverID)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // MARK: Amount Field
                VStack(alignment: .leading, spacing: 6) {
                    Text(AppStrings.SendFunds.amountLabel)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    TextField(AppStrings.SendFunds.amountPlaceholder, text: $amountText)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(errorMessage != nil ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .onChange(of: amountText) { _ in
                            validateAmount()
                        }
                    
                    // Inline Error
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                    }
                }
                
                // MARK: Balance
                Text("\(AppStrings.SendFunds.availableBalance) ৳ \(String(format: "%.2f", service.currentBalance))")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Send Button
                Button(action: {
                    sendMoney()
                }) {
                    Text(AppStrings.SendFunds.sendButton)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.05, green: 0.42, blue: 0.95),
                                    Color(red: 0.02, green: 0.30, blue: 0.88)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .opacity(0.9)
                        )
                        .cornerRadius(12)
                }
                .disabled(receiverID.isEmpty || amountText.isEmpty || errorMessage != nil)
                .opacity(receiverID.isEmpty || amountText.isEmpty || errorMessage != nil ? 0.6 : 1)
                
                Spacer()
            }
            .padding(20)
        }
        
        // MARK: Navigation
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        
        // MARK: Success Alert
        .alert(AppStrings.SendFunds.successTitle, isPresented: $showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("৳ \(String(format: "%.2f", lastTransferAmount)) \(AppStrings.SendFunds.successMessage)")
        }
    }
    
    // MARK: Live Validation
    private func validateAmount() {
        guard amountValue > 0 else {
            errorMessage = nil
            return
        }
        
        if amountValue > service.currentBalance {
            errorMessage = AppStrings.SendFunds.insufficientBalance
        } else {
            errorMessage = nil
        }
    }
    
    // MARK: Send Logic
    private func sendMoney() {
        Task {
            do {
                try await service.sendMoney(
                    receiverID: receiverID,
                    amount: amountValue
                )
                
                lastTransferAmount = amountValue
                receiverID = ""
                amountText = ""
                errorMessage = nil
                showSuccessAlert = true
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    NavigationStack {
        SendFundsView()
            .environmentObject(TransactionService())
    }
}
