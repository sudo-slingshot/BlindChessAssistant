//
//  GradientView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct GradientView: View {
    let gradient=RadialGradient(gradient: Gradient(colors: [.green,.blue]), center: .center, startRadius: 10, endRadius: 500)
    var body: some View {
        ZStack{
            gradient.opacity(0.6).ignoresSafeArea(.all)
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
