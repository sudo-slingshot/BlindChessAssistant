//
//  ChessBack.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct ChessBack: View {
    var body: some View {
        Image("ChessBackground").resizable().frame(width: 414, height: 232)
    }
}

struct ChessBack_Previews: PreviewProvider {
    static var previews: some View {
        ChessBack()
    }
}
