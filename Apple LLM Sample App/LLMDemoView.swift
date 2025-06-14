import SwiftUI

struct LLMDemoView: View {
	@State private var isLoading: Bool = false
	@StateObject private var viewModel = LLMDemoViewModel()
	
	var body: some View {
		VStack(spacing: 20) {
			TextField("Text to Prompt", text: $viewModel.textToPrompt)
				.textFieldStyle(.roundedBorder)
				.padding()
			if isLoading {
				ProgressView()
					.progressViewStyle(.circular)
					.scaleEffect(1.5)
			}
			if let content = viewModel.responseContent {
				Text("\(content)")
					.padding()
			} else {
				Text("No response yet.")
					.foregroundColor(.secondary)
			}
			Button("Run Demo") {
				Task {
					isLoading = true
					viewModel.responseContent = ""
					try? await viewModel.runDemo()
					await MainActor.run { isLoading = false }
				}
			}
			.buttonStyle(.borderedProminent)
		}
		.padding()
	}
}
