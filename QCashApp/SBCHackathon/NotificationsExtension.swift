//
//  NotificationsExtension.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import Foundation

extension Notification{
    enum Notifications:String{
        case paymentAgreemtent = "paymentAgreement"

        var value:Notification.Name{
            return Notification.Name(rawValue:self.rawValue)
        }
    }
}
