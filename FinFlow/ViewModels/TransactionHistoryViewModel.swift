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
    
    @Published private(set) var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: TransactionService) {
        // Observe the shared service
        service.$transactions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedTransactions in
                self?.transactions = updatedTransactions
            }
            .store(in: &cancellables)
    }
}
