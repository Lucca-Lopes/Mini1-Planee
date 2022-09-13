//
//  Tela_Gastos.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 06/09/22.
//

import SwiftUI

struct TelaGastos: View {
    
    @State var editando = false
    @State var mostrarSheet = false
    
    let utilitarios = Utilitarios()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        List{
            Section(header: Text("Computador")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 10.250,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "43 meses", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 238,37", destino: "tela_criar_orcamento")
            }
            
            Section(header: Text("Calculadora")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 150,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "80 meses", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 1,86", destino: "tela_criar_orcamento")
                
            }
            Section(header: Text("")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 240,73", destino: "tela_criar_orcamento")
                
            }
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
                    mostrarSheet = true
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                .sheet(isPresented: $mostrarSheet){
                    SheetView()
                }
            }
        }
        .navigationTitle("Gastos")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

struct Tela_Gastos_Previews: PreviewProvider {
    static var previews: some View {
        TelaGastos()
    }
}

struct SheetView: View {
    
    @State var editando = false
    @State var mostrarTelaGastos = TelaGastos()
    @State var item: String = ""
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let transition = AnyTransition.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity)
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View{
        NavigationView{
            List{
                HStack {
                    Text("Título")
                    Spacer()
                    TextField(
                        "Nome",
                        text: $item
                    )
                    .fixedSize()
                }
                HStack{
                    Text("Valor total")
                    Spacer()
                    TextField("Valor", text: $item)
                        .foregroundColor(.gray)
                        .fixedSize()
                }
                HStack{
                    Text("Vida útil")
                    Spacer()
                    TextField("Tempo", text: $item)
                        .foregroundColor(.gray)
                        .fixedSize()
                }
            }
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("OK")
                    })
                }
            }
            .navigationBarTitle("Adicionar gasto")
            .navigationBarTitleDisplayMode(.inline)
            //                .frame(width: screenWidth, height: screenHeight * 0.9, alignment: .center)
        }
    }
}
