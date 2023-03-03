////
////  InfoView.swift
////  VerifyingTelephoneNumber
////
////  Created by Андрей on 10.10.22.
////
//
//import SwiftUI
//
//struct InfoViewWithImage: View {
//    var model: ViewModelProtocols
//    var body: some View {
//        VStack(spacing: 10) {
//            VStack(alignment: .leading, spacing: 10) {
//                Image(systemName: model.imageName)
//                    .resizable()
//                    .frame(width: 40, height: 40, alignment: .leading)
//                    .foregroundColor(model.imageForegroundColor)
//                
//                Text(model.title)
//                    .font(.system(size: 22, weight: .bold, design: .default))
//            }
//            
//            Text(model.subtitle)
//                .font(.system(size: 18, weight: .medium, design: .default))
//                .foregroundColor(.secondary)
//        }
//    }
//}
