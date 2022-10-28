//
//  TelaEditarOrcamento.swift
//  Planee
//
//  Created by Lucca Lopes on 10/10/22.
//

import SwiftUI

struct TelaEditarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    var entidade: Orcamento
    @State var nomeOrcamento: String
    @State var nomeCliente: String
    @State var hora: Int
    @State var lucro: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        List{
            Section{
                TextField("Nome do orçamento", text: $nomeOrcamento)
                    .font(.system(.body, design: .rounded))
                TextField("Nome do cliente", text: $nomeCliente)
                    .font(.system(.body, design: .rounded))
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            Section(header: Text("Custos")
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                   Text("Custos fixos")
                        .font(.system(.body, design: .rounded))
                   Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
                        .font(.system(.body, design: .rounded))
               }
                HStack {
                    Text("Custos variáveis")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                        .font(.system(.body, design: .rounded))
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section(header: Text("Mão de obra")
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                    Text("Hora de trabalho")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorDaHora!.valorFinal))
                        .font(.system(.body, design: .rounded))
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                
                HStack {
                    Text("Custos por hora")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoHora))
                        .font(.system(.body, design: .rounded))
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                
                HStack {
                    Text("Tempo de trabalho")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField(
                        "0",
                        value: $hora,
                        formatter: vm.numFormatacao
                    )
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.25)
                    Text("h")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                }
                
                HStack {
                    Text("Custo total")
                        .font(.system(.body, design: .rounded))
//                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotal))
                        .font(.system(.body, design: .rounded))
//                        .bold()
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            
            Section() {
                HStack {
                    Text("Lucro")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Spacer()
                    TextField(
                        "0",
                        value: $lucro,
                        formatter: vm.numFormatacao
                    )
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: vm.screenWidth * 0.25)
                    Text("%")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            
            Section() {
                HStack {
                    Text("Valor total")
                        .font(.system(.body, design: .rounded))
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), 20.0))
                        .font(.system(.body, design: .rounded))
                        .bold()
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    if vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) {
                        vm.AtualizarOrcamento(entidade: entidade, nome: nomeOrcamento, nomeCliente: nomeCliente, tempoDeTrabalho: hora, lucro: lucro)
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }label:{
                    Text("Salvar")
                        .font(.system(.body, design: .rounded))
                        .accentColor(vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) ? Color.blue : Color.gray)
                }
                .disabled(!vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora))
                
            }
        }
        .navigationBarTitle("Editar orçamento")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture(perform: vm.DismissKeyboard)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
