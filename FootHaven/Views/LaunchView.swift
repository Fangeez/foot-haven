//
//  LaunchView.swift
//  FootHaven
//
//  Created by Harris Dawurang on 3/21/22.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color("AppColor")
                .ignoresSafeArea()
            Image("Logo")
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
