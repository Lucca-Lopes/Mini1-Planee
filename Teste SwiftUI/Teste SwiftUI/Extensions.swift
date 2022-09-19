//
//  Extensions.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 19/09/22.
//

import SwiftUI

extension View{
    
    func converterParaView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView{
        
        let scrollView = UIScrollView()
        
        let controladorDeHospedagem = UIHostingController(rootView: content()).view!
        controladorDeHospedagem.translatesAutoresizingMaskIntoConstraints = false
        
        let contraints = [
            
            controladorDeHospedagem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            controladorDeHospedagem.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            controladorDeHospedagem.topAnchor.constraint(equalTo: scrollView.topAnchor),
            controladorDeHospedagem.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        scrollView.addSubview(controladorDeHospedagem)
        scrollView.addConstraints(contraints)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    func exportarPDF<Content: View>(@ViewBuilder content: @escaping ()->Content,completion: @escaping(Bool,URL?)->()){
        

        
    
        let documentoDiretorio = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

        let resultadoFileUrl = documentoDiretorio.appendingPathComponent("NOMEDOSEUPDF\(UUID().uuidString).pdf")


//        ele criou um let size para convertera scrollview dele
        let pdfView = converterParaView {
          TelaInicialView()
        }
    
        let size = pdfView.contentSize
        
        pegarControlaorRaiz().view.insertSubview(pdfView, at: 0)
        
        let redenrizador = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do{
            try redenrizador.writePDF(to: resultadoFileUrl, withActions: { context in
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            completion(true,resultadoFileUrl)
        }
        catch{
            completion(false,nil)
            print(error.localizedDescription)
        }
    }
    func pegarControlaorRaiz()->UIViewController{
        guard let tela = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let raiz = tela.windows.first?.rootViewController else{
            return .init()
        }
        return raiz
    }
}

