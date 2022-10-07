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
                       .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.03, alignment: .leading)
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
                       .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.03, alignment: .trailing)
               }
                NavigationLink {
                     TelaDespesas(vm: vm)
                }
                label: {
                    Text("Despesas")
                        .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.03, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                        .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.03, alignment: .trailing)
                }
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                     TelaValorHdT(vm: vm)
                }
                label: {
                    Text("Valor hora de trabalho")
                        .frame(width: vm.screenWidth * 0.3, height: vm.screenHeight * 0.08, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora[0].valorFinal))
                        .frame(width: vm.screenWidth * 0.45, height: vm.screenHeight * 0.08, alignment: .trailing)
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
        .navigationTitle(entidade.nome!)
        .navigationBarTitleDisplayMode(.large)
    }
}
//        .sheet(isPresented: self.$mostrarSheetCP) {
//            vm.PDFUrl = nil
//        } content: {
//            if let pdfUrl = vm.PDFUrl {
//                SheetCompartilhar(urls: [pdfUrl])
//            }
//        }
        
//        .toolbar{
//            ToolbarItem(placement: .navigationBarTrailing)
//            {
//                Button{
//                    exportarPDF {
//                        self
//                            .environmentObject(vm)
//                    } completion: { status, url in
//                        if let url = url,status {
//                            vm.PDFUrl = url
//                            mostrarSheetCP.toggle()
//                        }
//                        else {
//                            print("Erro ao criar pdf")
//                        }
//                    }
//                }label:{
//                    Image(systemName: "square.and.arrow.up")
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing)
//            {
//                NavigationLink {
//                    TelaCriarOrcamento(vm: vm)
//                } label: {
//                    Text("Editar")
//                }
//            }
//        }
   
