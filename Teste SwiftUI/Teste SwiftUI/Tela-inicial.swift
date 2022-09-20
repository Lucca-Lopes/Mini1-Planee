//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.
//
import CoreData
import SwiftUI
import Accessibility

struct TelaInicialView: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let utilitarios = Utilitarios()
    
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Valor da hora de trabalho:")
                    .bold()
                    .padding()
                    .frame(width: screenWidth * 0.99, height: screenHeight * 0.05, alignment: .leading)
                
                Text("R$ 20,13")
                    .bold()
                    .font(.system(size: 20))
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.0, alignment: .leading)
                
                Text("")
                    .frame(height: screenHeight * 0.05)
                    .accessibilityHidden(true)
                
                Form{
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Criar orçamento")
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Botão Criar Orçamento")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Meus orçamentos")
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Botão Meus Orçamentos")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Calcular valor da hora")
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Botão Calcular valor da hora")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Despesas")
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Botão Despesas")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Gastos")
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Botão Gastos")
                    }
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Planee")
        }
    }
}
