//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var unloadScreen = false
    @State private var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var username:String = "default"
    
    var body: some View {
        ZStack {
            if (!unloadScreen) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Image("LogoTransparent")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .offset(x: -143, y: 0)
                    }
                    VStack {
                        
                    }.opacity(opacityScreen)
                        .onReceive(timer, perform: { _ in
                            if (unloadScreen) {
                                if (opacityScreen > 0)
                                {
                                    opacityScreen -= 0.05
                                }
                            }
                            else if (opacityScreen < 1.0) {
                                opacityScreen += 0.05
                            }
                        })
                    Spacer()
                }
            }
            else {
                //Go back to main screen
            }
        }
    }
}

#Preview {
    SettingsView()
}
