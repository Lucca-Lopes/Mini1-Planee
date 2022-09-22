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
    
//    let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.despesas) { despesaAtual in
                NavigationLink {
                    ItemDespesa(vm: vm, entidade: despesaAtual, nome: despesaAtual.nome ?? "", valor: despesaAtual.valor)
                }
                label: {
                    Text(despesaAtual.nome ?? "")
                        .lineLimit(1)
                    Spacer()
                    Text("R$ " + String(format: "%.2f", despesaAtual.valor))
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: vm.deletarDespesa)
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.calcularTotalDespesa(despesasSelecionadas: vm.despesas)))
                        .foregroundColor(.gray)
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
                Button(action: vm.addDespesa) {
                    Label("Add Item", systemImage: "plus")
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
