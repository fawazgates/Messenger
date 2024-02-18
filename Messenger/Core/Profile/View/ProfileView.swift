import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
        VStack {
            
            //MARK: HEADER
            
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profilImage = viewModel.profilImage {
                        profilImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xlarge)
                    }
                }
                
                Text(user.fullname)
                    .font(.title2).fontWeight(.semibold)
            }
            
            //MARK: LIST
            
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            
                            Text(option.title).font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button ("Log Out") {
                        AuthService.shared.signOut()
                    }
                    Button ("Delete Account") {
                    }
                }
                .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
