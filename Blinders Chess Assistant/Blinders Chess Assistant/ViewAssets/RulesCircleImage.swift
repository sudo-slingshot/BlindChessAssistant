//
//  RulesCircleImage.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct RulesCircleImage: View {
    var body: some View {
        Image("RulesIcon").resizable()
            .frame(width: 64.0, height: 64.0).clipShape(Circle()).overlay{Circle().stroke(.white, lineWidth: 4)}.shadow(radius: 4)
    }
}

struct RulesCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        RulesCircleImage()
    }
}
