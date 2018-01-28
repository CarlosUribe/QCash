//
//  VPaymentAgreementView.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit
import LocalAuthentication

class VPaymentAgreementView:UIView{
    weak var controller:CPaymentAgreementController!
    weak var paymentLabel:UILabel!
    weak var paymentButton:UIButton!
    weak var cancelButton:UIButton!
    var paymentCuantity:String = ""

    init(controller: CPaymentAgreementController, data:String){
        super.init(frame: .zero)
        self.controller = controller
        self.paymentCuantity = data

        let paymentLabel:UILabel = UILabel()
        paymentLabel.clipsToBounds = true
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentLabel.numberOfLines = 0
        paymentLabel.backgroundColor = .white
        paymentLabel.text = "Tu monto a pagar $\(data)"
        paymentLabel.font = UIFont.boldSystemFont(ofSize: 18)
        paymentLabel.textColor = .black
        paymentLabel.textAlignment = .center
        self.paymentLabel = paymentLabel

        let paymentButton:UIButton = UIButton()
        paymentButton.clipsToBounds = true
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.setTitle("Aceptar", for: .normal)
        paymentButton.setTitleColor(.white, for: .normal)
        paymentButton.layer.cornerRadius = 8.0
        paymentButton.backgroundColor = UIColor(red:0.13, green:0.71, blue:0.12, alpha:1.0)
        paymentButton.addTarget(self,
                                action: #selector(makeTransaction(sender:)),
                                for: .touchUpInside)
        self.paymentButton = paymentButton

        let cancelButton:UIButton = UIButton()
        cancelButton.clipsToBounds = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 8.0
        cancelButton.backgroundColor = UIColor(red:0.71, green:0.12, blue:0.36, alpha:1.0)
        cancelButton.addTarget(self,
                                action: #selector(cancelTransaction(sender:)),
                                for: .touchUpInside)
        self.cancelButton = cancelButton

        addSubview(paymentLabel)
        addSubview(paymentButton)
        addSubview(cancelButton)

        let views:[String : UIView] = [
            "paymentLabel":paymentLabel,
            "paymentButton":paymentButton,
            "cancelButton":cancelButton]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[paymentLabel]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-120-[paymentLabel(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-40-[cancelButton(80)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[paymentButton(80)]-40-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[paymentLabel]-20-[paymentButton(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[paymentLabel]-20-[cancelButton(40)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func makeTransaction(sender: UIButton){
        let myContext = LAContext()
        let myLocalizedReasonString = "Requerimos de tu Autorización para realizar la transacción"

        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        makeTransactionRequest()
                    } else {
                        // User did not authenticate successfully, look at error and take appropriate action
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
            }
        } else {
            // Fallback on earlier versions
        }
    }

    @objc func cancelTransaction(sender: UIButton){
        controller.parentController.setMainMenu()
    }

    func makeTransactionRequest(){
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {

        }
    }
}
