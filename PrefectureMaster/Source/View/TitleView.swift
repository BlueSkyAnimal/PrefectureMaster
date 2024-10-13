//
//  TitleView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

struct TitleView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.adaptive) var adaptive
    @Binding var page: Page
    @Binding var effectPlayer: AVAudioPlayer?
    @Binding var musicPlayer: AVAudioPlayer?
    @Binding var effect: Sound?
    @Binding var music: Sound?
    @State var isOptionSheetPresented = false
    @State var isCreditSheetPresented = false
    
    var geometrySize: CGSize
    
    var body: some View {
        VStack(spacing: adaptive.size(40)) {
            Image("Logo")
                .resizable()
                .frame(width: adaptive.size(1260), height: adaptive.size(210))
            HStack(spacing: adaptive.size(10)) {
                Button {
                    appState.playEffect("Tap", effectPlayer: &effectPlayer)
                    appState.stopMusic(musicPlayer: &musicPlayer)
                    music = appState.choiceGameMusic()
                    if let music = music {
                        appState.playMusic(music.name, musicPlayer: &musicPlayer)
                    }
                    withAnimation {
                        page = .play
                    }
                } label: {
                    VStack(spacing: adaptive.size(10)) {
                        Image(systemName: "play.fill")
                            .font(.system(size: adaptive.size(96)))
                            .frame(height: adaptive.size(120))
                        Text("始める")
                            .font(.system(size: adaptive.size(48)))
                    }
                    .foregroundColor(.white)
                }
                .buttonStyle(.game(tint: .accentColor, geometrySize: geometrySize))
                Button {
                    appState.playEffect("Tap", effectPlayer: &effectPlayer)
                    isOptionSheetPresented = true
                } label: {
                    VStack(spacing: adaptive.size(10)) {
                        Image(systemName: "gearshape")
                            .font(.system(size: adaptive.size(96)))
                            .foregroundColor(.gray)
                            .frame(height: adaptive.size(120))
                        Text("オプション")
                            .font(.system(size: adaptive.size(48)))
                    }
                }
                .buttonStyle(.game(geometrySize: geometrySize))
                Button {
                    appState.playEffect("Tap", effectPlayer: &effectPlayer)
                    isCreditSheetPresented = true
                } label: {
                    VStack(spacing: adaptive.size(10)) {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: adaptive.size(96)))
                            .foregroundColor(.gray)
                            .frame(height: adaptive.size(120))
                        Text("クレジット")
                            .font(.system(size: adaptive.size(48)))
                    }
                }
                .buttonStyle(.game(geometrySize: geometrySize))
            }
        }
        .padding(adaptive.size(40))
        .sheet(isPresented: $isOptionSheetPresented) {
            OptionView(effectPlayer: $effectPlayer, musicPlayer: $musicPlayer)
        }
        .sheet(isPresented: $isCreditSheetPresented) {
            CreditView(effectPlayer: $effectPlayer, musicPlayer: $musicPlayer)
        }
    }
}
