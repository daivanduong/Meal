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

struct CategoriesDink: Codable {
    var drinks: [Drinks]?
}

struct Drinks: Codable {
    var strCategory: String?
}

struct DrinkModel: Codable {
  
    var drinks: [Drink]?
    
}

struct Drink: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String

}

