//
//  TransactionHistoryViewModel.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation
import Combine

@MainActor
final class TransactionHistoryViewModel: ObservableObject {

    @Published var transactions: [Transaction] = []

    private let service: TransactionServiceProtocol

    init(service: TransactionServiceProtocol = TransactionService()) {
        self.service = service
    }

    func loadTransactions() async {
        transactions = await service.fetchTransactions()
    }
}




