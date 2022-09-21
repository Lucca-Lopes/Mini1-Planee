//
//  ContentView.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI
import CoreData

struct TelaMeusOrcamentos: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    @State var selection = Set<String>()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.ordem, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    var body: some View {
        List {
            ForEach(items) { item in
                if editando {
                    HStack {
                        Text("Orçamento \(item.ordem)")
                            .lineLimit(1)
                        Spacer()
                        Text("R$\(item.ordem*150)")
                            .foregroundColor(.gray)
                    }
                }
                else {
                    NavigationLink {
                        TelaOrcamento(vm: vm)
                    }
                label: {
                    Text("Orçamento \(item.ordem)")
                        .lineLimit(1)
                    Spacer()
                    Text("R$\(item.ordem*150)")
                        .foregroundColor(.gray)
                }
                }
            }
            .onMove(perform: moverItem)
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.editando.toggle()
                    
                }) {
                    Text(editando ? "Ok" :
                            "Editar")
                }
            }
            ToolbarItem {
                NavigationLink {
                    TelaCriarOrcamento(vm: vm)
                }
            label: {
                Label("Add Item", systemImage: "plus")
            }
//                Button(action: ) {
//                    Label("Add Item", systemImage: "plus")
//                }
            }
        }
        .navigationTitle("Meus Orçamentos")
        .navigationBarTitleDisplayMode(.large)
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//            newItem.ordem = (items.last?.ordem ?? 0) + 1
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
    private func moverItem(at sets: IndexSet, destination: Int){
        let itemMovido = sets.first!
        
        if itemMovido < destination {
            var indexInicial = itemMovido + 1
            let indexFinal = destination - 1
            var ordemInicial = items[itemMovido].ordem
            while indexInicial <= indexFinal {
                items[indexInicial].ordem = ordemInicial
                ordemInicial += 1
                indexInicial += 1
            }
            items[itemMovido].ordem = ordemInicial
        }
        else if itemMovido > destination {
            var indexInicial = destination
            let indexFinal = itemMovido - 1
            var ordemInicial = items[indexInicial].ordem + 1
            let novaOrdem = items[indexInicial].ordem
            while indexInicial <= indexFinal {
                items[indexInicial].ordem = ordemInicial
                ordemInicial += 1
                indexInicial += 1
            }
            items[itemMovido].ordem = novaOrdem
        }
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
//
//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaMeusOrcamentos()
//    }
//}
//#endif
