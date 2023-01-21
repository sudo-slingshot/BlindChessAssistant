//
//  CirclePlacementImageBig.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct CirclePlacementImageBig: View {
    var body: some View {
        Image("PlacementIcon").resizable()
            .frame(width: 164.0, height: 164.0).clipShape(Circle()).overlay{Circle().stroke(.white, lineWidth: 4)}.shadow(radius: 4)
    }
}


struct CirclePlacementImageBig_Previews: PreviewProvider {
    static var previews: some View {
        CirclePlacementImageBig()
    }
}
