//
//  ViewController.swift
//  FetchCodingChallenge
//
//  Created by César Alejandro Guadarrama Ortega on 29/08/23.
//

import UIKit
import Foundation

class ViewController: UIViewController{
     
    var meals:[Meal] = []
    var mealsError: [Meal] = [
    Meal(strMeal: "Datos no recuperados", strMealThumb: "", idMeal: "")
    ]
    var imageURL: String = ""
    var idMeal: String = ""
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "\(CustomTableViewCell.self)")
        //tableView.register(HeaderSectionCell.self, forHeaderFooterViewReuseIdentifier: "\(HeaderSectionCell.self)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        fetchAndDisplayMeals()
        configureView()
        tableView.reloadData()
    }
    
    private func configureView(){
        view.addSubview(tableView)
        var topPadding : CGFloat = 0.0
        if let topInset = UIApplication.shared.windows.first?.safeAreaInsets.top{
            topPadding = topInset
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding + 80),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getSafeAreaTop() -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return (keyWindow?.safeAreaInsets.top) ?? 0.0
    }
    
    func fetchAndDisplayMeals() {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        //let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID"
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
                    let mealsResponse = try decoder.decode(MealsResponse.self, from: data)
                    
                    self.meals = mealsResponse.meals
                    DispatchQueue.main.async {
                                       self.tableView.reloadData() // ¡Aquí recargamos la tabla en el hilo principal!
                                   }
                } catch {
                    self.meals = self.mealsError
                    DispatchQueue.main.async {
                                       self.tableView.reloadData() // ¡Aquí recargamos la tabla en el hilo principal!
                                   }
                    print("Error al decodificar: \(error)")
                    
                }
            }
            
            task.resume()
        } else {
            print("URL inválida.")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tapMeal"{
            let vistaMeal = segue.destination as! TapViewController
            vistaMeal.imageURL = imageURL
            vistaMeal.idMeal = idMeal
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return IngresosModel.getList().count
            
            return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath) as? CustomTableViewCell else{
           return UITableViewCell()
        }
        let value = meals[indexPath.row]
        cell.set(value)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let values = meals
        print("You tapped cell \(values[indexPath.row].strMeal).")
        if values[indexPath.row].strMeal != "Datos no recuperados"{
            imageURL = values[indexPath.row].strMealThumb
            idMeal = values[indexPath.row].idMeal
            performSegue(withIdentifier: "tapMeal", sender: nil)
        }else{
            showAlert()
        }
        
//
    }
    
    //metodo que activa el poder mover las celdas
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // metodo que mueve lor elementos del arreglo
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //** Recordar que la lista que retorna no se puede modificar, en la app hacer la modificacion
        //var lista = IngresosModel.getList()
        meals.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    //metodo que activa el eliminar los objetos de la tableView
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "No data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    
    
}


