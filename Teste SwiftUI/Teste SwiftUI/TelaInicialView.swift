//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.
//
import CoreData
import SwiftUI

struct TelaInicialView: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    var body: some View {
        NavigationView{
            VStack {
        
                Text("Valor da hora de trabalho:")
                    .bold()
                    .padding()
                //                    .frame(width: screenWidth * 0.75, height: screenHeight * 0.05)
                //                    .position(x: screenWidth * 0.3, y: screenHeight * 0.03)
                
                Text("R$ 20,13")
                    .bold()
                //                .padding()
                //                    .bold()
                //                    .frame(width: screenWidth * 0.75, height: screenHeight * 0.05)
                
                //                    .position(x: screenWidth * 0.3, y: screenHeight * 0.02)
                
                Form{
                    
                    Section{
                        criaBotao(titulo: "Criar orçamento")
                    }
                    
                    Section{
                      criaBotao(titulo: "Meus orçamentos")
                    }
                    
                    Section{
                        criaBotao(titulo: "Calcular valor da hora")
                    }
                    
                    Section{
                        criaBotao(titulo: "Despesas")
                    }
                    
                    Section{
                        criaBotao(titulo: "Gastos")
                    }
                }
                .cornerRadius(40)
            }
            .navigationTitle("Nome do app")
        }
        
    }

    func criaBotao(titulo: String) -> some View{
        let destino = NavigationLink {
            switch titulo{
            case "Criar orçamento":
                ContentView()

            case "Meus orçamentos":
                ContentView()

            case "Calcular o valor da hora":
                ContentView()

            case "Despesas":
                ContentView()

            case "Gastos":
                ContentView()

            default:
                ContentView()
            }
        }
        label: {
            Text("Criar Orçamento")
                .foregroundColor(.black)
                .bold()
            .padding()
        }
        return destino
    }
}

//    RoundedRectangle(cornerRadius: 40, style: .continuous)
//        .foregroundColor(Color.gray)
//        .position(x: screenWidth * 0.5, y: screenHeight * 0.5)

//struct TelaInicialView_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaInicialView(teste: ContentView())
//    }
//}

