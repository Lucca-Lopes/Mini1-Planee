//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.
//
import CoreData
import SwiftUI

struct TelaInicialView: View {
    
    @State var text = ""
    
    var body: some View {
    
        NavigationView{
//            HStack{
//                Text("oi")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            .padding(.vertical,12)
//            .padding(.horizontal)
//
            VStack{
                NavigationLink
                {
                    ContentView()
                } label: {
                    Text("Criar orçamento")
                }.foregroundColor(Color.black)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .foregroundColor(Color.gray)
                            .strokeBorder(.gray)
                            .foregroundColor(Color.gray)
//                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.horizontal,-100)
                            .padding(.vertical,-20)
                        
                            
                            
                    }
            }
            
            
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
