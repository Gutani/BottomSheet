//
//  ContentView.swift
//  BottomSheet
//
//  Created by Gustavo Malheiros on 13/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel:VMRestaurant
    
    var body: some View {
        ZStack {
            NavigationView {
                List{
                    ForEach(viewModel.restaurants) { restaurant in
                        BasicRow(modelRestaurant: restaurant).onTapGesture {
                            viewModel.showDetail = true
                            viewModel.selectedRestaurant = restaurant
                        }
                    }
                    
                }.listStyle(.plain)
                    .navigationTitle("Restaurant Cafe")
            }
            .offset( y: viewModel.showDetail ? -100 : 0)
            .animation(.easeInOut(duration: 0.2), value: viewModel.showDetail)
            
            if viewModel.showDetail {
                BlankView(backgrounColor: .black).opacity(0.5).onTapGesture {
                    viewModel.showDetail = false
                }
                if let selectedRestaurant = viewModel.selectedRestaurant {
                    RestaurantDetailView(modelRestaurant: selectedRestaurant, isShow: $viewModel.showDetail).transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct BasicRow:View {
    var modelRestaurant: Restaurant
    var body: some View {
        HStack{
            Image(modelRestaurant.image).resizable().frame(width: 50, height: 50).cornerRadius(5)
            Text(modelRestaurant.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: VMRestaurant())
    }
}
