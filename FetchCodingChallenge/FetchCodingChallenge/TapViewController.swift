//
//  TapViewController.swift
//  FetchCodingChallenge
//
//  Created by César Alejandro Guadarrama Ortega on 30/08/23.
//

import UIKit

class TapViewController: UIViewController {
    
    var imageURL: String = ""
    var idMeal: String = ""
    var meals: [MealSecondView] = []
    
    @IBOutlet var ingredienteLabel2: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var prepareLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImageFromURL(url: imageURL )
        fetchAllData(id: idMeal)
      
    }
    
    func fetchImageFromURL(url: String){
        let imageUrlString = url
        if let imageUrl = URL(string: imageUrlString) {
                    let session = URLSession.shared
                    let task = session.dataTask(with: imageUrl) { data, response, error in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }

                        guard let data = data, let image = UIImage(data: data) else {
                            print("No se pudo obtener la imagen.")
                            return
                        }

                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }

                    task.resume()
                } else {
                    print("URL inválida.")
                }
        }
    
    func fetchAllData(id: String){
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?%20i="+id
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No se recibieron datos.")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let mealResponse = try decoder.decode(MealsResponse2.self, from: data)
                    
                    //let meal = mealResponse
                    self.meals = mealResponse.meals
                    DispatchQueue.main.async {
                        //self.ingredientsLabel.text = self.meals[0].strIngredient1
                        let ingredientList1 = self.ingredientList(self.meals[0].strIngredient1, self.meals[0].strIngredient2, self.meals[0].strIngredient3, self.meals[0].strIngredient4, self.meals[0].strIngredient5, self.meals[0].strIngredient6, self.meals[0].strIngredient7, self.meals[0].strIngredient8, self.meals[0].strIngredient9, self.meals[0].strIngredient10)
                        let ingredientList2 = self.ingredientList2(self.meals[0].strIngredient11, self.meals[0].strIngredient12, self.meals[0].strIngredient13, self.meals[0].strIngredient14, self.meals[0].strIngredient15, self.meals[0].strIngredient16, self.meals[0].strIngredient17, self.meals[0].strIngredient18, self.meals[0].strIngredient19, self.meals[0].strIngredient20)
                        
                        
                        
                            self.ingredientsLabel.text = String(ingredientList1)
                            self.ingredienteLabel2.text = String(ingredientList2)
//                        let firstPart = ingredientList.prefix(upTo: middleIndex)
//                        let secondPart = ingredientList.suffix(from: middleIndex)
//                        self.ingredientsLabel.text = String(firstPart)
//                        self.ingredienteLabel2.text = String(secondPart)
                        self.prepareLabel.text = self.meals[0].strInstructions
                    }
                } catch {
                    print("Error al decodificar: \(error)")
                }
            }
            
            task.resume()
        } else {
            print("URL inválida.")
        }
    }
    
    func ingredientList(_ igt1: String?,_ igt2: String?,_ igt3: String?,_ igt4: String?,_ igt5: String?,_ igt6: String?,_ igt7: String?,_ igt8: String?,_ igt9: String?,_ igt10: String?) -> String{
        
        var response: String = ""
        
        if let igt1 = igt1{
            response += igt1 != "" ? "- \(igt1) \n" : ""
        }
        if let igt2 = igt2{
            response += igt2 != "" ? "- \(igt2) \n" : ""
        }
        if let igt3 = igt3{
            response += igt3 != "" ? "- \(igt3) \n" : ""
        }
        if let igt4 = igt4{
            response += igt4 != "" ? "- \(igt4) \n" : ""
        }
        if let igt5 = igt5{
            response += igt5 != "" ? "- \(igt5) \n" : ""
        }
        if let igt6 = igt6{
            response += igt6 != "" ? "- \(igt6) \n" : ""
        }
        if let igt7 = igt7{
            response += igt7 != "" ? "- \(igt7) \n" : ""
        }
        if let igt8 = igt8{
            response += igt8 != "" ? "- \(igt8) \n" : ""
        }
        if let igt9 = igt9{
            response += igt9 != "" ? "- \(igt9) \n" : ""
        }
        if let igt10 = igt10{
            response += igt10 != "" ? "- \(igt10) \n" : ""
        }
        return response
    }
    
    func ingredientList2(_ igt11: String?,_ igt12: String?,_ igt13: String?,_ igt14: String?,_ igt15: String?,_ igt16: String?,_ igt17: String?,_ igt18: String?,_ igt19: String?,_ igt20: String?) -> String{
        
        var response: String = ""
        
        if let igt11 = igt11{
            response += igt11 != "" ? "- \(igt11) \n" : ""
        }
        if let igt12 = igt12{
            response += igt12 != "" ? "- \(igt12) \n" : ""
        }
        if let igt13 = igt13{
            response += igt13 != "" ? "- \(igt13) \n" : ""
        }
        if let igt14 = igt14{
            response += igt14 != "" ? "- \(igt14) \n" : ""
        }
        if let igt15 = igt15{
            response += igt15 != "" ? "- \(igt15) \n" : ""
        }
        if let igt16 = igt16{
            response += igt16 != "" ? "- \(igt16) \n" : ""
        }
        if let igt17 = igt17{
            response += igt17 != "" ? "- \(igt17) \n" : ""
        }
        if let igt18 = igt18{
            response += igt18 != "" ? "- \(igt18) \n" : ""
        }
        if let igt19 = igt19{
            response += igt19 != "" ? "- \(igt19) \n" : ""
        }
        if let igt20 = igt20{
            response += igt20 != "" ? "- \(igt20) \n" : ""
        }
        return response
    }
    
    func make(){
        
    }
  

}
