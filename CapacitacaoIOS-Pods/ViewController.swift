//
//  ViewController.swift
//  CapacitacaoIOS-Pods
//
//  Created by PUCPR on 29/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imvCapaFilme: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlBase = "https://api.themoviedb.org/3/movie/284052?api_key="
        
        let key = "650ce1911372d393d8ef3aeaf214ced3"
        
        let url = "\(urlBase)\(key)"
        
        let baseImage = "https://image.tmdb.org/t/p/w500"
        
        Alamofire.request(url).responseJSON { (response) in print(response.result.value!)
            if (response.result.isSuccess) {
                let json = JSON(response.result.value!)
//                print(json["title"])
//                print(json["production_companies"][0]["name"])
                
                self.lblTitulo.text = json["title"].stringValue
                
                //Montar a url da Image
                let imagePath = "\(baseImage)\(json["poster_path"].stringValue)"
                
                //criar a URL
                let urlImage = URL(string: imagePath)
                
                DispatchQueue.global().async { [weak self] in
                    // Fazer o download da image
                    if let bytes = try? Data(contentsOf: urlImage!){
                        //Criar Imagem apartir dos dados lidos
                        if let image = UIImage(data: bytes) {
                            DispatchQueue.main.async {
                                //Mostrar image na view
                                self!.imvCapaFilme.image = image
                            }
                        }
                    }
                }
            }
        }
    }
}

