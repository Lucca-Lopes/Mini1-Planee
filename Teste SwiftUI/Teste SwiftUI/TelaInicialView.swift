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
    
    struct TodosBotoes: Identifiable {
        var id: UUID
        
        let name: String
    }
    
    let botoes: [TodosBotoes] = [
        TodosBotoes(id: UUID(), name: "Large Title"),
        TodosBotoes(id: UUID(), name: "Title"),
        TodosBotoes(id: UUID(), name: "Headline"),
        TodosBotoes(id: UUID(), name: "Body"),
    ]
    
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
//                        criaBotao(titulo: "Criar orçamento")
                        
                        NavigationLink {
                            ContentView()
                        }
                    label: {
                        Text("Criar Orçamento")
                            .foregroundColor(.black)
                            .bold()
                            .padding()

                    }
                    }
                    
                    Section{
                        
                        NavigationLink {
                            ContentView()
                        }
                    label: {
                        Text("Meus Orçamentos")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                        
                    }
                    }
                    
                    Section{
                        
                        NavigationLink {
                            ContentView()
                        }
                    label: {
                        Text("Calcular valor da hora")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                        
                    }
                    }
                    
                    Section{
                        
                        NavigationLink {
                            ContentView()
                        }
                    label: {
                        Text("Despesas")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                        
                    }
                    }
                    
                    Section{
                        NavigationLink {
                            ContentView()
                        }
                    label: {
                        Text("Gastos")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                    }
                    }
                }
            }
            .navigationTitle("Nome do app")
        }
        
    }

//    func criaBotao(titulo: String) {
//        NavigationLink {
//            switch titulo{
//            case "Criar orçamento":
//                ContentView()
//
//            case "Meus orçamentos":
//                ContentView()
//
//            case "Calcular o valor da hora":
//                ContentView()
//
//            case "Despesas":
//                ContentView()
//
//            case "Gastos":
//                ContentView()
//
//            default:
//                ContentView()
//            }
//        }
//        label: {
//            Text("Criar Orçamento")
//                .foregroundColor(.black)
//                .bold()
//            .padding()
//        }
//    }
}

//    RoundedRectangle(cornerRadius: 40, style: .continuous)
//        .foregroundColor(Color.gray)
//        .position(x: screenWidth * 0.5, y: screenHeight * 0.5)

//        NavigationView{
//            ZStack{
//                ForEach(botoes, id: \.name) { botoes in
//                    Text(botoes.name)
//                    NavigationLink(destination: ContentView()) {
//                        Image(systemName: "info.circle")
//                        Text("Texto")
//                Text(" Valor da hora de trabalho:")
//                   .bold()
//                   .font(.system(size: 20))
//                   .position(x: screenWidth * 0.33, y: screenHeight * 0.025)
//               Text("R$20,13")
//                   .bold()
//                   .font(.system(size: 25))
//
//                   .position(x: screenWidth * 0.16, y: screenHeight * 0.06)
//
//
//





//        }

//
//        }
//    }

//struct TelaInicialView_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaInicialView(teste: ContentView())
//    }
//}

