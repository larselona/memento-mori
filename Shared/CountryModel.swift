//
//  CountryModel.swift
//
//  Created by lars on 08/08/2020.
//


import SwiftUI

struct Country {
    var code: String?
    var name: String?
    var flag: Image? {
        guard let code = self.code else { return nil }
        guard let bundlePath = Bundle.main.path(forResource: "SwiftCountryPicker", ofType: "bundle") else { return nil }
        guard let bundle = Bundle(path: bundlePath)  else { return nil }
        guard let imagePath = bundle.path(forResource: "Images/\(code.lowercased())", ofType: "png") else { return nil }
        guard let uiImage = UIImage(contentsOfFile: imagePath) else { return nil }
        return Image.init(uiImage: uiImage)
    }
    
    init(code: String?, name: String?) {
        self.code = code
        self.name = name
    }
    
    // Populates the metadata from the included json file resource
    static func countryNamesByCode() -> [Country] {
        var countries = [Country]()
        if let bundlePath = Bundle.main.path(forResource: "SwiftCountryPicker", ofType: "bundle"),
            let bundle = Bundle(path: bundlePath),
            let jsonPath = bundle.path(forResource: "Data/countryCodes", ofType: "json") {
         
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
              
                do {
                    if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
                        for jsonObject in jsonObjects {
                            
                            guard let countryObj = jsonObject as? NSDictionary else {  return countries }
                            
                            guard let code = countryObj["code"] as? String, let name = countryObj["name"] as? String else {
                                return countries
                            }
                            let country = Country(code: code, name: name)
                            countries.append(country)
                        }
                    }
                }
                catch {
                  print("Parsing country json failed.")
                }
            }
        } else {
            print("Unable to locate SwiftCountryPicker bundle.")
        }
        return countries
    }
}
