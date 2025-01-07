//
//  ContentView.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = MainViewVM(service: MainViewServices())
	@State var showDetail: Bool = false
	@Namespace var namespace
	@State var selectedWord: FrenchWordType?
	@State var liked: [Like] = []
	var safeArea = EdgeInsets()
	
	var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				let size = geometry.size
				ZStack {
					if viewModel.isLoading {
						ProgressView("Loading...")
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					} else if let error = viewModel.error {
						VStack(spacing: 20) {
							Image(systemName: "wifi.slash")
								.font(.system(size: 50))
							Text("Connection Error")
								.font(.title2)
							Text(error.localizedDescription)
								.font(.caption)
								.multilineTextAlignment(.center)
								.foregroundColor(.gray)
							Button("Try Again") {
								Task {
									await viewModel.fetchWords()
								}
							}
							.buttonStyle(.bordered)
						}
						.padding()
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					
					ScrollView(.vertical, showsIndicators: false) {
						VStack(spacing: 0) {
							ForEach(viewModel.words.indices, id: \.self) { index in
								let word = viewModel.words[index]
								WordPageView(word: word, namespace: namespace)
									.id(word.id)
									.frame(width: size.width, height: size.height)
									.onTapGesture {
										withAnimation {
											selectedWord = word
											showDetail.toggle()
										}
									}
									.onTapGesture(count: 2) { position in
										let id  = UUID()
										liked.append(.init(id: id, tappedRect: position, isAnimated: false))
										withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
											if let idx = liked.firstIndex(where: { $0.id == id}) {
												liked[idx].isAnimated = true
											}
										} completion: {
											 liked.removeAll(where: { $0.id == id })
										}
									}
									.overlay(alignment: .topLeading) {
										HeartOverlayView(color: getWordColors(for: word)[0], liked: $liked, safeArea: safeArea)
									}
									
							}
						}
					}
					.scrollTargetBehavior(.paging)
					.opacity(showDetail ? 0 : 1)
					
					if showDetail {
						GeometryReader { geometry in
							let topEdge = geometry.safeAreaInsets.top + 60
							
							if let selectedWord = selectedWord {
								WordDetailView(word: selectedWord, namespace: namespace, showDetail: $showDetail, topEdge: topEdge)
									.frame(width: size.width, height: size.height)
							} else {
								Text("No word selected")
									.frame(width: size.width, height: size.height)
							}
						}
					}
				}
			}
			.ignoresSafeArea()
		}
	}
}

extension FrenchWordType: Identifiable {
	var id: UUID {
		switch self {
			case .verb(let verb): return verb.id
			case .noun(let noun): return noun.id
			case .adjective(let adj): return adj.id
			case .adverb(let adv): return adv.id
		}
	}
}

// MARK: - Detail Overlay
private struct DetailOverlayView: View {
	@Binding var selectedWord: FrenchWordType?
	@Binding var showDetail: Bool
	let size: CGSize
	
	var body: some View {
		GeometryReader { geometry in
			let topEdge = geometry.safeAreaInsets.top + 60
			
			if let selectedWord = selectedWord {
				WordDetailView(word: selectedWord, namespace: Namespace().wrappedValue, showDetail: $showDetail, topEdge: topEdge)
					.frame(width: size.width, height: size.height)
			} else {
				Text("No word selected")
					.frame(width: size.width, height: size.height)
			}
		}
	}
}

// MARK: - HeartOverlayView
private struct HeartOverlayView: View {
	let color: Color
	@Binding var liked: [Like]
	let safeArea: EdgeInsets
	
	var body: some View {
		ZStack {
			ForEach(liked) { like in
				AnimatedHeartView(
					color: color,
					like: like,
					safeArea: safeArea
				)
				.onDisappear {
					liked.removeAll(where: { $0.id == like.id })
				}
			}
		}
	}
}

// MARK: - Animated Heart View
private struct AnimatedHeartView: View {
	let color: Color
	let like: Like
	let safeArea: EdgeInsets
	
	var body: some View {
		Image(systemName: "suit.heart.fill")
			.font(.system(size: 75))
			.foregroundStyle(color)
			.frame(width: 100, height: 100)
			.animation(.smooth, body: { view in
				view
					.scaleEffect(like.isAnimated ? 1.8 : 1)
					.rotationEffect(.init(degrees: like.isAnimated ? 0 : .random(in: -30 ... 30)))
			})
			.offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
			.offset(y: like.isAnimated ? -(like.tappedRect.y + safeArea.top + 100) : 0)
	}
}
