//
//  NewVocabApp.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

import SwiftUI
import SwiftData

@main
struct NewVocabApp: App {
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@State private var authService = AuthService()
	
	let container: ModelContainer = {
		let schema = Schema([
			FrenchVerb.self,
			FrenchNoun.self,
			FrenchAdjective.self,
			FrenchAdverb.self,
			UserSession.self,
			WordInteraction.self
		])
		let container = try! ModelContainer(for: schema, configurations: [])
		return container
	}()
	
	var body: some Scene {
		WindowGroup {
			Group {
				switch authService.authState {
					case .undefined:
						WelcomeScreen()
					case .authenticated, .unauthenticated:
						MainView()
				}
			}
				.environment(authService)
				.onAppear {
					UserSessionManager.shared.initialize(modelContext: container.mainContext)
					authService.listenToAuthState()
				}
		}
		.modelContainer(container)
	}
}
