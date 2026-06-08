//
//  ViewController.swift
//  TipsCalcu
//
//  Created by Сабит Бектуров on 22.05.2026.
//

import UIKit

class ViewController: UIViewController {

    // MARK: UI elements

    let headlineLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        label.text = NSLocalizedString("headline_title", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let totalLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("enter_total_bill", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalTxtFld: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "0.0"
        txtField.textAlignment = .center
        txtField.keyboardType = .decimalPad
        txtField.borderStyle = .roundedRect  // Provides a basic background style
        txtField.layer.cornerRadius = 15  // Rounds the corners
        txtField.clipsToBounds = true  // Clips the content to the corner radius boundaries
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    let clientTypeLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("who_is_paying", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let clientTypeButton: UIButton = {
        // Create a button with a system style (rounded edges as in your screenshot)
        var config = UIButton.Configuration.glass()
        config.title = NSLocalizedString("guest_title", comment: "")  // Default text
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule  // Round into an oval shape matching the layout

        let button = UIButton(configuration: config)

        // CRITICAL: Forces the button to open the menu immediately on tap
        button.showsMenuAsPrimaryAction = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let amountOfPplLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("amount_of_people", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let amountOfPplButton: UIButton = {
        var config = UIButton.Configuration.glass()
        config.title = "2 \(NSLocalizedString("person_title", comment: ""))"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let tipPicker: UISegmentedControl = {
        let uiSegmentedControl = UISegmentedControl(items: [
            "5%", "10%", "15%", "20%",
        ])
        uiSegmentedControl.selectedSegmentIndex = 2
        uiSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return uiSegmentedControl
    }()

    let tipsPercentageLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("how_much_tip", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("output_title", comment: "")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        uiExecutor()
        setupClientMenu()
        setupAmountMenu()
        setupKeyboardHiding()
        uiHandler()
    }
    
    // MARK: - Business Logic
    private func calculateTips() {
        guard let totalSum = totalTxtFld.text
//                let currentClient = clientTypeButton.currentTitle,
//                let amountOfPpl = amountOfPplButton.currentTitle
        else { return }
        
        let currentClient = clientTypeButton.currentTitle ?? NSLocalizedString("guest_title", comment: "")
        let amountOfPpl = amountOfPplButton.currentTitle ?? "2 \(NSLocalizedString("person_title", comment: ""))"

        let total = Double(totalSum) ?? 0.0
        let clientType: Double
        
        switch currentClient {
        case NSLocalizedString("student_title", comment: ""):
            clientType = 0.95
            outputLbl3.text = NSLocalizedString("student_discount", comment: "")
            outputLbl3.textColor = .systemBlue
        case NSLocalizedString("birthday_title", comment: ""):
            clientType = 0.90
            outputLbl3.text = NSLocalizedString("birthday_discount", comment: "")
            outputLbl3.textColor = .systemGreen
        case "VIP":
            clientType = 0.85
            outputLbl3.text = NSLocalizedString("vip_discount", comment: "")
            outputLbl3.textColor = .systemOrange
        default:
            clientType = 1
            outputLbl3.text = ""
        }
        let digits = amountOfPpl.filter { $0.isNumber }
        
        let amountInt = Double(digits)
        
        let tipPercentageInd = tipPicker.selectedSegmentIndex
        var tipPercentage: Double = 0.0
        
        switch tipPercentageInd {
        case 0: tipPercentage = 0.05
        case 1: tipPercentage = 0.1
        case 2: tipPercentage = 0.15
        case 3: tipPercentage = 0.2
        default: tipPercentage = 0
        }
        
        let result = (total * clientType + total * clientType * tipPercentage) / (amountInt ?? 2)
        
        outputLbl2.text = String(format: NSLocalizedString("per_person_format", comment: ""), result)
    }

    
}

// MARK: - UI Setup & Layout
extension ViewController {
    private func uiExecutor() {
        view.addSubview(headlineLbl)
        view.addSubview(totalLbl)
        view.addSubview(totalTxtFld)
        view.addSubview(clientTypeLbl)
        view.addSubview(clientTypeButton)
        view.addSubview(amountOfPplLbl)
        view.addSubview(amountOfPplButton)
        view.addSubview(tipsPercentageLbl)
        view.addSubview(tipPicker)
        view.addSubview(outputLbl)
        view.addSubview(outputLbl2)
        view.addSubview(outputLbl3)


        NSLayoutConstraint.activate([
            // Tip Calculator Headline
            headlineLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            headlineLbl.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 80
            ),

            // Total Bill Amount
            totalLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            totalLbl.topAnchor.constraint(
                equalTo: headlineLbl.bottomAnchor,
                constant: 60
            ),

            totalTxtFld.centerXAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -80
            ),
            totalTxtFld.centerYAnchor.constraint(
                equalTo: totalLbl.centerYAnchor
            ),

            // Client Type
            clientTypeLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            clientTypeLbl.topAnchor.constraint(
                equalTo: totalTxtFld.bottomAnchor,
                constant: 30
            ),

            clientTypeButton.centerXAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -80
            ),
            clientTypeButton.centerYAnchor.constraint(
                equalTo: clientTypeLbl.centerYAnchor
            ),

            // Tip Percentage
            tipsPercentageLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            tipsPercentageLbl.topAnchor.constraint(
                equalTo: clientTypeLbl.bottomAnchor,
                constant: 30
            ),

            tipPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tipPicker.topAnchor.constraint(
                equalTo: tipsPercentageLbl.bottomAnchor,
                constant: 25
            ),
            tipPicker.widthAnchor.constraint(equalToConstant: 300),

            // Number of People
            amountOfPplLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            amountOfPplLbl.topAnchor.constraint(
                equalTo: tipPicker.bottomAnchor,
                constant: 30
            ),

            amountOfPplButton.centerXAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -80
            ),
            amountOfPplButton.centerYAnchor.constraint(
                equalTo: amountOfPplLbl.centerYAnchor
            ),

            // Output Sections
            outputLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            outputLbl.topAnchor.constraint(
                equalTo: amountOfPplLbl.bottomAnchor,
                constant: 30
            ),

            outputLbl2.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            outputLbl2.topAnchor.constraint(
                equalTo: outputLbl.bottomAnchor,
                constant: 30
            ),

            outputLbl3.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            outputLbl3.topAnchor.constraint(
                equalTo: outputLbl2.bottomAnchor,
                constant: 30
            ),

        ])
    }
}

// MARK: - Actions & Menus
extension ViewController {
    private func setupClientMenu() {
        // 1. Create menu actions (UIAction)
        // handler is a closure that triggers when the user selects this menu option
        let guestAction = UIAction(title: NSLocalizedString("guest_title", comment: "")) { [weak self] _ in
            self?.clientTypeButton.setTitle(NSLocalizedString("guest_title", comment: ""), for: .normal)
            self?.calculateTips()
            // Business logic for Guest goes here
        }

        let studentAction = UIAction(title: NSLocalizedString("student_title", comment: "")) { [weak self] _ in
            self?.clientTypeButton.setTitle(NSLocalizedString("student_title", comment: ""), for: .normal)
            self?.calculateTips()
            // Business logic for Student goes here
        }

        let birthdayAction = UIAction(title: NSLocalizedString("birthday_title", comment: "")) { [weak self] _ in
            self?.clientTypeButton.setTitle(NSLocalizedString("birthday_title", comment: ""), for: .normal)
            self?.calculateTips()
            // Business logic for Birthday Person goes here
        }

        let vipAction = UIAction(title: "VIP") { [weak self] _ in
            self?.clientTypeButton.setTitle("VIP", for: .normal)
            self?.calculateTips()
            // Business logic for VIP goes here
        }

        // 2. Assemble elements into a single UIMenu
        let menu = UIMenu(
            title: NSLocalizedString("client_type", comment: ""),
            children: [guestAction, studentAction, birthdayAction, vipAction]
        )

        // 3. Assign the configured menu to our button
        clientTypeButton.menu = menu
    }

    private func setupAmountMenu() {
        // 1. Create menu actions (UIAction)
        // handler is a closure that triggers when the user selects this menu option
        var amountOfPeopleArray = [UIAction]()
        for i in stride(from: 2, to: 100, by: 1) {
            amountOfPeopleArray.append(
                UIAction(title: "\(i) \(NSLocalizedString("person_title", comment: ""))") { [weak self] _ in
                    self?.amountOfPplButton.setTitle(
                        "\(i) \(NSLocalizedString("person_title", comment: ""))",
                        for: .normal
                        
                    )
                    self?.calculateTips()
                }
            )
        }

        // 2. Assemble elements into a single UIMenu
        let menu = UIMenu(
            title: NSLocalizedString("amount_of_people", comment: ""),
            children: amountOfPeopleArray
        )

        // 3. Assign the configured menu to our button
        amountOfPplButton.menu = menu
    }

    private func setupKeyboardHiding() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        // Prevents touch delays on other components (buttons won't hang on the first tap)
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)  // Closes the keyboard across the entire view hierarchy
    }

    
    
    private func uiHandler() {
        // For text field — tracks changes to input text
        totalTxtFld.addTarget(self, action: #selector(someInfoChanged), for: .editingChanged)
        
        // For segmented control — tracks changes to the selected index value
        tipPicker.addTarget(self, action: #selector(someInfoChanged), for: .valueChanged)
    }
    
    @objc private func someInfoChanged() {
        calculateTips()
    }
}
