//
//  OnboardingModel.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 31.10.24..
//

import Foundation

struct OnboardingModel {
    var screens: [OnboardingScreen]
    
    init() {
        self.screens = [
            OnboardingScreen(image: "pic1", title: "Пријави, не ћути", description: "Твоја безбедност је наш приоритет. Користи једноставан формулар за пријаву вршњачког насиља. Ми обезбеђујемо поверљивост, а твој глас може направити разлику."),
            OnboardingScreen(image: "pic2", title: "Сазнај више", description: "Знање је моћ. Истражи едукативне садржаје о различитим облицима вршњачког насиља и како га препознати. Заједно можемо створити безбедније окружење."),
            OnboardingScreen(image: "pic3", title: "Брза помоћ", description: "Осећаш ли се угрожено? Користи брзу СМС функцију да обавестиш особу од поверења. Само један клик ти може донети потребну помоћ у хитним ситуацијама.")
        ]
    }
}

struct OnboardingScreen {
    var image: String
    var title: String
    var description: String
}
