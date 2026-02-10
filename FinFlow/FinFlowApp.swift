//
//  FinFlowApp.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

//@main
//struct FinFlowApp: App {
//    var body: some Scene {
//        WindowGroup {
//            LoginView()
//        }
//    }
//}


@main
struct FinFlowApp: App {

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
