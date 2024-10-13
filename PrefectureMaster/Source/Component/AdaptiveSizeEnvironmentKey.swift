//
//  AdaptiveSizeEnvironmentKey.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/07/02.
//

import SwiftUI

struct AdaptiveSizeEnvironmentKey: EnvironmentKey {
    typealias Value = AdaptiveSizeEnvironmentValues
    static var defaultValue: AdaptiveSizeEnvironmentValues = AdaptiveSizeEnvironmentValues(frame: .zero)
}

struct AdaptiveSizeEnvironmentValues {
    let frame: CGSize
    
    func size(_ size: Double) -> Double {
        var scaleFactor: Double {
            min(Double(frame.height / 900), Double(frame.width / 1600))
        }
        return size * scaleFactor
    }
}

extension EnvironmentValues {
    var adaptive: AdaptiveSizeEnvironmentValues {
        get { self[AdaptiveSizeEnvironmentKey.self] }
        set { self[AdaptiveSizeEnvironmentKey.self] = newValue }
    }
}
