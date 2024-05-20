//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    @State var username:String = "default"
    @State var register:Bool = false
    @State private var uiLogoOffset:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var currentTimer:CGFloat = 0.0
    @State var opacityScreen:CGFloat = 0.0
    @State private var timer2 = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var removedFromScreen:Bool = false
    @State private var unloadScreen:Bool = false
    @State private var appTransition:Bool = true
    
    var body: some View {
        ZStack {
            if (!unloadScreen)
            {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .offset(x: 0, y: uiLogoOffset)
                        .animation(.easeOut(duration: 1))
                        .onReceive(timer, perform: { _ in
                            if (uiLogoOffset != uiLogoAppOffset) {uiLogoOffset = uiLogoAppOffset;appTransition = false}
                        })
                    Spacer()
                    VStack {
                        /*Text("Hello, World! (this'll be the loading screen btw)")
                        Text("Current username: \(username)")
                        Text("From register page (richtig oder falsch): \(register ? "RICHTIG" : "FALSCH")")*/
                        if (!appTransition)
                        {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                                .scaleEffect(2.0, anchor: .center)
                                .onReceive(timer, perform: { _ in
                                    currentTimer += 0.5
                                })
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                                        //Transition to next scene
                                        removedFromScreen = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 11.5) {
                                        //Transition to next scene
                                        unloadScreen = true
                                    }
                                }
                            Text(" ").font(.system(size: 20))
                            if (currentTimer <= 2.5)
                            {
                                Text("Csatlakozás...")
                                    .font(.system(size: 30))
                            }
                            else if (currentTimer <= 4.5) {
                                if (register) {
                                    Text("Regisztrálás...")
                                        .font(.system(size: 30))
                                }
                                else {
                                    Text("Csatlakozás...")
                                        .font(.system(size: 30))
                                }
                            }
                            else if (currentTimer <= 7.5) {
                                Text("Bejelentkezés...")
                                    .font(.system(size: 30))
                            }
                            else if (currentTimer <= 11) {
                                Text("Betöltés...")
                                    .font(.system(size: 30))
                            }
                            else {
                                Text(" ")
                                    .font(.system(size: 30))
                            }
                        }
                    }.foregroundColor(uiSecondaryColor)
                        .opacity(opacityScreen)
                        .onReceive(timer2, perform: { _ in
                            if (removedFromScreen) {
                                if (opacityScreen > 0)
                                {
                                    opacityScreen -= 0.05
                                }
                            }
                            else if (opacityScreen < 1.0 && !appTransition) {
                                opacityScreen += 0.05
                            }
                        })
                    Spacer()
                }
            }
            else {
                TransitionView1(username: self.username)
            }
        }
    }
}

#Preview {
    LoadingView()
}
