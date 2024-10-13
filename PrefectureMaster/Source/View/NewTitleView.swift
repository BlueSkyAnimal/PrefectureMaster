//
//  NewTitleView.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/03/16.
//

import SwiftUI

enum TitleButtonRole: Int, CaseIterable {
    case play, options, credits
}

struct NewTitleView: View {
    @State var focus: TitleButtonRole = .play
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text("Keyboard Controller")
                    .font(.headline)
                Spacer()
                Button {
                    guard let previous = TitleButtonRole.allCases.first(where: {
                        $0.rawValue == focus.rawValue - 1
                    }) else { return }
                    focus = previous
                } label: {
                    Image(systemName: "arrow.up")
                }
                .keyboardShortcut(.upArrow, modifiers: [])
                Button {
                    guard let next = TitleButtonRole.allCases.first(where: {
                        $0.rawValue == focus.rawValue + 1
                    }) else { return }
                    focus = next
                } label: {
                    Image(systemName: "arrow.down")
                }
                .keyboardShortcut(.downArrow, modifiers: [])
                Button {
                    print("Return key pressed!")
                } label: {
                    Image(systemName: "return")
                }
                .keyboardShortcut(.return, modifiers: [])
            }
            .padding()
            .frame(height: .zero)
            ZStack {
                HStack {
                    Spacer()
                    Image("JapanMapMonoChrome")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white.opacity(0.5))
                }
                VStack(alignment: .leading) {
                    Text("都道府県マスター")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Button {
                        focus = .play
                    } label: {
                        Label {
                            Text("Play")
                        } icon: {
                            Image(systemName: "play.circle.fill")
                                .frame(width: 20)
                        }
                        .padding(5)
                        .padding(.trailing, 5)
                        .foregroundColor(focus == .play ? .black : .white)
                        .background(focus == .play ? Color.white : .clear)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    }
                    .buttonStyle(.plain)
                    Button {
                        focus = .options
                    } label: {
                        Label {
                            Text("Options")
                        } icon: {
                            Image(systemName: "gearshape.fill")
                                .frame(width: 20)
                        }
                        .padding(5)
                        .padding(.trailing, 5)
                        .foregroundColor(focus == .options ? .black : .white)
                        .background(focus == .options ? Color.white : .clear)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    }
                    .buttonStyle(.plain)
                    Button {
                        focus = .credits
                    } label: {
                        Label {
                            Text("Credits")
                        } icon: {
                            Image(systemName: "hammer.fill")
                                .frame(width: 20)
                        }
                        .padding(5)
                        .padding(.trailing, 5)
                        .foregroundColor(focus == .credits ? .black : .white)
                        .background(focus == .credits ? Color.white : .clear)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.gradient)
        }
    }
}

struct NewTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NewTitleView()
    }
}
