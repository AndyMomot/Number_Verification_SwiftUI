//
//  Image+Extension.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 15.10.2022.
//

import SwiftUI

extension Image {
    func setImageStyle(foregroundColor: Color) -> some View {
        self
            .resizable()
            .frame(width: 40, height: 40, alignment: .leading)
            .foregroundColor(foregroundColor)
    }
}
