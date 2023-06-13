//
//  MealViewModel.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import Foundation


final class MealViewModel: MealViewModelProtocol {
    
    var categoriesMeal: CategoriesMeal?
    var reloadData: (() -> Void)?
    var categoriesDink = [DrinkCategories]()
    var mealModel: MealModel?
    var drinkModel: DrinkModel?
    var keyMeal: String?
    var keyDrink: String?

}

extension MealViewModel {
    func getDataAPICategoriesMeal() {
        let urlApi = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        URLSession.shared.dataTask(with: urlApi) { [weak self] data, reponse, error in
            if let data = data {
                let categoriesData = try! JSONDecoder().decode(CategoriesMeal.self, from: data)
                self?.categoriesMeal = categoriesData
                self?.reloadData?()
            }
        }.resume()
       
    }
    
    func getDataDrink() {
        let categories = [DrinkCategories(idDrink: 1, nameDrink: "Cocktail"), DrinkCategories(idDrink: 2, nameDrink: "Shot"),DrinkCategories(idDrink: 3, nameDrink: "Shake"),DrinkCategories(idDrink: 4, nameDrink: "Cocoa"), DrinkCategories(idDrink: 5, nameDrink: "Beer"), DrinkCategories(idDrink: 6, nameDrink: "Ordinary_Drink")]
        self.categoriesDink = categories
//        self.reloadData?()
    }
    
    var categoriesMealData: CategoriesMeal? {
        getDataAPICategoriesMeal()
        return categoriesMeal
    }
    
    func generateMeal (key: String) {
        URLSession.shared.dataTask(with: URL(string: "https:www.themealdb.com/api/json/v1/1/filter.php?c=\(key)")!) { [weak self] data, response , error in
            if let data = data {
                let mealData = try! JSONDecoder().decode(MealModel.self, from: data)
                self?.mealModel = mealData
                self?.reloadData?()
            }
            
        } .resume()
    }
    
    func generateDrink (key: String) {
        URLSession.shared.dataTask(with: URL(string: "https:www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(key)")!) { [weak self] data, response , error in
            if let data = data {
                let drinkData = try! JSONDecoder().decode(DrinkModel?.self, from: data)
                self?.drinkModel = drinkData
                self?.reloadData?()
            }
        } .resume()
        
    }
    
    
    
}


