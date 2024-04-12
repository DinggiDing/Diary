//
//  MemoryView.swift
//  Diary
//
//  Created by 성재 on 3/28/24.
//

import SwiftUI
import Kingfisher

struct MemoryView: View {
    
    
    /// coredata
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [Date().startOfMonth(), Date().endOfMonth()])) private var todos: FetchedResults<DB_core>
    
    @State private var filterScope: FilterScope = FilterScope(filter: Date.now, filter_on: true)
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) private var todos: FetchedResults<DB_core>
    

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
//        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer().frame(height: 16)
                HStack {
                    Spacer().frame(width: 10)
                    Button(action: {
//                        let lastMonth = Calendar.current.date(byAdding: .month, value: 0, to: Date())
//                        filterScope.filter = lastMonth
//                        filterScope.filter_on = false
                        
                        print(group(todos))
                    }, label: {
                        Text(formatDate_Year(Date.now))
                    })
                    Text(" > ")
                        .foregroundStyle(.black)
                    Button(action: {
                        let lastMonth = Calendar.current.date(byAdding: .year, value: 0, to: Date())
                        filterScope.filter = lastMonth
                        filterScope.filter_on = true
                    }, label: {
                        Text(formatDate_Month(Date.now))
                    })
                    Spacer()
                }
                Spacer().frame(height: 8)

                if filterScope.filter_on! {
                    LazyVGrid(columns: columns,  spacing: 5) {
                        ForEach(todos, id: \.self) {todo in
                            //VStack으로 도형추가
                            ZStack(alignment: .center) {
                                if !todo.image.isEmpty {
                                    KFImage.url(todo.image.first)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                                        .clipped()
                                } else {
                                    Text(todo.title!)
                                        .foregroundStyle(.black)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .font(.Arita_buriBold_edt)
                                        .frame(width: AppConfig.homeWidth/2-1)
                                        .blur(radius: 3)
                                        .clipped()
                                }
                                
                                Color(.black).opacity(0.3)
                                    .frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                                
                                Text(formatDate(todo.date!))
                                    .foregroundStyle(.white)
                                    .font(.custom("SUIT-Regular", size: 14))
                                    .frame(width: AppConfig.homeWidth/2-1)
                                
                            }.frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                        }
                    }
                }
                else {
                    LazyVGrid(columns: columns,  spacing: 5) {
                        ForEach(todos, id: \.self) {todo in
                            //VStack으로 도형추가
                            ZStack(alignment: .center) {
                                if !todo.image.isEmpty {
                                    KFImage.url(todo.image.first)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                                        .clipped()
                                } else {
                                    Text(todo.title!)
                                        .foregroundStyle(.black)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .font(.Arita_buriBold_edt)
                                        .frame(width: AppConfig.homeWidth/2-1)
                                        .blur(radius: 3)
                                        .clipped()
                                }
                                
                                Color(.black).opacity(0.3)
                                    .frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                                
                                Text(formatDate_Month(todo.date!))
                                    .foregroundStyle(.white)
                                    .font(.custom("SUIT-Regular", size: 14))
                                    .frame(width: AppConfig.homeWidth/2-1)
                                
                            }.frame(width: AppConfig.homeWidth/2-1, height: AppConfig.homeWidth3)
                        }
                    }
                }
                
                
                Spacer().frame(height: 65)
            }
            .navigationTitle("Now")
//            .toolbar {
//    //                ToolbarItem(placement: .navigationBarTrailing) {
//    //                    ProfileView()
//    //                        .onTapGesture {
//    //                            print("000000")
//    //                        }
//    //                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    ProfileView2(today_on: $today_on)
//                }
//
//            }
        }
        .onChange(of: filterScope) { newValue in
            todos.nsPredicate = filterScope.predicate
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY / MM / dd"
        return formatter.string(from: date)
    }
    
    private func formatDate_Month(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월"
        return formatter.string(from: date)
    }
    
    private func formatDate_Year(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년"
        return formatter.string(from: date)
    }
    
    func group(_ result : FetchedResults<DB_core>) -> [[DB_core]] {
        let sorted = result.sorted { $0.date! < $1.date! }

        return Dictionary(grouping: sorted) { (element : DB_core)  in
            formatDate_Month(element.date! as Date)
        }.sorted { $0.key < $1.key }.map(\.value)
    }
    
}

#Preview {
    MemoryView()
}

//extension Date {
//    func startOfMonth() -> Date {
//        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
//    }
//    
//    func endOfMonth() -> Date {
//        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
//    }
//}

extension Date {
    
    func startOfMonth() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
    }
    
    func endOfMonth() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return interval!.end
    }
    
    func startOfYeear() -> Date {
        let interval = Calendar.current.dateInterval(of: .year, for: self)
        return (interval?.start.toLocalTime())!
    }
    
    func endOfYear() -> Date {
        let interval = Calendar.current.dateInterval(of: .year, for: self)
        return interval!.end
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
