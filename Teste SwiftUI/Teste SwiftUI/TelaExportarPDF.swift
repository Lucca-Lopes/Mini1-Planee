//
//  TelaExportarPDF.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

struct TelaExportarPDF: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var gastos = false
    @State var despesas = false
    @State var valorDaHora = false
    
    @State var mostrarSheetCP = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List {
                Section(){
                    Toggle("Gastos", isOn: $gastos)
                    Toggle("Despesas", isOn: $despesas)
                    Toggle("Gastos", isOn: $valorDaHora)
                }
                .listStyle(.grouped)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            exportarPDF {
                                self.environmentObject(vm)
                            } completion: { status, url in
                                if let url = url, status {
                                    vm.PDFUrl = url
                                    mostrarSheetCP.toggle()
                                }
                                else {
                                    print("Falha ao produzir o PDF")
                                }
                            }
                        } label: {
                            Text("Enviar")
                        }
                    }
//                    if let gastos = vm.gastos {
//                        if gastos.isEmpty {
//
//                        }
//                    }
                    
                }
                .sheet(isPresented: $mostrarSheetCP) {
                    vm.PDFUrl = nil
                } content: {
                    if let pdfUrl = vm.PDFUrl {
                        SheetCompartilhar(urls: [pdfUrl])
                    }
                }
            }
        }
    }
}

struct SheetCompartilhar: UIViewControllerRepresentable {
    
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controlador = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controlador
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
}




//struct TelaExportarPDF_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaExportarPDF()
//    }
//}
