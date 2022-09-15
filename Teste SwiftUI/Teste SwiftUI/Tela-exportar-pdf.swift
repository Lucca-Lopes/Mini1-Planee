//
//  Tela-exportar-pdf.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 15/09/22.
//

import SwiftUI

struct Tela_exportar_pdf: View {
    
    @State var item: String = ""
    @State private var todosBotoes = false
    @State private var selecionartudo = false
    @State private var gastos = false
    @State private var despesas = false
    @State private var valordahora = false
    @State private var custoporhora = false
    @State private var tempoestimado = false
    @State private var custototal = false
    @State private var lucro = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
        List{
            Section{
            HStack {
                Toggle("Selecionar tudo", isOn: $todosBotoes )
            }
            }
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
                Button(action: {
                    //Criar a funcao de exportar pdf
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Enviar")
                })
            }
        }
        .navigationBarTitle("Informações a enviar")
        .navigationBarTitleDisplayMode(.inline)
    }
}
    func LigaTodosBotoes(){
        Toggle("Selecionar tudo", isOn: $todosBotoes)
    }

}

struct Tela_exportar_pdf_Previews: PreviewProvider {
    static var previews: some View {
        Tela_exportar_pdf()
    }
}
