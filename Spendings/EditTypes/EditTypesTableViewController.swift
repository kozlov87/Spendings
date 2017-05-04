//
// Copyright (c) 2016 Козлов Егор. All rights reserved.
//

import UIKit
import RealmSwift

class EditTypesTableVewController: UITableViewController {
    struct Storyboard {
        static let cellId = "cellId"
    }

    
    let realm = try! Realm()
    
    var types: Results<SpendingType> {
        get {
            return realm.objects(SpendingType)
        }
    }
    
    @IBAction func addingCancel(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func addingDone(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.cellId, for: indexPath)

        let spendingType = types[indexPath.row]

        cell.imageView?.image = UIImage(named: spendingType.image)
        cell.textLabel?.text = spendingType.title
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let object = types[indexPath.row]
            tableView.beginUpdates()
            try! realm.write {
                realm.delete(object)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            break

        default:
            break
        }
    }
    
    @IBAction func togleMenu(_ sender: AnyObject) {
        toggleSideMenuView()
    }
}
