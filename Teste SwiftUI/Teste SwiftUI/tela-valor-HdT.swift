//
//  tela-valor-HdT.swift
//  Teste SwiftUI
//
//  Created by Rodrigo Pereira on 09/09/22.
//

import SwiftUI

struct tela_valor_HdT: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var valor: String = ""
    @State var dias: String = ""
    @State var horasDiarias: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Valor da Hora de Trabalho")
                    .font(.system(size: 34, weight: .heavy))
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.1, alignment: .topLeading)
                List{
                    Section(header: Text("")){
                        HStack{
                            Text("Pretensão salarial")
                            Spacer()
                            TextField("R$2.400,00", text: $valor)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Dias de trabalho")
                            Spacer()
                            TextField("20 dias", text: $dias)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Horas diárias")
                            Spacer()
                            TextField("5h", text: $horasDiarias)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Section(header: Text(""))
                    {
                        HStack{
                            Text("Valor da hora de trabalho:")
                            Spacer()
                            Text("R$24,00")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .frame(width: screenWidth, height: screenHeight * 0.85, alignment: .center)
                
            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Valor da Hora de Trabalho").font(.headline)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
//            }
            
//            .navigationTitle("Valor da Hora de Trabalho")
    
//            .frame(width: screenWidth, height: screenHeight * 0.75, alignment: .center)
        }
    }
}

struct tela_valor_HdT_Previews: PreviewProvider {
    static var previews: some View {
        tela_valor_HdT()
    }
}
