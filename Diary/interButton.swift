//
//  interButton.swift
//  Diary
//
//  Created by 성재 on 3/22/24.
//

import SwiftUI

struct interButton: View {
    
    @State var fb = false
    @State var Hpress = false
    @GestureState var topG = false
    
    @Binding var isShowingEditForm : Bool
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: 150, height: 44)
                .foregroundColor(.mainpoint)
                .cornerRadius(40)
                .shadow(color: .mainpoint.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.6), radius: 10, x: 10, y:10)
            
            HStack(spacing: 13) {
                
                ZStack {
//                    Circle().trim(from: 0, to : 1)
//                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
//                        .rotation(.degrees(-90))
//                        .frame(width: 22, height: 22)
//                        .foregroundStyle(.gray5).opacity(0.5)
//                        .opacity(Hpress ? 0 : 1)
//                    
//                    Circle().trim(from: 0, to : topG ? 1 : 0)
//                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
//                        .rotation(.degrees(-90))
//                        .frame(width: 22, height: 22)
//                        .foregroundStyle(.gray5)
//                        .scaleEffect(Hpress ? 0 : 1)
                    Image(systemName: "pencil.line")
                        .foregroundColor(.white)
                        .font(.system(size: 10, weight: .bold))
//                        .scaleEffect(Hpress ? 0 : 1)
//                        .opacity(topG ? 0 : 1)
                    
                    
//                    Image(systemName: "checkmark")
//                        .font(.system(size: 14, weight: .bold))
//                        .foregroundStyle(.indigo)
//                        .scaleEffect(Hpress ? 1 : 0)
//                        .animation(.easeInOut, value: Hpress)
                }
                
                Text("Writing Now")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
//
//        .animation(.easeInOut.speed(0.3), value: Hpress)
        .scaleEffect(Hpress ? 0.8 : 1)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    Hpress = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        Hpress.toggle()
                        isShowingEditForm.toggle()
                    })
                }
        )

//        .gesture(LongPressGesture(minimumDuration: 1.0).updating($topG) { cstate, gstate, trantion in
//        gstate = cstate
//                
//        }
//            .onEnded({ value in
//                Hpress.toggle()
//
//                print("HHH")
//            })
//        )
    }
}

//#Preview {
//    interButton()
//}
