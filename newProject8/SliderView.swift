//
//  VolumeView.swift
//  newProject8
//
//  Created by Адам Дотмерзаев on 22.12.2024.
//

import SwiftUI


struct SliderView: View {
    @State private var progress: CGFloat = 0.2
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let effectiveHeight = progress < 0 ? height - (progress * height) : height
            
            ZStack(alignment: .bottom) {
                Rectangle()
                    .background(.ultraThinMaterial)
                Rectangle()
                    .fill(.white)
                    .frame(height: max(progress, 0) * height)
            }
            .clipShape(.rect(cornerRadius: 30))
            .frame(width: width, height: effectiveHeight, alignment: progress > 0 ? .bottom : .top)
            .scaleEffect(x: (0...1).contains(progress) ? 1 : 0.95)
            .animation(.default, value: (0...1).contains(progress))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = -value.translation.height + lastOffset
                        updateProgress(height: height)
                    }
                    .onEnded { _ in
                        withAnimation(.smooth) {
                            offset = min(height, max(offset, 0))
                            updateProgress(height: height)
                        }
                        lastOffset = offset
                    }
            )
        }
    }
    
    private func updateProgress(height: CGFloat) {
        let scale = 0.05
        let topExcessOffset = height + (offset - height) * scale
        let bottomExcessOffset = offset < 0 ? offset * scale : offset
        progress = (offset > height ? topExcessOffset : bottomExcessOffset) / height
    }
}
