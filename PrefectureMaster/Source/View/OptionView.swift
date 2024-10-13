//
//  OptionView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

struct OptionView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @Binding var effectPlayer: AVAudioPlayer?
    @Binding var musicPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("サウンド") {
                    VStack {
                        Slider(value: $appState.musicVolume, in: 0...100) {
                            Label {
                                Text("BGM")
                            } icon: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                        } minimumValueLabel: {
                            Image(systemName: "speaker.fill")
                        } maximumValueLabel: {
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        .labelStyle(.form(tint: .red))
                    }
                    VStack {
                        Slider(value: $appState.effectVolume, in: 0...100) {
                            Label {
                                Text("SE")
                            } icon: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                        } minimumValueLabel: {
                            Image(systemName: "speaker.fill")
                        } maximumValueLabel: {
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        .labelStyle(.form(tint: .red))
                    }
                }
                Section("ルール") {
                    Toggle(isOn: $appState.keyboardMode) {
                        Label {
                            Text("キーボード入力")
                                .monospacedDigit()
                        } icon: {
                            Image(systemName: "keyboard.fill")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .labelStyle(.form(tint: .cyan))
                    VStack {
                        Slider(value: $appState.limit, in: 1...30) {
                            Label {
                                Text("制限時間: \(String(format: "%.0f", ceil(appState.limit)))秒")
                                    .monospacedDigit()
                            } icon: {
                                Image(systemName: "stopwatch.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                        } minimumValueLabel: {
                            Image(systemName: "minus")
                                .fontWeight(.semibold)
                        } maximumValueLabel: {
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                        }
                        .labelStyle(.form(tint: .orange))
                    }
                }
            }
            .formStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完了") {
                        dismiss()
                        appState.playEffect("Tap", effectPlayer: &effectPlayer)
                    }
                }
            }
        }
        .frame(width: 400, height: 300)
    }
}
