//
//  StaticGradientView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 26/02/2023.
//

import SwiftUI

struct StaticGradientView: View {
    var body: some View {
        LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
    }
}

struct StaticGradientView_Previews: PreviewProvider {
    static var previews: some View {
        StaticGradientView()
    }
}
