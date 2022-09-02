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
    
    @State var text = ""
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    var body: some View {
    
        NavigationView{
            ZStack {
                Text("Valor da hora de trabalho:")
                    .bold()
                    .font(.system(size: 20))
                    .position(x: screenWidth * 0.33, y: screenHeight * 0.025)
                Text("R$20,13")
                    .bold()
                    .font(.system(size: 25))
                    
                    .position(x: screenWidth * 0.16, y: screenHeight * 0.06)
                
                
//            label: do {
//                    Text("Oiiiiiiiii")
//                    .position(x: screenWidth * 0.28, y: screenHeight * 0.03)
//                }
//                ("Valor da hora de trabalho:\nR$13,13", systemImage: "")
//                    .position(x: screenWidth * 0.28, y: screenHeight * 0.03)
                    
//                    .frame(width: screenWidth * 0.28, height: screenHeight * 0.03, alignment: .trailing)
//                Label("R$ 13,13", systemImage: "")
//                    .position(x: screenWidth * 0.12, y: screenHeight * 0.06)
                    
                    
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .foregroundColor(Color.gray)
                    .position(x: screenWidth * 0.5, y: screenHeight * 0.5)
                
                NavigationLink
                {
                    ContentView()
                } label: {
                    Text("Criar orçamento")
                        .bold()
                        .font(.system(size: 25))
                        .position(x: screenWidth * 0.5, y: screenHeight * 0.2)
                        .foregroundColor(.yellow)
//                        
                }
                
                    
            }
            
        
//            HStack{
//                Text("oi")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            .padding(.vertical,12)
//            .padding(.horizontal)
//
//            VStack{
//                List{
//            ZStack {
//                HStack {
//                  Text("Row height")
//                  Slider(value: $rowHeight, in: 40.0...80.0)
//                }
//                HStack {
//                  Text("Header height")
//                  Slider(value: $headerHeight, in: 60.0...80.0)
//                }
//                List(1..<6) { section in
//                  Section() {
//                    ForEach(1..<2) { row in
//                      Text("Criar Orçamento")
//                    }
//                  }
//                }
//              }
////                    listStyle(.plain)
//                    NavigationLink
//                    {
//                        ContentView()
//                    } label: {
//
////                        Text("Criar orçamento")
//
//                    }
//                }
//                .frame(width: 400, height: 50, alignment: .center)
//                
//                List{
//                    NavigationLink
//                    {
//                        ContentView()
//                    } label: {
//                        Text("Criar orçamento")
//                            .bold()
//                    }
//                }
//                .frame(width: 400, height: 100, alignment: .center)
//            }
//                Spacer()
                
//            }
//                .foregroundColor(Color.black)
//                    .background {
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
////                            .foregroundColor(Color.gray)
//                            .strokeBorder(.gray)
//                            .foregroundColor(Color.gray)
//                            .background(.purple)
//                            .cornerRadius(10)
//                            .padding(.horizontal,-100)
//                            .padding(.vertical,-20)
//
//
//
//                    }
//            }
            
            
//            Text("Valor da hora de trabalho:")
//                .frame(width:, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
            
            .navigationTitle("Nome do app")
            }
        }
       
    



struct TelaInicialView_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicialView()
    }
}
    }

