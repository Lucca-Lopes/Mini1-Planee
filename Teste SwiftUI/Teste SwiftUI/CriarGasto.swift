//
//  SheetGasto.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 22/09/22.
//

import SwiftUI

struct CriarGasto: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var nome: String = ""
    @State var valor: Double = 0.0
    @State var vidaUtil: Int = 0
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        NavigationView{
            List{
                HStack {
                    Text("Título")
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField(
                        "Nome",
                        text: $nome
                    )
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.4)
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                
                HStack{
                    Text("Valor total")
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
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
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                
                HStack{
                    Text("Vida útil")
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField(
                        "Meses",
                        value: $vidaUtil,
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
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        if vm.ValidaCustoFixo(nome: nome, valor: valor){
                            vm.AddCustoFixo(nome: nome, valorTotal: valor, vidaUtil: vidaUtil)
                            self.mode.wrappedValue.dismiss()
                        }
                    }label:{
                        Text("Ok")
                            .accentColor(vm.ValidaCustoFixo(nome: nome, valor: valor) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaCustoFixo(nome: nome, valor: valor))
                }
            }
            .navigationBarTitle("Adicionar custo fixo")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture(perform: vm.DismissKeyboard)
            .background(colorScheme == .dark ? Color.black : vm.corLight[3])
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}
