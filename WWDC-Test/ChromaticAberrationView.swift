//
//  ChromaticAberrationView.swift
//  WWDC-Test
//

import SwiftUI

struct ChromaticAberrationView: View {
    @State var counter: Int = 0
    @State var origin: CGPoint = .zero

    var body: some View {
        VStack {
            Text("Tap the image to trigger chromatic aberration")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Image(systemName: "camera.aperture")
                .font(.system(size: 120))
                .foregroundStyle(.red.gradient)
                .frame(width: 300, height: 300)
                .background(
                    LinearGradient(
                        colors: [.red.opacity(0.3), .cyan.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .onPressingChanged { point in
                    if let point {
                        origin = point
                        counter += 1
                    }
                }
                .modifier(ChromaticAberrationEffect(at: origin, trigger: counter))
                .shadow(radius: 3, y: 2)

            Spacer()
        }
        .padding()
        .navigationTitle("Chromatic Aberration")
    }
}

struct ChromaticAberrationEditorView: View {
    @State var origin: CGPoint = .zero
    @State var time: TimeInterval = 0.3
    @State var intensity: Double = 20
    @State var decay: Double = 3

    var body: some View {
        VStack {
            GroupBox {
                Grid {
                    GridRow {
                        VStack(spacing: 4) {
                            Text("Time")
                            Slider(value: $time, in: 0 ... 2)
                        }
                        VStack(spacing: 4) {
                            Text("Intensity")
                            Slider(value: $intensity, in: 0 ... 60)
                        }
                    }
                    GridRow {
                        VStack(spacing: 4) {
                            Text("Decay")
                            Slider(value: $decay, in: 0 ... 10)
                        }
                    }
                }
                .font(.subheadline)
            }

            Spacer()

            Image(systemName: "camera.aperture")
                .font(.system(size: 120))
                .foregroundStyle(.red.gradient)
                .frame(width: 300, height: 300)
                .background(
                    LinearGradient(
                        colors: [.red.opacity(0.3), .cyan.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .modifier(ChromaticAberrationModifier(
                    origin: origin,
                    elapsedTime: time,
                    duration: 2,
                    intensity: intensity,
                    decay: decay
                ))
                .shadow(radius: 3, y: 2)
                .onTapGesture {
                    origin = $0
                }

            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Aberration Editor")
    }
}

// MARK: - Chromatic Aberration Effect

struct ChromaticAberrationEffect<T: Equatable>: ViewModifier {
    var origin: CGPoint
    var trigger: T

    init(at origin: CGPoint, trigger: T) {
        self.origin = origin
        self.trigger = trigger
    }

    func body(content: Content) -> some View {
        let origin = origin
        let duration = duration

        content.keyframeAnimator(
            initialValue: 0,
            trigger: trigger
        ) { view, elapsedTime in
            view.modifier(ChromaticAberrationModifier(
                origin: origin,
                elapsedTime: elapsedTime,
                duration: duration
            ))
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }

    var duration: TimeInterval { 2 }
}

struct ChromaticAberrationModifier: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var duration: TimeInterval

    var intensity: Double = 20
    var decay: Double = 3

    func body(content: Content) -> some View {
        let shader = ShaderLibrary.ChromaticAberration(
            .float2(origin),
            .float(elapsedTime),
            .float(intensity),
            .float(decay)
        )

        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration

        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }

    var maxSampleOffset: CGSize {
        CGSize(width: intensity, height: intensity)
    }
}

#Preview("Chromatic Aberration") {
    NavigationStack {
        ChromaticAberrationView()
    }
}

#Preview("Aberration Editor") {
    NavigationStack {
        ChromaticAberrationEditorView()
    }
}
