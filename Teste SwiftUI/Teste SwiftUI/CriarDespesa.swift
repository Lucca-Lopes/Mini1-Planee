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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Nome")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField("Nome", text: $nome)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: vm.screenWidth * 0.4)
                    
                }
                .font(.system(.body, design: .rounded))
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                
                HStack {
                    Text("Valor")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField(
                        "R$ 0,00",
                        value: $valor,
                        formatter: vm.numFormatacao
                    )
                    .font(.system(.body, design: .rounded))
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
                        if vm.ValidaCustoVariavel(nome: nome, valor: valor){
                            vm.AddCustoVariavel(nome: nome, valor: valor)
                            self.mode.wrappedValue.dismiss()
                        }
                    }label:{
                        Text("Ok")
                            .font(.system(.body, design: .rounded))
                            .accentColor(vm.ValidaCustoVariavel(nome: nome, valor: valor) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaCustoVariavel(nome: nome, valor: valor))
                }
            }
            .navigationBarTitle("Adicionar custo variável")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture(perform: vm.DismissKeyboard)
            .background(colorScheme == .dark ? Color.black : vm.corLight[3])
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}
