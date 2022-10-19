//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI
import CoreData

struct TelaOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
        
    var entidade: Orcamento
    
    let utilitarios = Utilitarios()
    
    @State var mostrarSheetCP = false
    
    var body: some View {
        List{
            HStack {
                Text("Nome do cliente")
                Spacer()
                Text(entidade.nomeDoCliente!)
            }
            Section(header: Text("Custos")
            ) {
                HStack {
                   Text("Custos fixos")
                    Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
               }
                HStack {
                    Text("Custos variáveis")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                HStack {
                    Text("Hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorDaHora!.valorFinal))
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoHora))
                }
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    Text("\(entidade.horasDeTrabalho) horas")
                }
                HStack {
                    Text("Custo Total")
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotal))
                        .bold()
                }
            }
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("\(entidade.lucro)%")
                }
            }
            HStack {
                Text("Valor total")
                    .bold()
                Spacer()
                Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorTotal))
                    .bold()
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                NavigationLink {
                    TelaEditarOrcamento(vm: vm, entidade: entidade, nomeOrcamento: entidade.nome!, nomeCliente: entidade.nomeDoCliente!, hora: Int(entidade.horasDeTrabalho), lucro: Int(entidade.lucro))
                } label: {
                    Text("Editar")
                }
            }
        }
        .navigationTitle(entidade.nome!)
        .navigationBarTitleDisplayMode(.large)
    }
}
