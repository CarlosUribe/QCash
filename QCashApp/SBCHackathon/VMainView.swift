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

        let titleLabel:UILabel = UILabel()
        titleLabel.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red:0.22, green:0.22, blue:0.25, alpha:1.0)
        titleLabel.text = "QCash"

        let qrReader:UIButton = UIButton()
        qrReader.clipsToBounds = true
        qrReader.translatesAutoresizingMaskIntoConstraints = false
        qrReader.layer.cornerRadius = kCornerRadius / 2
        qrReader.backgroundColor = UIColor(red:0.32, green:0.56, blue:0.95, alpha:1.0)
        qrReader.setTitle("Pagar", for: .normal)
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
        qrMaker.setTitle("Cobrar", for: .normal)
        qrMaker.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        qrMaker.addTarget(self,
                           action: #selector(qrMaker(sender:)),
                           for: .touchUpInside)
        self.qrMaker = qrMaker

        addSubview(qrReader)
        addSubview(qrMaker)
        addSubview(titleLabel)

        let views:[String : UIView] = [
            "qrReader":qrReader,
            "qrMaker":qrMaker,
            "titleLabel":titleLabel]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[titleLabel]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-45-[titleLabel(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-95-[qrReader]-95-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[titleLabel]-45-[qrReader(120)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-95-[qrMaker]-95-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[qrReader]-40-[qrMaker(120)]",
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
