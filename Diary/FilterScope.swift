//
//  FilterScope.swift
//  Diary
//
//  Created by 성재 on 3/29/24.
//

import Foundation

struct FilterScope: Equatable {
//    var filter: String?
    var filter: Date?
    var filter_on: Bool?
    var predicate: NSPredicate? {
        guard let filter = filter else { return nil }
        guard let filter_on = filter_on else { return nil }
//        return NSPredicate(format: "category == %@", filter)
//        print(filter.startOfMonth())
//        print(filter.endOfMonth())
//        print(filter.startOfYeear())
//        print(filter.endOfYear())
        return filter_on ? NSPredicate(format: "date >= %@ AND date < %@", argumentArray:  [ filter.startOfMonth(), filter.endOfMonth()]) : NSPredicate(format: "date >= %@ AND date < %@", argumentArray:  [ filter.startOfYeear(), filter.endOfYear()])
    }
}
