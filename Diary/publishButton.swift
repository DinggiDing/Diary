//
//  publishButton.swift
//  Diary
//
//  Created by 성재 on 3/16/24.
//

import SwiftUI
import Drops

struct publishButton: View {
    
    // MARK: Core data variables
   @EnvironmentObject var manager: DataManager
   @Environment(\.managedObjectContext) var viewContext
    
    @Binding var title : String
    @Binding var status : String
    @Binding var image : [URL]
    
    @State var fb = false
    @State var Hpress = false
    @Binding var donedone : Bool
    
    @GestureState var topG = false
    
    var body: some View {

        ZStack {
            Rectangle().frame(width: 150, height: 44)
                .foregroundColor(.blackblue55)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.6), radius: 10, x: 10, y:10)
            
            HStack(spacing: 13) {
                //            Circle()
                //                .stroke(lineWidth: 7)
                //                .frame(width: 120, height: 120)
                //                .foregroundColor(Color.gray)
                //
                //            Circle()
                //                .stroke(lineWidth: 5.5)
                //                .frame(width: 105, height: 105)
                //                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                //
                //
                //            if topG {
                //                Circle()
                //                    .stroke(lineWidth: 15)
                //                    .frame(width: 105, height: 105)
                //                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                //                    .blur(radius: 3)
                //
                //            }
                
                ZStack {
                    Circle().trim(from: 0, to : 1)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .rotation(.degrees(-90))
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.gray5).opacity(0.5)
                        .opacity(Hpress ? 0 : 1)
                    
                    Circle().trim(from: 0, to : topG ? 1 : 0)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .rotation(.degrees(-90))
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.gray5)
                        .scaleEffect(Hpress ? 0 : 1)
                    Image(systemName: "arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 10, weight: .bold))
                        .scaleEffect(Hpress ? 0 : 1)
                        .offset(x: 0, y: topG ? -50: 0)
                        .opacity(topG ? 0 : 1)
                    
                    
                    //                Image(systemName: "square.and.arrow.up.circle")
                    //                    .foregroundStyle(.indigo)
                    //                    .font(.system(size: 60))
                    //                    .scaleEffect(Hpress ? 0 : 1)
                    //                    .clipShape(Circle().offset(y: topG ? 0 : 120))
                    //                    .animation(.easeInOut.speed(0.3), value: topG)
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.indigo)
                        .scaleEffect(Hpress ? 1 : 0)
                        .animation(.easeInOut, value: Hpress)
                }
                
                Text("Publish")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        
        .animation(.easeInOut.speed(0.3), value: topG)
        .scaleEffect(topG ? 0.8 : 1)
        .gesture(LongPressGesture(minimumDuration: 1.0).updating($topG) { cstate, gstate, trantion in
        gstate = cstate
                
        }
            .onEnded({ value in
                Hpress.toggle()
                self.saveTodo(title: title=="" ? formatDate(Date.now) : title, date: Date.now, status: status, image: image)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    donedone.toggle()
                }
                print("HHH")
                print(donedone)
            })
        )
        

    }
    
    // MARK: Core Data Operations
    private func saveTodo(title: String, date: Date, status: String, image: [URL]) {
        let todo = DB_core(context: self.viewContext)
        todo.id = UUID()
        todo.title = title
        todo.date = date
        todo.status = status
        todo.image = image
        
        do {
            try self.viewContext.save()
            print("Todo saved!")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 일기"
        return formatter.string(from: date)
    }
    
}

//#Preview {
//    publishButton()
//}
