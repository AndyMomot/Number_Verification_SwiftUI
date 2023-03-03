////
////  CustomButtonWithLink.swift
////  VerifyingTelephoneNumber
////
////  Created by Андрей on 7.10.22.
////
//
//import SwiftUI
//
//struct CustomButtonText: View {
//    var labelText: String
//    var foregroundColor: Color
//    var backgroundColor: Color
//    var borderWight: CGFloat
//    
//    
//    init(labelText: String, foregroundColor: Color, backgroundColor: Color, borderWight: CGFloat) {
//        self.labelText = labelText
//        self.foregroundColor = foregroundColor
//        self.backgroundColor = backgroundColor
//        self.borderWight = borderWight
//    }
//    
//    var body: some View {
//        Text(labelText) /// your text
//            .font(.system(size: ConstantsGlobal().buttonFondSize, weight: .bold, design: .default))
//            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * ConstantsGlobal().buttonHeight, alignment: .center)
//            .foregroundColor(foregroundColor)
//            .background(backgroundColor)
//            .border(.black, width: borderWight)
//            .cornerRadius(3)
//    }
//}
