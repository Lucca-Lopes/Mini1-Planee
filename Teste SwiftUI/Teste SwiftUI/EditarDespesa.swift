//
//  EditarDespesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

struct EditarDespesa: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    var entidade: CustoVariavel
            
    @State var nome: String
    @State var valor: Double
    
    @FocusState var focarNome: Bool
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Form {
            HStack {
                Text("Nome")
                    .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                Spacer()
                TextField("Nome", text: $nome)
                    .focused($focarNome)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.4)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            HStack {
                Text("Valor")
                    .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                Spacer()
                TextField(
                    "R$ 0,00",
                    value: $valor,
                    formatter: vm.numFormatacao
                )
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: vm.screenWidth * 0.4)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
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
        .navigationBarTitle("Editar custo variável")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture(perform: vm.dismissKeyboard)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
