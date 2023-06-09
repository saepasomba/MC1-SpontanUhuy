//
//  ContentView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isFinished = false
    
    var body: some View {
        NavigationStack {
            SplashScreenView(isFinished: $isFinished)
                .navigationDestination(
                    isPresented: $isFinished,
                    destination: {
                        OnboardPageView()
                            .navigationBarBackButtonHidden()
                    }
                )
        }.preferredColorScheme(.light)
            .onOpenURL { incomingURL in
                print("App was opened by: \(incomingURL)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
