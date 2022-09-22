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
    @State var hora: String = ""
    @State var lucro: Int = 0
    
    
    let utilitarios = Utilitarios()
    
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
//                   Text("R$ " + String(format: "%.2f", vm.calcularTotalGastos(gastosSelecionados: entidade.gastos)))
                   Text("R$ 1250,00")
               }
                NavigationLink {
                     TelaDespesasSelecionadas(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ 980,00")
//                    Text("R$ " + String(format: "%.2f", vm.calcularTotalGastos(gastosSelecionados: entidade.gastos)))
//                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                     TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))
                }
                label: {
                    Text("Valor hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.valorDaHora[0].valorFinal))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ 16,00")
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
                    Text("R$ 200,00")
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
                    Text("R$ 2000,00")
                        .bold()
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    vm.addOrcamento(nome: nomeOrcamento, nomeCliente: nomeCliente, totalGastos: 0.0, totalDespesas: 0.0, custoPorHora: vm.valorDaHora[0].valorFinal, tempoDeTrabalho: hora, custoTotal: 0.0, lucro: lucro, valorTotal: 0.0)
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
