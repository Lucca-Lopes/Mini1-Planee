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
                    .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
                }
                HStack{
                    Text("Valor total")
                    Spacer()
                    TextField(
                        "R$ 0,00",
                        value: $valor,
                        formatter: vm.formatacao
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
                        "Meses",
                        value: $vidaUtil,
                        formatter: vm.numFormatacao
                    )
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
                }
            }
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        if vm.ValidaGasto(nome: nome, valor: valor, vidaUtil: vidaUtil){
                            vm.addGasto(nome: nome, valor: valor, vidaUtil: vidaUtil)
                            self.mode.wrappedValue.dismiss()
                        }
                    }label:{
                        Text("OK")
                            .accentColor(vm.ValidaGasto(nome: nome, valor: valor, vidaUtil: vidaUtil) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaGasto(nome: nome, valor: valor, vidaUtil: vidaUtil))
                }
            }
            .navigationBarTitle("Adicionar gasto")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture(perform: vm.dismissKeyboard)
            //                .frame(width: screenWidth, height: screenHeight * 0.9, alignment: .center)
        }
    }
}
