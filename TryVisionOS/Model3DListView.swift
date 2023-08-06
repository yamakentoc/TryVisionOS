//
//  ContentView.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/09.
//

import SwiftUI
import RealityKit
import RealityKitContent

/// 3Dモデルの一覧を表示するView
struct Model3DListView: View {
    @Environment(ViewModel.self) private var model

    /// サイドバーのListのView
    var sidebarList: some View {
        List(model.model3DScenes) { scene in
            Button(action: {
                model.selectedModel3DScene = scene
            }, label: {
                Text(scene.modelName)
            })
        }
        .navigationTitle("3D Model List")
    }
    
    var body: some View {
        @Bindable var model = model
        NavigationSplitView {
            sidebarList
        } detail: {
            VStack {
                Model3D(named: model.selectedModel3DScene.sceneName, bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                HStack {
                    WindowToggle(modelName: model.selectedModel3DScene.modelName,
                                 isShowingImmersiveSpace: $model.isShowingImmersiveSpace,
                                 isShowingVolume: $model.isShowingVolume)
                    OpenImmersiveSpaceButton(modelName: model.selectedModel3DScene.modelName,
                                             isShowingImmersiveSpace: $model.isShowingImmersiveSpace,
                                             isShowingVolume: $model.isShowingVolume)
                }
            }
            .navigationTitle(model.selectedModel3DScene.modelName)
            .padding()
        }
    }
}

/// Volumeを開くためのボタン
private struct WindowToggle: View {
    var modelName: String
    @Binding var isShowingImmersiveSpace: Bool
    @Binding var isShowingVolume: Bool
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        Toggle("view \(modelName) in Volume", isOn: $isShowingVolume)
            .onChange(of: isShowingVolume) { wasShowing, isShowing in
                if isShowing {
                    openWindow(id: "Volume")
                } else {
                    dismissWindow(id: "Volume")
                }
            }
            .toggleStyle(.button)
            .disabled(isShowingImmersiveSpace)
    }
}

/// ImmersiveSpaceを開くためのボタン
private struct OpenImmersiveSpaceButton: View {
    var modelName: String
    @Binding var isShowingImmersiveSpace: Bool
    @Binding var isShowingVolume: Bool
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        Toggle("Open \(modelName) in ImmersiveSpace", isOn: $isShowingImmersiveSpace)
            .onChange(of: isShowingImmersiveSpace) { wasShowing, isShowing in
                Task {
                    if isShowing {
                        await openImmersiveSpace(id: "ImmersiveSpace")
                    } else {
                        await dismissImmersiveSpace()
                    }
                }
            }
            .toggleStyle(.button)
            .disabled(isShowingVolume)
    }
}

#Preview {
    Model3DListView()
        .environment(ViewModel())
}
