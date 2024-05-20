//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct CardPaymentView: View {
    @State var unloadScreen = false
    @State private var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var procState:super_Bool = .no //no: touch, maybe: process, yes: accepted
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
                        ZStack {
                            Image("CardTemplate")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 430)
                            Text("0123 4567 8910 1112").font(.system(size: 30)).offset(y: 33).foregroundColor(.black)
                            Text("EXP: 01/70").font(.system(size: 25)).offset(x: -85, y: 60).foregroundColor(.black)
                            Text("Hát Izsák").font(.system(size: 22, weight: .medium)).offset(x: -99, y: 86).foregroundColor(.black)
                            Image("LogoTransparent").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 56)
                                .offset(x: -140, y: -75)
                                .foregroundColor(.black)
                            Text("CENTERcard")
                                .font(.system(size: 30, weight: .medium))
                                .offset(x: -24, y: -75)
                                .foregroundColor(uiCENTERcolor)
                                .foregroundColor(.black)
                            Image(systemName: "wave.3.right")
                                .font(.system(size: 45))
                                .offset(x: 140, y: -68)
                                .foregroundColor(.black)
                        }
                        VStack {
                            if (procState == .no) {
                                VStack {
                                    Image(systemName: "iphone.radiowaves.left.and.right.circle")
                                        .foregroundColor(uiCENTERcolor)
                                        .font(.system(size: 68))
                                        .padding(.bottom, 1)
                                    Text("Tartsa a telefont a\n fizetőterminálhoz")
                                        .foregroundColor(uiCENTERcolor)
                                        .font(.system(size: 34))
                                        .onAppear() {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                                //Transition to next scene
                                                procState = .maybe
                                            }
                                        }
                                }.animation(.bouncy)
                            }
                            else if (procState == .maybe) {
                                VStack {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(uiCENTERcolor)
                                        .scaleEffect(2.0, anchor: .center)
                                        .padding(.bottom, 2)
                                        .padding(.top, 2)
                                    Text("Fizetés feldolgozása...")
                                        .foregroundColor(uiCENTERcolor)
                                        .font(.system(size: 34))
                                        .onAppear() {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                //Transition to next scene
                                                procState = .yes
                                            }
                                        }
                                }.animation(.bouncy)
                            }
                            else {
                                VStack {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(uiCENTERcolor)
                                        .font(.system(size: 68))
                                        .padding(.bottom, 1)
                                    Text("Fizetés sikeres!")
                                        .foregroundColor(uiCENTERcolor)
                                        .font(.system(size: 34))
                                    Button("Újra") {
                                        //Next scene :3
                                        procState = .no
                                    }
                                    .padding()
                                    .padding(.horizontal, 30)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(uiCENTERcolor).onTapGesture {
                                        procState = .no
                                    })
                                }.animation(.bouncy)
                            }
                            Button("Vissza") {
                                //Next scene :3
                                unloadScreen = true
                            }
                            .padding()
                            .padding(.horizontal, 30)
                            .foregroundStyle(.black)
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(uiSecondaryColor).onTapGesture {
                                unloadScreen = true
                            })
                            .animation(.bouncy)
                        }.offset(y: -30)
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
                MainScreenView(username: self.username)
            }
        }
    }
}

#Preview {
    CardPaymentView()
}
