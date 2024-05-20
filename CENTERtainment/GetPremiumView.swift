//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct GetPremiumView: View {
    @State var username:String = "default"
    @State private var unloadScreen:super_Bool = .no
    @State var opacityScreen:CGFloat = 0.0
    @State var opacityScreen2:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var code:String = ""
    
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
                                .offset(x: -143, y: 0)
                                .background(
                                    Image("LogoPremiumTransparent")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 65)
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
                                Text("Amint megvásárlja Premium szolgáltatásunkat, rögtön hozzáférést kap ezekhez:\n\n - Gyors felhő tárhely\n - AI szolgáltatásaink\n - Gyors, biztonságos VPN\n - Megbízható vírusírtó szoftver\n - És még sok más\n")
                                    .foregroundStyle(uiPremiumSecondaryColor)
                                    .font(.system(size: 25))
                            }.animation(.bouncy)
                            VStack {
                                if (code != "TAVASZIAKCIOK") {
                                    Text("Csak 10 000 Ft/Hónap\n")
                                        .foregroundStyle(uiPremiumSecondaryColor)
                                        .font(.system(size: 35))
                                }
                                else {
                                    Text("Első hónap 8 000 Ft,")
                                        .foregroundStyle(uiPremiumSecondaryColor)
                                        .font(.system(size: 35))
                                    Text("utánna 10 000 Ft/Hónap")
                                        .foregroundStyle(uiPremiumSecondaryColor)
                                        .font(.system(size: 35))
                                    Text("20% kedvezmény az első hónapra\n")
                                        .foregroundStyle(uiPremiumSecondaryColor)
                                        .font(.system(size: 23))
                                }
                            }
                            VStack {
                                Button("Előfizetés") {
                                    //Next scene :3
                                    unloadScreen = .yes
                                }
                                .padding()
                                .padding(.horizontal, 30)
                                .foregroundStyle(.white)
                                .font(.system(size: 35, weight: .medium, design: .rounded))
                                .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(uiPremiumCENTERcolor.opacity(0.77)).onTapGesture {
                                    unloadScreen = .yes
                                })
                                TextField("", text: $code, prompt: Text("Kuponkód").foregroundColor(textBoxColor))
                                    .foregroundColor(uiSecondaryColor)
                                    .italic()
                                    .lineLimit(1)
                                    .border(width: 4.0, edges: [.bottom], color: uiPremiumCENTERcolor)
                                //.scaleEffect(1.6, anchor: .leading)
                                    .font(.system(size: 33))
                                    .padding()
                                    .autocorrectionDisabled()
                                    .autocapitalization(.none)
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
            else {
                PayForPremiumView(username: self.username)
            }
        }
    }
}

#Preview {
    GetPremiumView()
}
