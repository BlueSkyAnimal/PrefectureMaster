//
//  ContentView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit
import MyLibrary

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.adaptive) var adaptive
    @State var page: Page = .title
    @State var effectPlayer: AVAudioPlayer?
    @State var musicPlayer: AVAudioPlayer?
    @State var effect: Sound?
    @State var music: Sound?
    
    var body: some View {
        GeometryReader { geometry in
            let geometrySize = geometry.size
            
            VStack {
                switch page {
                case .title:
                    TitleView(page: $page, effectPlayer: $effectPlayer, musicPlayer: $musicPlayer, effect: $effect, music: $music, geometrySize: geometrySize)
                        .transition(.scale(scale: 0.9).combined(with: .opacity))
                case .play:
                    PlayView(page: $page, effectPlayer: $effectPlayer, musicPlayer: $musicPlayer, effect: $effect, music: $music, geometrySize: geometrySize)
                        .transition(.move(edge: .bottom))
                }
            }
            .frame(width: geometrySize.width, height: geometrySize.height)
            .onAppear {
                music = appState.choiceMusic()
                if let music = music {
                    appState.playMusic(music.name, musicPlayer: &musicPlayer)
                }
            }
            .onDisappear {
                appState.stopMusic(musicPlayer: &musicPlayer)
                appState.stopEffect(effectPlayer: &effectPlayer)
            }
            .onChange(of: appState.musicVolume) { newValue in
                musicPlayer?.volume = Float(newValue / 100)
            }
            .onChange(of: appState.effectVolume) { newValue in
                effectPlayer?.volume = Float(newValue / 100)
            }
            .environment(\.adaptive, AdaptiveSizeEnvironmentValues(frame: geometrySize))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
