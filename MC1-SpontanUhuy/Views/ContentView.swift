//
//  ContentView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isEnded = false
    
    var body: some View {
        NavigationStack {
            RoomView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
