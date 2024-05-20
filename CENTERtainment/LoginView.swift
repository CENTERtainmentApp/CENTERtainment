//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var username:String = ""
    @State var password:String = ""
    @State private var autoLogin = false
    @State private var showPasswordToggle = false
    @State var actionState:super_Bool = .no //No: this view, Maybe: Register view, Yes: Loading View
    @State var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var removedFromScreen:Bool = false
    
    var body: some View {
        ZStack {
            if (actionState == .no)
            {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    VStack {
                        Text("Bejelentkezés")
                            .font(.system(size: 52, weight: .medium, design: .rounded))
                            .foregroundColor(uiCENTERcolor)
                        Spacer()
                        TextField("", text: $username, prompt: Text("Felhasználónév").foregroundColor(textBoxColor))
                            .foregroundColor(uiSecondaryColor)
                            .italic()
                            .lineLimit(1)
                            .border(width: 4.0, edges: [.bottom], color: uiCENTERcolor)
                        //.scaleEffect(1.6, anchor: .leading)
                            .font(.system(size: 28))
                            .padding()
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        Text(" ").font(.system(size: 10))
                        if (!showPasswordToggle)
                        {
                            SecureField("", text: $password, prompt: Text("Jelszó").foregroundColor(textBoxColor))
                                .foregroundColor(uiSecondaryColor)
                                .italic()
                                .lineLimit(1)
                                .border(width: 4.0, edges: [.bottom], color: uiCENTERcolor)
                            //.scaleEffect(1.6, anchor: .leading)
                                .font(.system(size: 28))
                                .padding()
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                        }
                        else {
                            TextField("", text: $password, prompt: Text("Jelszó").foregroundColor(textBoxColor))
                                .foregroundColor(uiSecondaryColor)
                                .italic()
                                .lineLimit(1)
                                .border(width: 4.0, edges: [.bottom], color: uiCENTERcolor)
                            //.scaleEffect(1.6, anchor: .leading)
                                .font(.system(size: 28))
                                .padding()
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                        }
                        Text(" ").font(.system(size: 20))
                        Toggle(isOn: $autoLogin) {
                            Text("Maradjon bejelentkezve")
                        }
                        .toggleStyle(.switch)
                        .font(.system(size: 20))
                        .foregroundColor(uiSecondaryColor)
                        .padding(.horizontal, 50)
                        Text(" ").font(.system(size: 5))
                        Toggle(isOn: $showPasswordToggle) {
                            Text("Jelszó megjelenítése")
                        }
                        .toggleStyle(.switch)
                        .font(.system(size: 20))
                        .foregroundColor(uiSecondaryColor)
                        .padding(.horizontal, 50)
                        Text(" ").font(.system(size: 20))
                        if (username != "" && password != "") {
                            Button("Tovább") {
                                //Next scene :3
                                removedFromScreen = true
                                actionState = .yes
                            }
                            .padding()
                            .padding(.horizontal, 30)
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(uiCENTERcolor).onTapGesture {
                                removedFromScreen = true
                                actionState = .yes
                            })
                        }
                        else {
                            Button("Tovább") {
                                //Nothing
                            }
                            .disabled(true)
                            .padding()
                            .padding(.horizontal, 30)
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.gray))
                        }
                        Spacer()
                        Button("Nincs még fiókom, regisztrálnék") {
                            //Register scene
                            removedFromScreen = true
                            actionState = .maybe
                        }
                        .font(.system(size: 20))
                        .foregroundStyle(uiSecondaryColor)
                    }
                    .opacity(opacityScreen)
                    .onReceive(timer, perform: { _ in
                        if (removedFromScreen) {
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
            else if (actionState == .maybe) {
                RegisterView()
            }
            else if (actionState == .yes) {
                LoadingView(username: self.username)
            }
        }
    }
}

#Preview {
    LoginView()
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder:Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
