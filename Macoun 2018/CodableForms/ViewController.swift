import UIKit

struct Person: Codable {
    var name: String
    var age: Int
    var address: Address
    var isTalking = false

    init(name: String, age: Int, address: Address) {
        self.name = name
        self.age = age
        self.address = address
    }
}

struct Address: Codable {
    var street: String
    var number: Int
    var postCode: Int
}

class ViewController: UITableViewController {

    private let person = Person(name: "Nikolaj Schumacher",
                                age: 35,
                                address: Address(street: "str", number: 42, postCode: 60437))
    private var dataSource: UITableViewDataSource? {
        didSet {
            if isViewLoaded {
                tableView.dataSource = dataSource
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Mirror implementation read-only
        // dataSource = MirrorDataSource(reflecting: person)
        
        // Codable implementation read-write
        dataSource = CodableDataSource(reflecting: person)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ChildCell else {
            return nil
        }

        let vc = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.title = cell.textLabel!.text
        vc.dataSource = cell.dataSource
        navigationController!.pushViewController(vc, animated: true)
        return indexPath
    }
}
