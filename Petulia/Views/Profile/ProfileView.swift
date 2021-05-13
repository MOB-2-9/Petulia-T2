//
//  ProfileView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileView: View {
  @State var showImagePicker: Bool = false
  @State var image: Image? = nil
  @EnvironmentObject var theme: ThemeManager
  let gradient = Gradient(colors: [.pink, .accentColor])
  
  var body: some View{
    VStack {
      Spacer()
      HStack {
        VStack {
          ZStack{
            if image != nil {
              image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .clipped()
                .padding()
            } else {
              Image("PetuliaLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .clipped()
                .padding()
            }
          }
          .onTapGesture {
            self.showImagePicker = true
          }
        }
        .sheet(isPresented: $showImagePicker) {
          ImagePicker(sourceType: .photoLibrary) { image in
            self.image = Image(uiImage: image)
          }
        }
      }
      Text("Ben Simpson").font(.system(size: 45).bold())
        .padding(.top, 12)
      Spacer()
    }.background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
    Spacer()
      .navigationBarTitle("Profile")
  }
}

struct ImagePicker: UIViewControllerRepresentable {
  
  @Environment(\.presentationMode)
  private var presentationMode
  
  let sourceType: UIImagePickerController.SourceType
  let onImagePicked: (UIImage) -> Void
  
  final class Coordinator: NSObject,
                           UINavigationControllerDelegate,
                           UIImagePickerControllerDelegate {
    
    @Binding
    private var presentationMode: PresentationMode
    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    
    init(presentationMode: Binding<PresentationMode>,
         sourceType: UIImagePickerController.SourceType,
         onImagePicked: @escaping (UIImage) -> Void) {
      _presentationMode = presentationMode
      self.sourceType = sourceType
      self.onImagePicked = onImagePicked
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
      onImagePicked(uiImage)
      presentationMode.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      presentationMode.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(presentationMode: presentationMode,
                       sourceType: sourceType,
                       onImagePicked: onImagePicked)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = sourceType
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }
}
