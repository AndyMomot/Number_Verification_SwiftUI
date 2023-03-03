////
////  RootScreenEndpoint.swift
////  VerifyingTelephoneNumber
////
////  Created by Андрей on 10.10.22.
////
//
//import Foundation
//import SwiftUI
//
//struct RootScreenModel: ViewModelProtocols {
//    var imageName: String { return "" }
//    var imageForegroundColor: Color { return .clear }
//    
//    var title: String {
//        switch SessionServiceImpl().state {
//        case .loggedIn:
//            return "Your account is verified!"
//        case .loggedOut:
//            return "Verification failed!"
//        }
//    }
//    var subtitle: String {
//        return "All users must verify their account with a valid mobile number before posting a pet advertisement.  Doing so will help us prevent animal welfare issues and reduce fraudulent behaviors."
//    }
//    
//    var phoneNumber: String { return ""}
//    var subtitlePartTwo: String { return ""}
//    
//    
//}
