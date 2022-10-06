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
    
    let formatacao: NumberFormatter = {
        let formatacao = NumberFormatter()
        formatacao.numberStyle = .decimal
        formatacao.minimumFractionDigits = 2
        formatacao.maximumFractionDigits = 2
        formatacao.decimalSeparator = ","
        formatacao.zeroSymbol = ""
        return formatacao
    }()
    
    private let numFormatacao: NumberFormatter = {
        let numero = NumberFormatter()
        numero.zeroSymbol = ""
        return numero
    }()
    
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
                        formatter: formatacao
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
                        formatter: numFormatacao
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
                    Button(action: {
                        if nome != "" && valor != 0.0 && vidaUtil != 0 {
                            vm.addGasto(nome: nome, valor: valor, vidaUtil: vidaUtil)
                            self.mode.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        Text("OK")
                    })
                }
            }
            .navigationBarTitle("Adicionar gasto")
            .navigationBarTitleDisplayMode(.inline)
            //                .frame(width: screenWidth, height: screenHeight * 0.9, alignment: .center)
        }
    }
}
