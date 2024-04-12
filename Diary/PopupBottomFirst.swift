//
//  PopupBottomFirst.swift
//  Diary
//
//  Created by 성재 on 3/13/24.
//

import SwiftUI
import FloatingButton

struct PopupBottomFirst: View {
    
    @Binding var isPresented: Bool
    @Binding var ispreint: Int
    @Binding var ispreint2: Int
    
    @State private var gotosecond: Bool = false
    @State private var didTap: [Bool] = [false, false, false, false, false]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Weather")
                    .foregroundColor(.black)
                    .font(.custom("SUIT-Regular", size: 20))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<5) { index in
                            MainButton(imageName: Mockdata.iconImageNames[index], colorHex: "F3F2F7", text: Mockdata.textnames[index], didtap: didTap[index])
                                .onTapGesture {
                                    didTap[index] = true
                                    ispreint = index + 1
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        gotosecond.toggle()
                                    }
                                }
                                
                        }
                    }.padding(.horizontal, 50)
                    Spacer()
                    Spacer()
                }
                
                Spacer()
                
                
                Text("Next")
                    .font(.custom("SUIT-Regular", size: 18))
                    .frame(maxWidth: AppConfig.homeWidth-24)
                    .padding(.vertical, 18)
                    .foregroundStyle(.white)
                    .background(.indigo)
                    .cornerRadius(12)
                    .onTapGesture {
                        gotosecond.toggle()
                    }
                
            }.navigationDestination(isPresented: $gotosecond, destination: {
                let _ = print("이동")
                PopupBottomSecond(isPresented: $isPresented, ispreint2: $ispreint2)
            })
            //        .background(Color.white.cornerRadius(20))
            //        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            //        .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
            .onAppear {
                if ispreint != 0 {
                    didTap[ispreint - 1] = true
                }
            }
        }
        

    }
}

//#Preview {
//    PopupBottomFirst()
//}



//struct ScreenStraight: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State var imagename: String = "sun.max.fill"
//    @State var colorname: Color = .red
//    @State var istap: Bool = false
//    
//    @Binding var ispre: Int
//
//    var body: some View {
//        
//        let mainButton1 = MainButton(imageName: imagename, colorHex: "f7b731")
//        let buttonsImage = MockData.iconImageNames.enumerated().map { index, value in
//            IconButton(imageName: value, color: MockData.colors[index])
//                .onTapGesture {
//                    imagename = value
//                    colorname = MockData.colors[index]
//                    ispre = index + 1
//                    istap.toggle()
//                }
//        }
//
//        let menu1 = FloatingButton(mainButtonView: mainButton1, buttons: buttonsImage)
//            .straight()
//            .direction(.right)
//            .delays(delayDelta: 0.1)
//            .initialOpacity(0)
//
//        return HStack {
//            if istap {
//                menu1
//            } else {
//                menu1
//            }
//            Spacer()
//        }
//    }
//}

//struct ScreenStraight2: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State var imagename: String = "sun.max.fill"
//    @State var colorname: Color = .red
//    @State var istap: Bool = false
//
//    var body: some View {
//        
//        let mainButton1 = MainButton(imageName: imagename, colorHex: "f7b731")
//        let buttonsImage = MockData.iconImageNames.enumerated().map { index, value in
//            IconButton(imageName: value, color: MockData.colors[index])
//                .onTapGesture {
//                    imagename = value
//                    colorname = MockData.colors[index]
//                    istap.toggle()
//                }
//        }
//
//        let menu1 = FloatingButton(mainButtonView: mainButton1, buttons: buttonsImage)
//            .straight()
//            .direction(.right)
//            .delays(delayDelta: 0.1)
//            .initialOpacity(0)
//
//        return HStack {
//            if istap {
//                menu1
//            } else {
//                menu1
//            }
//            Spacer()
//        }
//    }
//}

//struct ScreenCircle: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    var body: some View {
//        let mainButton1 = MainButton(imageName: "message.fill", colorHex: "f7b731")
//        let mainButton2 = MainButton(imageName: "umbrella.fill", colorHex: "eb3b5a")
//        let mainButton3 = MainButton(imageName: "message.fill", colorHex: "f7b731")
//        let buttonsImage = MockData.iconImageNames.enumerated().map { index, value in
//            IconButton(imageName: value, color: MockData.colors[index])
//        }
//
//        let menu1 = FloatingButton(mainButtonView: mainButton2, buttons: buttonsImage.dropLast())
//            .circle()
//            .startAngle(3/2 * .pi)
//            .endAngle(2 * .pi)
//            .radius(70)
//        let menu2 = FloatingButton(mainButtonView: mainButton1, buttons: buttonsImage)
//            .circle()
//            .delays(delayDelta: 0.1)
//            .initialOpacity(0)
//            .startAngle(0 * .pi)
//            .endAngle(3/2 * .pi)
//        let menu3 = FloatingButton(mainButtonView: mainButton3, buttons: buttonsImage.dropLast())
//            .circle()
//            .startAngle(3/2 * .pi)
//            .endAngle(2 * .pi)
//            .radius(70)
//
//        return VStack {
//            Spacer()
//            HStack {
//                menu1
//                Spacer()
//                menu2
//                Spacer()
//                menu3
//            }
//            .padding(20)
//        }
//    }
//}

struct MainButton: View {

    var imageName: String
    var colorHex: String
    var text: String
    var didtap: Bool
    var width: CGFloat = 78

    var body: some View {
        ZStack {
            Color(hex: didtap ? "4B0082" : colorHex)
                .frame(width: width, height: width)
                .cornerRadius(width / 5)
                .shadow(color: Color(hex: colorHex).opacity(0.3), radius: 15, x: 0, y: 15)
            VStack {
                Image(systemName: imageName)
                    .foregroundColor(didtap ? .white : .black)
                    .padding(.bottom, 5)
                Text(text).foregroundStyle(didtap ? .white : .black)
                    .font(.custom("SUIT-Regular", size: 13))
                
            }
            
        }
        

    }
}

struct IconButton: View {

    var imageName: String
    var color: Color
    let imageWidth: CGFloat = 20
    let buttonWidth: CGFloat = 45

    var body: some View {
        ZStack {
            Color(red: 3, green: 3, blue: 3)
            Image(systemName: imageName)
                .frame(width: imageWidth, height: imageWidth)
                .foregroundColor(color)
        }
        .frame(width: buttonWidth, height: buttonWidth)
        .cornerRadius(buttonWidth / 2)
    }
}

//struct IconAndTextButton: View {
//
//    var imageName: String
//    var buttonText: String
//    let imageWidth: CGFloat = 22
//
//    var body: some View {
//        ZStack {
//            Color.white
//            HStack {
//                Image(systemName: imageName)
//                    .resizable()
//                    .aspectRatio(1, contentMode: .fill)
//                    .foregroundColor(Color(hex: "778ca3"))
//                    .frame(width: imageWidth, height: imageWidth)
//                    .clipped()
//                Spacer()
//                Text(buttonText)
//                    .font(.system(size: 16, weight: .semibold, design: .default))
//                    .foregroundColor(Color(hex: "4b6584"))
//                Spacer()
//            }
//            .padding(.horizontal, 15)
//        }
//        .frame(width: 160, height: 45)
//        .cornerRadius(8)
//        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 1)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color(hex: "F4F4F4"), lineWidth: 1)
//        )
//    }
//}

extension Color {

    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
