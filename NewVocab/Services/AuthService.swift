//
//  AuthService.swift
//  NewVocab
//
//  Created by MasterBi on 12/02/2025.
//

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
import CryptoKit

enum AuthState {
	case undefined, authenticated, unauthenticated
}

@Observable
class AuthService {
	var email = ""
	var password = ""
	var authState: AuthState = .undefined
	var isLoading = false  // Add this property
	private var userSessionManager = UserSessionManager.shared
	var userName: String? {
		Auth.auth().currentUser?.displayName
	}
	
	init() {
		// Configure Firebase first if not already configured
		if FirebaseApp.app() == nil {
			FirebaseApp.configure()
		}
		
		// Then check auth state
		if let currentUser = Auth.auth().currentUser {
			self.authState = .authenticated
		} else {
			self.authState = .unauthenticated
		}
		
		// Start listening to auth state changes
		listenToAuthState()
	}
	
	func listenToAuthState() {
		Auth.auth().addStateDidChangeListener { [weak self] auth, user in
			guard let self = self else { return }
			if let user = user {
				self.authState = .authenticated
				// TODO: link user to the user session
			} else {
				self.authState = .unauthenticated
			}
		}
	}
	
	func skipAuth() {
		authState = .unauthenticated
	}
	
	func signUp(fullName: String, username: String, email: String, password: String) async throws {
		guard !fullName.isEmpty, !username.isEmpty else {
			throw NSError(
				domain: "AuthError",
				code: -1,
				userInfo: [NSLocalizedDescriptionKey: "Name and username are required"]
			)
		}
		
		isLoading = true
		defer { isLoading = false }
		
		let result = try await Auth.auth().createUser(withEmail: email, password: password)
		let user = result.user
		
		// Update profile
		let changeRequest = user.createProfileChangeRequest()
		changeRequest.displayName = fullName
		try await changeRequest.commitChanges()
		
		// Store additional user data in Firestore
		try await storeUserData(user: user, username: username, fullName: fullName)
		
		// Link user to session
		userSessionManager.linkToUser(userId: user.uid)
	}
	
	private func storeUserData(user: User, username: String, fullName: String) async throws {
		let db = Firestore.firestore(database: "vocab")
		try await db.collection("users").document(user.uid).setData([
			"username": username,
			"fullName": fullName,
			"email": user.email ?? "",
			"createdAt": FieldValue.serverTimestamp()
		])
	}
	
	func signIn() async throws {
		isLoading = true
		defer { isLoading = false }
		
		let result = try await Auth.auth().signIn(withEmail: email, password: password)
		// TODO: Fetch user session data
	}
	
	func signOut() throws {
		try Auth.auth().signOut()
		authState = .undefined
	}
	private func fetchUserSessionData(userID: String) async throws -> UserSession {
		// TODO: Implement API call to fetch user data
		// For now, return empty data
		return UserSession(userId: userID)
	}
}
