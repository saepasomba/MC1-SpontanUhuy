//
//  RoomFormView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 03/05/23.
//

import SwiftUI
import PhotosUI

struct RoomFormView: View {
    @StateObject var roomFormViewModel: RoomFormViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(roomFormViewModel.viewState == .newRoom ? "New" : "Edit") Room")
                    .fontWeight(.bold)
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    if roomFormViewModel.viewState == .editRoom {
                        ShareLink(item: URL(string: "https://temanruang.com/rooms/198903810101")!) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .padding(.vertical)
            .font(.title3)
            
            VStack {
                Text("Input Your Room Name")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Your room name", text: $roomFormViewModel.name)
                    .frame(height: 30)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                    }
            }
            .padding(.top)
            
            Text("Add Your Room Image")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            PhotosPicker(
                selection: $roomFormViewModel.selectedItem,
                matching: .any(of: [.images, .not(.livePhotos)])
            ) {
                if let imageData = roomFormViewModel.selectedPhotoData {
                    VStack {
                        ZStack {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .cornerRadius(15)
                                .overlay {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(
                                                Color(hex: Constants.Color.primaryBlue),
                                                lineWidth: 1
                                            )
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(.black).opacity(0.4))
                                    }
                                }
                            
                            Text("Edit Image").foregroundColor(.white)
                        }
                        
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                roomFormViewModel.selectedPhotoData = nil
                            }
                        } label: {
                            Text("Remove Image")
                                .padding(.top)
                                .foregroundColor(.red)
                        }
                    }
                } else if let imageURL = roomFormViewModel.imageURL {
                    VStack {
                        ZStack {
                            AsyncImage(
                                url: URL(string: imageURL)!,
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                        .cornerRadius(15)
                                        .overlay {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(
                                                        Color(hex: Constants.Color.primaryBlue),
                                                        lineWidth: 1
                                                    )
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(.black).opacity(0.4))
                                            }
                                        }
                                },
                                placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                        .cornerRadius(15)
                                        .overlay {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(
                                                        Color(hex: Constants.Color.primaryBlue),
                                                        lineWidth: 1
                                                    )
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(.black).opacity(0.4))
                                            }
                                        }
                                }
                            )
                            
                            Text("Edit Image").foregroundColor(.white)
                        }
                        
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                roomFormViewModel.imageURL = nil
                            }
                        } label: {
                            Text("Remove Image")
                                .padding(.top)
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    VStack {
                        Text("+")
                        Text("Add Image")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                    }
                }
            }
            .onChange(of: roomFormViewModel.selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        roomFormViewModel.selectedPhotoData = data
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Button {
                    Task {
                        await roomFormViewModel.save()
                    }
                } label: {
                    if roomFormViewModel.isLoading {
                        ProgressView().progressViewStyle(.circular)
                    } else {
                        Text(roomFormViewModel.viewState == .editRoom ? "Save Room" : "Save New Room")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background {
                                Color(hex: Constants.Color.primaryBlue)
                            }
                            .cornerRadius(8)
                    }
                }.disabled(roomFormViewModel.isLoading)
                
                if roomFormViewModel.viewState == .editRoom {
                    Button {
                        Task {
                            await roomFormViewModel.delete(roomId: roomFormViewModel.room!.id)
                        }
                    } label: {
                        Text("Delete Room")
                            .foregroundColor(.red)
                            .padding(.vertical)
                    }
                }
                
            }
        }
        .padding(.horizontal)
        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
        .onChange(of: roomFormViewModel.successAddRoom) { newValue in
            if newValue {
                dismiss()
            }
        }
    }
}

struct RoomFormView_Previews: PreviewProvider {
    static var previews: some View {
        RoomFormView(roomFormViewModel: RoomFormViewModel(viewState: .editRoom, room: nil))
    }
}
