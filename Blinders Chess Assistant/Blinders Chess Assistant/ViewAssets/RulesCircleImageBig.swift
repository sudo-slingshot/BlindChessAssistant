//
//  RulesCircleImageBig.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 29/01/2023.
//

import SwiftUI

struct RulesCircleImageBig: View {
    var body: some View {
        Image("RulesIcon").resizable()
            .frame(width: 164.0, height: 164.0).clipShape(Circle()).overlay{Circle().stroke(.white, lineWidth: 4)}.shadow(radius: 4)
    }
}

struct RulesCircleImageBig_Previews: PreviewProvider {
    static var previews: some View {
        RulesCircleImageBig()
    }
}
