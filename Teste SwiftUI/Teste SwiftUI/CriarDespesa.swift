//
//  Item-da-lista-de-despesa.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/09/22.
//

import SwiftUI

struct CriarDespesa: View {
    
    @ObservedObject var vm: PlaneeViewModel
            
    @State var nome: String
    @State var valor: Double
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Nome")
                    Spacer()
                    TextField("Nome", text: $nome)
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
                    .frame(maxWidth: vm.screenWidth * 0.4) 
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        if vm.ValidaDespesa(nome: nome, valor: valor){
                            vm.addDespesa(nome: nome, valor: valor)
                            self.mode.wrappedValue.dismiss()
                        }
                    }label:{
                        Text("OK")
                            .accentColor(vm.ValidaDespesa(nome: nome, valor: valor) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaDespesa(nome: nome, valor: valor))
                }
            }
            .navigationBarTitle("Adicionar despesa")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture(perform: vm.dismissKeyboard)
        }
    }
}
