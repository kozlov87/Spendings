//
//  StatisticsBrain.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import Foundation
import RealmSwift

class StatisticsBrain {
    fileprivate let realm = try! Realm()

    fileprivate func isIn(_ type: PeriodType, date: Date) -> Bool {
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.year, .month, .day]
        
        let nowComponents = (Calendar.current as NSCalendar).components(unitFlags, from: now)
        let dateComponents = (Calendar.current as NSCalendar).components(unitFlags, from: date)
        
        switch type {
        case .day:
            if nowComponents.day != dateComponents.day {
                return false
            }
            fallthrough
        case .month:
            if nowComponents.month != dateComponents.month {
                return false
            }
            fallthrough
        case .year:
            return nowComponents.year == dateComponents.year
        }
    }
        
    func getStatistics(_ periodType: PeriodType) -> [(type: String, sum: Double)] {
        var result: [(type: String, sum: Double)] = []
        let types = realm.objects(SpendingType)
        for type in types {
            var sum: Double = 0
            for spending in type.spendings {
                if isIn(periodType, date: spending.data!) {
                    sum += spending.cost
                }
            }
            if sum != 0 {
                result.append((type.title, sum))
            }
        }
        return result
    }
}

enum PeriodType {
    case day
    case month
    case year
}
