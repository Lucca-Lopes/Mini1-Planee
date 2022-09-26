//
//  EditarGasto.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

struct EditarGasto: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    @State var nome: String = ""
    @State var valor: Double = 0.0
    @State var vidaUtil: Int = 0
    
    @State var entidade: Gasto
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View{
        Form{
            HStack {
                Text("Título")
                Spacer()
                TextField(
                    "Nome",
                    text: $nome
                )
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
            }
            HStack{
                Text("Valor total")
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
            HStack{
                Text("Vida útil")
                Spacer()
                TextField(
                    "R$ 0,00",
                    value: $vidaUtil,
                    formatter: NumberFormatter()
                )
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if nome != "" && valor != 0.0 && vidaUtil != 0 {
                        vm.atualizarGasto(entidade: entidade, nome: nome, valor: valor, vidaUtil: vidaUtil)
                        self.mode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("OK")
                })
            }
        }
        .navigationBarTitle("Editar gasto")
        .navigationBarTitleDisplayMode(.inline)
    }
}
