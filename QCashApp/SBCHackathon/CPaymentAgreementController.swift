//
//  CPaymentAgreementController.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class CPaymentAgreementController: UIViewController {
    weak var viewPaymentAgreement:UIView!
    var paymentCode:String = ""

    convenience init(paymentCode:String){
        self.init()
        self.paymentCode = paymentCode
    }
    override func loadView() {
        let viewPaymentAgreement:VPaymentAgreementView = VPaymentAgreementView(controller:self, data:paymentCode)
        self.viewPaymentAgreement = viewPaymentAgreement
        view = viewPaymentAgreement
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    func showSuccessAndExit(){

    }

    func showFailureAndExit(){
        
    }
}
