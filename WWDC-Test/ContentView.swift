//
//  ContentView.swift
//  WWDC-Test
//
//  Created by Gary Tokman on 1/29/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Scroll Effects") {
                    NavigationLink {
                        ScrollPaginationView()
                    } label: {
                        Label("Scroll Pagination", systemImage: "rectangle.split.3x1")
                    }

                    NavigationLink {
                        RotationEffectView()
                    } label: {
                        Label("Rotation Effect", systemImage: "arrow.trianglehead.2.clockwise.rotate.90")
                    }

                    NavigationLink {
                        ParallaxEffectView()
                    } label: {
                        Label("Parallax Effect", systemImage: "square.2.layers.3d")
                    }

                    NavigationLink {
                        HueRotationEffectView()
                    } label: {
                        Label("Hue Rotation", systemImage: "paintpalette")
                    }
                }

                Section("Color Treatments") {
                    NavigationLink {
                        MeshGradientView()
                    } label: {
                        Label("Mesh Gradient", systemImage: "circle.hexagongrid.fill")
                    }
                }

                Section("View Transitions") {
                    NavigationLink {
                        TwirlTransitionView()
                    } label: {
                        Label("Twirl Transition", systemImage: "sparkles")
                    }
                }

                Section("Text Transitions") {
                    NavigationLink {
                        TextTransitionView()
                    } label: {
                        Label("Text Transition", systemImage: "textformat")
                    }
                }

                Section("Metal Shaders") {
                    NavigationLink {
                        RippleEffectView()
                    } label: {
                        Label("Ripple Effect", systemImage: "water.waves")
                    }

                    NavigationLink {
                        RippleEditorView()
                    } label: {
                        Label("Ripple Editor", systemImage: "slider.horizontal.3")
                    }

                    NavigationLink {
                        ChromaticAberrationView()
                    } label: {
                        Label("Chromatic Aberration", systemImage: "camera.filters")
                    }

                    NavigationLink {
                        ChromaticAberrationEditorView()
                    } label: {
                        Label("Aberration Editor", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .navigationTitle("Visual Effects")
        }
    }
}

#Preview {
    ContentView()
}
