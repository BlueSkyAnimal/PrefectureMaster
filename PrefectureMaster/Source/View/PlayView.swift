//
//  PlayView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import AVKit

struct PlayView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.adaptive) var adaptive
    @Binding var page: Page
    @Binding var effectPlayer: AVAudioPlayer?
    @Binding var musicPlayer: AVAudioPlayer?
    @Binding var effect: Sound?
    @Binding var music: Sound?
    @State var question: [Question] = Question.allPrefecture.shuffled()
    @State var input = ""
    @State var index = 0
    @State var numberOfCorrect = 0
    @State var count = 0
    @State var health = 3
    @State var timer: Timer?
    @State var popup: Popup?
    @State var mapScale: Double = 1
    @State var mapOffset: CGSize = .zero
    @State var pinScale: Double = 0
    
    var geometrySize: CGSize
    
    func scale(value: Double) -> Double {
        return value * adaptive.size(780) / 2000
    }
    
    func offset(_ position: CGPoint) -> CGSize {
        let x: Double = -(Double(position.x) - 1000)
        let y: Double = -(Double(position.y) - 1000)
        return .init(width: x, height: y)
    }
    
    var body: some View {
        ZStack {
            if let popup = popup {
                switch popup {
                    case .correct:
                        Image("Correct")
                            .resizable()
                            .frame(width: adaptive.size(400), height: adaptive.size(400))
                            .zIndex(1)
                            .transition(.scale.combined(with: .opacity))
                    case .miss:
                        Image("Mistake")
                            .resizable()
                            .frame(width: adaptive.size(400), height: adaptive.size(400))
                            .zIndex(1)
                            .transition(.scale.combined(with: .opacity))
                    case .clear:
                        Image("GameClear")
                            .resizable()
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    case .over:
                        Image("GameOver")
                            .resizable()
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    case .presentation:
                        HStack(spacing: adaptive.size(40)) {
                            ZStack {
                                Image("JapanMap")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: scale(value: mapOffset.width), y: scale(value: mapOffset.height))
                                    .scaleEffect(mapScale)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .onAppear {
                                        mapScale = 1
                                        pinScale = 0
                                        mapOffset = .zero
                                        withAnimation(.easeInOut(duration: 2)) {
                                            mapScale = 3
                                            mapOffset = offset(question[index].position)
                                        }
                                        withAnimation(.spring().delay(2)) {
                                            pinScale = 1
                                        }
                                    }
                                Image("MapPin")
                                    .resizable()
                                    .frame(width: adaptive.size(130), height: adaptive.size(180))
                                    .scaleEffect(pinScale, anchor: .init(x: 0.5, y: 0.5 + (68.75 / 180)))
                                    .offset(y: adaptive.size(-68.75))
                                    .zIndex(1)
                            }
                            VStack(alignment: .leading, spacing: adaptive.size(40)) {
                                Text(question[index].name + question[index].prefix.string)
                                    .font(.system(size: adaptive.size(96)))
                                    .fontWeight(.bold)
                                Text(question[index].tip)
                                    .font(.system(size: adaptive.size(48)))
                                    .fontWeight(.semibold)
                            }
                            .padding(adaptive.size(40))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.ultraThinMaterial)
                        }
                        .clipped()
                        .background()
                        .zIndex(2)
                        .transition(.move(edge: .bottom))
                }
            }
            VStack(spacing: adaptive.size(5)) {
                HStack(spacing: adaptive.size(5)) {
                    HStack(alignment: .bottom, spacing: adaptive.size(10)) {
                        Text("\(numberOfCorrect)")
                            .foregroundColor(.accentColor)
                            .font(.system(size: adaptive.size(96)))
                            .frame(width: adaptive.size(150))
                        Text("/\(appState.finish)")
                            .foregroundColor(.secondary)
                            .font(.system(size: adaptive.size(48)))
                            .frame(width: adaptive.size(100))
                    }
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .monospacedDigit()
                    .frame(width: adaptive.size(250))
                    Spacer()
                    HStack(spacing: adaptive.size(40)) {
                        ForEach(0..<3, id: \.self) { index in
                            Image(systemName: "heart")
                                .foregroundColor(.pink)
                                .font(.system(size: adaptive.size(64)))
                                .imageScale(.large)
                                .symbolVariant(health > index ? .fill : .none)
                        }
                    }
                    Spacer()
                    VStack(spacing: adaptive.size(5)) {
                        Text("\(count)")
                            .foregroundColor(.red)
                            .font(.system(size: adaptive.size(96)))
                    }
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .monospacedDigit()
                    .frame(width: adaptive.size(250))
                }
                Spacer()
                VStack(spacing: adaptive.size(5)) {
                    Image(question[index].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: adaptive.size(500), height: adaptive.size(500))
                        .foregroundColor(.green)
                }
                Spacer()
                InputField(page: $page, effectPlayer: $effectPlayer, musicPlayer: $musicPlayer, effect: $effect, music: $music, question: $question, input: $input, index: $index, numberOfCorrect: $numberOfCorrect, count: $count, health: $health, timer: $timer, popup: $popup, geometrySize: geometrySize)
            }
            .padding(adaptive.size(40))
        }
        .clipped()
        .onAppear {
            count = Int(ceil(appState.limit))
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                count -= 1
            }
        }
    }
}
