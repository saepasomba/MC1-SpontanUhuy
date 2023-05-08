//
//  MC1_SpontanUhuyApp.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 17/04/23.
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject var homePageViewModel = HomePageViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePageViewModel)
        }
    }
}
