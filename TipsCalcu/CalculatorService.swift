//
//  CalculatorService.swift
//  TipsCalcu
//
//  Created by Сабит Бектуров on 09.06.2026.
//

import Foundation

protocol TipCalculatorBusinessLogic {
    func calculateTotal(bill: Double, client: ClientType, tip: TipPercentage, peopleCount: Int) -> Double
}

struct CalculatorService: TipCalculatorBusinessLogic {
    func calculateTotal(bill: Double, client: ClientType, tip: TipPercentage, peopleCount: Int) -> Double {
        (bill * client.discountMultiplier + bill * tip.tipMultiplier) / Double(peopleCount)
    }
}
