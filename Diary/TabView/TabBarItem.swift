//
//  TabBarItem.swift
//  Diary
//
//  Created by 성재 on 3/27/24.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favorites, profile, messages
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        case .messages: return "message"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        case .messages: return "Messages"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return .blue
        case .favorites: return .red
        case .profile: return .orange
        case .messages: return .green
        }
    }
}
