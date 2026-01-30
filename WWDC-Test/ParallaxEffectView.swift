//
//  ParallaxEffectView.swift
//  WWDC-Test
//

import SwiftUI

struct ParallaxEffectView: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(colors, id: \.self) { color in
                    VStack(spacing: 8) {
                        ZStack {
                            LinearGradient(
                                colors: [color, color.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .offset(x: phase.value * -250)
                            }

                            Image(systemName: "star.fill")
                                .font(.system(size: 80))
                                .foregroundStyle(.white)
                        }
                        .containerRelativeFrame(.horizontal)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 32))

                        Text(color.description.capitalized)
                            .font(.headline)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 32)
        .scrollTargetBehavior(.paging)
        .navigationTitle("Parallax Effect")
    }
}

#Preview {
    NavigationStack {
        ParallaxEffectView()
    }
}
