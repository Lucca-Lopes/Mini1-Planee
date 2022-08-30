//
//  ContentView.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
//    @State var editando = false
//    @State var selection = Set<String>()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.ordem, ascending: true)],
        animation: .default)
    
//    @Environment(\.editMode) private var editMode: Binding<EditMode>? {
//        get {
//            return self
//        }
//        set {
//
//        }
//    }
    
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
//                navigationTitle("Ola")
//                    .font(.system(size: 32))
//                    .offset(y: 25)
//                .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text("Orçamento \(item.ordem+1)")
                            .lineLimit(1)
//                            .padding()
                        Spacer()
//                            .frame(minWidth: 10, idealWidth: 100, maxWidth: 300, minHeight: 10, idealHeight: 10, maxHeight: 10, alignment: .center)
//                            .padding()
                        Text("R$\(Int.random(in: 2000 ... 10000))")
                            .foregroundColor(.gray)
//                            .padding(.leading, 190)
//                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onMove(perform: moverItem)
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        EditButton()
                    } label: {
                        Text(EditMode == EditMode.a ? "Ok" : "Editar")
                        Text("Alguma coisa")
                    }
                    
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
//            Text("Select an item")
            .navigationTitle(Text("Meus Orçamentos"))
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.ordem = (items.last?.ordem ?? 0) + 1

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
    
//extension EditMode {
//    mutating func toggle() {
//            self = self == .active ? .inactive : .active
//    }
//}
