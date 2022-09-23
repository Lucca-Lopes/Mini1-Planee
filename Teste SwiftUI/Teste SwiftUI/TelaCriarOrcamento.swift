//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct TelaCriarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
//    @State var entidade: Orcamento
    @State var nomeOrcamento: String = ""
    @State var nomeCliente: String = ""
    @State var hora: Int = 0
    @State var lucro: Int = 0
    @State var totalGastos: Double = 0.0
    @State var totalDespesas: Double = 0.0
//    @State var custoTotal: Double
    
    let utilitarios = Utilitarios()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(vm: PlaneeViewModel){
        self.vm = vm
        self.totalGastos = vm.calcularTotalGastos()
        self.totalDespesas = vm.calcularTotalDespesa()
    }

    
    var body: some View {
        List{
            TextField("Titulo", text: $nomeOrcamento)
            TextField("Nome do cliente", text: $nomeCliente)
            
            Section(header: Text("Custos")
            ) {
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", vm.calcularTotalGastos()))
               }
                NavigationLink {
                    TelaDespesas(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.calcularTotalDespesa()))
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
                    Text("R$ " + String(format: "%.2f", vm.valorDaHora.last!.valorFinal))
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
                        "00:00",
                        value: $hora,
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
                }
                HStack {
                    Text("Custo total")
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", (totalGastos + totalDespesas)))
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
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
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
                    if nomeOrcamento != "" && nomeCliente != "" && hora != 0 {
                        vm.addOrcamento(nome: nomeOrcamento, nomeCliente: nomeCliente, totalGastos: totalGastos, totalDespesas: totalDespesas, valorDaHora: vm.valorDaHora.last!, tempoDeTrabalho: hora, lucro: lucro)
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }label:{
                    Text("Adicionar")
                }
            }
        }
        .navigationBarTitle("Novo orçamento")
        .navigationBarTitleDisplayMode(.inline)
        //            .fixedSize()
        //            .frame(width: screenWidth, height: screenHeight, alignment: .center)
        //        }
    }
}

//struct tela_criar_orcamento_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaCriarOrcamento()
//        
//    }
//}
