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

            Text("\(amountPrefix) ৳\(abs(transaction.amount))")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(amountColor)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
    }

    private var formattedDate: String {
        transaction.date
            .replacingOccurrences(of: "2025-", with: "Aug ")
            .replacingOccurrences(of: "-", with: " ")
    }
}
