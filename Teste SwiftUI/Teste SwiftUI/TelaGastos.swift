//
//  Tela_Gastos.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 06/09/22.
//

import SwiftUI

struct TelaGastos: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    @State var mostrarSheet = false
    
    let utilitarios = Utilitarios()
    
    
    var body: some View {
        List{
            ForEach (vm.gastos) { gastoAtual in
                Section(header:
                            NavigationLink {
                    SheetView(vm: vm, entidade: gastoAtual)
                }
                        label: {
                    Text(gastoAtual.nome ?? "")
                        .lineLimit(1)
                    
                }
                ) {
                    HStack {
                        Text("Valor total")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", gastoAtual.valor))
                    }
                    HStack {
                        Text("Vida útil")
                        Spacer()
                        Text("\(gastoAtual.vidaUtil) meses")
                    }
                    HStack {
                        Text("Custo mensal")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", gastoAtual.custo))
                    }
                }
            
            }
            .onDelete(perform: vm.deletarGasto)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.editando.toggle()
                }) {
                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button(action: {
                    vm.addGasto()
                    mostrarSheet = true
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                .sheet(isPresented: $mostrarSheet){
                    SheetView(vm: vm, entidade: vm.gastos.last!)
                }
            }
        }
        .navigationTitle("Gastos")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

//struct Tela_Gastos_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaGastos(vm: vm)
//    }
//}

