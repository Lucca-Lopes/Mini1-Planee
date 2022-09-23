//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct TelaCriarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var entidade: Orcamento
    @State var nomeOrcamento: String = ""
    @State var nomeCliente: String = ""
    @State var hora: Int = 0
    @State var lucro: Int = 0
    
    let utilitarios = Utilitarios()
    
    init(vm: PlaneeViewModel){
        self.vm = vm
        self.entidade = vm.addOrcamento()
    }
    
    init(vm: PlaneeViewModel, entidade: Orcamento) {
        self.vm = vm
        self.entidade = entidade
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
//                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", entidade.custoTotal))
                }
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    TextField(
                        "00:00",
                        value: $hora,
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
                }
                HStack {
                    Text("Custo total")
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", entidade.custoTotal))
                        .bold()
//                        .foregroundColor(.gray)
                }
            }
            
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    TextField(
                        "0%",
                        value: $lucro,
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
                }
            }
            Section() {
                HStack {
                    Text("Valor total")
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", entidade.valorTotal))
                        .bold()
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    vm.atualizarOrcamento(entidade: entidade, nome: nomeOrcamento, nomeCliente: nomeCliente, totalGastos: vm.calcularTotalGastos(), totalDespesas: vm.calcularTotalDespesa(), custoPorHora: vm.valorDaHora.last!.valorFinal, tempoDeTrabalho: hora, custoTotal: 0.0, lucro: lucro)
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
