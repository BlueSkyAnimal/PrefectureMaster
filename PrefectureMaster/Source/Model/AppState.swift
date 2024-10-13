//
//  AppState.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

class AppState: ObservableObject {
    static var shared = AppState()
    
    @AppStorage("effectVolume") var effectVolume: Double = 50
    @AppStorage("musicVolume") var musicVolume: Double = 50
    @AppStorage("keyboardMode") var keyboardMode = true
    @AppStorage("limit") var limit: Double = 12
    @Published var finish = 30
    @Published var sound: [Sound] = [
        Sound("GetReady", role: .music),
        Sound("PartyTime", role: .game),
    ]
}

extension AppState {
    func choiceEffect() -> Sound? {
        let effect = self.sound.filter { $0.role == .effect }
        return effect.randomElement()
    }
    
    func choiceMusic() -> Sound? {
        let effect = self.sound.filter { $0.role == .music }
        return effect.randomElement()
    }
    
    func choiceGameMusic() -> Sound? {
        let effect = self.sound.filter { $0.role == .game }
        return effect.randomElement()
    }
    
    func playEffect(_ name: String, effectPlayer: inout AVAudioPlayer?) {
        do {
            if let asset = NSDataAsset(name: name) {
                effectPlayer = try AVAudioPlayer(data: asset.data)
                effectPlayer?.volume = Float(self.effectVolume / 100)
            }
            effectPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopEffect(effectPlayer: inout AVAudioPlayer?) {
        effectPlayer?.stop()
    }
    
    func playMusic(_ name: String, musicPlayer: inout AVAudioPlayer?) {
        do {
            if let asset = NSDataAsset(name: name) {
                musicPlayer = try AVAudioPlayer(data: asset.data)
                musicPlayer?.volume = Float(self.musicVolume / 100)
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.prepareToPlay()
            }
            musicPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopMusic(musicPlayer: inout AVAudioPlayer?) {
        musicPlayer?.stop()
    }
}
