//
//  FormLabelStyle.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

struct FormLabelStyle: LabelStyle {
    var tint: Color
    var color: Color
    var icon: Font.Weight
    var title: Font.Weight
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .fontWeight(icon)
                .foregroundColor(color)
                .shadow(color: .black.opacity(0.3), radius: 0.5, y: 0.2)
                .padding(3)
                .frame(width: 20, height: 20)
                .background(tint.gradient)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.2), radius: 1, y: 0.5)
            configuration.title
                .fontWeight(title)
        }
    }
}
