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
	@State private var showSidebar = false
	@State private var offset: CGFloat = 0
	@Namespace var namespace
	@State var selectedWord: FrenchWordType?
	@State var currentWord: FrenchWordType?
	@Environment(AuthService.self) var authService
	@State private var currentPage: Int = 0
	@State private var showSignIn = false
	@State private var showSignUp = false
	
	var body: some View {
		let sidebarWidth: CGFloat = UIScreen.main.bounds.width * 0.7
		
		NavigationStack {
			ZStack {
				// Only show sidebar when there are words loaded
				if !viewModel.isLoading && viewModel.error == nil && !viewModel.words.isEmpty {
					SidebarView(
						isOpen: Binding(
							get: { showSidebar },
							set: { newValue in
								withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
									showSidebar = newValue
									offset = newValue ? -sidebarWidth : 0
								}
							}
						),
						navigateToSignIn: { showSignIn = true },
						navigateToSignUp: { showSignUp = true }
					)
					.frame(width: sidebarWidth)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.scaleEffect(calculateSidebarScale(sidebarWidth: sidebarWidth))
					.background {
						Color("SidebarBackground", bundle: nil)
							.defaultValue(Color.black)
							.ignoresSafeArea()
					}
				}
				
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
						
						ZStack {
							ScrollView(.vertical, showsIndicators: false) {
								VStack(spacing: 0) {
									ForEach(viewModel.words.indices, id: \.self) { index in
										let word = viewModel.words[index]
										
										WordPageView(word: word, namespace: namespace)
											.id(word.id)
											.frame(width: size.width, height: UIScreen.main.bounds.height)
											.background(
												GeometryReader { geo in
													Color.clear
														.preference(key: PageCenterPreferenceKey.self,
																	value: [index: geo.frame(in: .global).midY])
												}
											)
											.onAppear {
												currentWord = word
												UserSessionManager.shared.updateWordInteraction(wordId: word.id) { interaction in
													interaction.seenCount += 1
													interaction.lastSeenAt = Date()
												}
											}
											.onTapGesture {
												withAnimation {
													selectedWord = word
													showDetail.toggle()
													
													UserSessionManager.shared.updateWordInteraction(wordId: word.id) { interaction in
														interaction.hasViewedDetail = true
													}
												}
											}
									}
								}
							}
							.ignoresSafeArea()
							.coordinateSpace(name: "scrollView")
							// When the centers update, choose the page whose midY is closest to the screen's center.
							.onPreferenceChange(PageCenterPreferenceKey.self) { centers in
								let screenMidY = UIScreen.main.bounds.midY
								if let closestPage = centers.min(by: { abs($0.value - screenMidY) < abs($1.value - screenMidY) })?.key {
									if currentPage != closestPage {
										currentPage = closestPage
										print("Current page: \(currentPage)")
										currentWord = viewModel.words[currentPage]
									}
								}
							}
							.scrollTargetBehavior(.paging)
							
							// Menu button
							VStack {
								HStack {
									Spacer()
									if viewModel.words.count > 0 {
										Button {
											withAnimation(.spring(response: 0.5)) {
												showSidebar.toggle()
												offset = showSidebar ? -sidebarWidth : 0
											}
										} label: {
											Image(systemName: "line.3.horizontal")
												.font(.title2)
												.foregroundStyle(
													LinearGradient(
														colors: currentWord.flatMap { word in
															let colors = getWordColors(for: word)
															return [colors[0], colors[1]]
														} ?? [.gray, .gray.opacity(0.7)],
														startPoint: .topLeading,
														endPoint: .bottomTrailing
													)
												)
										}
										.padding(.trailing, 30)
										.padding(.top, 75)
									}
								}
								Spacer()
							}
						}
						
						if showDetail {
							GeometryReader { geometry in
								let topEdge = geometry.safeAreaInsets.top
								
								if let selectedWord = selectedWord {
									WordDetailView(word: selectedWord, namespace: namespace, showDetail: $showDetail, topEdge: topEdge + 60)
										.frame(width: size.width, height: size.height)
								} else {
									Text("No word selected")
										.frame(width: size.width, height: size.height)
								}
							}
						}
					}
				}
				// Only show overlay when sidebar is visible
				.overlay {
					if !viewModel.isLoading && viewModel.error == nil {
						Color.black
							.opacity(calculateOverlayOpacity(sidebarWidth: sidebarWidth))
							.ignoresSafeArea()
							.allowsHitTesting(showSidebar)
							.onTapGesture {
								withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
									showSidebar = false
									offset = 0
								}
							}
					}
				}
				.cornerRadius(40, corners: [.topRight, .bottomRight])
				.ignoresSafeArea()
				.shadow(color: .black.opacity(0.3), radius: 10 * (-offset/sidebarWidth))
				.offset(x: offset)
				.gesture(
					DragGesture()
						.onChanged { value in
							if !showSidebar && value.translation.width < 0 { return }
							if showSidebar {
								offset = -sidebarWidth + value.translation.width
							}
						}
						.onEnded { value in
							withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
								if value.predictedEndTranslation.width > sidebarWidth/2 {
									offset = 0
									showSidebar = false
								} else {
									offset = -sidebarWidth
									showSidebar = true
								}
							}
						}
				)
			}
			.navigationDestination(isPresented: $showSignIn) {
				SignInView()
			}
			.navigationDestination(isPresented: $showSignUp) {
				SignUpView()
			}
		}
		
	}
	
	private func calculateSidebarScale(sidebarWidth: CGFloat) -> CGFloat {
		let minScale: CGFloat = 0.9
		let maxScale: CGFloat = 1.0
		let progress = -offset / sidebarWidth // 0 when closed, 1 when fully open
		return minScale + (progress * (maxScale - minScale))
	}
	
	private func calculateOverlayOpacity(sidebarWidth: CGFloat) -> Double {
		let maxOpacity: Double = 0.5 // Maximum darkness
		let progress = -offset / sidebarWidth // Convert offset to progress (0 to 1)
		return progress * maxOpacity
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

struct PageCenterPreferenceKey: PreferenceKey {
	static var defaultValue: [Int: CGFloat] = [:]
	static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
		value.merge(nextValue(), uniquingKeysWith: { $1 })
	}
}
