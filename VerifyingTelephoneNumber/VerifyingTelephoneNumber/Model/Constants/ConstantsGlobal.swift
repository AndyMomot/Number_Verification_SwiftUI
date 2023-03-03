//
//  Constants.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 7.10.22.
//

import Foundation
import SwiftUI

struct ConstantsGlobal {
    var buttonHeight: CGFloat = 0.07
    var buttonFondSize: CGFloat = 16
    var numberOfAttempt: Int = 5 // How many times user can enter sms code before blocked
    var numberOfOTPFields: Int = 6
}

extension ConstantsGlobal {
    // Web pages
    var userPage: String { return "https://www.youtube.com" }
    var helpWebPage: String { return "https://youtu.be/2Q_ZzBGPdqE" }
    var defaultWebPage: String {return "https://www.google.com" }
}
