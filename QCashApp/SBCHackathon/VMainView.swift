//
//  VMainView.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 26/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class VMainView: UIView {
    weak var controller:CMainController!
    weak var qrReader:UIButton!
    weak var qrMaker:UIButton!
    private let kCornerRadius:CGFloat = 50

    init(controller:CMainController){
        super.init(frame:.zero)
        self.controller = controller
        clipsToBounds = true
        backgroundColor = .white

        let qrReader:UIButton = UIButton()
        qrReader.clipsToBounds = true
        qrReader.translatesAutoresizingMaskIntoConstraints = false
        qrReader.layer.cornerRadius = kCornerRadius / 2
        qrReader.backgroundColor = UIColor(red:0.32, green:0.56, blue:0.95, alpha:1.0)
        qrReader.setTitle("QR", for: .normal)
        qrReader.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        qrReader.addTarget(self,
                           action: #selector(qrReader(sender:)),
                           for: .touchUpInside)
        self.qrReader = qrReader

        let qrMaker:UIButton = UIButton()
        qrMaker.clipsToBounds = true
        qrMaker.translatesAutoresizingMaskIntoConstraints = false
        qrMaker.layer.cornerRadius = kCornerRadius / 2
        qrMaker.backgroundColor = UIColor(red:0.13, green:0.71, blue:0.12, alpha:1.0)
        qrMaker.setTitle("QR", for: .normal)
        qrMaker.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        qrMaker.addTarget(self,
                           action: #selector(qrMaker(sender:)),
                           for: .touchUpInside)
        self.qrMaker = qrMaker

        addSubview(qrReader)
        addSubview(qrMaker)

        let views:[String : UIView] = [
            "qrReader":qrReader,
            "qrMaker":qrMaker]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(110)-[qrReader(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-140-[qrReader(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(110)-[qrMaker(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[qrReader]-20-[qrMaker(100)]",
            options:[],
            metrics:metrics,
            views:views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func qrReader(sender:UIButton){
        let mainController:CQRController = CQRController()
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        controller.parentController.transitionTo(transition:transition)
    }

    @objc func qrMaker(sender:UIButton){
        let mainController:CQRMakerController = CQRMakerController()
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        controller.parentController.transitionTo(transition:transition)
    }
}
