//
//  CreditView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

struct CreditView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @Binding var effectPlayer: AVAudioPlayer?
    @Binding var musicPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("制作") {
                    VStack(alignment: .leading) {
                        Label {
                            Text("Kazuyoshi Chiba")
                        } icon: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form())
                        Text("SwiftUIエンジニア。主にmacOS向けアプリの開発をしています。")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                Section("イラスト") {
                    HStack {
                        Label {
                            Text("日本地図無料イラスト素材集 様")
                        } icon: {
                            Image(systemName: "globe.asia.australia.fill")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .green))
                        Spacer()
                        if let url = URL(string: "https://japan-map.com") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Section("BGM") {
                    HStack {
                        Label {
                            Text("Safu Works 様")
                        } icon: {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .red))
                        Spacer()
                        if let url = URL(string: "https://safuworks.com") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    HStack {
                        Label {
                            Text("OtoLogic 様")
                        } icon: {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .red))
                        Spacer()
                        if let url = URL(string: "https://otologic.jp") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Section("SE") {
                    HStack {
                        Label {
                            Text("クラゲ工匠 様")
                        } icon: {
                            Image(systemName: "waveform.path")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .red))
                        Spacer()
                        if let url = URL(string: "http://www.kurage-kosho.info") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    HStack {
                        Label {
                            Text("効果音ラボ 様")
                        } icon: {
                            Image(systemName: "waveform.path")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .red))
                        Spacer()
                        if let url = URL(string: "https://soundeffect-lab.info") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    HStack {
                        Label {
                            Text("OtoLogic 様")
                        } icon: {
                            Image(systemName: "waveform.path")
                                .resizable()
                                .scaledToFit()
                        }
                        .labelStyle(.form(tint: .red))
                        Spacer()
                        if let url = URL(string: "https://otologic.jp") {
                            Link(destination: url) {
                                Label("Webサイト…", systemImage: "globe")
                                    .labelStyle(.iconOnly)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Section("Special Thanks") {
                    Label {
                        Text("このゲームを見つけてくれたあなた")
                    } icon: {
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .labelStyle(.form(tint: .orange))
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
