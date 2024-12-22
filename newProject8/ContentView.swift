//
//  ContentView.swift
//  newProject8
//
//  Created by Адам Дотмерзаев on 21.12.2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            
            SliderView()
                .frame(width: 100, height: 225)
                .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
