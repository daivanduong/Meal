//
//  MealModel.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import Foundation

struct CategoriesMeal: Codable {
    var categories: [Categories]?
}

struct Categories: Codable {
    var idCategory: String?
    var strCategory: String?
    var strCategoryThumb: String?
    var strCategoryDescription: String?
}

struct MealModel: Codable {
    var meals: [Meals]?
}

struct Meals: Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String

}

class DrinkCategories {
    let idDrink: Int
    let nameDrink: String
    
    init(idDrink: Int, nameDrink: String) {
        self.idDrink = idDrink
        self.nameDrink = nameDrink
    }
}


class DrinkModel: Codable {
  
    var drinks: [Drink]?
    
}

class Drink: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String

}

