//
//  LaunchScreen.swift
//  ToDoList
//
//  Created by Morgan Wolff on 17/11/2022.
//

import Foundation
import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "checkmark.square")
                            .font(.system(size: 80))
                            .foregroundColor(.green)
                    Text("ToDoList")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.black.opacity(0.80))
                }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
            }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.isActive = true
                        }
                    }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
