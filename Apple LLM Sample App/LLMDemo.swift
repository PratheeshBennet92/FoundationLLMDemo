//
//  LLMDemo.swift
//  Apple LLM Sample App
//
//  Created by Pratheesh Bennet on 14/06/25.
//
import FoundationModels
import Combine

class LLMDemoViewModel: ObservableObject {
	@Published var textToPrompt: String = ""
	@Published var responseContent: String?
	func runDemo() async throws {
		let prompt = textToPrompt
		let session = LanguageModelSession()
		let response = try await session.respond(to: prompt)
		print("LLM Response: \(response.content)")
		self.responseContent = response.content
	}
}

