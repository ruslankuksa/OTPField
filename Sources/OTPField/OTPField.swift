
import SwiftUI


public struct OTPFieldView: View {
    
    private enum OTPFieldStyle {
        case square
        case roundedSquare(CGFloat)
        case underline
    }
    
    public var otpLength = 6
    public var spacing: CGFloat = 16
    @Binding public var otpCode: String
    @FocusState private var focus: Bool
    
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                ZStack {
                    TextField("OTPField", text: $otpCode)
                        .frame(width: 0, height: 0, alignment: .center)
                        .focused($focus, equals: true)
                        .keyboardType(.numberPad)
                        .onChange(of: otpCode) { _ in
                            handleInput()
                            debugPrint(otpCode)
                        }
                    
                    HStack(spacing: spacing) {
                        ForEach(0..<otpLength, id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .strokeBorder(Color.black, lineWidth: 1)
                                    .frame(width: 40, height: 40)
                                
                                text(for: index)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .onAppear {
                focus = true
            }
        }
    }
    
    @ViewBuilder
    private func text(for index: Int) -> some View {
        if otpCode.count > index {
            Text(otpCode[index])
        } else {
            Text("")
        }
    }
    
    private func handleInput() {
        let numbers = otpCode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if numbers.count > otpLength {
            otpCode = String(numbers.prefix(otpLength))
        } else {
            otpCode = numbers
        }
    }
    
    private func otpFiledStyle(_ style: OTPFieldStyle) {
        // TODO: - Add different styles
    }
}
