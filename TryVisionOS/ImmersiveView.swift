//
//  ImmersiveView.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/12.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @Environment(ViewModel.self) private var model
    
    var body: some View {
        ZStack {
            Model3DView()
                .environment(model)
            TextureView()
        }
    }
}

struct TextureView: View {
    
    var body: some View {
        RealityView { content in
            // Outdoor画像をtextureとして持つmaterialを作成する
            guard let textureResource = try? TextureResource.load(named: "Outdoor") else {
                fatalError("Unable to load texture")
            }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(textureResource))
            // materialに大きな球体をattachする
            let entity = Entity()
            entity.components.set(ModelComponent(
                mesh: .generateSphere(radius: 1000),
                materials: [material]
            ))
            // textureが内側を向いているようにする
            entity.scale *= .init(x: -1, y: 1, z: 1)
            content.add(entity)
        }
    }
}

struct Model3DView: View {
    @Environment(ViewModel.self) private var model
    
    var body: some View {
        RealityView { content in
            guard let toyCarEntity = try? await Entity(named: model.selectedModel3DScene.sceneName, in: realityKitContentBundle) else {
                fatalError()
            }
            toyCarEntity.position = [0.5, 1, -0.5]
            content.add(toyCarEntity)
            
            // ImmersiveSpace内の照明をaddする
            if let imageBasedLightURL = Bundle.main.url(forResource: "ImageBasedLight", withExtension: "exr"),
               let imageBasedLightImageSource = CGImageSourceCreateWithURL(imageBasedLightURL as CFURL, nil),
               let imageBasedLightImage = CGImageSourceCreateImageAtIndex(imageBasedLightImageSource, 0, nil),
               let imageBasedLightResource = try? await EnvironmentResource.generate(fromEquirectangular: imageBasedLightImage) {
                let imageBasedLightSource = ImageBasedLightComponent.Source.single(imageBasedLightResource)

                let imageBasedLight = Entity()
                imageBasedLight.components.set(ImageBasedLightComponent(source: imageBasedLightSource))
                content.add(imageBasedLight)

                toyCarEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: imageBasedLight))
            }

            
        }
    }
}


#Preview {
    ImmersiveView()
        .environment(ViewModel())
}
