//
//  MealViewModel.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import Foundation


final class MealViewModel: MealViewModelProtocol {
    
    var categoriesMeal1: CategoriesMeal?
    var reloadCollectionView: (() -> Void)?
    var categoriesDink = [DrinkCategories]()

}

extension MealViewModel {
    func getDataAPICategoriesMeal() {
        let urlApi = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        URLSession.shared.dataTask(with: urlApi) { [weak self] data, reponse, error in
            if let data = data {
                let categoriesData = try! JSONDecoder().decode(CategoriesMeal.self, from: data)
                self?.categoriesMeal1 = categoriesData
                self?.reloadCollectionView?()
            }
        }.resume()
       
    }
    
    func getDataDrink() {
        let categories = [DrinkCategories(idDrink: 1, nameDrink: "Cocktail"), DrinkCategories(idDrink: 2, nameDrink: "Shot"),DrinkCategories(idDrink: 3, nameDrink: "Shake"),DrinkCategories(idDrink: 4, nameDrink: "Cocoa"), DrinkCategories(idDrink: 5, nameDrink: "Beer"), DrinkCategories(idDrink: 6, nameDrink: "Ordinary_Drink")]
        
        self.categoriesDink = categories
        self.reloadCollectionView?()
    }
    
    var categoriesMeal: CategoriesMeal? {
        getDataAPICategoriesMeal()
        return categoriesMeal1
    }
}


