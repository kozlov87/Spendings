//
// Copyright © 2017 Козлов Егор. All rights reserved.
//

import Foundation
import RealmSwift

class SpendingType: Object {
    
    
    dynamic var title: String = ""
    dynamic var image: String = ""

    var spendings: [Spending] {
        var items = [Spending]()
        for x in LinkingObjects(fromType: Spending.self, property: "type") {
            items.append(x)
        }
        return items
    }
    
    class func setDatabase() {
        let keys : [(index: Int, title: String)] = [
            (18, "Продукты"),
            (14, "Обеды"),
            (15, "Одежда"),
            (11, "Спорт"),
            (8, "Бензин"),
            (3, "Авто"),
            (6, "Дом"),
            (2, "Досуг")
        ]

        let realm = try! Realm()
        try! realm.write {
            for (index, title) in keys {
                let imageName = "Image\(index)"
                let newType = SpendingType(value: [title, imageName])
                realm.add(newType)
            }
        }
    }
}
