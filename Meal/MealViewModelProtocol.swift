//
//  MealViewModelProtocol.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//
import Foundation

protocol MealViewModelProtocol {
    var categoriesMealData: CategoriesMeal? { get }
    var categoriesDrinkData: CategoriesDink? { get }
    var reloadData: (() -> ())? { get set }

    func getDataAPICategoriesMeal()
    func getDataAPICategoriesDrink()
    func generateMeal (key: String)
    func generateDrink (key: String)
}
