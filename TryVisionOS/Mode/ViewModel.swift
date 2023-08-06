//
//  ViewModel.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/09.
//

import Foundation
import Observation

@Observable
class ViewModel {
    /// 3Dモデルのシーンのリスト
    var model3DScenes: [Model3DScene] = Model3DScene.allCases
    /// 選択中の3Dモデルのシーン
    var selectedModel3DScene: Model3DScene = .toyCar
    /// Volumeを表示中か
    var isShowingVolume = false
    /// ImmersiveSpaceを表示中か
    var isShowingImmersiveSpace = false
}
