//
//  navigation-link.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 02/09/22.
//

import SwiftUI

public class Utilitarios {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
//    @Environment(\.managedObjectContext) private var viewContext
    
    func criaNavigationLink(textoPrincipal: String, textoSecundario: String, destino: String) -> some View {
        let navigationLink = NavigationLink {
            
            switch destino {
            case "Gastos":
                TelaGastos()

                
            case "Valor da hora de trabalho":
                TelaValorHdT()
                
            case "Custo por hora":
                TelaDespesas()
                
            default:
                TelaInicial()
            }
        }
        label: {
            Text(textoPrincipal)
            Spacer()
            Text(textoSecundario)
                .foregroundColor(.gray)
        }
        return navigationLink
    }
    
    
    
    func criaNLHome(titulo: String) -> some View {
        let destino = NavigationLink {
            switch titulo {
            case "Criar orçamento":
                TelaCriarOrcamento()

            case "Meus orçamentos":
                TelaMeusOrcamentos()

            case "Calcular valor da hora":
                TelaValorHdT()

            case "Despesas":
                TelaDespesas()

            case "Gastos":
                TelaGastos()

            default:
                TelaInicial()
            }
        }
        label: {
            Text(titulo)
                .foregroundColor(.black)
                .bold()
                .font(.system(size: 22))
                .frame(height: 55)
        }
        return destino
    }
    
}
 
