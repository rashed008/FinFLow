//
//  TransactionRowView.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

struct TransactionRowView: View {
    
    let transaction: Transaction
    
    private var amountColor: Color {
        transaction.isIncome ? Color.green : Color.red
    }
    
    private var amountPrefix: String {
        transaction.isIncome ? "+" : "-"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.black.opacity(0.85))
                
                Text("\(formattedDate) • \(transaction.category)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(amountPrefix) ৳\(formattedAmount)")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(amountColor)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
    }
    
    private var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: transaction.date) else {
            return transaction.date
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM, yyyy"
        
        return outputFormatter.string(from: date)
    }
    
    private var formattedAmount: String {
        String(format: "%.2f", abs(transaction.amount))
    }
    
}
