//
//  Model.swift
//  ExchangeRates
//
//  Created by Ekaterina on 4.07.21.
//

import Foundation

struct ExchangeModel : Codable {
    
    let code : Int?
    let downloadDate : String?
    let message : String?
    let messageTitle : String?
    let productState : Int?
    let rates : [Rate]?
    let ratesDate : String?
    let rid : String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case downloadDate = "downloadDate"
        case message = "message"
        case messageTitle = "messageTitle"
        case productState = "productState"
        case rates = "rates"
        case ratesDate = "ratesDate"
        case rid = "rid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        downloadDate = try values.decodeIfPresent(String.self, forKey: .downloadDate)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        messageTitle = try values.decodeIfPresent(String.self, forKey: .messageTitle)
        productState = try values.decodeIfPresent(Int.self, forKey: .productState)
        rates = try values.decodeIfPresent([Rate].self, forKey: .rates)
        ratesDate = try values.decodeIfPresent(String.self, forKey: .ratesDate)
        rid = try values.decodeIfPresent(String.self, forKey: .rid)
    }
    
}

struct Rate : Codable {
    
    let basic : String?
    let buy : String?
    let currMnemFrom : String?
    let currMnemTo : String?
    let deltaBuy : String?
    let deltaSale : String?
    let from : Int?
    let name : String?
    let sale : String?
    let to : Int?
    let tp : Int?
    
    enum CodingKeys: String, CodingKey {
        case basic = "basic"
        case buy = "buy"
        case currMnemFrom = "currMnemFrom"
        case currMnemTo = "currMnemTo"
        case deltaBuy = "deltaBuy"
        case deltaSale = "deltaSale"
        case from = "from"
        case name = "name"
        case sale = "sale"
        case to = "to"
        case tp = "tp" // не разобралась что означает и в каком контексте отобразить
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        basic = try values.decodeIfPresent(String.self, forKey: .basic)
        buy = try values.decodeIfPresent(String.self, forKey: .buy)
        currMnemFrom = try values.decodeIfPresent(String.self, forKey: .currMnemFrom)
        currMnemTo = try values.decodeIfPresent(String.self, forKey: .currMnemTo)
        deltaBuy = try values.decodeIfPresent(String.self, forKey: .deltaBuy)
        deltaSale = try values.decodeIfPresent(String.self, forKey: .deltaSale)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        sale = try values.decodeIfPresent(String.self, forKey: .sale)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        tp = try values.decodeIfPresent(Int.self, forKey: .tp)
    }
    
    func nameLabelText() -> String {
        
        //отсекаем лишнее у строки с названием
        var newName = ""
        if let name = name, name.contains("/") {
            let index = name.range(of: "/")?.upperBound
            newName = String(name.suffix(from: index!))
        } else {
            newName = name!
        }
        
        guard let currensyFrom = currMnemFrom, let codeFrom = from, let currensy = currMnemTo, let codeTo = to  else { return "" }
        return "\(newName)," + " \(currensy), " + "\(codeTo)" + " / " + "\(currensyFrom)," + " \(codeFrom)"
    }
    
    func priceLabelText() -> String {
        guard let buy = buy, let sale = sale, let basic = basic, let currensy = currMnemTo else { return "0 / 0" }
        return "\(basic) \(currensy): " + "\(buy)" + " / " + "\(sale)"
    }
    
    func deltaLabelText() -> String {
        guard let deltaBuy = deltaBuy, let deltaSail = deltaSale  else { return "0 / 0" }
        return "δ: " + "\(deltaBuy)" + " / " + "\(deltaSail)"
    }
    
}
