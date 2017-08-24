import UIKit

var str = "Hello, playground"
print(Locale.current)
//
//let locale = Locale.current.regionCode
//print(locale)
//let price = 123.00 as NSNumber
//
//let formatter = NumberFormatter()
//formatter.numberStyle = .currency
//formatter.locale = Locale.current
//formatter.string(from: price) // "$123.44"

func localeconverter(currency: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    let formattedString = formatter.string(from: currency as NSNumber)
    return formattedString ?? ""
}


let price: Double = 2.3067
print(localeconverter(currency: price))
