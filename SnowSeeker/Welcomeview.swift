//
//  Welcomeview.swift
//  SnowSeeker
//
//  Created by Mohsin khan on 08/12/2025.
//

import SwiftUI

struct Welcomeview: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Welcomeview()
}
