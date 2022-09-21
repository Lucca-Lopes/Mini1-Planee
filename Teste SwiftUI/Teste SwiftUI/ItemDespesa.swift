//
//  Item-da-lista-de-despesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/09/22.
//

import SwiftUI

struct ItemDespesa: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
//    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    var entidade: Despesa
    
    @State var nome: String
    @State var valor: Double
    
    var body: some View {
        Form {
            HStack {
                Text("Nome")
                Spacer()
                TextField("Nome", text: $nome)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)

            }
            HStack {
                Text("Valor")
                Spacer()
                TextField(
                    "R$ 0,00",
                    value: $valor,
                    formatter: NumberFormatter()
                )
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    vm.atualizarDespesa(entidade: entidade, nome: nome, valor: valor)
                    self.mode.wrappedValue.dismiss()
                }) {
                    Text("Salvar")
                }
            }
        }
    }
}


//struct ItemDespesaEditando: View {
//
//    let screenWidth = UIScreen.main.bounds.size.width
//    let screenHeight = UIScreen.main.bounds.size.height
//
//    let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
//
//    @State var nome: String
//    @State var valor: Double
//    var entidade: Despesa
//
////    var completion: (String, String) -> Void
//
//    var body: some View {
//        HStack {
//            Picker("Escolha um nome",
//                   selection: $nome) {
//                ForEach(opcoes, id: \.self) { opcao in
//                    Text(opcao)
//                }
//                .foregroundColor(.black)
//            }
//                   .pickerStyle(.menu)
//            Spacer()
//            TextField(
//                "Oi",
//                value: $valor,
//                formatter: NumberFormatter()
//            )
//            .multilineTextAlignment(.trailing)
//            .keyboardType(.numberPad)
//            .textFieldStyle(.roundedBorder)
//            .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
//        }
//    }
//}
//
//struct ItemDespesaSemEditar: View {
//    var entidade: Despesa
//
//    var body: some View {
//        HStack {
//            Text(entidade.nome ?? "Luz")
//            Spacer()
//            Text("R$ \(entidade.valor)")
//                .foregroundColor(.gray)
//        }
//    }
//}

//    func salvarAtualizacao(nome: String, valor: Double) {
//
//    }
//}
