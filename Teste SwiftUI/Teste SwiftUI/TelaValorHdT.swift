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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List{
            HStack{
                Text("Pretensão salarial")
                    .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                Spacer()
                TextField("R$ 0,00", value: $valor, formatter: vm.formatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            HStack{
                Text("Dias de trabalho")
                    .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                Spacer()
                TextField("0 dias", value: $dias, formatter: vm.numFormatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            HStack{
                Text("Horas diárias")
                    .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                Spacer()
                TextField("0 horas", value: $horasDiarias, formatter: vm.numFormatacao)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.3)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            Section(header: Text(""))
            {
                HStack{
                    Text("Valor da hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora[0].valorFinal))
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
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
                        .accentColor(valor != 0 && dias != 0 && horasDiarias != 0 ? Color.blue : Color.gray)
                }
            }
        }
        .onTapGesture(perform: vm.DismissKeyboard)
        .navigationTitle("Hora de trabalho")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
