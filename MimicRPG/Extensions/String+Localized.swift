//
//  Extension+Extended.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//
//  Pode ser usado de duas formas, "string".localized() ou
//  utilizando o enum de localizedStrings
import Foundation
extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
protocol Localizable {
    var localized: String { get }
}
// 1
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized()
    }
}
enum LocalizedStrings: String, Localizable {
    case hello
/*
    Adicione aqui o case da string que quer.
    Pode ser feito com case talcoisa = "alguma coisa"
    Mas se o alguma coisa for igual a talcoisa, basta fazer case talcoisa
    Forma de usar LocalizedStrings.hello.localized
*/
}
