//
//  TransactionServiceProtocol.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() async -> [Transaction]
    func sendMoney(receiverID: String, amount: Double) async throws -> [Transaction]
}
