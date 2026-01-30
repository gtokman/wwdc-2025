//
//  MeshGradientView.swift
//  WWDC-Test
//

import SwiftUI

struct MeshGradientView: View {
    @State private var animateGradient = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Static Mesh Gradient")
                .font(.headline)

            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.9, 0.3], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .black, .black, .black,
                    .blue, .blue, .blue,
                    .green, .green, .green
                ]
            )
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 24))

            Text("Animated Mesh Gradient")
                .font(.headline)

            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [animateGradient ? 0.1 : 0.9, animateGradient ? 0.7 : 0.3], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .purple, .indigo, .purple,
                    .orange, .pink, .orange,
                    .yellow, .mint, .yellow
                ]
            )
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Mesh Gradient")
    }
}

#Preview {
    NavigationStack {
        MeshGradientView()
    }
}
