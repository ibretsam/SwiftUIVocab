//
//  AppDelegate.swift
//  NewVocab
//
//  Created by MasterBi on 12/02/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		// Configure Firebase first if not already configured
		if FirebaseApp.app() == nil {
			FirebaseApp.configure()
		}
		
		// Using debug provider only for development
		let providerFactory = AppCheckDebugProviderFactory()
		AppCheck.setAppCheckProviderFactory(providerFactory)
		
		return true
	}
}
