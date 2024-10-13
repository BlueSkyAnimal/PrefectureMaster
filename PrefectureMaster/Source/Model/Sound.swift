//
//  Sound.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

struct Sound {
    var name: String
    var role: SoundRole
    
    init(_ name: String, role: SoundRole) {
        self.name = name
        self.role = role
    }
}
