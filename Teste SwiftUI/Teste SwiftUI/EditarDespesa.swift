//
//  EditarDespesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

struct EditarDespesa: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    var entidade: Despesa
            
    @State var nome: String
    @State var valor: Double
    
    @FocusState var focarNome: Bool
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
            Form {
                HStack {
                    Text("Nome")
                    Spacer()
                    TextField("Nome", text: $nome)
                        .focused($focarNome)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: vm.screenWidth * 0.4)
                }
                HStack {
                    Text("Valor")
                    Spacer()
                    TextField(
                        "R$ 0,00",
                        value: $valor,
                        formatter: vm.numFormatacao
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.4)                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        if vm.ValidaDespesa(nome: nome, valor: valor){
                            vm.atualizarDespesa(entidade: entidade, nome: nome, valor: valor)
                            self.mode.wrappedValue.dismiss()
                        }
                    }label:{
                        Text("OK")
                            .accentColor(vm.ValidaDespesa(nome: nome, valor: valor) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaDespesa(nome: nome, valor: valor))
                }
            }
            .navigationBarTitle("Editar despesa")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture(perform: vm.dismissKeyboard)
    }
}
