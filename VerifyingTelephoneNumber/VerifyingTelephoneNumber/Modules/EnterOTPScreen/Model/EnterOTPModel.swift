//
//  EnterOTPModel.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 11.10.22.
//

import Foundation
import SwiftUI

class EnterOTPModel: ObservableObject {
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        case 5: return .field6
        case 6: return .field7
        case 7: return .field8
        case 8: return .field9
        default: return .field10
        }
    }
    
    @Published var otpText: String = ""
    @Published var otpFields: [String]
    
    init(repeatingCount: Int) {
        otpFields = Array(repeating: "", count: repeatingCount)
    }
}

extension EnterOTPModel {
    func showWarningLabel(numberOfAttempt: Int) -> some View {
        VStack {
            switch numberOfAttempt {
            case 2 ..< ConstantsGlobal().numberOfAttempt - 1:
                Text("Please enter a valid code!")
                    .foregroundColor(.red)
            case 1:
                Text("You have 1 more attempt before your account is blocked")
                     .foregroundColor(.red)
            default: EmptyView()
            }
        }
    }
    
    func showProgressView(loadingProcess: Bool) -> some View {
        VStack {
            if loadingProcess {
                ProgressView()
            } else {
                EmptyView()
            }
        }
    }
}

enum NumberOfSections {
    case one, two, three, fore, five, six, seven, eight, nine, ten
    
    var number: Int {
        let number: Int
        switch self {
        case .one:      number = 1
        case .two:      number = 2
        case .three:    number = 3
        case .fore:     number = 4
        case .five:     number = 5
        case .six:      number = 6
        case .seven:    number = 7
        case .eight:    number = 8
        case .nine:     number = 9
        case .ten:      number = 10
        }
        return number
    }
}

enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
    case field7
    case field8
    case field9
    case field10
}
