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
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let totalLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("enter_total_bill", comment: "")
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalTxtFld: UITextField = {
        let txtField = PaddedTextField()
        txtField.placeholder = "0.0"
        txtField.textAlignment = .center
        txtField.keyboardType = .decimalPad
        txtField.borderStyle = .none
        txtField.backgroundColor = .secondarySystemBackground
        txtField.layer.cornerRadius = 10  // Rounds the corners
        txtField.clipsToBounds = true  // Clips the content to the corner radius boundaries
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    let clientTypeLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("who_is_paying", comment: "")
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let clientTypeButton: UIButton = {
        // Create a button with a system style (rounded edges as in your screenshot)
        var config = UIButton.Configuration.glass()
        config.title = ClientType.guest.title  // Default text
        config.baseBackgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .label
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
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let amountOfPplButton: UIButton = {
        var config = UIButton.Configuration.glass()
        config.title = "2 \(NSLocalizedString("person_title", comment: ""))"
        config.baseBackgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .label
        config.cornerStyle = .capsule

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let tipPicker: UISegmentedControl = {
        let tipPercArrTitle = TipPercentage.allCases.map({ $0.title })
//        var tipPercArrTitle = [String]()
//        for i in stride(from: 0, to: TipPercentage.allCases.count, by: 1) {
//            tipPercArrTitle.append(TipPercentage.allCases[i].title)
//        }
        let uiSegmentedControl = UISegmentedControl(items: tipPercArrTitle)
        uiSegmentedControl.selectedSegmentIndex = 2
        uiSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return uiSegmentedControl
    }()

    let tipsPercentageLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("how_much_tip", comment: "")
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("output_title", comment: "")
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
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
        
        let currentClient = clientTypeButton.currentTitle ?? ClientType.guest.title
        let amountOfPpl = amountOfPplButton.currentTitle ?? "2 \(NSLocalizedString("person_title", comment: ""))"

        let total = Double(totalSum) ?? 0.0
        
        let clientType = ClientType(title: currentClient) ?? ClientType.guest
        let clientTypeMultiplier: Double
        
        
        clientTypeMultiplier = clientType.discountMultiplier
        outputLbl3.text = clientType.discountDescription
        outputLbl3.textColor = clientType.statusColor
        
        let digits = amountOfPpl.filter { $0.isNumber }
        
        let amountInt = Double(digits)
        
        let tipPercentageInd = tipPicker.selectedSegmentIndex
        let tipPercentage: Double = TipPercentage.allCases[tipPercentageInd].tipMultiplier
        
        let result = (total * clientTypeMultiplier + total * tipPercentage) / (amountInt ?? 2)
        
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
//            totalTxtFld.heightAnchor.constraint(equalToConstant: 45),
//            totalTxtFld.widthAnchor.constraint(equalToConstant: 120),

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
        
        var clientActions: [UIAction] = []
        
        for i in stride(from: 0, to: ClientType.allCases.count, by: 1) {
            clientActions.append(UIAction(title: ClientType.allCases[i].title) { [weak self] _ in
                self?.clientTypeButton.setTitle(ClientType.allCases[i].title, for: .normal)
                self?.calculateTips()
            })
        }

        // 2. Assemble elements into a single UIMenu
        let menu = UIMenu(
            title: NSLocalizedString("client_type", comment: ""),
            children: clientActions
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

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 2, left: 15, bottom: 2, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

enum ClientType: CaseIterable {
    case guest, student, birthday, VIP
    
    init?(title: String) {
        guard let user = ClientType.allCases.first(where: {
            $0.title == title }) else { return nil }
        self = user
    }
    
    var title: String {
        switch self {
        case .guest:
            NSLocalizedString("guest_title", comment: "")
        case .student:
            NSLocalizedString("student_title", comment: "")
        case .birthday:
            NSLocalizedString("birthday_title", comment: "")
        case .VIP:
            "VIP"
        }
    }
    
    var discountMultiplier: Double {
        switch self {
        case .guest:
            1.0
        case .student:
            0.95
        case .birthday:
            0.90
        case .VIP:
            0.85
        }
    }
    
    var discountDescription: String {
        switch self {
        case .guest:
            ""
        case .student:
            NSLocalizedString("student_discount", comment: "")
        case .birthday:
            NSLocalizedString("birthday_discount", comment: "")
        case .VIP:
            NSLocalizedString("vip_discount", comment: "")
        }
    }
    
    var statusColor: UIColor {
        switch self {
        case .guest:
                .label
        case .student:
                .systemBlue
        case .birthday:
                .systemGreen
        case .VIP:
                .systemOrange
        }
    }
}

enum TipPercentage: CaseIterable {
    case low, medium, high, extra
    
    var tipMultiplier: Double {
        switch self {
        case .low:
            0.05
        case .medium:
            0.10
        case .high:
            0.15
        case .extra:
            0.20
        }
    }
    
    var title: String {
        "\(Int(tipMultiplier * 100))%"
    }
}
