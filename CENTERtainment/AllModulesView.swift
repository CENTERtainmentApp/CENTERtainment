//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct AllModulesView: View {
    @State var unloadScreen = false
    @State private var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var username:String = "default"
    @State var hasPremium:Bool = false
    let moduleList:[[String]] = [["CTPay","creditcard"], ["CENTERPaint","paintbrush.pointed"]]
    
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
                            .opacity(hasPremium ? 0:1)
                            .background(
                                Image("LogoPremiumTransparent")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 65)
                                    .offset(x: -143)
                                    .opacity(hasPremium ? 1:0)
                            )
                    }
                    VStack {
                        ScrollView {
                            //Modules go here
                            ForEach(moduleList, id: \.self) { module in
                                ModuleListView(name: module[0], icon: module[1], isPremium: hasPremium)
                            }
                        }.frame()
                        HStack {
                            Spacer()
                            HStack {
                                Image(systemName: "arrow.left").foregroundColor(.white).font(.system(size: 30)).padding(.leading, 19)
                                Text("Vissza").font(.system(size: 25, weight: .medium)).foregroundColor(hasPremium ? uiPremiumCENTERcolor : uiCENTERcolor)
                                Spacer()
                            }
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill((hasPremium ? uiPremiumSecondaryColor : uiSecondaryColor).opacity(0.27)).frame(height: 60))
                                .frame(width: 155)
                                .onTapGesture {
                                    unloadScreen = true
                                }
                            Spacer()
                        }.padding(.top,43)
                            .padding(.leading, -7)
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
                if (hasPremium) {
                    MainScreenPremiumView(username: self.username)
                }
                else {
                    MainScreenView(username: self.username)
                }
            }
        }
    }
}

struct ModuleListView:View {
    var name:String
    var icon:String
    var isPremium:Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(isPremium ? uiPremiumCENTERcolor : uiCENTERcolor, style: StrokeStyle.init(lineWidth: 4))
                .frame(width: 70, height: 70)
                .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).fill(isPremium ? uiPremiumCENTERcolor.opacity(0.4) : uiCENTERcolor.opacity(0.4)))
                .overlay(Image(systemName: icon).font(.system(size: 30)).foregroundColor(isPremium ? uiPremiumSecondaryColor : uiSecondaryColor))
                .padding(.trailing)
            Text(name).foregroundColor(isPremium ? uiPremiumCENTERcolor : uiCENTERcolor)
                .font(.system(size: 25, weight: .medium))
            Spacer()
        }.padding()
            .padding(.leading)
            .padding(.bottom, -25)
    }
}

#Preview {
    AllModulesView()
}
