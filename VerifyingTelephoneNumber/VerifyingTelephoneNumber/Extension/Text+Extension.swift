//
//  Text+Extension.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 15.10.2022.
//

import SwiftUI
extension Text {
    func setRegularGreenStyle() -> some View {
        self
            .font(.system(size: ConstantsGlobal().buttonFondSize, weight: .bold, design: .default))
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.03, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(.green)
            .border(.black, width: 0)
            .cornerRadius(3)
    }
    
    func setRegularWhiteStyle() -> some View {
        self
            .font(.system(size: ConstantsGlobal().buttonFondSize, weight: .bold, design: .default))
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.03, alignment: .center)
            .padding()
            .foregroundColor(.black)
            .background(.white)
            .border(.black, width: 1)
            .cornerRadius(3)
    }
    
    func setTitleStyle() -> some View {
        self.font(.system(size: 22, weight: .bold, design: .default))
            .foregroundColor(.black)
    }
    
    func setSubtitleStyle() -> some View {
        self.font(.system(size: 18, weight: .medium, design: .default))
            .foregroundColor(.secondary)
        
    }
}
