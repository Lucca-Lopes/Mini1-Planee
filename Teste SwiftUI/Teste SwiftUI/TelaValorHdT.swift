//
//  tela-valor-HdT.swift
//  Teste SwiftUI
//
//  Created by Rodrigo Pereira on 09/09/22.
//

import SwiftUI

struct TelaValorHdT: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var valor: Double = 0.0
    @State var dias: Int = 0
    @State var horasDiarias: Int = 0
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        List{
            HStack{
                Text("Pretensão salarial")
                Spacer()
                TextField("R$ 0,00", value: $valor, formatter: vm.formatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            HStack{
                Text("Dias de trabalho")
                Spacer()
                TextField("0 dias", value: $dias, formatter: vm.numFormatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            HStack{
                Text("Horas diárias")
                Spacer()
                TextField("0 horas", value: $horasDiarias, formatter: vm.numFormatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text(""))
            {
                HStack{
                    Text("Valor da hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora[0].valorFinal))
                }
            }
        }
        .listStyle(.insetGrouped)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    if valor != 0 && dias != 0 && horasDiarias != 0 {
                        vm.AtualizarVdH(entidade: vm.valorDaHora[0], pretensaoSalarial: valor, dias: dias, horas: horasDiarias)
                        self.mode.wrappedValue.dismiss()
                    }
                }label:{
                    Text("Salvar")
                }
            }
        }
        .onTapGesture(perform: vm.DismissKeyboard)
        .navigationTitle("Hora de trabalho")
        .navigationBarTitleDisplayMode(.large)
    }
}
