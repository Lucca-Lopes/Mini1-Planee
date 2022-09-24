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
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", vm.calcularTotalGastos()))
               }
                NavigationLink {
                     TelaGastos(vm: vm)
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
                     TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))
                }
                label: {
                    Text("Valor hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.valorDaHora[0].valorFinal))
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.custoTotal))
                }
            }
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("\(vm.orcamentos.last!.lucro)%")
                }
            }
            HStack {
                Text("Valor total")
                Spacer()
                Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.valorTotal))
                    .bold()
            }
        }
        .sheet(isPresented: self.$mostrarSheetCP) {
            vm.PDFUrl = nil
        } content: {
            if let pdfUrl = vm.PDFUrl {
                SheetCompartilhar(urls: [pdfUrl])
            }
        }
        .navigationTitle(vm.orcamentos.last!.nome ?? "")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    exportarPDF {
                        self
                            .environmentObject(vm)
                    } completion: { status, url in
                        if let url = url,status {
                            vm.PDFUrl = url
                            mostrarSheetCP.toggle()
                        }
                        else {
                            print("Erro ao criar pdf")
                        }
                    }
                }label:{
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing)
            {
                NavigationLink {
                    TelaCriarOrcamento(vm: vm)
                } label: {
                    Text("Editar")
                }
            }
        }
    }
}
