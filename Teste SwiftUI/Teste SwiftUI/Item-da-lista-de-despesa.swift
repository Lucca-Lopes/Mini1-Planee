//
//  Item-da-lista-de-despesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/09/22.
//

import SwiftUI

struct Item_da_lista_de_despesa: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    let item: Despesa
    var editando: Bool
//    {
//        get {
//            return false
//        }
//        set {
//            if newValue == false {
//                item.nome = nome
//                item.valor = valor
//            }
//        }
//    }
    
    @Binding var nome: String
    @Binding var valor: Double
    
    var body: some View {
        HStack {
            if !editando {
                Text(item.nome ?? "Luz")
                Spacer()
                Text("R$ \(item.valor)")
                    .foregroundColor(.gray)
            }
            else {
                Picker("Escolha um nome",
                       selection: $nome) {
                    ForEach(opcoes, id: \.self) { opcao in
                        Text(opcao)
                    }
                    .foregroundColor(.black)
                }
                .pickerStyle(.menu)
                Spacer()
                TextField(
                    "Oi",
                    value: $valor,
                    formatter: NumberFormatter()
                )
                
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
               
            }
        }
    }
    
    func atualizarParametros(nomeAtual: inout String, valorAtual: inout Double) {
        nomeAtual = nome
        valorAtual = valor
    }
    
}

//struct Item_da_lista_de_despesa_Previews: PreviewProvider {
//    static var previews: some View {
//        Item_da_lista_de_despesa()
//    }
//}
