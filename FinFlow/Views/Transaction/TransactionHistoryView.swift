
//
//  TransactionHistoryView.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

struct TransactionHistoryView: View {
    
    @EnvironmentObject var service: TransactionService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            Color(red: 0.97, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: Title
                    Text("Transaction History")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 12)
                    
                    // MARK: Sorted Transactions (Newest First)
                    VStack(spacing: 12) {
                        ForEach(sortedTransactions) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
            }
        }
        // MARK: Navigation Back Button
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
    }
}

// MARK: - Sorting Logic

private extension TransactionHistoryView {
    
    var sortedTransactions: [Transaction] {
        service.transactions.sorted {
            parseDate($0.date) > parseDate($1.date)
        }
    }
    
    func parseDate(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string) ?? Date.distantPast
    }
}

#Preview {
    NavigationStack {
        TransactionHistoryView()
            .environmentObject(TransactionService())
    }
}
