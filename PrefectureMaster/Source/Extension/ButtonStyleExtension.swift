//
//  ButtonStyleExtension.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

extension ButtonStyle where Self == ScaleEffectButtonStyle {
    static func game(tint: Color? = nil, geometrySize: CGSize) -> ScaleEffectButtonStyle {
        return ScaleEffectButtonStyle(tint: tint, geometrySize: geometrySize)
    }
}
