//
//  MainView.swift
//  Diary
//
//  Created by 성재 on 2/26/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var isShowingDetailForm: Bool = false
    @State private var tabState: Visibility = .visible
    
    
    
    @State private var selectedIndex : Int = 0
    @State private var tabSelection: TabBarItem = .home
    @State var isHiding : Bool = false

    init() {
        // MARK: Navigation Title font & blur setting
        let appearance = UINavigationBarAppearance()

        if let descriptorWithDesign = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(.serif),
            let descriptorWithTraits = descriptorWithDesign.withSymbolicTraits(.traitBold) {
            let font = UIFont(descriptor: descriptorWithTraits, size: 34)
            appearance.largeTitleTextAttributes = [.font: font, .foregroundColor: UIColor.label]
        }
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear // in your case, you can set it as black color for dark mode
        appearance.shadowColor = .clear // to remove thin line just under the NavigationBar
        appearance.backgroundEffect = UIBlurEffect(style: .light)
            
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.setAnimationsEnabled(false)
        
    }
    
    var body: some View {
            TabBarContainer(selection: $tabSelection, isHiding: $isHiding) {
                ContentView(isHiding: $isHiding)
                    .tabBarItem(tab: .home, selection: $tabSelection)
                MemoryView()
                    .tabBarItem(tab: .favorites, selection: $tabSelection)
                TodayWriteView()
                    .tabBarItem(tab: .messages, selection: $tabSelection)
                SampleTabView("일기록", "person.circle")
                    .tabBarItem(tab: .profile, selection: $tabSelection)
            }
    }
    
    @ViewBuilder
    func SampleTabView(_ title: String, _ icon: String) -> some View {
        Text(title)
            .tabItem {
                Image(systemName: icon)

//                    .foregroundStyle(.mainpoint)
//                Text(title)
            }
    }
}

#Preview {
    MainView()
}
