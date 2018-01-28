//
//  UIVIewControllerExtension.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

extension UIViewController{
    var parentController:CMain{
        get{
            return self.parent as! CMain
        }
    }
}
