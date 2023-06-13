//
//  MealViewModelProtocol.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//
import Foundation
import CoreLocation

protocol MealViewModelProtocol {
    var categoriesMealData: CategoriesMeal? { get }

    func getDataAPICategoriesMeal()
    func generateMeal (key: String)
    func generateDrink (key: String)
}
