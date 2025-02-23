//
//  SignInView.swift
//  NewVocab
//
//  Created by MasterBi on 22/02/2025.
//

import SwiftUI

struct SignInView: View {
	@Environment(AuthService.self) private var authService
	@Environment(\.dismiss) private var dismiss
	@State private var email = ""
	@State private var password = ""
	@State private var showError = false
	@State private var errorMessage = ""
	
	var body: some View {
		ScrollView {
			ZStack {
				WordBackgroundView(word: WordPreview.shared.frenchWords[7])
					.scaleEffect(2)
					.padding(.bottom, 200)
				VStack(spacing: 24) {
					// Header
					VStack(spacing: 12) {
						Text("Welcome Back")
							.font(.system(size: 40, weight: .semibold, design: .serif))
							.foregroundStyle(
								LinearGradient(
									colors: [
										Color(hex: "#D4ACC8"), Color(hex: "#E5C6DB")
									],
									startPoint: .topLeading,
									endPoint: .bottomTrailing
								)
							)
						
						Text("Continue your learning progress")
							.font(.subheadline)
							.foregroundStyle(.gray)
					}
					.padding(.top, 40)
					
					// Form Fields
					VStack(spacing: 16) {
						TextField("Email", text: $email)
							.textFieldStyle(AuthTextFieldStyle())
							.textContentType(.emailAddress)
							.autocapitalization(.none)
						
						SecureField("Password", text: $password)
							.textFieldStyle(AuthTextFieldStyle())
					}
					.padding(.top, 20)
					
					// Sign In Button
					Button(action: signIn) {
						if authService.isLoading {
							ProgressView()
								.tint(.white)
						} else {
							Text("Sign In")
								.font(.headline)
						}
					}
					.frame(maxWidth: .infinity)
					.foregroundStyle(.white)
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
					.padding(.top, 20)
					
					Spacer()
				}
				.padding(.horizontal, 24)
			}
		}
		.scrollDismissesKeyboard(.immediately)
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					dismiss()
				} label: {
					Image(systemName: "chevron.left")
						.font(.title3)
						.foregroundStyle(
							LinearGradient(
								colors: [
									Color(hex: "#D4ACC8"), Color(hex: "#E5C6DB")
								],
								startPoint: .topLeading,
								endPoint: .bottomTrailing
							)
						)
				}
			}
		}
		.alert("Error", isPresented: $showError) {
			Button("OK") { showError = false }
		} message: {
			Text(errorMessage)
		}
		.background {
			Color(.systemBackground)
				.ignoresSafeArea()
				.onTapGesture {
					hideKeyboard()
				}
		}
	}
	
	private func signIn() {
		Task {
			do {
				authService.email = email
				authService.password = password
				try await authService.signIn()
			} catch {
				errorMessage = error.localizedDescription
				showError = true
			}
		}
	}
	
	private func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
										to: nil,
										from: nil,
										for: nil)
	}
}

struct AuthTextFieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 12)
					.fill(Color.gray.opacity(0.1))
			)
	}
}
