//
//  ViewController.swift
//  TipsCalcu
//
//  Created by Сабит Бектуров on 22.05.2026.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Шаг 1: Объявление UI-элементов

    let headlineLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        label.text = "Калькулятор чаевых"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let totalLbl: UILabel = {
        let label = UILabel()
        label.text = "Введите сумму чека:"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalTxtFld: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "0.0"
        txtField.textAlignment = .center
        txtField.keyboardType = .decimalPad
        txtField.borderStyle = .roundedRect  // Дает базовую подложку
        txtField.layer.cornerRadius = 15  // Скругляет углы
        txtField.clipsToBounds = true  // Обрезает контент по радиусу
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    let clientTypeLbl: UILabel = {
        let label = UILabel()
        label.text = "Кто оплачивает счет?"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let clientTypeButton: UIButton = {
        // Создаем кнопку с системным стилем (с закругленными краями, как на твоем скрине)
        var config = UIButton.Configuration.glass()
        config.title = "Гость"  // Текст по умолчанию
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule  // Закругляем в овал, как на макете

        let button = UIButton(configuration: config)

        // КРИТИЧЕСКИ ВАЖНО: заставляем кнопку сразу открывать меню
        button.showsMenuAsPrimaryAction = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let amountOfPplLbl: UILabel = {
        let label = UILabel()
        label.text = "Количество человек:"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let amountOfPplButton: UIButton = {
        var config = UIButton.Configuration.glass()
        config.title = "2 человека"
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
        label.text = "Сколько оставить чаевых?"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl: UILabel = {
        let label = UILabel()
        label.text = "Вывод"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outputLbl2: UILabel = {
        let label = UILabel()
        label.text = "0.0 с человека"
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
        view.backgroundColor = .white
        uiExecutor()
        setupClientMenu()
        setupAmountMenu()
        setupKeyboardHiding()
        uiHandler()
    }

    private func uiExecutor() {
        // MARK: Шаг 2: Добавление на экран
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

        // MARK: Шаг 3: Расположение элементов на экране

        NSLayoutConstraint.activate([
            // Калькулятор чаевых
            headlineLbl.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 20
            ),
            headlineLbl.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 80
            ),

            // Сумма чека
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

            // Тип клиента
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

            // Процент чаевых
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

            // Количество человек
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

            // Вывод
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

    private func setupClientMenu() {
        // 1. Создаем элементы меню (UIAction)
        // handler — это замыкание, которое сработает, когда пользователь выберет этот пункт
        let guestAction = UIAction(title: "Гость") { [weak self] _ in
            self?.clientTypeButton.setTitle("Гость", for: .normal)
            self?.calculateTips()
            // Здесь твоя логика расчета для Гостя
        }

        let studentAction = UIAction(title: "Студент") { [weak self] _ in
            self?.clientTypeButton.setTitle("Студент", for: .normal)
            self?.calculateTips()
            // Здесь твоя логика расчета для Студента
        }

        let birthdayAction = UIAction(title: "Именинник") { [weak self] _ in
            self?.clientTypeButton.setTitle("Именинник", for: .normal)
            self?.calculateTips()
            // Здесь твоя логика расчета для Именинника
        }

        let vipAction = UIAction(title: "VIP") { [weak self] _ in
            self?.clientTypeButton.setTitle("VIP", for: .normal)
            self?.calculateTips()
            // Здесь твоя логика расчета для VIP
        }

        // 2. Собираем элементы в одно UIMenu
        let menu = UIMenu(
            title: "Тип клиента",
            children: [guestAction, studentAction, birthdayAction, vipAction]
        )

        // 3. Отдаем это меню нашей кнопке
        clientTypeButton.menu = menu
    }

    private func setupAmountMenu() {
        // 1. Создаем элементы меню (UIAction)
        // handler — это замыкание, которое сработает, когда пользователь выберет этот пункт
        var amountOfPeopleArray = [UIAction]()
        for i in stride(from: 2, to: 100, by: 1) {
            amountOfPeopleArray.append(
                UIAction(title: "\(i) человека") { [weak self] _ in
                    self?.amountOfPplButton.setTitle(
                        "\(i) человека",
                        for: .normal
                        
                    )
                    self?.calculateTips()
                }
            )
        }

        // 2. Собираем элементы в одно UIMenu
        let menu = UIMenu(
            title: "Количество человек",
            children: amountOfPeopleArray
        )

        // 3. Отдаем это меню нашей кнопке
        amountOfPplButton.menu = menu
    }

    private func setupKeyboardHiding() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        // Отменяет задержку нажатий на другие элементы (кнопки не будут тупить при первом тапе)
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)  // Закрывает клавиатуру на всей view
    }

    private func calculateTips() {
        guard let totalSum = totalTxtFld.text
//                let currentClient = clientTypeButton.currentTitle,
//                let amountOfPpl = amountOfPplButton.currentTitle
        else { return }
        
        let currentClient = clientTypeButton.currentTitle ?? "Гость"
        let amountOfPpl = amountOfPplButton.currentTitle ?? "2 человека"

        let total = Double(totalSum) ?? 0.0
        let clientType: Double
        
        switch currentClient {
        case "Студент":
            clientType = 0.95
            outputLbl3.text = "Применена студенческая скидка 📚"
            outputLbl3.textColor = .blue
        case "Именинник":
            clientType = 0.90
            outputLbl3.text = "Применена скидка именинника 🎁"
            outputLbl3.textColor = .green
        case "VIP":
            clientType = 0.85
            outputLbl3.text = "Применена VIP скидка 😎"
            outputLbl3.textColor = .yellow
        default:
            clientType = 1
            outputLbl3.text = ""
        }
        var amountStr = amountOfPpl
        amountStr.removeLast(9)
        
        let amountInt = Double(amountStr)
        
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
        
        outputLbl2.text = String(format: "%.2f с человека", result)
    }
    
    private func uiHandler() {
        // Для текстового поля — ловим изменение текста
        totalTxtFld.addTarget(self, action: #selector(someInfoChanged), for: .editingChanged)
        
        // Для сегмента — ловим изменение выбранного значения
        tipPicker.addTarget(self, action: #selector(someInfoChanged), for: .valueChanged)
    }
    
    @objc private func someInfoChanged() {
        calculateTips()
    }
}
