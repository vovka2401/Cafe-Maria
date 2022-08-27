//
//  Dish.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 19.07.2022.
//

import UIKit

enum DishType: String{
    case main = "Main"
    case salad = "Salads"
    case dessert = "Desserts"
    case drink = "Drinks"
}

protocol DishProtocol{
    var title: String {get set}
    var price: Float {get set}
    var weight: Float {get set}
    var image: UIImage {get set}
    var ingredients: String {get set}
    var description: String {get set}
    var type: DishType {get set}
}

class Dish: DishProtocol{
    var title: String
    var price: Float
    var weight: Float
    var image: UIImage
    var ingredients: String
    var description: String
    var type: DishType
    
    init(title: String, price: Float, weight: Float, image: UIImage, ingredients: String, description: String, type: DishType){
        self.title = title
        self.price = price
        self.weight = weight
        self.image = image
        self.ingredients = ingredients
        self.description = description
        self.type = type
    }
}

protocol DishDBProtocol {
    func getDishesByType(type: DishType)->[DishProtocol]
    func getDishes()->[DishProtocol]
}

class DishDB: DishDBProtocol {
    
    static let shared = DishDB()
    private var dishes: [DishProtocol]
    
    private init(){
        dishes = [
            Dish(title: "Caesar", price: 20, weight: 200, image: UIImage(named: "caesar")!, ingredients: "Green salad, tomatoes, chicken fillet, white bread, Caesar dressing, garlic, parmesan", description: "We all know what it is: chopped romaine lettuce and garlicky croutons, tossed in a creamy dressing made with eggs, olive oil, lemon, Parmesan, Worcestershire sauce, and anchovies. Even when mass-produced, this combination of savory, creamy, tangy, and crunchy ingredients is tasty stuff.", type: .salad),
            Dish(title: "Greek", price: 25, weight: 220, image: UIImage(named: "greek")!, ingredients: "smt", description: "Greek salad is a popular salad in Greek cuisine generally made with pieces of tomatoes, cucumbers, onion, feta cheese (usually served as a slice on top of the other ingredients), and olives (typically Kalamata olives) and dressed with salt, Greek oregano, and olive oil.", type: .salad)
        ]
    }
    
    func getDishesByType(type: DishType)->[DishProtocol] {
        dishes.filter{$0.type == type}
    }
    
    func getDishes() -> [DishProtocol] {
        return dishes
    }
}
