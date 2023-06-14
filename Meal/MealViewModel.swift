//
//  MealViewModel.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import Foundation

 class MealViewModel: MealViewModelProtocol {

    var categoriesMeal: CategoriesMeal?
    var categoriesDink: CategoriesDink?
    var reloadData: (() -> Void)?
    var mealModel: MealModel?
    var drinkModel: DrinkModel?

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
    
    var categoriesMealData: CategoriesMeal? {
        getDataAPICategoriesMeal()
        return categoriesMeal
    }
    
    func getDataAPICategoriesDrink() {
        let urlApi = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
        URLSession.shared.dataTask(with: urlApi) { [weak self] data, reponse, error in
            if let data = data {
                let categoriesData = try! JSONDecoder().decode(CategoriesDink.self, from: data)
                self?.categoriesDink = categoriesData
                self?.reloadData?()
            }
        }.resume()
    }
    
    
    var categoriesDrinkData: CategoriesDink? {
        getDataAPICategoriesDrink()
        reloadData?()
        return categoriesDink
    }
    
    func generateMeal (key: String) {
        URLSession.shared.dataTask(with: URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(key)")!) { [weak self] data, response , error in
            if let data = data {
                let mealData = try! JSONDecoder().decode(MealModel.self, from: data)
                self?.mealModel = mealData
                self?.reloadData?()
            }
        } .resume()
    }
    
    func generateDrink (key: String) {
        let url = URLComponents(queryItems: [URLQueryItem(name: "c", value: key)]).url!
        URLSession.shared.dataTask(with: URL(string: "\(url)")!) { [weak self] data, response , error in
            if let data = data {
                let drinkData = try! JSONDecoder().decode(DrinkModel?.self, from: data)
                self?.drinkModel = drinkData
                self?.reloadData?()
            }
        } .resume()
    }

}

extension URLComponents {
    init(scheme: String = "https",
         host: String = "www.thecocktaildb.com",
         path: String = "/api/json/v1/1/filter.php",
         queryItems: [URLQueryItem]) {
        self.init()
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}


