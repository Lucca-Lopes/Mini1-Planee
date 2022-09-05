//
//  navigation-link.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 02/09/22.
//

import SwiftUI

public class Utilitarios {
    
    func criaNavigationLink(textoPrincipal: String, textoSecundario: String, destino: String) -> some View {
        let navigationLink = NavigationLink {
            
            switch destino {
            case "Gastos":
                ContentView()
                
            case "Despesas":
                ContentView()
                
            case "Valor da hora de trabalho":
                ContentView()
                
            case "Custo por hora":
                ContentView()
                
            default:
                ContentView()
            }
//
//            if destino == "tela_criar_orcamento" {
//                tela_criar_orcamento()
//            }
//            else {
//                ContentView()
//            }
        }
        label: {
            Text(textoPrincipal)
//                .lineLimit(1)
            Spacer()
//                .padding()
            Text(textoSecundario)
                .foregroundColor(.gray)
        }
        return navigationLink
    }
    
//    func distinguirTela(nome: String) -> some View {
//        switch nome {
//        case "tela_criar_orcamento":
//            return tela_criar_orcamento()
//        default:
//            return ContentView()
//        }
//    }
    
}
 
