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
            Image("OnboardBG")
                .resizable()
                .ignoresSafeArea()
            VStack (alignment: .leading) {
                Spacer()
                Group {
                    Text("Design Home Space on Your Own")
                        .font(.system(size: 34))
                        .padding(.bottom, 15)
                        .fontWeight(.medium)
                    Text("Augmented Reality helps you visualize your imaginary home space.")
                        .font(.system(size: 17))
                    Text("More than just a room, more than usual.")
                        .font(.system(size: 17))
                        .padding(.bottom, 67)
                }
                .foregroundColor(
                    Color(hex: Constants.Color.primaryBlue)
                )
                
                NavigationLink {
                    HomepageView()
                        .navigationBarBackButtonHidden()
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

struct OnboardpageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardpageView()
    }
}
