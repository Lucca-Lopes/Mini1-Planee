//
//  Tela-exportar-pdf.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 15/09/22.
//

import SwiftUI

struct Tela_exportar_pdf: View {
    
    @State var item: String = ""
    
    @State private var todosBotoes = false {
        didSet {
            LigaTodosBotoes()
        }
    }
    
//    @State var nomes: [String] = ["Gastos", "Despesas" "Valor da hora de trabalho", "Custos por hora", "Tempo estimado de trabalho", "Custo total", "Lucro"]
    
//    @State var botoes: [String: Bool] = ["Gastos" : false, "Despesas" : false, "Valor da hora de trabalho" : false, "Custos por hora" : false, "Tempo estimado de trabalho" : false, "Custo total" : false, "Lucro" : false]

    @State var botoes: [Bool] = [false, false, false, false, false, false, false, false]
    
    @State private var selecionartudo = false
    @State private var gastos = false
    @State private var despesas = false
    @State private var valordahora = false
    @State private var custoporhora = false
    @State private var tempoestimado = false
    @State private var custototal = false
    @State private var lucro = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    //Propriedades PDf
    @State var PDFUrl: URL?
    @State var mostraSheetCp: Bool = false
    
    var body: some View {
        NavigationView{
        List{
            Section{
                HStack {
                    Toggle("Selecionar tudo", isOn: $todosBotoes)
                        .onTapGesture {
                            if todosBotoes != true {
                                LigaTodosBotoes()
                            }
                        }
                }
            }
            
//            ForEach(nomes) { nome in
//                HStack{
//                    Toggle("Gastos", isOn: botoes[nome.index])
//                }
//            }
            
            HStack{
//                Toggle("Gastos", isOn: $todosBotoes )
                Toggle("Gastos", isOn: $gastos )
            }
            HStack{
//                Toggle("Despesas", isOn: $todosBotoes )
                Toggle("Despesas", isOn: $despesas )
            }
            HStack{
//                Toggle("Valor da hora de trabalho", isOn: $todosBotoes )
                Toggle("Valor da hora de trabalho", isOn: $valordahora )
            }
            HStack{
//                Toggle("Custo por hora", isOn: $todosBotoes )
                Toggle("Custo por hora", isOn: $custoporhora )
            }
            HStack{
//                Toggle("Tempo estimado de trabalho", isOn: $todosBotoes )
                Toggle("Tempo estimado de trabalho", isOn: $tempoestimado )
            }
            HStack{
//                Toggle("Custo total", isOn: $todosBotoes )
                Toggle("Custo total", isOn: $custototal )
            }
            HStack{
//                Toggle("Lucro", isOn: $todosBotoes )
                Toggle("Lucro", isOn: $lucro )
            }
        }
            
        .listStyle(.grouped)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    exportarPDF {
//                        self.environmentObject(gastos)
                    } completion: { status, url in
                        if let url = url,status{
                            self.PDFUrl = url
                            self.mostraSheetCp.toggle()
                        }
                        else{
                            print("Falha para produzir o PDF")
                        }
                    }
//                        .environmentObject()
                    //Criar a funcao de exportar pdf
//                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
//                    Text("Enviar")
                    
                }
            }
        }
        .navigationBarTitle("Informações a enviar")
        .navigationBarTitleDisplayMode(.inline)
    }
        .sheet(isPresented: $mostraSheetCp){
            PDFUrl = nil
        } content: {
            if let PDFUrl = PDFUrl {
                SheetCompartilhada(urls: [PDFUrl])
            }
        }
}
    func LigaTodosBotoes(){
        gastos = true
        despesas = true
        valordahora = true
        custoporhora = true
        tempoestimado = true
        custototal = true
        lucro = true
    }
}

struct Tela_exportar_pdf_Previews: PreviewProvider {
    static var previews: some View {
        Tela_exportar_pdf()
    }
}

struct SheetCompartilhada: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let controlador = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controlador
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    var urls: [Any]
    
}

