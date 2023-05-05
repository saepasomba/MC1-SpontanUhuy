//
//  OnboardpageView.swift
//  MC1-SpontanUhuy
//
//  Created by Martinus Andika Novanawa on 03/05/23.
//

import SwiftUI

struct OnboardpageView: View {
    
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
            
            VStack (alignment: .leading) {
                Spacer()
                Group {
                    Text("Design Home Space on Your Own")
                        .font(.system(size: 34))
                        .padding(.bottom, 8)
                        .fontWeight(.medium)
                    Text("Augmented Reality helps you visualize your imaginary home space.")
                        .font(.system(size: 17))
                    Text("More than just a room, more than usual.")
                        .font(.system(size: 17))
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
                        .background {
                            Color(hex: Constants.Color.primaryBlue)
                        }
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
