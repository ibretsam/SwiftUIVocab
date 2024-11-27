//
//  CustomTextField.swift
//  NewVocab
//
//  Created by MasterBi on 23/11/2024.
//
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    let isSecure: Bool
    
    var body: some View {
        HStack(spacing: 8) {  // Reduced from 12
            Image(systemName: icon)
                .foregroundColor(.primary.opacity(0.4))
                .frame(width: 16)  // Reduced from 20
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .font(.system(.subheadline))  // Smaller font
        .padding(12)  // Reduced padding
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primary.opacity(0.15), lineWidth: 0.5)
        )
    }
}
