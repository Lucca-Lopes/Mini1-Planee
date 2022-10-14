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
    
    let utilitarios = Utilitarios()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private enum Field: Int {
        case titulo, nomeCliente, tempoTrabalho, lucro
    }

    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            List{
                TextField("Titulo", text: $nomeOrcamento)
                    .focused($focusedField, equals: .titulo)
                TextField("Nome do cliente", text: $nomeCliente)
                    .focused($focusedField, equals: .nomeCliente)
                
                Section(header: Text("Custos")
                ) {
                    NavigationLink {
                        TelaGastos(vm: vm)
                   }
                   label: {
                       Text("Gastos")
                           .frame(maxWidth: .infinity, alignment: .leading)
                       Spacer()
                       Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalGastos()))
                           .frame(maxWidth: .infinity, alignment: .trailing)
                   }
                    NavigationLink {
                        TelaDespesas(vm: vm)
                    }
                    label: {
                        Text("Despesas")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalDespesa()))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                
                Section(header: Text("Mão de obra")
                ) {
                    NavigationLink {
                        TelaValorHdT(vm: vm, valor: vm.valorDaHora.last!.pretensaoSalarial, dias: Int(vm.valorDaHora.last!.dias), horasDiarias: Int(vm.valorDaHora.last!.horas))
                            
                    }
                    label: {
                        Text("Valor hora de trabalho")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora.last!.valorFinal))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    HStack {
                        Text("Custos por hora")
                        Spacer()
                        Text("R$ 0,00")
                    }
                    HStack {
                        Text("Tempo de trabalho")
                        Spacer()
                        TextField(
                            "0",
                            value: $hora,
                            formatter: vm.numFormatacao
                        )
                        .focused($focusedField, equals: .tempoTrabalho)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: vm.screenWidth * 0.25)
                        Text("h")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Custo total")
                            .bold()
                        Spacer()
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), (vm.calcularTotalGastos() + vm.calcularTotalDespesa())))
                            .bold()
                    }
                }
                
                Section() {
                    HStack {
                        Text("Lucro")
                        Spacer()
                        TextField(
                            "0",
                            value: $lucro,
                            formatter: vm.numFormatacao
                        )
                        .focused($focusedField, equals: .lucro)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: vm.screenWidth * 0.25)
                        Text("%")
                            .foregroundColor(.gray)
                    }
                }
                
                Section() {
                    HStack {
                        Text("Valor total")
                            .bold()
                        Spacer()
                        Text("R$ 0,00")
                            .bold()
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button{
                        if vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) {
                            vm.addOrcamento(nome: nomeOrcamento, nomeCliente: nomeCliente, totalGastos: vm.calcularTotalGastos(), totalDespesas: vm.calcularTotalDespesa(), valorDaHora: vm.valorDaHora.last!, tempoDeTrabalho: hora, lucro: lucro)
                            self.mode.wrappedValue.dismiss()
                        }
                        
                    }label:{
                        Text("Adicionar")
                            .accentColor(vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) ? Color.blue : Color.gray)
                    }
                    .disabled(!vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora))
                    
                }
            }
            .navigationBarTitle("Novo orçamento")
            .navigationBarTitleDisplayMode(.inline)
            
            if focusedField != nil{
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.001)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(perform: vm.dismissKeyboard)
            }
        }
    }
}
