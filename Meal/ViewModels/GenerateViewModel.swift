//
//  GenerateViewModel.swift
//  Meal
//
//  Created by Ocean97 on 18/06/2023.
//

import Foundation
class GenerateViewModel: GenerateViewModelProtocol {
   
    var mealModel: MealModel?
    var drinkModel: DrinkModel?
    
    var reloadData: (() -> ())?
    
    
    func titleForHeaderInSection(section: Int) -> String {
        if section == 0 {
            return "Meal"
        } else {
            return "Drink"
        }
        
    }
    var numberOfSections: Int {
        return 2
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 1
        
    }
    
    func callAPI() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let key_meal = UserDefaults.standard.string(forKey: "CategoriesMeal")
        let url_meal = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php")!
        URLSession.shared.dataTask(with: urlComponents(url: url_meal, categories: key_meal!)) { [weak self] data, response , error in
            if let data = data {
                let mealData = try! JSONDecoder().decode(MealModel.self, from: data)
                self?.mealModel = mealData
                dispatchGroup.leave()
            }
        } .resume()
        dispatchGroup.enter()
        let key_drink = UserDefaults.standard.string(forKey: "CategoriesDrink")
        let url_drink = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php")!
        URLSession.shared.dataTask(with: urlComponents(url: url_drink, categories: key_drink!)) { [weak self] data, response , error in
            if let data = data {
                let drinkData = try! JSONDecoder().decode(DrinkModel?.self, from: data)
                self?.drinkModel = drinkData
                dispatchGroup.leave()
            }
        } .resume()
        
        dispatchGroup.notify(queue: .main) {
            self.reloadData?()
        }
        
    }
    func getName(index: IndexPath) -> String {
        if index.section == 0 {
            return mealModel?.meals?.randomElement()!.strMeal ?? ""
        } else {
            return drinkModel?.drinks?.randomElement()!.strDrink ?? ""
        }
    }
    
    func getURLImage(index: IndexPath) -> URL {
        let UrlDefaults = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php")!
        if index.section == 0 {
            let url = URL(string: mealModel?.meals?.randomElement()!.strMealThumb ?? "")
            return url ?? UrlDefaults
        } else {
            let url = URL(string: drinkModel?.drinks?.randomElement()!.strDrinkThumb ?? "")
            return url ?? UrlDefaults
        }
    }
    
    func getCategoriesName(index: IndexPath) -> String {
        if index.section == 0 {
            let key_meal = UserDefaults.standard.string(forKey: "CategoriesMeal")
            return key_meal!
        } else {
            let key_drink = UserDefaults.standard.string(forKey: "CategoriesDrink")
            return key_drink!
        }
    }
    func urlComponents(url: URL, categories: String) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItemCategories = URLQueryItem(name: "c", value: categories)
        components?.queryItems = [queryItemCategories]
        return (components?.url)!
    }
    
    
}

