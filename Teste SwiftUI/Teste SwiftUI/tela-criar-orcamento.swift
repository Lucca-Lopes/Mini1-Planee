//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct tela_criar_orcamento: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Gastos")
                    .bold()
                ) {
        
                    NavigationLink {
                        Text("Gastos fixos")
                    }
                    label: {
                        Text("Gastos fixos")
                            .lineLimit(1)
                        Spacer()
                        Text("R$ 1250,00")
                            .foregroundColor(.gray)
                    }
                }
                
            }
            .navigationTitle("Novo orçamento")
        }
        
//        Text("Tela")
//            .position(x: screenWidth * 0.5, y: screenHeight * 0.5)
//            .frame(width: screenWidth / 2, height: screenHeight * 0.5)
    }
}

struct tela_criar_orcamento_Previews: PreviewProvider {
    static var previews: some View {
        tela_criar_orcamento()
        
    }
}
