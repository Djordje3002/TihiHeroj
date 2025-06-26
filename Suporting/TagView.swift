//
//  TagView.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 12.11.24..
//

import SwiftUI

struct TagView: View {
    @Binding var tag: Tag
    @State private var isTapped = false
    
    var body: some View {
        Text(tag.title)
            .font(.system(size: 13))
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .foregroundColor(tag.selected ? .white : .thunder700)
            .background(tag.selected ? Color.lilac600 : Color.white)
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(tag.selected ? Color.lilac600 : Color.thunder700, lineWidth: 1)
            )
            .scaleEffect(isTapped ? 0.95 : 1.0)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isTapped = true
                }
                tag.selected.toggle()
                withAnimation(.easeInOut(duration: 0.1)) {
                    isTapped = false
                }
            }
            .accessibilityLabel(tag.title)
            .accessibilityValue(tag.selected ? "Selected" : "Not selected")
            .accessibilityAction {
                tag.selected.toggle()
            }
    }
}

//#Preview {
//    // Wrapper view to provide a Binding for the preview
//    struct TagViewPreviewWrapper: View {
//        @State private var tag = Tag(title: "Sample Tag", selected: false)
//        
//        var body: some View {
//            TagView(tag: $tag)
//        }
//    }
//    
//    return TagViewPreviewWrapper()
//}
