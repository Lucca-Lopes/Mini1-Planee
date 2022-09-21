//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI
import CoreData

struct TelaDespesas: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var nome = ""
    @State var valor = 0.0
    @State var valorTotal = 0.0
    
//    let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
//    @State var preco: String = "R$ 82,90"
//    @State var nomeSeleionado: String = "Luz"
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.despesas) { despesaAtual in
                NavigationLink {
                    ItemDespesa(vm: vm, entidade: despesaAtual, nome: despesaAtual.nome ?? "Nova despesa", valor: despesaAtual.valor)
                }
                label: {
                    Text(despesaAtual.nome ?? "")
                        .lineLimit(1)
                    Spacer()
                    Text("R$\(despesaAtual.valor)")
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: vm.deletarDespesa)
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ \(vm.calcularTotalDespesa(despesasSelecionadas: vm.despesas))")
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
//    func salvarCD(){
//        do {
//            try viewContext.save()
//        } catch {
//            let error = error as NSError
//            fatalError("An error occured: \(error)")
//        }
//    }
//
//    func addDespesa(){
//
//        let despesa = Despesa(context: viewContext)
//        despesa.valor = 0.0
//
//        do {
//                    try viewContext.save()
//                } catch {
//                    let error = error as NSError
//                    fatalError("An error occured: \(error)")
//                }
//
//        print(despesa)
//    }
    
//}

//struct tela_despesas_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaDespesas()
//    }
//}
