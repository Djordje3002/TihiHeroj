//
//  ReportView.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 16.10.24..
//

import SwiftUI

struct ReportView: View {
    
    @Binding var path: [AppScreen]
    
    var body: some View {
        
        VStack {
            reportViewNavBar
            ScrollView{
                TitleView(text: "Добро је знати")
                DescriptionText(text: "Путем ове апликације можеш пријавити сваки облик насиља које укључује малолетна лица (било да су жртве или починиоци).")
                DescriptionText(text: "У случају насиља у породици одмах позовите бесплатан број 192.")
                DescriptionText(text: "Подаци које остављаш се користе у сврху поступања надлежних органа по твојој пријави, који могу бити: образовна установа, центар за социјални рад, надлежни јавни тужилац, полицијска управа/станица, школска управа, Министарство просвете, Министарство за бригу о породици и демографију, Министарство за рад, запошљавање, борачка и социјална питања, Министарство унутрашњих послова ...")
                DescriptionText(text: "Подаци ће се чувати до окончања поступка по пријави, а најдуже две године.")
                Spacer()
                NextStepButton(
                    isEnabled: true,
                    action: {
                        path.append(.reportScreen1)
                    },
                    title: Text("Започни пријаву"),
                    arrow: false
                )
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
    
    private var reportViewNavBar: some View{
        ZStack{
            Spacer()
            Text("Пријава насиља")
                .font(.headline)
            HStack{
                
                Spacer()
                Button(
                    action: {
                        path.removeLast()
                }, label: {
                    Text("Затвори")
                        .foregroundColor(.thunder500)
                        .font(.system(size: 17))
                })
            }
        }
    }
    
}
#Preview {
    ReportView(path: Binding.constant([]))
}

