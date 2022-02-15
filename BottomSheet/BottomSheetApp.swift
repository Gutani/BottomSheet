//
//  BottomSheetApp.swift
//  BottomSheet
//
//  Created by Gustavo Malheiros on 13/02/22.
//

import SwiftUI

@main
struct BottomSheetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: VMRestaurant())
        }
    }
}
