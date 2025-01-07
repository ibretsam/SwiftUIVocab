//
//  Config.swift
//  NewVocab
//
//  Created by MasterBi on 07/01/2025.
//

import Foundation

struct Config {
	let serverHost: String
	let serverPort: Int
	
	static func load() -> Config {
		guard let path = Bundle.main.path(forResource: "config", ofType: "json"),
			  let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
			  let config = try? JSONDecoder().decode(Config.self, from: data) else {
			return Config(serverHost: "localhost", serverPort: 5002) // Default values
		}
		return config
	}
}

extension Config: Decodable {
	enum CodingKeys: String, CodingKey {
		case serverHost = "server_host"
		case serverPort = "server_port"
	}
}
