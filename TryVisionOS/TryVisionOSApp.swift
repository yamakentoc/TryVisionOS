//
//  TryVisionOSApp.swift
//  TryVisionOS
//
//  Created by 山口賢登 on 2023/07/09.
//

import SwiftUI

@main
struct TryVisionOSApp: App {
    @State private var model = ViewModel()
    
    @State private var immersionStyle: ImmersionStyle = .full

    
    var body: some Scene {
        // window
        WindowGroup {
            ZStack {
                TabView {
                    Model3DListView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .environment(model)
                    SecondView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Setting")
                        }
                }
            }
        }
        .windowStyle(.plain)
        
        // Volume
        WindowGroup(id: "Volume") {
            VolumeView()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        
        // ImmersiveSpace
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(model)
        }
        .immersionStyle(selection: $immersionStyle, in: .full) // inに.mixed, .progressive, .fullのように利用可能なStyleを指定できる
        
    }
}
