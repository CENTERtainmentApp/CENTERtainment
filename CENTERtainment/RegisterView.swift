//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State var username:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var againPwd:String = ""
    @State private var showPasswordToggle = false
    @State var actionState:super_Bool = .no //No: this view, Maybe: Login view, Yes: Registering View
    @State var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var removedFromScreen:Bool = false
    
    var body: some View {
        ZStack {
            if (actionState == .no) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    VStack {
                        Text("Regisztráció")
                            .font(.system(size: 52, weight: .medium, design: .rounded))
                            .foregroundColor(uiCENTERcolor)
                        Spacer()
                        TextField("", text: $email, prompt: Text("Új E-Mail cím").foregroundColor(textBoxColor))
                            .foregroundColor(uiSecondaryColor)
                            .italic()
                            .lineLimit(1)
                            .border(width: 4.0, edges: [.bottom], color: uiCENTERcolor)
                        //.scaleEffect(1.6, anchor: .leading)
                            .font(.system(size: 28))
                            .padding()
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        TextField("", text: $username, prompt: Text("Új Felhasználónév").foregroundColor(textBoxColor))
                            .foregroundColor(uiSecondaryColor)
                            .italic()
                            .lineLimit(1)
                            .border(width: 4.0, edges: [.bottom], color: uiCENTERcolor)
                        //.scaleEffect(1.6, anchor: .leading)
                            .font(.system(size: 28))
                            .padding()
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        if (!showPasswordToggle)
                        {
                            SecureField("", text: $password, prompt: Text("Új Jelszó").foregroundColor(textBoxColor))
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
                            TextField("", text: $password, prompt: Text("Új Jelszó").foregroundColor(textBoxColor))
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
                        if (!showPasswordToggle)
                        {
                            SecureField("", text: $againPwd, prompt: Text("Jelszó újra").foregroundColor(textBoxColor))
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
                            TextField("", text: $againPwd, prompt: Text("Jelszó újra").foregroundColor(textBoxColor))
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
                        Text(" ").font(.system(size: 5))
                        Toggle(isOn: $showPasswordToggle) {
                            Text("Jelszó megjelenítése")
                        }
                        .toggleStyle(.switch)
                        .font(.system(size: 20))
                        .foregroundColor(uiSecondaryColor)
                        .padding(.horizontal, 50)
                        Text(" ").font(.system(size: 10))
                        if (email != "" && username != "" && password != "" && password == againPwd) {
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
                        Button("Már van fiókom") {
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
                LoginView()
            }
            else if (actionState == .yes) {
                CreatingAccView(username: self.username)
            }
        }
    }
}

#Preview {
    RegisterView()
}
