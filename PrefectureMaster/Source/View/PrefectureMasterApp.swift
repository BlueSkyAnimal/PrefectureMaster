//
//  PrefectureMasterApp.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI
import MyLibrary

@main
struct PrefectureMasterApp: App {
    @StateObject var appState = AppState.shared
    let windowEventHandler = PresentationWindowEventHandler()
    
    var body: some Scene {
        Window("ContentView", id: "ContentView") {
            ContentView()
                .environmentObject(appState)
                .frame(minWidth: 480, minHeight: 270)
                .ignoresSafeArea()
                .background()
                .presentedWindowManager { window in
                    window.isMovableByWindowBackground = true
                    window.delegate = windowEventHandler
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
    }
}

class PresentationWindowEventHandler: NSObject, NSWindowDelegate {
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        let isFullScreen = sender.styleMask.contains(.fullScreen)
        if !isFullScreen {
            return NSSize(width: frameSize.height * 16 / 9, height: frameSize.height)
        } else {
            return frameSize
        }
    }
}
