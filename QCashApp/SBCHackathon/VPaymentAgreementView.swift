//
//  VPaymentAgreementView.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit
import LocalAuthentication
import Apollo

class VPaymentAgreementView:UIView{
    weak var controller:CPaymentAgreementController!
    weak var paymentLabel:UILabel!
    weak var paymentButton:UIButton!
    weak var cancelButton:UIButton!
    weak var successFailureButton:UIButton!
    var paymentCuantity:String = ""
    private let kCodeSender:String = "3ec61274-823b-4610-bd86-a8f5626c55b4"//usuario creado desde el backend
    private let kCodeReciver:String = "f093584c-9bf5-46ec-8754-c8ad84a935ec"

    let apollo: ApolloClient = {
        let graphQLEndpoint:String = "https://qcash.roderik.io"
        let configuration = URLSessionConfiguration.default
        let url = URL(string: graphQLEndpoint)!

        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

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

        let successFailureButton:UIButton = UIButton()
        successFailureButton.clipsToBounds = true
        successFailureButton.translatesAutoresizingMaskIntoConstraints = false
        successFailureButton.clipsToBounds = true
        successFailureButton.translatesAutoresizingMaskIntoConstraints = false
        successFailureButton.setTitleColor(.white, for: .normal)
        successFailureButton.layer.cornerRadius = 8.0
        successFailureButton.backgroundColor = UIColor(red:0.32, green:0.56, blue:0.95, alpha:1.0)
        successFailureButton.isHidden = true
        successFailureButton.addTarget(self,
                                action: #selector(endTransaction(sender:)),
                                for: .touchUpInside)
        self.successFailureButton = successFailureButton

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
        addSubview(successFailureButton)

        let views:[String : UIView] = [
            "paymentLabel":paymentLabel,
            "paymentButton":paymentButton,
            "cancelButton":cancelButton,
            "successFailureButton":successFailureButton]

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
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[successFailureButton]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[paymentLabel]-80-[successFailureButton(40)]",
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
                        self.makeTransactionRequest(amount: Int(self.paymentCuantity)!)
                        //self.cretaeUser(name: "Caleb")
                    }
                    else {

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

    func cretaeUser(name:String){
        let requestServices:CreateUserMutation = CreateUserMutation(name:"Caleb")

        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.apollo.perform(mutation: requestServices) { (result, error) in
                    print(result!.data?.createUser.id! ?? "")

                }
        }
    }

    func makeTransactionRequest(amount:Int){
        let requestServices:ChangeBalanceMutation = ChangeBalanceMutation(senderID:kCodeSender, reciverID:kCodeReciver, amount:amount)

        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.apollo.perform(mutation: requestServices) { (result, error) in
                    print(result!.data!.changeBalance)
                    let finalResult:Int = (result?.data?.changeBalance)!

                    UIView.animate(withDuration: 0.1,
                                   delay: 0.1,
                                   options: UIViewAnimationOptions.curveEaseIn,
                                   animations: { () -> Void in

                                    if finalResult > 0{
                                        self.successFailureButton.isHidden = false
                                        self.successFailureButton.setTitle("Exito: Tu nuevo saldo es $\(finalResult)", for: .normal)
                                    }
                                    else{
                                        self.successFailureButton.isHidden = false
                                        self.successFailureButton.setTitle("Error: Fondos insuficientes", for: .normal)
                                    }

                                    self.cancelButton.isHidden = true
                                    self.paymentButton.isHidden = true
                                    self.superview?.layoutIfNeeded()

                    }, completion: nil)
                }
        }
    }

    @objc func endTransaction(sender:UIButton){
        controller.parentController.setMainMenu()
    }
}
