import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //MARK: LOGO IMAGE
                Image("messenger").resizable().scaledToFit().frame(width: 150, height: 150).padding()
                
                //MARK: TEXT FIELDS
                VStack {
                    TextField("Enter your email", text: $viewModel.email).font(.subheadline).padding(12).background(Color(.systemGray6)).cornerRadius(10).padding(.horizontal, 24)
                    SecureField("Enter your password", text: $viewModel.password).font(.subheadline).padding(12).background(Color(.systemGray6)).cornerRadius(10).padding(.horizontal, 24)
                }
                
                //MARK: FORGOT PASSWORD
                Button {
                    print("Forgot password")
                } label: {
                    Text("Fortgot password").font(.footnote).fontWeight(.semibold).padding(.top).padding(.trailing,28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                //MARK: LOGIN BOTTON
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login").font(.subheadline).fontWeight(.semibold).foregroundColor(.white).frame(width: 360, height: 44).background(Color(.systemBlue)).cornerRadius(10)
                }
                .padding(.vertical)
                
                //MARK: FACEBOOK LOGIN
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    Text("OR").font(.footnote).fontWeight(.semibold)
                    Rectangle().frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .foregroundColor(.gray)
                
                HStack {
                    Image("fb").resizable().frame(width: 20, height: 20)
                    Text("Continue with facebook").font(.footnote).fontWeight(.semibold).foregroundColor(Color(.systemBlue))
                }
                .padding(.top, 0)
                
                Spacer()
                
                //MARK: SIGN UP LOGIN
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account")
                        
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LoginView()
}
