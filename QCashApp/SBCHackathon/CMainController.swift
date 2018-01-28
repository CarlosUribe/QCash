//
//  CMainController.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 26/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class CMainController: UIViewController {

    weak var mainView:VMainView!

    override func loadView() {
        let mainView:VMainView = VMainView(controller:self)
        self.mainView = mainView
        view = mainView
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
