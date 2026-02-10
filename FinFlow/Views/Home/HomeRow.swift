//
//  HomeRow.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

struct HomeRowExact: View {
    
    let icon: String
    let title: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 34, height: 34)
                
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(Color.black.opacity(0.85))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(Color.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05),
                radius: 4, x: 0, y: 2)
    }
}

