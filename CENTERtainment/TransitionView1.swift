//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct TransitionView1: View {
    @State var username:String = "default"
    @State private var unloadScreen = false;
    @State private var uiLogoOffsetX:CGFloat = 0
    @State private var uiLogoOffsetY:CGFloat = -93
    @State private var uiLogoFrame:CGFloat = 200
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var time:CGFloat = 0
    
    var body: some View {
        ZStack {
            if (!unloadScreen) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: uiLogoFrame, height: uiLogoFrame)
                        .offset(x: uiLogoOffsetX, y: uiLogoOffsetY)
                        .animation(.easeOut(duration: 1))
                        .onReceive(timer, perform: { _ in
                            time+=0.5
                            if (time < 1.0) {
                                uiLogoOffsetY = -340
                                uiLogoOffsetX = -145
                                uiLogoFrame = 80
                            }
                            else if (time > 2.0) {
                                unloadScreen = true
                            }
                        })
                    Spacer()
                }
            }
            else {
                MainScreenView(username: self.username)
            }
        }
    }
}

#Preview {
    TransitionView1()
}
