//
//  RoomView.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import SwiftUI
import RealityKit

struct RoomView: View {
    @EnvironmentObject var viewModel: RoomViewModel
    
    var body: some View {
        ZStack {
            RoomContainer()
            VStack {
                HStack {
                    Image("Icon Back")
                    Spacer()
                }.padding()
                Button("Clicked this") {
                    viewModel.chosenModel = "Select"
                }
                Spacer()
            }
        }
    }
}

struct RoomContainer: UIViewRepresentable {
    @EnvironmentObject var viewModel: RoomViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let arView = CustomARView(frame: .zero)
        
        self.viewModel.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { (event) in
            
            if self.viewModel.chosenModel != nil {
                do {
                    let model = try ModelEntity.loadModel(contentsOf: Bundle.main.url(forResource: "Antique_Furniture", withExtension: "usdz")!)
                    
                    model.scale *= 0.2
                    
                    let clonedModel = model.clone(recursive: true)
                    clonedModel.generateCollisionShapes(recursive: true)
                    
                    arView.installGestures(
                        [.translation, .scale, .rotation],
                        for: clonedModel
                    )
                    
                    let anchor = AnchorEntity()
                    anchor.addChild(clonedModel)
                    
                    arView.scene.addAnchor(anchor)
                    
                    print("Anchor placed with position \(anchor.position)")
                } catch {
                    print("Error is \(error)")
                }
            }
            
            viewModel.chosenModel = nil
        }
        
//        ModelEntity.loadModelAsync(
//            contentsOf: Bundle.main.url(forResource: "Indian_Furniture", withExtension: "usdz")!
//        ).sink(
//            receiveCompletion: { completion in
//                switch completion {
//                case .failure(let err):
//                    print("Error is \(err)")
//                case .finished:
//                    break
//                }
//            },
//            receiveValue: { model in
//                let clonedModel = model.clone(recursive: true)
//                clonedModel.generateCollisionShapes(recursive: true)
//
//                arView.installGestures([.translation, .scale, .rotation], for: clonedModel)
//
//                let anchor = AnchorEntity(plane: .any)
//                anchor.addChild(clonedModel)
//
//                arView.scene.addAnchor(anchor)
//
//                print("Anchor placed with position \(anchor.position)")
//            }
//        )
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do Nothing
    }
}

//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomView()
//    }
//}
