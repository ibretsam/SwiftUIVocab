//
//  CustomStackView.swift
//  NewVocab
//
//  Created by MasterBi on 30/9/24.
//
import SwiftUI

let TITLEBAR_HEIGHT: CGFloat = 45
let CORNER_RADIUS: CGFloat = 14
let MAX_OFFSET: CGFloat = 160

struct CustomStackView<Title: View, Content: View>: View {
    var titleView: Title
    var contentView: Content
    @State private var topOffset: CGFloat = 0
    @State private var bottomOffset: CGFloat = 0
    
    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
        self.contentView = contentView()
        self.titleView = titleView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .font(.callout)
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(height: TITLEBAR_HEIGHT)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.leading)
                .background(
                    BlurView(removeAllFilters: true)
                        .blur(radius: 9, opaque: true)
                        .background(.black.opacity(0.05))
                        .opacity(bottomOffset < TITLEBAR_HEIGHT ? 1 : 0)
                )
                .cornerRadius(CORNER_RADIUS, corners: bottomOffset < TITLEBAR_HEIGHT ? .allCorners : [.topLeft, .topRight])
                .zIndex(1)
            
            VStack {
                
                Divider()
                    .overlay(Color.white.opacity(0.8))
                
                contentView
                    .foregroundColor(.white)
            }
            .offset(y: topOffset >= MAX_OFFSET ? 0 : topOffset - MAX_OFFSET)
            .zIndex(0)
            .clipped()
        }
        .background(
            BlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.black.opacity(0.05))
                .opacity(bottomOffset < TITLEBAR_HEIGHT ? 0 : 1)
        )
        .cornerRadius(CORNER_RADIUS)
        .opacity(getOpacity())
        .offset(y: topOffset >= MAX_OFFSET ? 0 : MAX_OFFSET - topOffset)
        .background(
            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let maxY = proxy.frame(in: .global).maxY
                
                DispatchQueue.main.async {
                    self.topOffset = minY
                    self.bottomOffset = maxY - MAX_OFFSET
                }
                
                return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: $bottomOffset))
    }
    
    // Opacity...
    func getOpacity() -> CGFloat {
        
        if bottomOffset < 34 {
            let progress = bottomOffset / 34
            
            return progress
        }
        
        return 1
    }
}

struct BlurView: UIViewRepresentable, ShapeStyle {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> BlurViewHelper {
        return BlurViewHelper(removeAllFilters: removeAllFilters)
    }
    
    func updateUIView(_ uiView: BlurViewHelper, context: Context) {
        
    }
    
    func _classicStyle() -> AnyShapeStyle {
        return AnyShapeStyle(self)
    }
}

class BlurViewHelper: UIVisualEffectView {
    init(removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else {
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
}

struct CornerModifier: ViewModifier {
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        if bottomOffset < TITLEBAR_HEIGHT {
            content
        } else {
            content
                .cornerRadius(CORNER_RADIUS)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCorner(corners: corners, radius: radius))
    }
}
