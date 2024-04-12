//
//  TodayWriteView.swift
//  Diary
//
//  Created by 성재 on 4/1/24.
//

import SwiftUI

struct TodayWriteView: View {
    
    /// coredata
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
    
    
    @State var isHiding: Bool = false
    @State var isPresented: Bool = false
    
    var body: some View {
        
        if checkIfDateIsWithinRange(date: todos[0].date!) {
            EditTodayView(db: todos[0], isPresented: $isPresented, isHiding: $isHiding, isThirdTab: true)
        }
        else {
            EditView2(isPresented: $isPresented, isHiding: $isHiding, isThirdTab: true)
        }
       
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

//#Preview {
//    TodayWriteView()
//}
