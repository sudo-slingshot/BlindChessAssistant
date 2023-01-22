//
//  GradientView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct GradientView: View {
    let gradient=LinearGradient(colors: [Color.white, Color.blue, Color.orange], startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack{
            gradient.opacity(0.4).ignoresSafeArea(.all)
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
