//
//  Item-da-lista-de-despesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/09/22.
//

import SwiftUI

struct ItemDespesa: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        
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
                    .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)

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
                .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
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
