//
//  CMain.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class CMain: UIViewController {
    let interaction:CMainControllerInteraction
    var transition:CMainControllerTransition?
    private var statusBarStyle:UIStatusBarStyle

    init(){
        interaction = CMainControllerInteraction()
        statusBarStyle = UIStatusBarStyle.lightContent

        super.init(nibName:nil, bundle:nil)

        let mainController:CMainController = CMainController()
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        transitionTo(transition:transition)
    }

    required init?(coder:NSCoder){
        fatalError()
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return statusBarStyle
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    //MARK: public

    func transitionTo(transition:CMainControllerTransition){
        UIApplication.shared.keyWindow?.endEditing(true)
        transition.startTransition(main:self)
    }

    func pop(){
        UIApplication.shared.keyWindow?.endEditing(true)
        transition?.pop()
    }

    func statusBarLight(){
        statusBarStyle = UIStatusBarStyle.lightContent
        setNeedsStatusBarAppearanceUpdate()
    }

    func statusBarDefault(){
        statusBarStyle = UIStatusBarStyle.default
        setNeedsStatusBarAppearanceUpdate()
    }

    func gotPrice(code:String){
        pop()
        
        let mainController:CPaymentAgreementController = CPaymentAgreementController(paymentCode:code)
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        transitionTo(transition:transition)
    }

    func setMainMenu(){
        pop()
        
        let mainController:CMainController = CMainController()
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        transitionTo(transition:transition)
    }
}

