//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct TelaCriarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var nomeOrcamento: String = ""
    @State var nomeCliente: String = ""
    @State var hora: Int = 0
    @State var lucro: Int = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    let utilitarios = Utilitarios()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private enum Field: Int {
        case titulo, nomeCliente, tempoTrabalho, lucro
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            List{
                Section{
                    TextField("Titulo", text: $nomeOrcamento)
                        .font(.system(.body, design: .rounded))
                        .focused($focusedField, equals: .titulo)
                    TextField("Nome do cliente", text: $nomeCliente)
                        .font(.system(.body, design: .rounded))
                        .focused($focusedField, equals: .nomeCliente)
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                
                Section(header: Text("Custos")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
                ) {
                    NavigationLink {
                        TelaGastos(vm: vm)
                   }
                   label: {
                       Text("Custos fixos")
                           .font(.system(.body, design: .rounded))
                           .frame(maxWidth: .infinity, alignment: .leading)
                       Spacer()
                       Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.CalcularTotalCustosFixos()))
                           .font(.system(.body, design: .rounded))
                           .frame(maxWidth: .infinity, alignment: .trailing)
                   }
                    NavigationLink {
                        TelaDespesasOrcamento(vm: vm)
                    }
                    label: {
                        Text("Custos variáveis")
                            .font(.system(.body, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.CalcularTotalCustosVariaveis()))
                            .font(.system(.body, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
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
                    NavigationLink {
                        TelaValorHdT(vm: vm, valor: vm.valorDaHora.last!.pretensaoSalarial, dias: Int(vm.valorDaHora.last!.dias), horasDiarias: Int(vm.valorDaHora.last!.horas))
                        
                    }
                label: {
                    Text("Hora de trabalho")
                        .font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora.last!.valorFinal))
                        .font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    
                    HStack {
                        Text("Custos por hora")
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        Text("R$ 0,00")
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
                        .focused($focusedField, equals: .tempoTrabalho)
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
//                            .bold()
                        Spacer()
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), (vm.CalcularTotalCustosFixos() + vm.CalcularTotalCustosVariaveis())))
                            .font(.system(.body, design: .rounded))
//                            .bold()
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
                        .focused($focusedField, equals: .lucro)
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
                        Text("R$ 0,00")
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
                            vm.AddOrcamento(nome: nomeOrcamento, nomeCliente: nomeCliente, valorDaHora: vm.valorDaHora.last!, tempoDeTrabalho: hora, lucro: lucro)
                            self.mode.wrappedValue.dismiss()
                        }
                        
                    }label:{
                        Text("Adicionar")
                            .font(.system(.body, design: .rounded))
                            .accentColor(vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora))
                    
                }
            }
            .navigationBarTitle("Novo orçamento")
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .dark ? Color.black : vm.corLight[3])
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
            
            if focusedField != nil{
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.001)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(perform: vm.DismissKeyboard)
            }
        }
    }
}
