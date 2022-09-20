//
//  navigation-link.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 02/09/22.
//

import SwiftUI
import Accessibility

public class Utilitarios {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
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
                TelaInicialView()
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
    
    func criaDespesa(editando: Bool) -> some View {
        
        let nomes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
//
        @State var nome = "Luz"
        @State var preco = 0.0
        
        let celula = HStack {
            if !editando {
                Text(nome)
                Spacer()
                Text("R$ \(preco)")
                    .foregroundColor(.gray)
            }
            else {
                Picker("Escolha um nome",
                       selection: $nome) {
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
                TelaInicialView()
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
 
