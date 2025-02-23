//
//  SignUpView.swift
//  NewVocab
//
//  Created by MasterBi on 22/02/2025.
//

import SwiftUI

struct SignUpView: View {
	@Environment(AuthService.self) private var authService
	@Environment(\.dismiss) private var dismiss
	@State private var email = ""
	@State private var password = ""
	@State private var confirmPassword = ""
	@State private var showError = false
	@State private var errorMessage = ""
	@State private var fullName = ""
	@State private var username = ""
	
	var body: some View {
		ScrollView {
			ZStack {
				WordBackgroundView(word: WordPreview.shared.frenchWords[1])
					.scaleEffect(3)
				VStack(spacing: 24) {
					// Header
					VStack(spacing: 12) {
						Text("Create Account")
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
						
						Text("Start your French learning journey")
							.font(.subheadline)
							.foregroundStyle(.gray)
					}
					.padding(.top, 40)
					
					// Form Fields
					VStack(spacing: 16) {
						TextField("Full Name", text: $fullName)
							.textFieldStyle(AuthTextFieldStyle())
							.textContentType(.name)
							.autocapitalization(.words)
						
						TextField("Username", text: $username)
							.textFieldStyle(AuthTextFieldStyle())
							.textContentType(.username)
							.autocapitalization(.none)
						
						TextField("Email", text: $email)
							.textFieldStyle(AuthTextFieldStyle())
							.textContentType(.emailAddress)
							.autocapitalization(.none)
						
						SecureField("Password", text: $password)
							.textFieldStyle(AuthTextFieldStyle())
						
						SecureField("Confirm Password", text: $confirmPassword)
							.textFieldStyle(AuthTextFieldStyle())
					}
					.padding(.top, 20)
					
					// Sign Up Button
					Button(action: signUp) {
						if authService.isLoading {
							ProgressView()
								.tint(.white)
						} else {
							Text("Create Account")
								.font(.headline)
						}
					}
					.frame(maxWidth: .infinity)
					.foregroundStyle(.white)
					.padding()
					.background(
						LinearGradient(
							colors: [
								Color(hex: "#98C9A3"), Color(hex: "#C2E0CC")
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
									Color(hex: "#98C9A3"),
									Color(hex: "#C2E0CC")
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
	
	private func signUp() {
		guard password == confirmPassword else {
			errorMessage = "Passwords don't match"
			showError = true
			return
		}
		
		Task {
			do {
				try await authService.signUp(
					fullName: fullName,
					username: username,
					email: email,
					password: password
				)
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
