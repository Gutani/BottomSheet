//
//  RestaurantDetailView.swift
//  BottomSheet
//
//  Created by Gustavo Malheiros on 14/02/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    var modelRestaurant:Restaurant
    var viewModelRest:VMRestaurant = VMRestaurant()
    
    @GestureState var dragState = DragState.inactive
    @Binding var isShow: Bool
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader() { geometryReader in
            VStack {
                HandleBar()
                ScrollView {
                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(
                            in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)
                    TitleBar()
                    HeaderView(modelRestaurant: modelRestaurant)
                    DetailInfoView(icon: "map", info: modelRestaurant.location).padding(.top)
                    DetailInfoView(icon: "phone", info: modelRestaurant.phone)
                    DetailInfoView(icon: nil, info: modelRestaurant.description)
                        .padding(.top).padding(.bottom, 100)
                }.disabled(viewModelRest.viewState == ThresholdViewState.HalfOpenned)
                    .background(Color.white)
                    .cornerRadius(10, antialiased: true)
                    .coordinateSpace(name: "scrollview")
            }
            .offset(y: geometryReader.size.height/2 + dragState.translation.height + viewModelRest.positionOffSet)
            .animation(Animation.interpolatingSpring(stiffness: 200.0, damping: 35.0, initialVelocity: 5.0), value: isShow)
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture().updating($dragState, body: {
                value, state, transaction in
                state = .dragging(translation: value.translation)
            }).onEnded { value in
                if viewModelRest.viewState == ThresholdViewState.HalfOpenned {
                    if value.translation.height < -geometryReader.size.height * 0.25 {
                        viewModelRest.positionOffSet = -geometryReader.size.height/2 + 50
                        viewModelRest.viewState = .FullOpenned
                    }
                    
                    if value.translation.height > geometryReader.size.height * 0.3 {
                        self.isShow = false
                    }
                }
                
            })
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                if viewModelRest.viewState == .FullOpenned {
                    self.scrollOffset = value > 0 ? value : 0
                    if self.scrollOffset > 120 {
                        viewModelRest.positionOffSet = 0
                        viewModelRest.viewState = .HalfOpenned
                        self.scrollOffset = 0
                    }
                }
            }
            .offset(y: self.scrollOffset)
        }
    }
}

struct DetailInfoView:View{
    var icon:String?
    var info:String
    
    var body: some View{
        HStack{
            if icon != nil {
                Image(systemName: icon!).padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            Spacer()
        }.padding(.horizontal)
    }
}

struct HeaderView:View {
    var modelRestaurant:Restaurant
    var body: some View {
        Image(modelRestaurant.image).resizable().scaledToFill().frame(height: 300).clipped().overlay {
            HStack {
                VStack (alignment: .leading) {
                    Spacer()
                    Text(modelRestaurant.name).foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded)).bold().border(.red)
                    Text(modelRestaurant.type).font(.system(.headline, design: .rounded)).foregroundColor(.white).padding(10).background(.red).cornerRadius(5)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct TitleBar:View {
    var body: some View {
        HStack {
            Text("Restaurant Details").font(.headline).foregroundColor(.primary)
            Spacer()
        }.padding()
    }
}

struct HandleBar:View{
    var body: some View {
        Rectangle().frame(width: 50, height: 5).foregroundColor(Color(.systemGray6)).cornerRadius(10)
    }
}

//struct RestaurantDetailView_Previews: PreviewProvider {
//    @State var value: Binding<Bool>
//
//    static var previews: some View {
//        RestaurantDetailView(modelRestaurant: VMRestaurant().restaurants[15], detail: $value).background(.gray)
//    }
//}


struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
