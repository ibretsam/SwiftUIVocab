//
//  WelcomeScreen.swift
//  NewVocab
//
//  Created by MasterBi on 12/02/2025.
//

import SwiftUI

struct WelcomeScreen: View {
	@Environment(AuthService.self) private var authService
	@State private var showSignUp = false
	@State private var showSignIn = false
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 30) {
				Spacer()
				
				ZStack {
					WordBackgroundView(word: WordPreview.shared.frenchWords[1])
						.scaleEffect(2)
					// Logo and Title
					VStack(spacing: 20) {
						Text("V")
							.font(.system(size: 100, weight: .bold, design: .serif))
							.foregroundStyle(
								LinearGradient(
									colors: [
										Color(hex: "#98C9A3"), Color(hex: "#C2E0CC")
									],
									startPoint: .topLeading,
									endPoint: .bottomTrailing
								)
							)
					}
				}
				
				Spacer()
				
				Text("Welcome to Vocab")
					.font(.system(size: 40, weight: .semibold, design: .serif))
					.foregroundStyle(
						LinearGradient(
							colors: [
								Color(hex: "#98C9A3"), Color(hex: "#C2E0CC")
							],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						)
					)
				
				// Action Buttons
				VStack(spacing: 16) {
					NavigationLink(destination: SignUpView()) {
						Text("Create Account")
							.font(.headline)
							.foregroundStyle(.white)
							.frame(maxWidth: .infinity)
							.padding()
							.background(
								LinearGradient(
									colors: [
										Color(hex: "#98C9A3"), Color(hex: "#C2E0CC")
									],
									startPoint: .topTrailing,
									endPoint: .bottomLeading
								)
							)
							.clipShape(RoundedRectangle(cornerRadius: 14))
					}
					
					NavigationLink(destination: SignInView()) {
						Text("Sign In")
							.font(.headline)
							.foregroundStyle(.white)
							.frame(maxWidth: .infinity)
							.padding()
							.background(
								LinearGradient(
									colors: [
										Color(hex: "#D4ACC8"), Color(hex: "#E5C6DB")
									],
									startPoint: .topLeading,
									endPoint: .bottomTrailing
								)
							)
							.clipShape(RoundedRectangle(cornerRadius: 14))
					}
					
					Button("Continue as Guest") {
						authService.skipAuth()
					}
					.font(.subheadline)
					.foregroundStyle(.gray)
					.padding(.top, 8)
				}
				.padding(.horizontal, 24)
				
				Spacer()
			}
		}
	}
}
