//
//  tela-valor-HdT.swift
//  Teste SwiftUI
//
//  Created by Rodrigo Pereira on 09/09/22.
//

import SwiftUI

struct TelaValorHdT: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var valor: Double
    @State var dias: Int
    @State var horasDiarias: Int
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("")
                .frame(height: vm.screenHeight * 0.05)
            Text("Valor da Hora de Trabalho")
                .font(.system(size: 34, weight: .heavy))
                .frame(width: vm.screenWidth * 0.9, height: vm.screenHeight * 0.1, alignment: .leading)
            List{
                HStack{
                    Text("Pretensão salarial")
                    Spacer()
                    TextField("R$ 0,00", value: $valor, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Dias de trabalho")
                    Spacer()
                    TextField("0 dias", value: $dias, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Horas diárias")
                    Spacer()
                    TextField("0 horas", value: $horasDiarias, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
                
                Section(header: Text(""))
                {
                    HStack{
                        Text("Valor da hora de trabalho")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", vm.valorDaHora[0].valorFinal))
                    }
                }
            }
            .listStyle(.insetGrouped)
            .frame(width: vm.screenWidth, height: vm.screenHeight * 0.85, alignment: .center)
        }
        .background(Color(red: 0, green: 0, blue: 0.4, opacity: 0.0515))
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    vm.atualizarVdH(entidade: vm.valorDaHora[0], pretensaoSalarial: valor, dias: dias, horas: horasDiarias)
                    self.mode.wrappedValue.dismiss()
                }label:{
                    Text("Salvar")
                }
            }
        }
    }
}

//struct tela_valor_HdT_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaValorHdT()
//    }
//}
