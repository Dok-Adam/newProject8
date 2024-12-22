//
//  Swioe.swift
//  newProject8
//
//  Created by Адам Дотмерзаев on 21.12.2024.
//

import SwiftUI

struct Swipe: View {
    @Binding var value: Double
    @State private var dragStart: CGFloat?
    @State private var overdragPoint: CGFloat?
    @State private var stretch: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.ultraThinMaterial)
            .overlay(
                VStack {
                    Spacer()
                    // Этот прямоугольник будет заполнять слайдер снизу вверх
                    Rectangle()
                        .fill(Color.white) // Убедимся, что цвет непрозрачен
                        .frame(height: calculateHeight())
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .frame(
                width: calculateWidth(),
                height: 350 + abs(stretch)
            )
            .offset(y: stretch)
            .gesture(
                DragGesture()
                    .onChanged { handleDragChange($0) }
                    .onEnded { _ in resetDrag() }
            )
    }
    
    // Вычисление высоты полосы
    private func calculateHeight() -> CGFloat {
        let baseHeight: CGFloat = 350
        if value >= 1 && stretch < 0 {
            return baseHeight + abs(stretch)
        }
        return baseHeight * CGFloat(value)
    }
    
    // Вычисление ширины слайдера
    private func calculateWidth() -> CGFloat {
        let baseWidth: CGFloat = 140
        return baseWidth * (1 - abs(stretch) / 700)
    }
    
    // Обработка изменения жеста
    private func handleDragChange(_ gesture: DragGesture.Value) {
        if dragStart == nil { dragStart = gesture.location.y }

        if overdragPoint == nil {
            let delta = gesture.location.y - (dragStart ?? 0)
            value = max(0, min(1, value - delta / 350))
            if (value == 0 && delta > 0) || (value == 1 && delta < 0) {
                overdragPoint = gesture.location.y
            }
        } else {
            let overdragDistance = gesture.location.y - (overdragPoint ?? 0)
            stretch = overdragDistance * 0.08
            if (value == 0 && overdragDistance < 0) || (value == 1 && overdragDistance > 0) {
                overdragPoint = nil
            }
        }
        dragStart = gesture.location.y
    }
    
    // Сброс состояния после завершения жеста
    private func resetDrag() {
        withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
            dragStart = nil
            overdragPoint = nil
            stretch = 0
        }
    }
}


//struct Swipe: View {
//    @Binding var value: Double
//    @State private var drag = (start: CGFloat?.none, overdrag: CGFloat?.none, stretch: CGFloat.zero)
//
//    var body: some View {
//        
//        RoundedRectangle(cornerRadius: 50)
//            .fill(.ultraThinMaterial)
//            .overlay(Rectangle().fill(.clear)
//            .overlay(Rectangle().fill(.white)
//            .frame(height: value >= 1 && drag.stretch < 0 ? 350 + abs(drag.stretch) : 350 * value), alignment: .bottom)
//            .clipShape(RoundedRectangle(cornerRadius: 50)))
//            .frame(width: 140 * (1 - abs(drag.stretch) / 700), height: 350 + abs(drag.stretch))
//            .offset(y: drag.stretch)
//            .gesture(
//                DragGesture()
//                    .onChanged { g in
//                        if drag.start == nil { drag.start = g.location.y }
//
//                        if drag.overdrag == nil {
//                            let delta = g.location.y - drag.start!
//                            value = max(0, min(1, value - delta / 350))
//                            if (value == 0 && delta > 0) || (value == 1 && delta < 0) { drag.overdrag = g.location.y }
//                        } else {
//                            let dist = g.location.y - drag.overdrag!
//                            drag.stretch = dist * 0.08
//                            if (value == 0 && dist < 0) || (value == 1 && dist > 0) { drag.overdrag = nil }
//                        }
//                        drag.start = g.location.y
//                    }
//                    .onEnded { _ in withAnimation(.interpolatingSpring) { drag = (nil, nil, 0) } }
//            )
//    }
//}

