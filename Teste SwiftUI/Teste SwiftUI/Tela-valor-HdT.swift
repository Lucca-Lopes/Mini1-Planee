//
//  tela-valor-HdT.swift
//  Teste SwiftUI
//
//  Created by Rodrigo Pereira on 09/09/22.
//

import SwiftUI
import CoreData

struct TelaValorHdT: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var valor: Double = 0.0
    @State var dias: Int = 0
    @State var horasDiarias: Int = 0
    @State var valorFinal: Double = 0.0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: ValorHoraDeTrabalho.entity(), sortDescriptors: [])
    var VdT: FetchedResults<ValorHoraDeTrabalho>
    
//    @FetchRequest(entity: Orcamento.entity(), sortDescriptors: [])
//    var Orcamento: FetchedResults<Orcamento>
    
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
                    TextField("R$2.400,00", value: $valor, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Dias de trabalho")
                    Spacer()
                    TextField("20 dias", value: $dias, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Horas diárias")
                    Spacer()
                    TextField("5h", value: $horasDiarias, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                
                Section(header: Text(""))
                {
                    HStack{
                        Text("Valor da hora de trabalho:")
                        Spacer()
                        Text("R$ \(valorFinal)")
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
                    salvarHdT()
                }label:{
                    Text("Salvar")
                }
            }
        }
    }
    
    func salvarHdT(){
        
        valorFinal = (valor / Double(dias)) / Double(horasDiarias)
        
        let valorDaHora = ValorHoraDeTrabalho(context: viewContext)
        valorDaHora.pretensaoSalarial = valor
        valorDaHora.dias = Int64(dias)
        valorDaHora.horas = Int64(horasDiarias)
        valorDaHora.valorFinal = valorFinal
            
        do {
                    try viewContext.save()
                } catch {
                    let error = error as NSError
                    fatalError("An error occured: \(error)")
                }

        print(valorDaHora)
    }
    
}

struct tela_valor_HdT_Previews: PreviewProvider {
    static var previews: some View {
        TelaValorHdT()
    }
}
