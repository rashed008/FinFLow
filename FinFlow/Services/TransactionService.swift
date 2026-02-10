//
//  TransactionService.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation

final class TransactionService: TransactionServiceProtocol {

    func fetchTransactions() async -> [Transaction] {
        try? await Task.sleep(nanoseconds: 300_000_000)

        return (1...100).map { index in
            Transaction(
                id: UUID(),
                title: index % 2 == 0 ? "Bank Transfer" : "Salary",
                amount: index % 2 == 0 ? -Double.random(in: 100...800) : Double.random(in: 1000...5000),
                date: "2025-08-10",
                category: index % 2 == 0 ? "Transfer" : "Income" 
            )
        }
    }
}


