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
    @State var hora: Int = 0
    @State var lucro: Int = 0
//    @State var custoTotal: Double
        
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        List{
            TextField(entidade.nome!, text: $nomeOrcamento)
                .foregroundColor(.gray)
            TextField(entidade.nomeDoCliente!, text: $nomeCliente)
                .foregroundColor(.gray)
            
            Section(header: Text("Custos")
            ) {
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalGastos()))
               }
                NavigationLink {
                    TelaDespesas(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalDespesa()))
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                    TelaValorHdT(vm: vm, valor: vm.valorDaHora.last!.pretensaoSalarial, dias: Int(vm.valorDaHora.last!.dias), horasDiarias: Int(vm.valorDaHora.last!.horas))
                        
                }
                label: {
                    Text("Valor hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora.last!.valorFinal))
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
                        "\(entidade.horasDeTrabalho)",
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
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), (vm.calcularTotalGastos() + vm.calcularTotalDespesa())))
                        .bold()
                }
            }
            
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    TextField(
                        "\(entidade.lucro)",
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
//        .onTapGesture{
//            self.dismissKeyboard()
//        }
    }
}




//struct TelaEditarOrcamento_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaEditarOrcamento()
//    }
//}
