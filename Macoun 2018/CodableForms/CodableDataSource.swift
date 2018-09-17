import UIKit

// shortcut to avoid writing dictionary coders
func decode<T: Decodable>(_ dictionary: [String: Any]) -> T {
    let data = try! JSONSerialization.data(withJSONObject: dictionary)
    return try! JSONDecoder().decode(T.self, from: data)
}

func encode<T: Encodable>(_ object: T) -> [String: Any] {
    let data = try! JSONEncoder().encode(object)
    return try! JSONSerialization.jsonObject(with: data) as! [String: Any]
}

class CodableDataSource<T>: BaseCodableDataSource where T: Encodable, T: Decodable {

    var object: T {
        didSet {
            dump(object)
        }
    }

    init(reflecting object: T) {
        self.object = object
        super.init(dictionary: encode(object))
    }

    override func update() {
        super.update()
        object = decode(dictionary)
    }
}

class ChildCodableDataSource: BaseCodableDataSource {
    let key: String
    let parent: BaseCodableDataSource

    init(dictionary: [String: Any], key: String, parent: BaseCodableDataSource) {
        self.key = key
        self.parent = parent
        super.init(dictionary: dictionary)
    }

    fileprivate override func update() {
        parent.updateValue(key: key, value: dictionary)
    }
}

class BaseCodableDataSource: NSObject, UITableViewDataSource, UITextFieldDelegate {

    fileprivate var dictionary: [String: Any]

    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let children = dictionary
        let index = children.index(children.startIndex, offsetBy: indexPath.row)

        let value = children[index].value

        let label = children[index].key
        let cell: UITableViewCell
        if let dictionary = value as? [String: Any] {
            return childCell(dictionary, key: label, tableView: tableView, indexPath: indexPath)
        } else if let boolean = value as? Bool {
            cell = boolPropertyCell(boolean, key: label, tableView: tableView, indexPath: indexPath)
        } else if let int = value as? Int {
            cell = intPropertyCell(int, key: label, tableView: tableView, indexPath: indexPath)
        } else {
            cell = textPropertyCell(value, key: label, tableView: tableView, indexPath: indexPath)
        }
        cell.tag = indexPath.row
        return cell
    }

    private func childCell(_ dictionary: [String: Any], key: String, tableView: UITableView, indexPath: IndexPath)
            -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildCell

        cell.textLabel!.text = key
        cell.dataSource = ChildCodableDataSource(dictionary: dictionary, key: key, parent: self)
        return cell
    }

    private func boolPropertyCell(_ value: Bool, key: String, tableView: UITableView,
                                  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoolPropertyCell", for: indexPath) as! BoolPropertyCell
        cell.label.text = key
        cell.value = value
        cell.control.addTarget(self, action: #selector(self.update(sender:)), for: .valueChanged)
        return cell
    }

    private func intPropertyCell(_ value: Int, key: String, tableView: UITableView,
                                 indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IntPropertyCell", for: indexPath) as! IntPropertyCell
        cell.label.text = key
        cell.value = value
        cell.control.addTarget(self, action: #selector(update(sender:)), for: .editingChanged)
        cell.stepper.addTarget(self, action: #selector(update(sender:)), for: .touchUpInside)
        return cell
    }

    private func textPropertyCell(_ value: Any, key: String, tableView: UITableView,
                                  indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "StringPropertyCell", for: indexPath) as! StringPropertyCell
        cell.label.text = key
        cell.value = String(describing: value)
        cell.control.addTarget(self, action: #selector(self.update(sender:)), for: .editingChanged)
        cell.control.isEnabled = value is String // We can *show* any type as String, but we can't convert it back
        return cell
    }

    @objc
    func update(sender: UIControl) {
        var view: UIView = sender
        while (!(view is PropertyCell)) {
            view = view.superview!
        }
        let cell = view as! PropertyCell
        let key = cell.label!.text!

        let oldValue = dictionary[key]!

        let newValue: Any
        if let cell = cell as? StringPropertyCell {
            newValue = cell.value
            assert(oldValue is String, "Converter for \(type(of: oldValue)) not implemented")
        } else if let cell = cell as? IntPropertyCell {
            newValue = cell.value
        } else if let cell = cell as? BoolPropertyCell {
            newValue = cell.value
        } else {
            fatalError("\(type(of: cell)) not handled")
        }

        updateValue(key: key, value: newValue)
    }

    fileprivate func updateValue(key: String, value: Any) {
        dictionary[key] = value
        update()
    }

    fileprivate func update() {
        // override point
    }
}
