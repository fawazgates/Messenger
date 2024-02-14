import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)

                } else {
                    HStack(alignment: .bottom, spacing: 8) {
                        CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)
                        
                        Text(message.messageText)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray4))
                            .foregroundColor(.black)
                            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                        
                        Spacer()
                    }
                }
            }
        .padding(.horizontal, 8)
    }
}

//#Preview {
  //  ChatMessageCell(isFromCurrentUser: false)
//}
