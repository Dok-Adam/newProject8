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


//struct ContentView: View {
//    @State private var volume: Double = 0.2
//
//    var body: some View {
//        ZStack {
//            Color.gray.opacity(0.6)
//                .ignoresSafeArea()
//
//            Image("swag")
//                .resizable()
//                .blur(radius: 10, opaque: true)
//                .ignoresSafeArea()
//
//            Swipe(value: $volume)
//                .frame(width: 140, height: 550)
//                .clipped()
//        }
//    }
//}

//struct ContentView: View {
//    @State private var volume: Double = 0.2
//
//    var body: some View {
//        ZStack {
//            Color.gray.opacity(0.6).ignoresSafeArea()
//            Image("swag")
//                .resizable()
//                .blur(radius: 10, opaque: true)
//                .ignoresSafeArea()
//
//            Swipe(value: $volume)
//                .frame(width: 140, height: 550)
//                .clipped()
//        }
//    }
//}
