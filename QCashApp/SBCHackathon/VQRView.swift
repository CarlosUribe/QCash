//
//  VQRView.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class VQRView: UIView {
    weak var controller:CQRController!
    weak var topbar:UIView!

    init(controller: CQRController) {
        super.init(frame: .zero)
        self.controller = controller

        let topBar:UIView = UIView()
        topBar.clipsToBounds = true
        topBar.translatesAutoresizingMaskIntoConstraints = false
        self.topbar = topBar

        addSubview(topBar)

        let views:[String : UIView] = [
            "topBar":topBar]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[topBar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[topBar(64)]",
            options:[],
            metrics:metrics,
            views:views))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
