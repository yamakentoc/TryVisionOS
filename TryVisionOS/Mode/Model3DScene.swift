//
//  Model3DScene.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/09.
//

import Foundation

/// 各3Dモデルのシーン
enum Model3DScene: String, Identifiable, CaseIterable {
    case toyCar
    case toyDrummer
    case sun
    case earth
    
    var id: Self { self }
        
    // シーン名
    var sceneName: String {
        switch self {
        case .toyCar:
            "ToyCarScene"
        case .toyDrummer:
            "ToyDrummerScene"
        case .sun:
            "SunScene"
        case .earth:
            "EarthScene"
        }
    }
    
    // モデルの名前
    var modelName: String {
        switch self {
        case .toyCar:
            "ToyCar"
        case .toyDrummer:
            "ToyDrummer"
        case .sun:
            "Sun"
        case .earth:
            "Earth"
        }
    }
    
}
