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
        
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        List{
            TextField("Nome do orçamento", text: $nomeOrcamento)
            TextField("Nome do cliente", text: $nomeCliente)
            
            Section(header: Text("Custos")
            ) {
                HStack {
                   Text("Custos fixos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
               }
                HStack {
                    Text("Custos variáveis")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                HStack {
                    Text("Hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorDaHora!.valorFinal))
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoHora))
                }
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    TextField(
                        "0",
                        value: $hora,
                        formatter: vm.numFormatacao
                    )
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
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotal))
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
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), 20.0))
                        .bold()
                }
            }
            
            
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
                        .accentColor(vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora) ? Color.blue : Color.gray)
                }
                .disabled(!vm.ValidaOrcamento(nomeOrcamento: nomeOrcamento, nomeCliente: nomeCliente, qtdHora: hora))
                
            }
        }
        .navigationBarTitle("Editar orçamento")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture(perform: vm.DismissKeyboard)
    }
}
