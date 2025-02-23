//
//  SidebarView.swift
//  NewVocab
//
//  Created by MasterBi on 22/02/2025.
//
import SwiftUI

struct SidebarView: View {
	@Binding var isOpen: Bool
	@Environment(AuthService.self) private var authService
	var navigateToSignIn: () -> Void
	var navigateToSignUp: () -> Void
	
	var body: some View {
		ZStack {
			VStack(alignment: .leading, spacing: 0) {
				// Profile Section
				VStack(alignment: .leading, spacing: 15) {
					if authService.authState == .authenticated {
						// Profile Image
						Circle()
							.fill(Color.gray.opacity(0.2))
							.overlay {
								Image(systemName: "person.fill")
									.font(.system(size: 30))
									.foregroundColor(.white)
							}
							.frame(width: 70, height: 70)
						
						Text(authService.userName ?? "User")
							.font(.title3)
							.bold()
							.foregroundStyle(.white)
						
						Text(authService.email)
							.font(.subheadline)
							.foregroundStyle(.gray)
					} else {
						// Auth Buttons
						VStack(spacing: 16) {
							Button {
								isOpen = false
								navigateToSignUp()
							} label: {
								Text("Create Account")
									.font(.headline)
									.foregroundStyle(.white)
									.frame(maxWidth: .infinity)
									.padding()
									.background(
										LinearGradient(
											colors: [
												Color(hex: "#F2A583"), Color(hex: "#FFBEA1")
											],
											startPoint: .topTrailing,
											endPoint: .bottomLeading
										)
									)
									.clipShape(RoundedRectangle(cornerRadius: 14))
							}
							
							Button {
								isOpen = false
								navigateToSignIn()
							} label: {
								Text("Sign In")
									.font(.headline)
									.foregroundStyle(.white)
									.frame(maxWidth: .infinity)
									.padding()
									.background(
										LinearGradient(
											colors: [
												Color(hex: "#8FB8CC"), Color(hex: "#B8CCE0")
											],
											startPoint: .topLeading,
											endPoint: .bottomTrailing
										)
									)
									.clipShape(RoundedRectangle(cornerRadius: 14))
							}
						}
						.padding(.horizontal, 30)
					}
				}
				.padding(.horizontal, 30)
				.padding(.top, 60)
				.padding(.bottom, 20)
				
				if authService.authState == .authenticated {
					Divider()
						.background(.gray.opacity(0.3))
						.padding(.horizontal, 20)
					
					// Menu Items
					authenticatedMenuItems
					
					Spacer()
					
					// Logout Button
					logoutButton
				}
			}
			.frame(maxHeight: .infinity)
			
			closeButton
		}
		.background(Color("SidebarBackground", bundle: nil)
			.defaultValue(Color.black.opacity(0.9))
			.ignoresSafeArea())
	}
	
	private var authenticatedMenuItems: some View {
		VStack(alignment: .leading, spacing: 25) {
			MenuButton(
				title: "Profile",
				icon: "person.circle",
				action: {}
			)
			
			MenuButton(
				title: "Saved Words",
				icon: "bookmark.fill",
				action: {}
			)
			
			MenuButton(
				title: "Settings",
				icon: "gearshape.fill",
				action: {}
			)
		}
		.padding(.top, 30)
		.padding(.horizontal, 30)
	}
	
	private var logoutButton: some View {
		Button {
			Task {
				try? authService.signOut()
			}
		} label: {
			HStack {
				Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
					.font(.headline)
				Spacer()
			}
			.foregroundStyle(.red)
			.padding()
			.background(.red.opacity(0.1))
			.clipShape(RoundedRectangle(cornerRadius: 10))
		}
		.padding(.horizontal, 30)
		.padding(.bottom, 30)
	}
	
	private var closeButton: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					withAnimation {
						isOpen = false
					}
				} label: {
					Image(systemName: "xmark")
						.font(.title3)
						.foregroundStyle(.white)
						.padding(20)
				}
				.padding(.trailing, 20)
			}
			Spacer()
		}
	}
}

struct MenuButton: View {
	let title: String
	let icon: String
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Label(title, systemImage: icon)
				.font(.headline)
				.foregroundStyle(.white)
		}
	}
}

extension Color {
	func defaultValue(_ color: Color) -> Color {
		if let _ = Bundle.main.path(forResource: self.description, ofType: nil) {
			return self
		}
		return color
	}
}
