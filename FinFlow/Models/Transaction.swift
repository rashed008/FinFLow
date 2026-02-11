//
//  Transaction.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
       let title: String
       let category: String
       let date: String
       let amount: Double
       
       var isIncome: Bool {
           amount >= 0
       }
    
    var isToday: Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let d = formatter.date(from: date) else { return false }
        return Calendar.current.isDateInToday(d)
    }
}



