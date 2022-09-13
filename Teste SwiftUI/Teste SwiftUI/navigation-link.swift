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
    
    func criaNavigationLink(textoPrincipal: String, textoSecundario: String, destino: String) -> some View {
        let navigationLink = NavigationLink {
            
            switch destino {
            case "Gastos":
                Tela_Gastos()
     
            case "Valor da hora de trabalho":
                ContentView()
                
            case "Custo por hora":
                ContentView()

                
            default:
                ContentView()
            }
        }
        label: {
            Text(textoPrincipal)
//                .lineLimit(1)
            Spacer()
            Text(textoSecundario)
                .foregroundColor(.gray)
        }
        return navigationLink
    }
    
    func criaDespesa(editando: Bool) -> some View {
        
        let nomes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
        
        @State var nomeSelecionado: String = "Luz"
        @State var preco: Float = 0.0
        
        let celula = HStack {
            if !editando {
                Text(nomeSelecionado)
                Spacer()
                Text("R$ \(preco)")
                    .foregroundColor(.gray)
            }
            else {
                Picker("Escolha um nome",
                       selection: $nomeSelecionado) {
                    ForEach(nomes, id: \.self) { nome in
                        Text(nome)
                    }
                    .foregroundColor(.black)
                }
                .pickerStyle(.menu)
                Spacer()
                TextField(
                    "Oi",
                    value: $preco,
                    formatter: NumberFormatter()
                    
                )
                
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
                
            }
        }
        return celula
    }
    
//    func distinguirTela(nome: String) -> some View {
//        switch nome {
//        case "tela_criar_orcamento":
//            return tela_criar_orcamento()
//        default:
//            return ContentView()
//        }
//    }
    
    func criaNLHome(titulo: String) -> some View {
        let destino = NavigationLink {
            switch titulo {
            case "Criar orçamento":
                tela_criar_orcamento()

            case "Meus orçamentos":
                ContentView()

            case "Calcular o valor da hora":
                tela_valor_HdT()

            case "Despesas":
                tela_despesas()

            case "Gastos":
                Tela_Gastos()

            default:
                ContentView()
            }
        }
        label: {
            Text(titulo)
                .foregroundColor(.black)
                .bold()
                .font(.system(size: 22))
                .frame(height: 55)
//            .padding()
        }
        return destino
    }
    
}
 
