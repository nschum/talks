import UIKit

protocol PropertyCell {
    var label: UILabel! {get set}
}

class StringPropertyCell: UITableViewCell, PropertyCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var control: UITextField!

    var value: String {
        get {return control.text ?? ""}
        set {control!.text = newValue}
    }
}

class IntPropertyCell: UITableViewCell, PropertyCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var control: UITextField!
    @IBOutlet var stepper: UIStepper!

    var value: Int {
        get {return Int(exactly: stepper.value)!}
        set {
            control.text = newValue.description
            stepper.value = Double(newValue)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.minimumValue = -Double.infinity
        stepper.maximumValue = Double.infinity
    }

    @IBAction func updateStepper() {
        control!.text = Int(exactly: stepper.value)!.description
    }

    @IBAction func updateText() {
        stepper.value = Double(control.text!)!.rounded()
    }
}

class BoolPropertyCell: UITableViewCell, PropertyCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var control: UISwitch!
    var value: Bool {
        get {return control.isOn}
        set {control.isOn = newValue}
    }
}

class ChildCell: UITableViewCell {
    var dataSource: UITableViewDataSource!
}
