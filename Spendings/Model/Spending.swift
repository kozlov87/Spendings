//
// Copyright (c) 2016 Козлов Егор. All rights reserved.
//

import Foundation
import RealmSwift

class Spending: Object {
    dynamic var cost: Double = 0
    dynamic var type: SpendingType?
    dynamic var data: Date?

    override static func indexedProperties() -> [String] {
        return ["data"]
    }
}
