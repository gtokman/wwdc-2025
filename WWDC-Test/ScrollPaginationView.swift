//
//  ScrollPaginationView.swift
//  WWDC-Test
//

import SwiftUI

struct ScrollPaginationView: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 22) {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 24)
                        .fill(color.gradient)
                        .frame(width: 300, height: 400)
                        .overlay {
                            Text(color.description.capitalized)
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 44)
        .scrollTargetBehavior(.paging)
        .navigationTitle("Scroll Pagination")
    }
}

#Preview {
    NavigationStack {
        ScrollPaginationView()
    }
}
