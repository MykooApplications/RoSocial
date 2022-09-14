//
//  RocialApp.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/12/22.
//

import SwiftUI
import Firebase

@main
struct RocialApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
