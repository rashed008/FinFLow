//
//  SendFundsViewModel.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation
import Combine

@MainActor
final class SendFundsViewModel: ObservableObject {
    
    @Published var receiverID: String = ""
    @Published var amountText: String = ""
    @Published var showSuccessAlert = false
    @Published var errorMessage: String?
    @Published var lastTransferAmount: Double = 0
    
    private let service: TransactionService
    
    init(service: TransactionService) {
        self.service = service
    }
    
    var amount: Double {
        Double(amountText) ?? 0
    }
    
    var balanceFormatted: String {
        String(format: "%.2f", service.currentBalance)
    }
    
    func sendMoney() {
        Task {
            do {
                try await service.sendMoney(
                    receiverID: receiverID,
                    amount: amount
                )
                
                lastTransferAmount = amount
                receiverID = ""
                amountText = ""
                showSuccessAlert = true
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
