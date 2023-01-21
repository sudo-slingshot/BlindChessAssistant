//
//  CircleRobotImage.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct CircleRobotImage: View {
    var body: some View {
        Image("Robot").resizable()
            .frame(width: 164.0, height: 164.0).clipShape(Circle()).overlay{Circle().stroke(.white, lineWidth: 4)}.shadow(radius: 4)
    }
}

struct CircleRobotImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleRobotImage()
    }
}
