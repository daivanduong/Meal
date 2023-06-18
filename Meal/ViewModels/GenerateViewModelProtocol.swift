//
//  GenerateViewModelProtocol.swift
//  Meal
//
//  Created by Ocean97 on 18/06/2023.
//

import Foundation

protocol GenerateViewModelProtocol {
    func titleForHeaderInSection(section: Int ) -> String
    var numberOfSections: Int { get }
    func numberOfRowsInSection(section: Int) -> Int
    func callAPI()
    var reloadData: (() -> ())? { get set }
    func getName(index: IndexPath) -> String
    func getURLImage(index: IndexPath) -> URL
    func getCategoriesName(index: IndexPath) -> String
    func urlComponents(url: URL, categories: String) -> URL
}
