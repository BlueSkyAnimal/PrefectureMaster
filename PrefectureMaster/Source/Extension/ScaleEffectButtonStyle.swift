//
//  GameButtonStyle.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

struct ScaleEffectButtonStyle: ButtonStyle {
    @EnvironmentObject var appState: AppState
    @Environment(\.adaptive) var adaptive
    var isZoomIn: Bool = false
    var tint: Color?
    var geometrySize: CGSize
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .padding(.vertical, adaptive.size(10))
            .padding(.horizontal, adaptive.size(20))
            .frame(maxWidth: .infinity)
            .background(tint ?? Color.gray.opacity(0.1))
            .background(in: RoundedRectangle(cornerRadius: adaptive.size(20), style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: adaptive.size(20), style: .continuous))
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}
