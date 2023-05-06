//
//  OnboardpageView.swift
//  MC1-SpontanUhuy
//
//  Created by Martinus Andika Novanawa on 03/05/23.
//

import SwiftUI

struct OnboardPageView: View {
    
    var body: some View {
        ZStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                Image("OnboardBG_Iphone")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                if UIDevice.current.orientation == .landscapeLeft {
                    Image("OnboardBG_Landscape")
                        .resizable()
                        .ignoresSafeArea()
                }
                else if UIDevice.current.orientation == .landscapeRight {
                    Image("OnboardBG_Landscape")
                        .resizable()
                        .ignoresSafeArea()
                }
                else {
                    Image("OnboardBG_Portrait")
                        .resizable()
                        .ignoresSafeArea()
                }
            }
            
            Color(hex: 0xFF000000, alpha: 0.1)
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Design Home Space on Your Own")
                        .font(.system(size: 34))
                        .padding(.bottom, 8)
                        .fontWeight(.medium)
                    
                    Text("Augmented Reality helps you visualize your imaginary home space.\nMore than just a room, more than usual.")
                        .font(.body)
                        .padding(.bottom, 32)
                }
                .foregroundColor(
                    Color(hex: Constants.Color.primaryBlue)
                )
                
                NavigationLink {
                    HomePageView().navigationBarBackButtonHidden()
                } label: {
                    Text("Get Started")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background { Color(hex: Constants.Color.primaryBlue) }
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct OnboardPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardPageView()
    }
}
