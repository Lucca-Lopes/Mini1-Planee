//
//  TelaDespesasSelecionadas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 21/09/22.
//

import SwiftUI

struct TelaDespesasSelecionadas: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var entidade: Orcamento
    @State var despesasDisponiveis: [Despesa]
    @State var despesasSelecionadas: [Despesa] = []
    @State var toggles: [Bool]
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (despesasDisponiveis) { despesaAtual in
                NavigationLink {
                    ItemDespesa(vm: vm, entidade: despesaAtual, nome: despesaAtual.nome ?? "", valor: despesaAtual.valor)
                }
                label: {
                    // inserir toggle
                    ItemDespesaSelecionada(selecionado: DetectarBooleano(despesas: despesasDisponiveis, toggles: toggles, despesaAtual: despesaAtual), despesasSelecionadas: despesasSelecionadas, entidade: despesaAtual)
                }
            }
//            .onDelete(perform: vm.deletarDespesa)
            Section() {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.calcularTotalDespesa(despesasSelecionadas: despesasSelecionadas)))
                        .foregroundColor(.gray)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    entidade.despesas = despesasSelecionadas
                    vm.salvar()
                    
                    
//                    if editando {
//                        vm.salvar()
//                    }
//                    self.editando.toggle()
                    
                    
                }) {
                    Text("Salvar")
//                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button(action: vm.addDespesa) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Despesas")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
    
    func DetectarBooleano(despesas: [Despesa], toggles: [Bool], despesaAtual: Despesa) -> Bool{
        for i in 0...despesas.count {
            if despesas[i] == despesaAtual {
                return toggles[i]
            }
        }
        return toggles[0]
    }
    
}

//struct TelaDespesasSelecionadas_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaDespesasSelecionadas()
//    }
//}
