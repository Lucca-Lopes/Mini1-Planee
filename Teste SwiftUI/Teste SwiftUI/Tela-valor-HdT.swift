//
//  tela-valor-HdT.swift
//  Teste SwiftUI
//
//  Created by Rodrigo Pereira on 09/09/22.
//

import SwiftUI

struct TelaValorHdT: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var valor: String = ""
    @State var dias: String = ""
    @State var horasDiarias: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var nameTextField: UITextField!
    
    var body: some View {
        VStack {
            Text("")
                .frame(height: screenHeight * 0.05)
            Text("Valor da Hora de Trabalho")
                .font(.system(size: 34, weight: .heavy))
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.1, alignment: .leading)
            List{
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
        .background(Color(red: 0, green: 0, blue: 0.4, opacity: 0.0515))
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
//                    self.mode.wrappedValue.dismiss()
                    do {
                        try viewContext.save()
                        print("Salvou")
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                   
                }label:{
                    Text("Salvar")
                }
            }
        }
    }
}

struct tela_valor_HdT_Previews: PreviewProvider {
    static var previews: some View {
        TelaValorHdT()
    }
}
