//
//  DragState.swift
//  BottomSheet
//
//  Created by Gustavo Malheiros on 14/02/22.
//

import Foundation
import SwiftUI


enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    var isDragging: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}


enum ThresholdViewState {
    case FullOpenned
    case HalfOpenned
    
}
