//
//  SoftGlowingButton.swift
//  Alcysm
//
//  Created by Aditi Mohan Jamakhandi on 7/16/25.
//
import SwiftUI

struct SoftGlowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 15)
            .padding(.horizontal, 60)
            .background(configuration.isPressed ? Color("SoftLavender").opacity(0.7) : Color("SoftLavender"))
            .cornerRadius(25)
            .shadow(color: Color("SoftLavender"), radius: 20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}
