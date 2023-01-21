//
//  HeaderView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Hello Player").font(.title).foregroundColor(.primary)
            HStack{
                Text("This is your chess assistant").foregroundColor(.secondary).font(.subheadline)
                Spacer()
                Text(Date(), style: .date).foregroundColor(.secondary).font(.subheadline)
            }
            Divider()
        }
    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
