//
//  GradientView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct GradientView: View {
    
    @State private var animateGradient = false
    @State private var progress: CGFloat = 0
    let gradient1 = Gradient(colors: [.black, .black])
    let gradient2 = Gradient(colors: [.blue, .orange])
    
    var body: some View {
        ZStack{
            Rectangle().animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 1.0)) {
                        self.progress = 1.0
                    }
                }
        }
    }
}
struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
