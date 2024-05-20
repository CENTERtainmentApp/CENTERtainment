//
//  This file is the property of CENTERtainment
//  (C) 2024- All rights reserved.
//

import SwiftUI

struct CreatingAccView: View {
    @State var finishedPage:Bool = false
    @State var acceptedTOS:Bool = false
    @State var opacityScreen:CGFloat = 0.0
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var removedFromScreen:Bool = false
    
    @State var username:String = "default"
    
    var body: some View {
        ZStack {
            if (!finishedPage) {
                LinearGradient(colors: [uiBgColorTop, uiBgColorBottom], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea(.all)
                VStack {
                    Image("LogoTransparent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    VStack {
                        ScrollView {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("**CENTERtainment Általános**")
                                        .foregroundColor(uiSecondaryColor)
                                        .font(.title3)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("**Szerződési Feltételek (ÁSZF) és**")
                                        .foregroundColor(uiSecondaryColor)
                                        .font(.title3)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("**adatvédelmi irányelvek**")
                                        .foregroundColor(uiSecondaryColor)
                                        .font(.title3)
                                    Spacer()
                                }
                                Text("\nKöszöntjük a CENTERtainment almazásban! Kérjük, olvassa el figyelmesen az alábbi Általános Szerződési Feltételeket (a továbbiakban: ÁSZF), mielőtt használná alkalmazásunkat vagy regisztrálna.\n\n1. **Regisztráció és Fiók létrehozása**\n\nAz alkalmazásunk használatához regisztráció és fiók létrehozása szükséges. A regisztráció során bizonyos személyes adatokat kérhetünk, mint például név, e-mail cím és egyéb elérhetőségek.\n\n**2. Adatvédelem és Biztonság**\n\nMegértjük és tiszteletben tartjuk az Ön magánéletét. Az általunk gyűjtött személyes adatokat kizárólag az alkalmazásunk működtetéséhez és a szolgáltatásaink nyújtásához használjuk fel. Az Ön adatait harmadik felekkel nem osztjuk meg, és minden lehetséges intézkedést megteszünk az adatok biztonságának garantálása érdekében.\n\n**3. Automatikus Adatgyűjtés**\n\nAz alkalmazás használata során automatikusan gyűjtünk bizonyos adatokat, például az eszköz típusát, az operációs rendszert és az alkalmazás használatára vonatkozó statisztikákat. Ezek az adatok segítenek nekünk jobban megérteni az alkalmazás használatát, és javítani szolgáltatásainkat.\n\n**4. Felhasználói Élmény és Személyre Szabás**\n\nAz általunk gyűjtött adatok segítségével személyre szabott élményt tudunk nyújtani Önnek az alkalmazásban. Ez lehetőséget ad számunkra arra, hogy javítsuk az alkalmazás funkcionalitását és tartalmát az Ön igényei szerint.\n\n**5. Harmadik Felek Szolgáltatásai**\n\nAz alkalmazásunk harmadik felek által nyújtott szolgáltatásokat is integrálhat. Ezekre a szolgáltatásokra vonatkozóan az adott harmadik fél saját felhasználási feltételei és adatvédelmi irányelvei érvényesek lehetnek.\n\n**6. Kapcsolatfelvétel és További Információk**\n\nHa kérdése van az ÁSZF-el vagy az adatvédelmi gyakorlatunkkal kapcsolatban, kérjük, vegye fel velünk a kapcsolatot az alkalmazáson keresztül elérhető kapcsolatfelvételi lehetőségek egyikén.\n\nAz alkalmazásunk használatával Ön elfogadja az Általános Szerződési Feltételeket és az adatvédelmi irányelveket.\nKöszönjük, hogy a CENTERtainment alkalmazást választotta!")
                            }.foregroundColor(uiSecondaryColor)
                        }.padding(23)
                        Text(" ").font(.system(size: 5))
                        Toggle(isOn: $acceptedTOS) {
                            Text("Elfogadom az ÁSZF-t")
                        }
                        .toggleStyle(.switch)
                        .font(.system(size: 20))
                        .foregroundColor(uiSecondaryColor)
                        .padding(.horizontal, 50)
                        Text(" ").font(.system(size: 10))
                        if (acceptedTOS) {
                            Button("Regisztrálok!") {
                                //Next scene :3
                                removedFromScreen = true
                                finishedPage = true
                            }
                            .padding()
                            .padding(.horizontal, 30)
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(uiCENTERcolor))
                        }
                        else {
                            Button("Regisztrálok!") {
                                //Nothing
                            }
                            .disabled(true)
                            .padding()
                            .padding(.horizontal, 30)
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.gray))
                        }
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
            else {
                LoadingView(username: self.username, register: true)
            }
        }
    }
}

#Preview {
    CreatingAccView()
}
