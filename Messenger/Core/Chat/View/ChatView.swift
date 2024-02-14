import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    var body: some View {
        ScrollView {
            // MARK: HEADER
            
            VStack {
                CircularProfileImageView(user: User.MOCK_USER, size: .xlarge)
                
                VStack(spacing: 4) {
                    
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Messanger")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            // MARK: MESSAGES
            
            ForEach(viewModel.messages) { message in
                ChatMessageCell(message: message)
            }
            
        }
            
            // MARK: MESSAGES INPUT VIEW
            
            
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("message...", text: $viewModel.messagetext, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 40)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messagetext = ""
                } label: {
                    Text("send").fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }


#Preview {
    ChatView(user: User.MOCK_USER)
}
