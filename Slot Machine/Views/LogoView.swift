//
//  LogoView.swift
//  Slot Machine
//
//  Created by Melih Cesur on 24.09.2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256,idealWidth: 300,maxWidth: 320,minHeight: 112,idealHeight: 130,maxHeight: 140,alignment: .center)
            .padding(.horizontal)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
