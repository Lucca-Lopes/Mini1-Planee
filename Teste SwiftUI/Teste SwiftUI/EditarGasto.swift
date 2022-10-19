//
//  EditarGasto.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

struct EditarGasto: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var entidade: CustoFixo
    
    @State var editando = false
    @State var nome: String
    @State var valor: Double
    @State var vidaUtil: Int
    
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
                .frame(maxWidth: vm.screenWidth * 0.4)
            }
            HStack{
                Text("Valor total")
                Spacer()
                TextField(
                    "R$ 0,00",
                    value: $valor,
                    formatter: vm.formatacao
                )
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: vm.screenWidth * 0.4)
            }
            HStack{
                Text("Vida útil")
                Spacer()
                TextField(
                    "R$ 0,00",
                    value: $vidaUtil,
                    formatter: vm.numFormatacao
                )
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: vm.screenWidth * 0.4)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    if vm.ValidaCustoFixo(nome: nome, valor: valor){
                        vm.AtualizarCustoFixo(entidade: entidade, nome: nome, valor: valor, vidaUtil: vidaUtil)
                        self.mode.wrappedValue.dismiss()
                    }
                }label:{
                    Text("Ok")
                        .accentColor(vm.ValidaCustoFixo(nome: nome, valor: valor) ? Color.blue : Color.gray)
                }
                .disabled(!vm.ValidaCustoFixo(nome: nome, valor: valor))
            }
        }
        .navigationBarTitle("Editar custo fixo")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture(perform: vm.DismissKeyboard)
    }
}
