//
//  WelcomeView.swift
//  FootHaven
//
//  Created by Harris Dawurang on 3/31/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("InAppBackground").ignoresSafeArea()
                VStack(spacing: 5) {
                    Text("Welcome to the FootHaven app, please select the category of statistics you would like to retrieve.")
                        .fontWeight(.light)
                        .font(Font.system(size: 21))
                        .padding(EdgeInsets(top: 10, leading: 9, bottom: 60, trailing: 9))
                    WelcomeOptionCellView(title: "Get Player Stats", image: "person.fill")
                    WelcomeOptionCellView(title: "Get Team Stats", image: "person.3.fill")
                    WelcomeOptionCellView(title: "Get League Stats", image: "person.2.square.stack.fill")
                    Spacer()
                }
            }
            .navigationTitle("FootHaven")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
