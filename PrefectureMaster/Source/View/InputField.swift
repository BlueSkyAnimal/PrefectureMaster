//
//  InputField.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

struct InputField: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.adaptive) var adaptive
    @Binding var page: Page
    @Binding var effectPlayer: AVAudioPlayer?
    @Binding var musicPlayer: AVAudioPlayer?
    @Binding var effect: Sound?
    @Binding var music: Sound?
    @Binding var question: [Question]
    @Binding var input: String
    @Binding var index: Int
    @Binding var numberOfCorrect: Int
    @Binding var count: Int
    @Binding var health: Int
    @Binding var timer: Timer?
    @Binding var popup: Popup?
    @State var isInputDisabled = false
    @FocusState var isFocused
    
    var geometrySize: CGSize
    
    var body: some View {
        if popup != nil || isInputDisabled {
            Color.clear
                .frame(height: adaptive.size(100))
        } else {
            HStack(spacing: adaptive.size(10)) {
                TextField("漢字で入力…", text: $input)
                    .font(.system(size: adaptive.size(48)))
                    .textFieldStyle(.plain)
                    .padding(adaptive.size(10))
                    .frame(height: adaptive.size(40))
                    .frame(maxWidth: .infinity)
                    .focused($isFocused)
                    .onAppear {
                        isFocused = true
                    }
                Button {
                    checker()
                } label: {
                    Image(systemName: "arrow.forward")
                        .foregroundColor(.white)
                        .font(.system(size: adaptive.size(48)))
                        .frame(width: adaptive.size(80), height: adaptive.size(80))
                        .background(Color.accentColor)
                        .background(in: RoundedRectangle(cornerRadius: adaptive.size(15), style: .continuous))
                        .contentShape(RoundedRectangle(cornerRadius: adaptive.size(15), style: .continuous))
                }
                .buttonStyle(.plain)
                .keyboardShortcut(.defaultAction)
                .disabled(popup != nil || isInputDisabled)
            }
            .padding(adaptive.size(10))
            .frame(height: adaptive.size(100))
            .background(Color.gray.opacity(0.1))
            .cornerRadius(adaptive.size(30))
            .onChange(of: count) { value in
                if value == 0 {
                    miss()
                }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
    
    func checker() {
        if input == question[index].name || input == question[index].name + question[index].prefix.string {
            correct()
        } else {
            miss()
        }
    }
    
    func correct() {
        numberOfCorrect += 1
        appState.playEffect("CorrectSound", effectPlayer: &effectPlayer)
        timer?.invalidate()
        timer = nil
        withAnimation(.spring()) {
            popup = .correct
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                popup = .presentation
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation {
                popup = nil
            }
            if numberOfCorrect == appState.finish {
                isInputDisabled = true
                appState.stopMusic(musicPlayer: &musicPlayer)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    clear()
                }
            } else {
                index += 1
                count = Int(ceil(appState.limit))
                if index > question.count - 1 {
                    index = 0
                }
                input = ""
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    count -= 1
                }
            }
        }
    }
    
    func miss() {
        appState.playEffect("MistakeSound", effectPlayer: &effectPlayer)
        timer?.invalidate()
        timer = nil
        withAnimation(.spring()) {
            popup = .miss
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                popup = .presentation
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation {
                health -= 1
                popup = nil
            }
            if health == 0 {
                isInputDisabled = true
                appState.stopMusic(musicPlayer: &musicPlayer)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    over()
                }
            } else {
                index += 1
                count = Int(ceil(appState.limit))
                if index > question.count - 1 {
                    index = 0
                }
                input = ""
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    count -= 1
                }
            }
        }
    }
    
    func clear() {
        appState.playEffect("GameClearSound", effectPlayer: &effectPlayer)
        withAnimation {
            popup = .clear
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation {
                page = .title
            }
            music = appState.choiceMusic()
            if let music = music {
                appState.playMusic(music.name, musicPlayer: &musicPlayer)
            }
        }
    }
    
    func over() {
        appState.playEffect("GameOverSound", effectPlayer: &effectPlayer)
        withAnimation {
            popup = .over
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.spring()) {
                popup = nil
            }
            withAnimation {
                page = .title
            }
            music = appState.choiceMusic()
            if let music = music {
                appState.playMusic(music.name, musicPlayer: &musicPlayer)
            }
        }
    }
}
