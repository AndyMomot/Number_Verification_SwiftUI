////
////  CustomButtonWithLink.swift
////  VerifyingTelephoneNumber
////
////  Created by Андрей on 7.10.22.
////
//
//import SwiftUI
//
//struct CustomButtonWithLink<T: View>: View {
//    var destination: T
//    var labelText: String
//    var foregroundColor: Color
//    var backgroundColor: Color
//    var borderWight: CGFloat
//    
//    init(destination: T, labelText: String, foregroundColor: Color, backgroundColor: Color, borderWight: CGFloat) {
//        self.destination = destination
//        self.labelText = labelText
//        self.foregroundColor = foregroundColor
//        self.backgroundColor = backgroundColor
//        self.borderWight = borderWight
//    }
//    
//    var body: some View {
//        NavigationLink(destination: destination, label: {
//            Text(labelText) /// your text
//                .font(.system(size: ConstantsGlobal().buttonFondSize, weight: .bold, design: .default))
//                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * ConstantsGlobal().buttonHeight, alignment: .center)
//                .foregroundColor(foregroundColor)
//                .background(backgroundColor)
//                .border(.black, width: borderWight)
//                .cornerRadius(3)
//        })
//    }
//}
