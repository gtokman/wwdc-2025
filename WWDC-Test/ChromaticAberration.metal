//
//  ChromaticAberration.metal
//  WWDC-Test
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[ stitchable ]]
half4 ChromaticAberration(
    float2 position,
    SwiftUI::Layer layer,
    float2 origin,
    float time,
    float intensity,
    float decay
) {
    // Distance from the current pixel to the origin point.
    float distance = length(position - origin);

    // Direction vector pointing away from origin.
    float2 direction = normalize(position - origin);

    // The aberration amount decays over time and falls off with distance.
    float aberration = intensity * exp(-decay * time) * smoothstep(0.0, 300.0, distance);

    // Offset each color channel by a different amount along the direction vector
    // to simulate chromatic aberration (lens fringing).
    float2 redOffset   = position + direction * aberration;
    float2 greenOffset = position;
    float2 blueOffset  = position - direction * aberration;

    // Sample each channel independently.
    half4 redSample   = layer.sample(redOffset);
    half4 greenSample = layer.sample(greenOffset);
    half4 blueSample  = layer.sample(blueOffset);

    // Composite the separated channels back together.
    half4 color;
    color.r = redSample.r;
    color.g = greenSample.g;
    color.b = blueSample.b;
    color.a = greenSample.a;

    return color;
}
