//
//  TransactionService.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation
import Combine

enum TransactionError: LocalizedError {
    case insufficientBalance
    case invalidAmount
    
    var errorDescription: String? {
        switch self {
        case .insufficientBalance:
            return "Insufficient balance."
        case .invalidAmount:
            return "Amount must be greater than zero."
        }
    }
}

@MainActor
final class TransactionService: ObservableObject {
    
    // Single Source of Truth
    @Published private(set) var transactions: [Transaction] = []
    
    init() {
        loadMockData()
    }
    
    // MARK: - Mock Load
    private func loadMockData() {
        transactions = [
            Transaction(id: UUID(), title: "Netflix Subscription", category: "Entertainment", date: "2025-08-15", amount: -950),
            Transaction(id: UUID(), title: "Groceries", category: "Shopping", date: "2025-08-14", amount: -2400),
            Transaction(id: UUID(), title: "Salary", category: "Income", date: "2025-08-10", amount: 45000),
            Transaction(id: UUID(), title: "Uber Ride", category: "Transport", date: "2025-08-09", amount: -380),
            Transaction(id: UUID(), title: "Coffee", category: "Food", date: "2025-08-09", amount: -120),
            Transaction(id: UUID(), title: "Electricity Bill", category: "Utilities", date: "2025-08-08", amount: -3200),
            Transaction(id: UUID(), title: "Freelance Payment", category: "Income", date: "2025-08-07", amount: 12000),
            Transaction(id: UUID(), title: "Restaurant", category: "Food", date: "2025-08-07", amount: -1800),
            Transaction(id: UUID(), title: "Internet Bill", category: "Utilities", date: "2025-08-06", amount: -1500),
            Transaction(id: UUID(), title: "Bonus", category: "Income", date: "2025-08-05", amount: 8000)
        ]
    }
    
    // MARK: - Balance
    
    var currentBalance: Double {
        transactions.reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - Send Money
    
    func sendMoney(receiverID: String, amount: Double) async throws {
        
        // Simulate API delay
        try await Task.sleep(nanoseconds: 300_000_000)
        
        guard amount > 0 else {
            throw TransactionError.invalidAmount
        }
        
        guard amount <= currentBalance else {
            throw TransactionError.insufficientBalance
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newTransaction = Transaction(
            id: UUID(),
            title: "Fund Transfer to \(receiverID)",
            category: "Transfer",
            date: formatter.string(from: Date()),
            amount: -amount
        )
        
        // Insert at top (latest first)
        transactions.insert(newTransaction, at: 0)
    }
}
