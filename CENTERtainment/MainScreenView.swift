//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct MainScreenView: View {
    @State var username:String = "default"
    @State private var unloadScreen:megabool = .falsch
    @State private var time:String = Date().ISO8601Format(.iso8601(timeZone: .autoupdatingCurrent, includingFractionalSeconds: false, dateSeparator: .dash, dateTimeSeparator: .space)).replacingOccurrences(of: "-", with: ".")
    @State private var timeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var thinked:Bool = false
    
    var body: some View {
        ZStack {
            if (unloadScreen == .falsch) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Image("LogoTransparent")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .offset(x: -108, y: 0)
                        Circle()
                            .stroke(/*Color(red: 1, green: 0, blue: 0)*/Color(red: 33 / 255, green: 103 / 255, blue: 17 / 255, opacity: 1), lineWidth: 3)
                            .background(Circle().fill(Color(red: 0.8, green: 0.4, blue: 0.4)))
                            .frame(width: 65, height: 80)
                            .overlay(
                                Text(":3").font(.system(size: 35, weight: .medium)).foregroundColor(uiSecondaryColor)
                                    .overlay(
                                        Image("DefaultPfp")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 63, height: 63)
                                    )
                            )
                            .offset(x: 105)
                            .opacity(opacityScreen)
                            .onReceive(timer, perform: { _ in
                                if (unloadScreen != .falsch) {
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
                    VStack {
                        HStack {
                            Text("")
                            Text("Helló, \(username)!")
                                .foregroundColor(uiCENTERcolor)
                                .font(.system(size: 30))
                                .padding([.top, .horizontal])
                            Spacer()
                        }
                        HStack {
                            Text("")
                            Text("\(Image(systemName: "calendar.badge.clock")) \(time)")
                                .foregroundColor(uiSecondaryColor)
                                .font(.system(size: 25))
                                .padding(.horizontal)
                                .onReceive(timeTimer, perform: { _ in
                                    time = Date().ISO8601Format(.iso8601(timeZone: .autoupdatingCurrent, includingFractionalSeconds: false, dateSeparator: .dash, dateTimeSeparator: .space)).replacingOccurrences(of: "-", with: ".")
                                })
                            Spacer()
                        }
                        HStack {
                            Text("")
                            Text("\(Image(systemName: "cloud.sun.fill").renderingMode(.original)) 23°")
                                .foregroundColor(uiSecondaryColor)
                                .font(.system(size: 25))
                                .padding(.horizontal)
                            Spacer()
                        }
                        VStack {
                            if (thinked) {
                                VStack {
                                    HStack {
                                        Image(systemName: "lightbulb").foregroundColor(.yellow).font(.system(size: 30)).padding(.leading, 19)
                                        VStack{
                                            HStack {
                                                Text("Javaslat").font(.system(size: 25, weight: .medium)).foregroundColor(uiCENTERcolor)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("A jelenlegi helyzete alapján").font(.system(size: 15, weight: .medium)).foregroundColor(uiCENTERcolor)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                    }.padding(.top, 5)
                                    HStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(uiCENTERcolor, style: StrokeStyle.init(lineWidth: 4))
                                            .frame(width: 75, height: 75)
                                            .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)).fill(uiCENTERcolor.opacity(0.4)))
                                            .overlay(Image(systemName: "creditcard").font(.system(size: 37)).foregroundColor(uiSecondaryColor))
                                            //.overlay(Button(" ") {unloadScreen = .maybe;}.frame(width: 75, height: 75).contentShape(Rectangle()))
                                            .padding(.leading, 19)
                                            .onTapGesture {
                                                unloadScreen = .maybe
                                            }
                                        VStack {
                                            HStack {
                                                Text("Fizetés")
                                                    .font(.system(size: 22, weight: .medium))
                                                    .foregroundColor(uiSecondaryColor)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Használja az eszközt úgy, mint egy bankkártyát")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(uiSecondaryColor)
                                                Spacer()
                                            }
                                        }.padding(10)
                                        Spacer()
                                    }
                                }.animation(.easeOut)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .circular)
                                            .fill(uiCENTERcolor.opacity(0.2))
                                            .padding(.horizontal, 10)
                                            .padding(.bottom, -15)
                                            .padding(.top, -7)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                                    .stroke(uiCENTERcolor, style: StrokeStyle.init(lineWidth: 3.5))
                                                    .padding(.horizontal, 10)
                                                    .padding(.bottom, -15)
                                                    .padding(.top, -7)
                                            )
                                    )
                            }
                            else {
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(.white)
                                        .scaleEffect(1.7, anchor: .center)
                                        .onAppear() {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                                //AI marketing bullshit finished
                                                thinked = true
                                            }
                                        }
                                        .padding(.leading, 26)
                                    Text("Az AI gondolkodik...")
                                        .font(.system(size: 25, weight: .medium))
                                        .foregroundColor(uiCENTERcolor)
                                        .padding(.horizontal, 14)
                                    Spacer()
                                }
                            }
                            VStack {
                                HStack {
                                    Image(systemName: "pin").foregroundColor(.white).font(.system(size: 25)).padding(.leading, 19)
                                    Text("Rögzített").font(.system(size: 20, weight: .medium)).foregroundColor(uiCENTERcolor)
                                    Spacer()
                                    Image(systemName: "arrow.forward").foregroundColor(uiCENTERcolor).font(.system(size: 25)).padding(.trailing, 19)
                                }.padding(.top, thinked ? 15 : 1)
                                HStack {
                                    //Option BN {}
                                    //Option FG []
                                    ModuleIcon(icon: "creditcard", name: "CTPay").padding(.leading, 15)
                                    ModuleIcon(icon: "rectangle.and.pencil.and.ellipsis", name: "Jelszavak")
                                    ModuleIcon(icon: "paintbrush.pointed", name: "CTDraw")
                                    ModuleIcon(icon: "camera.aperture", name: "CTSocial")
                                    Image(systemName: "arrow.forward.circle.fill").foregroundColor(uiCENTERcolor).font(.system(size: 25)).offset(x: -8, y: -9)
                                    Spacer()
                                }
                                HStack {
                                    Image(systemName: "clock").foregroundColor(.white).font(.system(size: 25)).padding(.leading, 19)
                                    Text("Legutóbb használtak").font(.system(size: 20, weight: .medium)).foregroundColor(uiCENTERcolor)
                                    Spacer()
                                    Image(systemName: "arrow.forward").foregroundColor(uiCENTERcolor).font(.system(size: 25)).padding(.trailing, 19)
                                }.padding(.top, 5)
                                HStack {
                                    //Option BN {}
                                    //Option FG []
                                    ModuleIcon(icon: "bubble.left.and.bubble.right", name: "Üzenetek").padding(.leading, 15)
                                    ModuleIcon(icon: "camera.shutter.button", name: "Kamera")
                                    ModuleIcon(icon: "music.note.list", name: "Zene")
                                    ModuleIcon(icon: "rectangle.and.pencil.and.ellipsis", name: "Jelszavak")
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    HStack {
                                        Image(systemName: "list.bullet").foregroundColor(.white).font(.system(size: 30)).padding(.leading, 19)
                                        Text("Összes mutatása").font(.system(size: 25, weight: .medium)).foregroundColor(uiCENTERcolor)
                                        Spacer()
                                    }
                                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(uiSecondaryColor.opacity(0.27)).frame(height: 60))
                                        .frame(width: 281)
                                        .onTapGesture {
                                            unloadScreen = .perhaps
                                        }
                                    Spacer()
                                }.padding(.top,43)
                                    .padding(.leading, -7)
                            }.animation(.bouncy)
                            Spacer()
                        }.opacity(opacityScreen)
                            .onReceive(timer, perform: { _ in
                                if (unloadScreen != .falsch) {
                                    if (opacityScreen > 0)
                                    {
                                        opacityScreen -= 0.05
                                    }
                                }
                                else if (opacityScreen < 1.0) {
                                    opacityScreen += 0.02
                                }
                            })
                    }
                }
            }
            else if (unloadScreen == .maybe){
                //CardPaymentView(username: self.username)
                //Temporary replacement to test
                GetPremiumView(username: self.username)
            }
            else if (unloadScreen == .perhaps) {
                //All modules
                AllModulesView(username: self.username, hasPremium: false)
            }
            else if (unloadScreen == .mayhaps) {
                //Settings
            }
        }
    }
}

struct ModuleIcon:View {
    var icon:String
    var name:String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(uiCENTERcolor, style: StrokeStyle.init(lineWidth: 4))
                .frame(width: 60, height: 60)
                .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).fill(uiCENTERcolor.opacity(0.4)))
                .overlay(Image(systemName: icon).font(.system(size: 30)).foregroundColor(uiSecondaryColor))
            HStack {
                Spacer()
                Text(name).foregroundColor(uiSecondaryColor)
                    .font(.system(size: 14))
                Spacer()
            }
        }.frame(width: 80)
    }
}

#Preview {
    MainScreenView()
}
