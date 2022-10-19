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
    
    var body: some View{
        NavigationView{
            List{
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
                        "Meses",
                        value: $vidaUtil,
                        formatter: vm.numFormatacao
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.4)
                    
                }
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
        }
    }
}
