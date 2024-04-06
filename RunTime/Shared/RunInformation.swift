//
//  RunInformation.swift
//  RunTime
//
//  Created by Sarah Perez on 4/6/24.
//

import Foundation

struct RunInformation {
    let runIntensity: RunIntensity
}

enum RunIntensity {
    case easy
    case moderate
    case tempo
    case threshold
    case long
    case race
    
    var title: String {
        switch self {
        case .easy:
            return "Easy Run"
        case .moderate:
            return "Moderate Run"
        case .tempo:
            return "Tempo Run"
        case .threshold:
            return "Threshold Run"
        case .long:
            return "Long Run"
        case .race:
            return "Race"
        }
    }
    
    var duration: Int {
        switch self {
        case .easy:
            return 1800
        case .moderate:
            return 2700
        case .tempo:
            return 2700
        case .threshold:
            return 1800
        case .long:
            return 5400
        case .race:
            return 3600
        }
    }
    
}
