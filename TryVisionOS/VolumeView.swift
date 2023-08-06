//
//  VolumeView.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/10.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct VolumeView: View {
    
    @Environment(ViewModel.self) private var model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RealityView { content in
                if let scene = try? await Entity(named: model.selectedModel3DScene.sceneName, in: realityKitContentBundle) {
                    content.add(scene)
                }
            }
            HStack(spacing: 17) {
                Toggle(isOn: .constant(false), label: {
                    Label("Star", systemImage: "star")
                })
                .help("Star")
                
                Toggle(isOn: .constant(false), label: {
                    Label("dog", systemImage: "pawprint")
                })
                .help("dog")
                
                Toggle(isOn: .constant(false), label: {
                    Label("share", systemImage: "square.and.arrow.up")
                })
                .help("share")
            }
            .toggleStyle(.button)
            .buttonStyle(.borderless) // ボタンの背景なし
            .labelStyle(.iconOnly)
            .padding(12)
            .glassBackgroundEffect()
        }
    }
}

#Preview {
    VolumeView()
        .environment(ViewModel())
}
