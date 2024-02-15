//
//  SwiftUIView.swift
//  Fox Docs
//
//  Created by Fox on 12.02.2024.
//

import SwiftUI

struct BannerModifier: ViewModifier {

    struct BannerData {
        var title:String
        var detail:String
        var type: BannerType
    }

    enum BannerType {
        case Info
        case Warning
        case Success
        case Error

        var tintColor: Color {
            switch self {
            case .Info:
                return Color(red: 67/255, green: 154/255, blue: 215/255)
            case .Success:
                return Color.green
            case .Warning:
                return Color.yellow
            case .Error:
                return Color.red
            }
        }
    }

    @Binding var data:BannerData
    @Binding var show:Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    HStack {
                        Image("Done")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        VStack(alignment: .center, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                }
                .padding()
                .animation(.bouncy)
                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
            }
        }
    }

}


extension View {
    func banner(data: Binding<BannerModifier.BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello")
        }
    }
}
