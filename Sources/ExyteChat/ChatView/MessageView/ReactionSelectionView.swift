//
//  ReactionSelectionView.swift
//  Chat
//
//  Created by Brandon Toms on 1/24/25.
//

import SwiftUI
import enum FloatingButton.Alignment

struct ReactionSelectionView: View {
        
    let emojis:[String] = ["👍", "👎", "❤️", "🤣", "‼️", "❓", "🥳", "💪", "🔥", "💔", "😭"]
   
    var color:Color
    var alignment: Alignment
    var leadingPadding:CGFloat
    var trailingPadding:CGFloat

    var reactionClosure:((String) -> Void)
    
    private let horizontalPadding:CGFloat = 16
    private let verticalPadding:CGFloat = 10
    
    var body: some View {
        HStack(spacing: 0) {
            if alignment == .left {
                Color.clear.viewSize(leadingPadding)
            } else {
                Color.clear.frame(width: trailingPadding * 3, height: trailingPadding)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: horizontalPadding) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button(action: { reactionClosure(emoji) }) {
                            Text(emoji)
                                .font(.title3)
                        }
                        
                    }
                    Button(action: { print("show other emojis") }) {
                        Image(systemName: "face.smiling")
                            .foregroundStyle(.white)
                    }
                }
                .padding([.top, .bottom], verticalPadding)
                .padding([.leading, .trailing], horizontalPadding)
            }
            .padding([.leading, .trailing], 4)
            .modifier(InteriorRadialShadow(color: color))
            .background(
                Capsule(style: .continuous)
                    .foregroundStyle(color)
            )

            if alignment == .right {
                Color.clear.viewSize(trailingPadding)
            } else {
                Spacer()
                Color.clear.frame(width: trailingPadding * 3, height: trailingPadding)
            }
        }
    }
}

internal struct InteriorRadialShadow: ViewModifier {
    var color:Color
    
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                GeometryReader { proxy in
                    Capsule(style: .continuous)
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [.clear, color]), center: .center, startRadius: proxy.size.width / 2 - 20, endRadius: proxy.size.width / 2 - 5)
                        )
                }

                Capsule(style: .continuous)
                    .stroke(color, lineWidth: 3)
            }
            .allowsHitTesting(false)
        )
    }
}


#Preview {
    VStack {
        ReactionSelectionView(color: .gray, alignment: .left, leadingPadding: 20, trailingPadding: 20) { selectedEmoji in
            print(selectedEmoji)
        }
    }
    .chatTheme(.init())
    .frame(width: 400, height: 100)
    .border(.blue)
}
