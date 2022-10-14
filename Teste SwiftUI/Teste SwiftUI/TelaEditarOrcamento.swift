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
//    @State var custoTotal: Double
        
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        List{
            TextField("Nome do orçamento", text: $nomeOrcamento)
//                .foregroundColor(.gray)
            TextField("Nome do cliente", text: $nomeCliente)
//                .foregroundColor(.gray)
            
            Section(header: Text("Custos")
            ) {
//                NavigationLink {
//                    TelaGastos(vm: vm)
//               }
//               label: {
                HStack {
                   Text("Gastos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
               }
//                NavigationLink {
//                    TelaDespesas(vm: vm)
//                }
//                label: {
                HStack {
                    Text("Despesas")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
//                NavigationLink {
//                    TelaValorHdT(vm: vm, valor: vm.valorDaHora.last!.pretensaoSalarial, dias: Int(vm.valorDaHora.last!.dias), horasDiarias: Int(vm.valorDaHora.last!.horas))
//
//                }
//                label: {
                HStack {
                    Text("Valor hora de trabalho")
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
                    
//                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
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
                    if nomeOrcamento != "" && nomeCliente != "" && hora != 0 {
                        vm.atualizarOrcamento(entidade: entidade, nome: nomeOrcamento, nomeCliente: nomeCliente, tempoDeTrabalho: hora, lucro: lucro)
                        self.mode.wrappedValue.dismiss()
                    }
                }label:{
                    Text("Salvar")
                }
            }
        }
        .navigationBarTitle("Editar orçamento")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture(perform: vm.dismissKeyboard)
    }
}




//struct TelaEditarOrcamento_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaEditarOrcamento()
//    }
//}
