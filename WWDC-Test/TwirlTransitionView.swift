//
//  TwirlTransitionView.swift
//  WWDC-Test
//

import SwiftUI

struct Twirl: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase.isIdentity ? 1 : 0.5)
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : 10)
            .rotationEffect(
                .degrees(
                    phase == .willAppear ? 360 :
                        phase == .didDisappear ? -360 : .zero
                )
            )
            .brightness(phase == .willAppear ? 1 : 0)
    }
}

struct TwirlTransitionView: View {
    @State private var isVisible = true

    var body: some View {
        VStack(spacing: 40) {
            Toggle("Show Content", isOn: $isVisible.animation(.spring(duration: 0.6)))
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            if isVisible {
                VStack(spacing: 20) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.yellow)

                    Text("Twirl Transition")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(40)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.blue.gradient)
                )
                .transition(Twirl())
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Twirl Transition")
    }
}

#Preview {
    NavigationStack {
        TwirlTransitionView()
    }
}
