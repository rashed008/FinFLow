//
//  AppState.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
