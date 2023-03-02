//
//  ConnectedView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 02/03/2023.
//

import SwiftUI

struct ConnectedView: View {
    var body: some View {
        ZStack{
            StaticGradientView()
            VStack{
                HorseImage()
                Text("Votre plateau est connecté!").font(.title)
            }.frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ConnectedView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedView()
    }
}
