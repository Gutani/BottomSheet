//
//  BlankView.swift
//  BottomSheet
//
//  Created by Gustavo Malheiros on 14/02/22.
//

import SwiftUI

struct BlankView: View {
    var backgrounColor:Color
    var body: some View {
        VStack(){
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(backgrounColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgrounColor: .gray)
    }
}
