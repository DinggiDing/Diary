//
//  ContentView.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @State var isShowingEditForm: Bool = false
    
    /// coredata
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
    let columns = [GridItem(.flexible(), spacing: 1)]

    @State private var favoriteColor = "Day"
    var colors = ["Day", "Month", "Year"]
    
//    @State private var isShowingDetailForm: Bool = false
    
//    @State var isHiding : Bool = false
    @Binding var isHiding : Bool
    @State var scrollOffset : CGFloat = 0
    @State var threshHold : CGFloat = 0
    
    @State var isPresented: Bool = false
    @State var today_on: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                ScrollView(content: {
                    //                        if todos[0].date! >= getNoonToday() {
                    
                    
                    ZStack {
                        VStack {
                            Spacer().frame(height: 16)

                            if !checkIfDateIsWithinRange(date: todos[0].date!) {
                                //                            let _ = print("HI")
                                
                                HStack(spacing: 18) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundColor(Color("gray6"))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 5, height: 5)
                                    Text(Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                        .font(.SUIT_Regular)
                                        .foregroundStyle(Color("gray3"))
                                    
                                    Spacer()
                                }.padding(.bottom, 12)
                                
                                HStack {
                                    Spacer()
                                    
                                    interButton(isShowingEditForm: $isShowingEditForm)
                                    
                                        .padding(.bottom, 38)
//                                        .rotationEffect(.radians(.pi))
//                                        .scaleEffect(x: -1, y:1, anchor: .center)
                                    Spacer()
                                }
//                                    .listRowSeparator(.hidden)
//                                    .rotationEffect(.radians(.pi))
//                                    .scaleEffect(x: -1, y: 1, anchor: .center)
//                                    .frame(width: AppConfig.homeWidth - 52)
                            }
                            else {
                                Spacer().frame(height: 20)
                            }
        
                            ForEach(todos, id: \.self) { todo in
                                NavigationLink(destination: {
                                    if checkIfDateIsWithinRange(date: todo.date!) {
                                        EditTodayView(db: todo, isPresented: $isPresented, isHiding: $isHiding)
                                    }
                                    else {
                                        ShowView(db: todo, isHiding: $isHiding)
                                    }
                                }, label: {
                                    HStack(alignment: .center) {
                                        VStack(alignment: .leading) {
                                            HStack(spacing: 18) {
                                                Image(systemName: "circle.fill")
                                                    .resizable()
                                                    .foregroundColor(Color("gray6"))
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 5, height: 5)
                                                
                                                Text(todo.date ?? Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                    .font(.SUIT_Regular)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }.padding(.bottom, 12)
                                            
                                            HStack {
                                                Spacer()
                                                VStack(alignment: .leading) {
                                                    Text(todo.title ?? "")
                                                        .font(.Arita_buriBold)
                                                        .foregroundStyle(Color.black)
                                                        .frame(width: 280, alignment: .leading)
                                                        .padding(.bottom, 5)
                                                    
                                                    Text(todo.status ?? "")
                                                        .font(.Arita_buriLight)
                                                        .foregroundStyle(Color.black)
                                                        .lineLimit(5)
                                                        .frame(width: 280, alignment: .leading)
                                                        .multilineTextAlignment(.leading)
                                                    
                                                    if !todo.image.isEmpty {
                                                        ScrollView(.horizontal) {
                                                            LazyHGrid(rows: columns, spacing: 10) {
                                                                ForEach(todo.image, id: \.self) { images in
                                                                    KFImage.url(images)
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .frame(width: 119, height: 153)
                                                                        .clipped()
          
                                                                }
                                                            }.frame(height: 150)
                                                        }
                                                    }
                                                }
                                                .frame(width: 280)
                                                Spacer()
                                            }
                                            
                                            Spacer().frame(height: 36)
                                            
                                        }
                                    }
//                                    .listRowSeparator(.hidden)
//                                    .rotationEffect(.radians(.pi))
//                                    .scaleEffect(x: -1, y: 1, anchor: .center)
//                                    .frame(width: AppConfig.homeWidth - 52)
                                })
            
                            }
                            GeometryReader { proxy in
                                Color.clear
                                    .changeOverlayOnScroll(
                                        proxy: proxy,
                                        offsetHolder: $scrollOffset,
                                        thresHold: $threshHold,
                                        toggle: $isHiding
                                    )
                            }
                        }
                        
                        
                    }
        
                    
                })
                .padding(.leading, 26)
                .padding(.trailing, 26)
                .coordinateSpace(name: "scroll")
//                .toolbar(isHiding ? .hidden : .visible, for: .navigationBar)
//                .toolbar(isHiding ? .hidden : .visible, for: .tabBar)
                    
//                .rotationEffect(.radians(.pi))
//                .scaleEffect(x: -1, y: 1, anchor: .center)
//                .background(.white)
//                .scrollContentBackground(.hidden)

                
                
                HStack {
                    Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                        .foregroundStyle(.gray5)
                    Spacer()
                }
            }
            .onAppear {
                today_on = checkIfDateIsWithinRange(date: todos[0].date!)

                isHiding = false
            }
            
            .navigationDestination(isPresented: $isShowingEditForm, destination: {
                EditView2(isPresented: $isShowingEditForm, isHiding: $isHiding, isThirdTab: false)
            })
            .navigationTitle("Writing Now")
            .toolbar {
    //                ToolbarItem(placement: .navigationBarTrailing) {
    //                    ProfileView()
    //                        .onTapGesture {
    //                            print("000000")
    //                        }
    //                }
                ToolbarItem(placement: .navigationBarLeading) {
                    ProfileView2(today_on: $today_on)
                }

            }
//            .ignoresSafeArea()
        }
        
    }
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func checkIfDateIsWithinRange(date: Date) -> Bool {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date.now)
        let hour = components.hour ?? 0
        
        var startDate = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
        var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
        
        if hour < 11 {
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
            endDate = Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
        }

//        print("__")
//        print(startDate)
//        print(Date.now)
//        print(date)
//        print(hour)
//        print(endDate)
//        print("==")
        if date >= startDate && date < endDate {
            print("1")
            return true
        }
        else {
            return false
        }
    }
    
}

#Preview {
    MainView()
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.main)
            .foregroundStyle(.white)
            .clipShape(Circle())
            
    }
}

extension View {
    
    func changeOverlayOnScroll(
        proxy : GeometryProxy,
        offsetHolder : Binding<CGFloat>,
        thresHold : Binding<CGFloat>,
        toggle: Binding<Bool>
    ) -> some View {
        self
            .onChange(
                of: proxy.frame(in: .named("scroll")).minY
            ) { newValue in
                // Set current offset
                offsetHolder.wrappedValue = abs(newValue)
                // If current offset is going downward we hide overlay after 200 px.
                if offsetHolder.wrappedValue > thresHold.wrappedValue + 200 {
                    // We set thresh hold to current offset so we can remember on next iterations.
                    thresHold.wrappedValue = offsetHolder.wrappedValue
                    // Hide overlay
                    toggle.wrappedValue = false
                    
                    // If current offset is going upward we show overlay again after 200 px
                }else if offsetHolder.wrappedValue < thresHold.wrappedValue - 200 {
                    // Save current offset to threshhold
                    thresHold.wrappedValue = offsetHolder.wrappedValue
                    // Show overlay
                    toggle.wrappedValue = true
                }
         }
    }
}
