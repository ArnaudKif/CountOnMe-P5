//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by arnaud kiefer on 31/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculModel {
    let space = " "

    var calculText: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateTextDisplay"), object: nil, userInfo: ["updateDisplay": calculText])
        }
    } // end of calculText

    /// Transforms calculText into an array of Strings using the spaces between each character to separate them
    var elements : [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    } // end of elements

    // MARK: - Error check computed variables

    /// This boolean check that the text does not end with + or - or x or ÷ or =
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && elements.last != "="
    } // end of expressionIsCorrect

    /// This boolean check the presence of = and check the number of elements in elements
    var secondToLastIsEqual: Bool {
return elements.count > 2 && elements[elements.count - 2] == "="
    } // end of secondToLastIsNotEqual

    func sendAlertNotification(message : String) {
        let alertName = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: alertName, object: nil, userInfo: ["message": message])
    } // end of sendAlertNotification

    // MARK: - Buttons methods

    func numberButtonTaped(butttonTitle: String) {
        if secondToLastIsEqual || elements.last == "=" {
            clearCalculText()
        }
        calculText.append(butttonTitle)
    } // end of numberButtonTaped

    func inverseButtonTaped() {
        if secondToLastIsEqual {
            lastResultIsCalculText()
        }
        inverseLastNumber()
    } // end of inverseButtonTaped

    func operatorButtonTaped(operatorString: String) {
        if expressionIsCorrect {
            if secondToLastIsEqual {
                lastResultIsCalculText()
            }
            calculText.append("\(space)\(operatorString)\(space)")
        } else { sendAlertNotification(message: "Impossible de mettre deux opérateurs à la suite ! Veuillez entrer un chiffre.")}
    } // end of operatorButtonTaped

    func pointButtonTaped() {
        if expressionIsCorrect && elements.last?.firstIndex(of: ".") == nil {
            if elements.count == 0 {
                calculText.append("0")
            }
            calculText.append(".")
        }
    } // end fo PointButtonTaped

    func acButtonTaped() {
        removeLastElement()
    } // end of acButtonTaped

    func acButtonMultiTaped() {
        clearCalculText()
    } // end of acButtonMultiTaped

    func equalButtonTaped() {
        if expressionIsCorrect && elements.firstIndex(of: "=") == nil && elements.count != 0 {
            let result = makeTheCalcul()
            calculText.append("\(space)=\(space)\(result)")
        } else { sendAlertNotification(message: "Impossible ! Erreur de synthaxe dans votre opération. Veuillez entrer un chiffre ou corriger avec la touche AC.")}
    } // end of equalButtonTaped

    /// This function deletes the last element of the array elements
    func removeLastElement() {
        var textCalcul = elements
        guard textCalcul != [] else { return }
        textCalcul.removeLast()
        clearCalculText()
        for text in textCalcul {
            calculText.append("\(space)\(text)")
        }
        if !expressionIsCorrect {
            calculText.append("\(space)")
        }
    } // end of removeLastElement

    /// This function clear the text
    func clearCalculText() {
        calculText = ""
    } // end of clearCalculText

    /// This function takes the last element of elements and replaces all the text with this one
    func lastResultIsCalculText() {
        let lastResult = elements.last!
        clearCalculText()
        calculText.append("\(lastResult)")
    } // end fo lastResultIsCalculText

    /// This function reverses the last number entered by adding - or deleting
    func inverseLastNumber() {
        var textCalcul = elements
        guard textCalcul != [] else { return }
        if expressionIsCorrect {
            var lastNumber = textCalcul.last!
            textCalcul.removeLast()
            if let ind = lastNumber.firstIndex(of: "-") {
                lastNumber.remove(at: ind)
                textCalcul.append(lastNumber)
            } else {
                textCalcul.append("\(space)-\(lastNumber)")
            }
        } else { return }
        clearCalculText()
        for text in textCalcul {
            calculText.append("\(space)\(text)")
        }
    } // end of inverseLastNumber

    // MARK: - Calcul Methods

    /// This function calculates the result of the operation
    func makeTheCalcul() -> String {
        var operationsToReduce = elements
        var priorityOperator: Bool {
            return (operationsToReduce.firstIndex(of: "x") != nil) || (operationsToReduce.firstIndex(of: "÷") != nil)
        }
        while operationsToReduce.count > 1 {
            while priorityOperator {
                if let indexTempOfOperator = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "÷"}) {
                    let operand = operationsToReduce[indexTempOfOperator]
                    let leftNumber = Double(operationsToReduce[indexTempOfOperator - 1])!
                    let rightNumber = Double(operationsToReduce[indexTempOfOperator + 1])!
                    var priorityOperationsResult: Double = 0.0

                    if operand == "x" {
                        priorityOperationsResult = leftNumber * rightNumber
                    } else {
                        if rightNumber != 0 { priorityOperationsResult = leftNumber / rightNumber
                        } else {
                            sendAlertNotification(message: "Impossible de diviser par 0")
                            calculText.append("Erreur")
                        }
                    }
                    operationsToReduce[indexTempOfOperator - 1] = doubleToInteger(currentResult: priorityOperationsResult)
                    operationsToReduce.remove(at: indexTempOfOperator + 1)
                    operationsToReduce.remove(at: indexTempOfOperator)
                }
            }
            if operationsToReduce.count > 1 {
                let left = Double(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Double(operationsToReduce[2])!
                var result: Double = 0
                if operand == "+" { result = left + right
                }
                if operand == "-" { result = left - right
                }
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(doubleToInteger(currentResult: result))", at: 0)
            }
        }
        return operationsToReduce.first!
    } // end of makeTheCalcul

    /// This function formats a Double into a String with or without the comma as required
    func doubleToInteger(currentResult: Double) -> String {
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: currentResult)), number: .decimal)
        return doubleAsString
    } // end of doubleToInteger

} // end of class CalculModel
