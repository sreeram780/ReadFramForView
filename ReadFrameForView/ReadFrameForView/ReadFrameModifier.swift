//
//  ReadFrameModifier.swift
//  ReadFrameForView
//
//  Created by SreeRamReddy on 10/08/24.
//
// https://freedium.cfd/https://blog.devgenius.io/swiftui-custom-tabview-610d3747d52d

import Foundation
import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct ReadFrame: ViewModifier {
    var onFrame: (CGRect) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
                }
            )
            .onPreferenceChange(FramePreferenceKey.self) { frame in
                onFrame(frame)
            }
    }
}

extension View {
    func readFrame(onFrame: @escaping (CGRect) -> Void) -> some View {
        self.modifier(ReadFrame(onFrame: onFrame))
    }
}
