////
////  TransactionHistoryView.swift
////  FinFlow
////
////  Created by RASHED on 2/8/26.
////

import SwiftUI

struct TransactionHistoryView: View {
    
    @StateObject private var viewModel = TransactionHistoryViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Title
                    Text("Transaction History")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 12)
                    
                    // All Transactions
                    VStack(spacing: 12) {
                        ForEach(viewModel.transactions) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                    }
                    
                    // Today Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                        
                        ForEach(viewModel.transactions.filter { $0.isToday }) {
                            TransactionRowView(transaction: $0)
                        }
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
            }
        }
        //Navigation bar back button
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
        .task {
            await viewModel.loadTransactions()
        }
    }
}

#Preview {
    NavigationStack {
        TransactionHistoryView()
    }
}
