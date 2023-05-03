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
            SplashScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isFinished = true
                    }
                }
                .navigationDestination(isPresented: $isFinished, destination: {
                    Testing()
                        .navigationBarBackButtonHidden()
                })
//            RoomView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
