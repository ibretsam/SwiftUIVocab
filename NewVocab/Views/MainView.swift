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
	
	var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				let size = geometry.size
				ZStack {
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
