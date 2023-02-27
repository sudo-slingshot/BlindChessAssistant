//
//  HorseImage.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 27/02/2023.
//

import SwiftUI

struct HorseImage: View {
    var body: some View {
        Image("HorseLogo").resizable().frame(width: 100, height: 100)
    }
}

struct HorseImage_Previews: PreviewProvider {
    static var previews: some View {
        HorseImage()
    }
}
