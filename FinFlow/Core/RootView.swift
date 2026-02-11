//
//  RootView.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            if appState.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
