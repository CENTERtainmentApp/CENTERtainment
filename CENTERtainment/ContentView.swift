//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var appTransition:Bool = false
    @State var uiLogoOffset:CGFloat = 0;
    @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State var appOpenTime:Double = 0
    @State var navigate = false
    
    var body: some View {
        ZStack {
            if (!navigate)
            {
            LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .offset(x: 0, y: 0 - uiLogoOffset)
                        .animation(.easeOut(duration: 1))
                        .onReceive(timer, perform: { _ in
                            if (appOpenTime < appOpenDelayTime) {
                                appOpenTime += 0.05
                            }
                            else if (uiLogoOffset < uiLogoAppOffset) {
                                if (!appTransition) { appTransition = true }
                                //uiLogoOffset += 15
                                uiLogoOffset = uiLogoAppOffset
                            }
                        })
                    //NavigationLink("LoginView", destination: LoginView(), isActive: $navigate)
                    Spacer()
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + appOpenDelayTime + 1) {
                                //Transition to next scene
                                self.timer.upstream.connect().cancel()
                                navigate = true
                            }
                        }
                    if (!appTransition)
                    {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaleEffect(2.0, anchor: .center)
                    }
                    Spacer()
                }
            }
            if (navigate) { LoginView() }
        }
    }
}

#Preview {
    ContentView()
}
