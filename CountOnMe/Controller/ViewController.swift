//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    let calculModel = CalculModel()

    // MARK: - IBOutlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var operatorButton: [UIButton]!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalcul(notification:)), name: Notification.Name("updateTextDisplay"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertCalcul(notification:)), name: Notification.Name("alertDisplay"), object: nil)
    } // end of viewDidLoad

    // MARK: - Alert Methods
    @objc func displayCalcul(notification : Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["updateDisplay"] as? String
    } // end of displayCalcul

    @objc func alertCalcul(notification : Notification) {
        guard let alertInfo = notification.userInfo!["message"] as? String else { return }
        createAlert(message: alertInfo)
    } // end of alertCalcul

   func createAlert(message: String) {
        let alertVC = UIAlertController(title: "Alert !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    } // end of createAlert

    // MARK: - View IBActions

    @IBAction func tapedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        calculModel.numberButtonTaped(butttonTitle: numberText)
    } // end of tapedNumberButton

    @IBAction func tapedOperatorButton(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else { return }
        calculModel.operatorButtonTaped(operatorString: sign)
    } // end of tapedOperatorButton

    @IBAction func tapedPointButton(_ sender: UIButton) {
        calculModel.pointButtonTaped()
    }// end of tapedPointButton

    @IBAction func tapedEqualButton(_ sender: UIButton) {
        calculModel.equalButtonTaped()
    } // end of tapedEquelButton

    @IBAction func tapedACButton(_ sender: UIButton) {
        calculModel.acButtonTaped()
    } // end of tapedACButton

    @IBAction func taped2ACButton(_ sender: UIButton) {
        calculModel.acButtonMultiTaped()
    } // end of taped2ACButton

    @IBAction func inverseButton(_ sender: UIButton) {
        calculModel.inverseButtonTaped()
    } // end of inverseButton

} // end of ViewController
