//
//  CQRMakerController.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class CQRMakerController: UIViewController {
    weak var qrMakerView:VQRMakerView!

    override func loadView() {
        let qrMakerView:VQRMakerView = VQRMakerView(controller:self)
        self.qrMakerView = qrMakerView
        view = qrMakerView
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
}
