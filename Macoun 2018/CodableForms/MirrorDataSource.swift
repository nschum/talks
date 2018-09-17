import UIKit

class MirrorDataSource: NSObject, UITableViewDataSource {

    private let mirror: Mirror

    convenience init(reflecting object: Any) {
        self.init(mirror: Mirror(reflecting: object))
    }

    private init(mirror: Mirror) {
        self.mirror = mirror
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mirror.children.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let children = mirror.children
        let index = children.index(children.startIndex, offsetBy: indexPath.row)

        let value = children[index].value
        let childMirror = Mirror(reflecting: value)

        let label = children[index].label ?? ""
        if childMirror.children.count > 1 {
            return childCell(childMirror, key: label, tableView: tableView, indexPath: indexPath)
        } else if let boolean = value as? Bool {
            return boolPropertyCell(boolean, key: label, tableView: tableView, indexPath: indexPath)
        } else {
            return stringPropertyCell(value, key: label, tableView: tableView, indexPath: indexPath)
        }
    }

    private func childCell(_ mirror: Mirror, key: String, tableView: UITableView, indexPath: IndexPath)
            -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildCell

        cell.textLabel!.text = key
        cell.dataSource = MirrorDataSource(mirror: mirror)
        return cell
    }

    private func boolPropertyCell(_ value: Bool, key: String, tableView: UITableView,
                                  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoolPropertyCell", for: indexPath) as! BoolPropertyCell
        cell.label.text = key
        cell.value = value
        cell.control.isEnabled = false
        return cell
    }

    private func stringPropertyCell(_ value: Any, key: String, tableView: UITableView,
                                    indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "StringPropertyCell", for: indexPath) as! StringPropertyCell
        cell.label.text = key
        cell.value = String(describing: value)
        cell.control.isEnabled = false
        return cell
    }
}
