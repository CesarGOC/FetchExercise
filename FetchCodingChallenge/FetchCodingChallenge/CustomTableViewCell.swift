//
//  CustomTableViewCell.swift
//  FetchCodingChallenge
//
//  Created by César Alejandro Guadarrama Ortega on 29/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

        
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        
    lazy private var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(nameLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                    stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
                ])
    }
    
    
    
    func set(_ value: Meal){
        nameLabel.text = "   \(value.strMeal)"
       
        
    }
    
    func fetchImageFromURL(url: String) -> UIImage? {
        var imageView: UIImage?
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
                    imageView = image
                   
                }

                task.resume()
            } else {
                print("URL inválida.")
            }
        return imageView
        }
    
}
