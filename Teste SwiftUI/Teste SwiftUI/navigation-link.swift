//
//  navigation-link.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 02/09/22.
//

import SwiftUI

public class Utilitarios {
    
    func criaNavigationLink(textoPrincipal: String, textoSecundario: String, destino: AnyView) {
        NavigationLink {
            destino
        }
        label: {
            Text(textoPrincipal)
                .lineLimit(1)
            Spacer()
            Text(textoSecundario)
                .foregroundColor(.gray)
        }
//        return navigationLink
    }
}
 
