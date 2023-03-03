////
////  CustomButton.swift
////  VerifyingTelephoneNumber
////
////  Created by Андрей on 7.10.22.
////
//
//import SwiftUI
//
//struct CustomButton: View {
//    var text: String
//    var foregroundColor: Color
//    var backgroundColor: Color
//    var borderWight: CGFloat
//    var clicked: (() -> Void) /// use closure for callback
//    
//    var body: some View {
//        Button(action: clicked) { /// call the closure here
//            Text(text) /// your text
//                .font(.system(size: 16, weight: .bold, design: .default))
//                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * ConstantsGlobal().buttonHeight,alignment: .center)
//                .foregroundColor(foregroundColor)
//                .background(backgroundColor)
//                .border(.black, width: borderWight)
//                .cornerRadius(3)
//        }
//    }
//}
