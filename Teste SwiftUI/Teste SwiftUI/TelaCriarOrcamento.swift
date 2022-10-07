//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

//extension View{
//    func dismissKeyboard(){
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}

struct TelaCriarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
//    @State var entidade: Orcamento
    @State var nomeOrcamento: String = ""
    @State var nomeCliente: String = ""
    @State var hora: Int = 0
    @State var lucro: Int = 0
//    @State var custoTotal: Double
    
    let utilitarios = Utilitarios()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
//    private enum Field: Int {
//        case titulo, nomeCliente, tempoTrabalho, lucro
//    }
//
//    @FocusState private var focusedField: Field?
    
    var body: some View {
        List{
            TextField("Titulo", text: $nomeOrcamento)
//                .focused($focusedField, equals: .titulo)
            TextField("Nome do cliente", text: $nomeCliente)
//                .focused($focusedField, equals: .nomeCliente)
            
            Section(header: Text("Custos")
            ) {
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                       .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.03, alignment: .leading)
                   Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalGastos()))
                       .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.03, alignment: .trailing)
               }
                NavigationLink {
                    TelaDespesas(vm: vm)
                }
                label: {
                    Text("Despesas")
                        .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.03, alignment: .leading)
//                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalDespesa()))
                        .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.03, alignment: .trailing)
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                    TelaValorHdT(vm: vm, valor: vm.valorDaHora.last!.pretensaoSalarial, dias: Int(vm.valorDaHora.last!.dias), horasDiarias: Int(vm.valorDaHora.last!.horas))
                        
                }
                label: {
                    Text("Valor hora de trabalho")
                        .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.1, alignment: .leading)
//                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora.last!.valorFinal))
                        .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.1, alignment: .trailing)
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
//                    .focused($focusedField, equals: .tempoTrabalho)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.2, height: vm.screenHeight * 0.03, alignment: .trailing)
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
//                    .focused($focusedField, equals: .lucro)
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
//            ToolbarItem(placement: .keyboard) {
//                Button(action: {
//                    focusedField = nil
//                }, label: {
//                    Image(systemName: "keyboard.chevron.compact.down")
//                })
//            }
            
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    print(hora)
                    if nomeOrcamento != "" && nomeCliente != "" && hora != 0 {
                        vm.addOrcamento(nome: nomeOrcamento, nomeCliente: nomeCliente, totalGastos: vm.calcularTotalGastos(), totalDespesas: vm.calcularTotalDespesa(), valorDaHora: vm.valorDaHora.last!, tempoDeTrabalho: hora, lucro: lucro)
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }label:{
                    Text("Adicionar")
                }
            }
        }
        .navigationBarTitle("Novo orçamento")
        .navigationBarTitleDisplayMode(.inline)
//        .onTapGesture{
//            self.dismissKeyboard()
//        }
    }
}
//struct tela_criar_orcamento_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaCriarOrcamento()
//        
//    }
//}
