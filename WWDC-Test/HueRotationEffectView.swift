//
//  HueRotationEffectView.swift
//  WWDC-Test
//

import SwiftUI

struct HueRotationEffectView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<10, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.purple)
                        .frame(height: 150)
                        .visualEffect { content, proxy in
                            content
                                .hueRotation(Angle(degrees: proxy.frame(in: .global).origin.y / 10))
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Hue Rotation")
    }
}

#Preview {
    NavigationStack {
        HueRotationEffectView()
    }
}
