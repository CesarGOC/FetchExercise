//
//  CustomTableViewCell.swift
//  FetchCodingChallenge
//
//  Created by César Alejandro Guadarrama Ortega on 29/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
//    private var logoPic : UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
        
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
//    private var moneyLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
        
    lazy private var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(nameLabel)
        //stackView.addArrangedSubview(moneyLabel)
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
        //addSubview(logoPic)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
//                    //Profile Constraints
//                    logoPic.widthAnchor.constraint(equalToConstant: 60),
//                    logoPic.heightAnchor.constraint(equalToConstant: 60),
//                    logoPic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
//                    logoPic.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//                    logoPic.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//
//                    //StackView Constraints
//                    stackView.leadingAnchor.constraint(equalTo: logoPic.trailingAnchor, constant: 10),
                    //stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
                    stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                    stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
                ])
    }
    
    
    
    func set(_ value: Meal){
        nameLabel.text = "   \(value.strMeal)"
        //logoPic.image = fetchImageFromURL(url: value.strMealThumb)
        
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
