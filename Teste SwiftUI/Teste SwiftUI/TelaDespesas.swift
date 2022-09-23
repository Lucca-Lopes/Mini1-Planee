//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI

struct TelaDespesas: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var nome = ""
    @State var valor = 0.0
    @State var valorTotal = 0.0
    @State var mostrarCriarDespesa = false    
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.despesas) { despesaAtual in
                NavigationLink {
                    EditarDespesa(vm: vm, entidade: despesaAtual, nome: despesaAtual.nome ?? "", valor: despesaAtual.valor)
                }
                label: {
                    Text(despesaAtual.nome ?? "")
                        .lineLimit(1)
                    Spacer()
                    Text("R$ " + String(format: "%.2f", despesaAtual.valor))
                }
//                .sheet(isPresented: $mostrarCriarDespesa){
//                    EditarDespesa(vm: vm, entidade: despesaAtual, nome: despesaAtual.nome ?? "", valor: despesaAtual.valor)
//                }
            }
            .onDelete(perform: vm.deletarDespesa)
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.calcularTotalDespesa()))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if editando {
                        vm.salvar()
                    }
                    self.editando.toggle()
                }) {
                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button {
                    mostrarCriarDespesa = true
                } label: {
                    Label("", systemImage: "plus")
                }
                .sheet(isPresented: $mostrarCriarDespesa){
                    CriarDespesa(vm: vm, nome: "", valor: 0.0)
            }
            }
        }
        .navigationTitle("Despesas")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

//struct tela_despesas_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaDespesas()
//    }
//}
