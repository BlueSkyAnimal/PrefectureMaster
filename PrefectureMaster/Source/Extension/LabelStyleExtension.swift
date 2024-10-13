//
//  LabelStyleExtension.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

extension LabelStyle where Self == FormLabelStyle {
    static func form(tint: Color = .accentColor, color: Color = .white, icon: Font.Weight = .regular, title: Font.Weight = .regular) -> FormLabelStyle {
        return FormLabelStyle(tint: tint, color: color, icon: icon, title: title)
    }
}
