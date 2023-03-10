//
//  Drink.swift
//  Barman
//
//  Created by raul.oropeza on 28/02/23.
//


import Foundation

// MARK: - Drink
struct Drink: Codable {
    let directions, ingredients, name, img: String
}

typealias Drinks = [Drink]
