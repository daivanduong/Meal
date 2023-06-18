//
//  MealViewModelProtocol.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//
import Foundation

protocol MealViewModelProtocol {
    func headerTitle ( index: IndexPath) -> String
    var numberOfSections: Int { get }
    func numberOfItemsInSection(section: Int) -> Int
    func getCategoriesNameForCell( index: IndexPath) -> String
    func startAPICall()
    func isChecked() -> Bool
    var reloadData: (() -> ())? { get set }
    var updateBTGenerate: (() -> ())? { get set }
    func isSelectCell( index: Int)
    func getCategoriesName(index: IndexPath)
   
}
