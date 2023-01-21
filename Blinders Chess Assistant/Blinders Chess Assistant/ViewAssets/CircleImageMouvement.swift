//
//  CircleImageMouvement.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct CircleImageMouvement: View {
    var body: some View {
        Image("MouvementIcon").resizable()
            .frame(width: 64.0, height: 64.0).clipShape(Circle()).overlay{Circle().stroke(.white, lineWidth: 4)}.shadow(radius: 4)
    }
}

struct CircleImageMouvement_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageMouvement()
    }
}
