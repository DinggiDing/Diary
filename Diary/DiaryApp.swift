//
//  DiaryApp.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

import SwiftUI
import TipKit

@main
struct DiaryApp: App {
    
    
    // MARK: - Core data
    @StateObject private var manager: DataManager = DataManager()
    
    init() {
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
//            ExpView()
            MainView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
//            publishButton()
//            EditView2(isPresented: .constant(false))


        }
    }
}
