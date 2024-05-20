//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct PayForPremiumView: View {
    @State var username:String = "default"
    @State private var unloadScreen:super_Bool = .no
    @State var opacityScreen:CGFloat = 0.0
    @State var opacityScreen2:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var pay:Bool = true
    @State private var procState:Bool = false
    
    var body: some View {
        ZStack {
            if (unloadScreen == .no) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        ZStack {
                            Image("LogoTransparent")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .offset(x: -130, y: 0)
                                .opacity(opacityScreen2)
                                .onReceive(timer, perform: { _ in
                                    if (unloadScreen != .no) {
                                        if (opacityScreen2 > 0)
                                        {
                                            opacityScreen2 -= 0.05
                                        }
                                    }
                                    else if (opacityScreen2 < 0.5) {
                                        opacityScreen2 += 0.05
                                    }
                                })
                                .background(
                                    Image("LogoPremiumTransparent")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 65)
                                        .offset(x: -143, y: 0)
                                        .onReceive(timer, perform: { _ in
                                            if (unloadScreen != .no) {
                                                if (opacityScreen > 0)
                                                {
                                                    opacityScreen -= 0.05
                                                }
                                            }
                                            else if (opacityScreen < 1.0) {
                                                opacityScreen += 0.05
                                            }
                                        })
                                )
                            HStack {
                                Text("Premium vásárlása")
                                    .foregroundColor(uiPremiumCENTERcolor)
                                    .font(.system(size: 30))
                                    .offset(x: 42)
                            }.opacity(opacityScreen)
                            .onReceive(timer, perform: { _ in
                                if (unloadScreen != .no) {
                                    if (opacityScreen > 0)
                                    {
                                        opacityScreen -= 0.05
                                    }
                                }
                                else if (opacityScreen < 1.0) {
                                    opacityScreen += 0.05
                                }
                            })
                        }
                    }
                    if (unloadScreen == .no) {
                        VStack {
                            Spacer()
                            VStack {
                                Text("Válasszon fizetési módot:\n")
                                    .foregroundStyle(uiPremiumSecondaryColor)
                                    .font(.system(size: 30))
                            }.animation(.bouncy)
                            VStack {
                                if (pay) {
                                    HStack {
                                        Image(systemName: "circle.circle.fill").foregroundColor(uiPremiumCENTERcolor).font(.system(size: 33)).padding(.leading, 19)
                                        Text("CTPay kártya    ").font(.system(size: 25, weight: .medium)).foregroundColor(uiPremiumSecondaryColor)
                                    }
                                    Text(" ").font(.system(size: 10))
                                    HStack {
                                        Image(systemName: "circle").foregroundColor(uiPremiumCENTERcolor).font(.system(size: 33)).padding(.leading, 19)
                                        Text("Más online kártya   ").font(.system(size: 25, weight: .medium)).foregroundColor(uiPremiumSecondaryColor)
                                    }.onTapGesture {
                                        pay = false
                                    }
                                }
                                else {
                                    HStack {
                                        Image(systemName: "circle").foregroundColor(uiPremiumCENTERcolor).font(.system(size: 33)).padding(.leading, 19)
                                        Text("CTPay kártya    ").font(.system(size: 25, weight: .medium)).foregroundColor(uiPremiumSecondaryColor)
                                    }.onTapGesture {
                                        pay = true
                                    }
                                    Text(" ").font(.system(size: 10))
                                    HStack {
                                        Image(systemName: "circle.circle.fill").foregroundColor(uiPremiumCENTERcolor).font(.system(size: 33)).padding(.leading, 19)
                                        Text("Más online kártya   ").font(.system(size: 25, weight: .medium)).foregroundColor(uiPremiumSecondaryColor)
                                    }
                                }
                            }
                            VStack {
                                Text(" ").font(.system(size: 30))
                                Button("Előfizetés!") {
                                    //Next scene :3
                                    unloadScreen = .maybe
                                }
                                .padding()
                                .padding(.horizontal, 30)
                                .foregroundStyle(.white)
                                .font(.system(size: 35, weight: .medium, design: .rounded))
                                .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(uiPremiumCENTERcolor.opacity(0.77)).onTapGesture {
                                    unloadScreen = .maybe
                                })
                            }.animation(.bouncy)
                            Spacer()
                        }.opacity(opacityScreen)
                        .onReceive(timer, perform: { _ in
                            if (unloadScreen != .no) {
                                if (opacityScreen > 0)
                                {
                                    opacityScreen -= 0.05
                                }
                            }
                            else if (opacityScreen < 1.0) {
                                opacityScreen += 0.05
                            }
                        })
                    }
                    Spacer()
                }
            }
            else if (unloadScreen == .maybe) {
                if (unloadScreen == .maybe) {
                    LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                        .ignoresSafeArea(.all)
                    VStack {
                        HStack {
                            ZStack {
                                Image("LogoTransparent")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .offset(x: -130, y: 0)
                                    .opacity(0.5)
                                    .background(
                                        Image("LogoPremiumTransparent")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 65, height: 65)
                                            .offset(x: -143, y: 0)
                                    )
                                HStack {
                                    Text("Premium vásárlása")
                                        .foregroundColor(uiPremiumCENTERcolor)
                                        .font(.system(size: 30))
                                        .offset(x: 42)
                                }
                            }
                        }
                        if (unloadScreen == .maybe) {
                            VStack {
                                Spacer()
                                if (!procState) {
                                    VStack {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .tint(uiPremiumCENTERcolor)
                                            .scaleEffect(2.0, anchor: .center)
                                            .padding(.bottom, 2)
                                            .padding(.top, 2)
                                        Text("Fizetés feldolgozása...")
                                            .foregroundColor(uiPremiumCENTERcolor)
                                            .font(.system(size: 34))
                                            .onAppear() {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                                    //Transition to next scene
                                                    procState = true
                                                }
                                            }
                                    }.animation(.bouncy)
                                }
                                else {
                                    VStack {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(uiPremiumCENTERcolor)
                                            .font(.system(size: 68))
                                            .padding(.bottom, 1)
                                        Text("Fizetés sikeres!")
                                            .foregroundColor(uiPremiumCENTERcolor)
                                            .font(.system(size: 34))
                                            .onAppear() {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                                    //Transition to next scene
                                                    unloadScreen = .yes
                                                }
                                            }
                                    }.animation(.bouncy)
                                }
                                Spacer()
                            }.opacity(opacityScreen)
                            .onReceive(timer, perform: { _ in
                                if (unloadScreen != .maybe) {
                                    if (opacityScreen > 0)
                                    {
                                        opacityScreen -= 0.05
                                    }
                                }
                                else if (opacityScreen < 1.0) {
                                    opacityScreen += 0.05
                                }
                            })
                        }
                        Spacer()
                    }
                }
            }
            else {
                MainScreenPremiumView(username: self.username)
            }
        }
    }
}

#Preview {
    PayForPremiumView()
}
