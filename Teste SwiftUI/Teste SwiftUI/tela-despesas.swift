//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI



struct tela_despesas: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var hora: String = ""
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        NavigationView {
            List {
                HStack {
//                    Text("Luz")
//                    padding()
//                    Image(systemName: "chevron.right")
                    //criar text, spcer, text nesse ordem, ao clicar em editar o primeiro text vira um picker pra selecionar o nome e o segundo text vira um textfield
                    NavigationLink {
                        ContentView()
                    }
                    label: {
                        Text("Luz")
                        Spacer()
                        TextField(
                            "R$ 00,00",
                            value: $hora,
                            formatter: NumberFormatter()
                        )
                        .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
                    }
                    
                }
            }
            .navigationTitle("Despesas")
        }
    }
}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        tela_despesas()
    }
}
