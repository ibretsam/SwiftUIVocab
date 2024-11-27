//
//  WordDetailView.swift
//  NewVocab
//
//  Created by MasterBi on 21/9/24.
//

import SwiftUI
import AVFoundation

struct HeaderView: View {
	let word: FrenchWordType
	let namespace: Namespace.ID
	let synthesizer = AVSpeechSynthesizer()
	@Binding var offset: CGFloat
	@Binding var selectedTab: Int
	
	
	
	private func getWordText(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.word
			case .noun(let noun): return noun.word
			case .adjective(let adj): return adj.word
			case .adverb(let adv): return adv.word
		}
	}
	
	private func getIpaText(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.ipa
			case .noun(let noun): return noun.ipa
			case .adjective(let adj): return adj.ipa
			case .adverb(let adv): return adv.ipa
		}
	}
	
	private func getEnglishMeaning(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.englishMeaning
			case .noun(let noun): return noun.englishMeaning
			case .adjective(let adj): return adj.englishMeaning
			case .adverb(let adv): return adv.englishMeaning
		}
	}
	
	var grammaticalCategory: GrammaticalCategory {
		switch word {
			case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.grammaticalCategory
			case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.grammaticalCategory
			case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.grammaticalCategory
			case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.grammaticalCategory
		}
	}
	
	func getSubtitleText(word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb):
				if selectedTab == 0 {
					return "Overview"
				} else {
					return verb.conjugation.moods[selectedTab - 1].name.rawValue
				}
			default:
				return selectedTab == 0 ? "Definition" : "Examples"
		}
	}
	
	var body : some View {
		Text(getWordText(word))
			.font(.system(size: 56, weight: .bold, design: .serif))
			.matchedGeometryEffect(id: getWordText(word), in: namespace)
			.foregroundStyle(.white)
		
		ZStack {
			HStack {
				Text("/\(getIpaText(word))/")
					.font(.title2)
					.foregroundStyle(.white)
					.matchedGeometryEffect(id: getIpaText(word), in: namespace)
					.opacity(getTitleOpacity(offset: offset))
				
				Button(action: {
					speakWord(wordText: getWordText(word), synthesizer: synthesizer)
				}) {
					Image(systemName: "speaker.wave.2")
						.font(.title2)
						.foregroundColor(.white)
				}
				.matchedGeometryEffect(id: word.id, in: namespace)
				.opacity(getTitleOpacity(offset: offset))
			}
			
			Text(getSubtitleText(word: word).uppercased())
				.font(.caption)
				.foregroundStyle(.white)
				.opacity(1 - getTitleOpacity(offset: offset + 40))
		}
		
		Text("(\(grammaticalCategory.rawValue)) \(getEnglishMeaning(word))")
			.font(.title3)
			.foregroundStyle(.white)
			.matchedGeometryEffect(id: getEnglishMeaning(word), in: namespace)
			.opacity(getTitleOpacity(offset: offset - 20))
	}
}

struct WordDetailView: View {
    let word: FrenchWordType
    let namespace: Namespace.ID
    @Binding var showDetail: Bool
    @State var offset: CGFloat = 0
    @State private var selectedTab: Int = 0
    @State private var stackContentHeight: CGFloat = 0
    @State private var vStackHeight: CGFloat = 0
    @State private var totalPages: Int
    @State private var synthesizer = AVSpeechSynthesizer()
    @State private var isBookmarked: Bool = false
    var topEdge: CGFloat
	
	private func getWordText(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.word
			case .noun(let noun): return noun.word
			case .adjective(let adj): return adj.word
			case .adverb(let adv): return adv.word
		}
	}
	
	private func getIpaText(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.ipa
			case .noun(let noun): return noun.ipa
			case .adjective(let adj): return adj.ipa
			case .adverb(let adv): return adv.ipa
		}
	}
	
	private func getEnglishMeaning(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.englishMeaning
			case .noun(let noun): return noun.englishMeaning
			case .adjective(let adj): return adj.englishMeaning
			case .adverb(let adv): return adv.englishMeaning
		}
	}
    
    var grammaticalCategory: GrammaticalCategory {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.grammaticalCategory
        }
    }
    
    var combinedGradientColors: [Color] {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.combinedGradientColors
        }
    }
    
    init(word: FrenchWordType, namespace: Namespace.ID, showDetail: Binding<Bool>, topEdge: CGFloat) {
        self.word = word
        self.namespace = namespace
        self._showDetail = showDetail
        self.topEdge = topEdge
        
        let pages: Int
        switch word {
        case .verb(let verb):
            pages = verb.conjugation.moods.count + 1
        default:
            pages = 2
        }
        self._totalPages = State(initialValue: pages)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    VStack {
						VStack {
							HeaderView(word: word, namespace: namespace, offset: $offset, selectedTab: $selectedTab)
						}
                        .background(
                            GeometryReader { vStackGeometry in
                                Color.clear
                                    .onAppear {
                                        vStackHeight = vStackGeometry.size.height
                                    }
                                    .onChange(of: vStackGeometry.size.height) { oldHeight, newHeight in
                                        vStackHeight = newHeight
                                    }
                            }
                        )
                        .offset(y: -offset)
                        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                        .offset(y: getTitleOffset(offset: offset))
                        .onTapGesture {
                            withAnimation {
                                showDetail.toggle()
                            }
                        }
                        
                        // Pass the VStack height to getPageHeight
                        switch word {
                        case .verb(let verb):
                            FrenchVerbCustomTab(word: verb, selectedTab: $selectedTab, stackContentHeight: $stackContentHeight)
                                .frame(height: withAnimation(.easeInOut) {
                                    getPageHeight(currentHeight: stackContentHeight, vStackHeight: vStackHeight)
                                })
                        case .noun(let noun):
                            FrenchNounCustomTab(word: noun, selectedTab: $selectedTab, stackContentHeight: $stackContentHeight)
                                .frame(height: withAnimation(.easeInOut) {
                                    getPageHeight(currentHeight: stackContentHeight, vStackHeight: vStackHeight)
                                })
                        case .adjective(let adj):
                            FrenchAdjectiveCustomTab(word: adj, selectedTab: $selectedTab, stackContentHeight: $stackContentHeight)
                                .frame(height: withAnimation(.easeInOut) {
                                    getPageHeight(currentHeight: stackContentHeight, vStackHeight: vStackHeight)
                                })
                        case .adverb(let adv):
                            FrenchAdverbCustomTab(word: adv, selectedTab: $selectedTab, stackContentHeight: $stackContentHeight)
                                .frame(height: withAnimation(.easeInOut) {
                                    getPageHeight(currentHeight: stackContentHeight, vStackHeight: vStackHeight)
                                })
                        }
                    }
                    .padding(.top, 25)
                    .padding(.top, topEdge)
                    .overlay {
						GeometryReader { geometry in
							let minY = geometry.frame(in: .global).minY
							
							Color.clear
								.onAppear {
									self.offset = minY + 20
								}
								.onChange(of: geometry.frame(in: .global).minY) { _, newValue in
									self.offset = newValue + 20
								}
						}                    }
                    .edgesIgnoringSafeArea(.all)
                }
                .background(LinearGradient(
                    gradient: .init(colors: combinedGradientColors),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                
                NavigationBar(isBookmarked: $isBookmarked, selectedTab: $selectedTab, showDetail: $showDetail, totalPages: $totalPages)
                
            }
        }
    }
    
    // Modify getPageHeight to account for the VStack height
    func getPageHeight(currentHeight: CGFloat, vStackHeight: CGFloat) -> CGFloat {
        var height: CGFloat
        
        // Subtract the VStack height from the screen height
        if (currentHeight < UIScreen.main.bounds.height - vStackHeight) {
            height = UIScreen.main.bounds.height - vStackHeight
        } else {
            height = currentHeight + 100
        }
        
        return height + 20
    }
}

struct NavigationBar: View {
	@Binding var isBookmarked: Bool
	@Binding var selectedTab: Int
	@Binding var showDetail: Bool
	@Binding var totalPages: Int
	
	
	var body: some View {
		VStack {
			HStack {
				
				Button {
					withAnimation(.spring()) {
						isBookmarked.toggle()
					}
				} label: {
					Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
						.font(.title2)
						.foregroundColor(.white)
				}
				.contentTransition(.symbolEffect(.replace))
				.padding(.leading, 15)
				
				Spacer()
				
				CustomPageControl(numberOfPages: totalPages, currentPage: $selectedTab)
					.padding(.top, 10)
				
				Spacer()
				
				Button {
					withAnimation {
						showDetail.toggle()
					}
				} label: {
					Image(systemName: "list.bullet")
						.font(.title2)
						.foregroundColor(.white)
				}
				.padding(.trailing, 15)
			}
			
			Spacer()
		}
		.frame(height: 81)
		.background(
			BlurView(removeAllFilters: true)
				.blur(radius: 20, opaque: true)
				.background(.black.opacity(0.1))
		)
	}
}


struct PreviewWrapper: View {
    @Namespace var namespace
    @State var showDetail: Bool = false
    var body: some View {
        GeometryReader { geometry in
            let topEdge = geometry.safeAreaInsets.top
            
            WordDetailView(word: WordPreview.shared.frenchWords[3], namespace: namespace, showDetail: $showDetail, topEdge: topEdge)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

//#Preview {
//    PreviewWrapper()
//}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func luminance() -> Double {
        let uiColor = UIColor(self)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
    
    func isLight() -> Bool {
        return luminance() > 0.5
    }
    
    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}


