import SwiftUI


extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let grayButton = Color(hex: "#252528")
}

struct ContentView: View {
    
    @StateObject private var calculator: CalculatorViewModel = CalculatorViewModel()
    
    private let buttons = [
        ["AC", "±", "%"],
        ["7","8","9"],
        ["4","5","6"],
        ["1","2","3"],
        ["","0","."]
    ]

    var body: some View {
        VStack {
            Spacer()
            Divider()
            Text(calculator.display)
                .font(.system(size: 200))
                .fontWeight(.light)
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.head)
                .frame(maxWidth: 310, maxHeight: 60, alignment: .trailing)
                .minimumScaleFactor(0.3)
                .padding(.vertical, 35)
            
            Divider()
            HStack(spacing: 15) {
                VStack(spacing: 15) {
                    Row(buttons: buttons[0], foregroundColor: .black, backgroundColor: .gray, calculator: calculator)
                    Row(buttons: buttons[1], backgroundColor: Color.grayButton, calculator: calculator)
                    Row(buttons: buttons[2], backgroundColor: Color.grayButton, calculator: calculator)
                    Row(buttons: buttons[3], backgroundColor: Color.grayButton, calculator: calculator)
                    Row(buttons: buttons[4], backgroundColor: Color.grayButton, calculator: calculator)
//                    HStack {
//                        Button(action: {calculator.touchDigit("0")}, label: {
//                            Text("0")
//                                .foregroundStyle(.white)
//                                .font(.largeTitle)
//                                .frame(minWidth: 50, maxWidth: 180, minHeight: 50, maxHeight: 80)
//                                .background(Color.grayButton)
//                                .shadow(radius: 7)
//                                .cornerRadius(100)
//                        })
//                        Button(action: {calculator.touchDot()}, label: {
//                            Text(".")
//                                .foregroundStyle(.white)
//                                .font(.largeTitle)
//                                .frame(minWidth: 50, maxWidth: 80, minHeight: 50, maxHeight: 80)
//                                .background(Color.grayButton)
//                                .clipShape(Circle())
//                                .shadow(radius: 7)
//                        })
//                    }
                } // VStack
                
                VStack(spacing: 15) {
                    OperatorButton(buttons: ["÷", "×", "−", "+"], calculator: calculator)
                    ButtonView(title: "=", backgroundColor: .orange) { calculator.equalOperation() }
                } // VStack
            }// HStack
            Divider()
        }
        .padding()
        .background(.black)
    }
}

struct Row: View {
    var buttons: [String]
    var foregroundColor: Color = .white
    var backgroundColor: Color
    @ObservedObject var calculator: CalculatorViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(buttons, id: \.self) {
                CalculatorButton(title: $0, foregroundColor: foregroundColor, backgroundColor: backgroundColor, calculator: calculator)
            }
        }
    }
}

struct CalculatorButton: View {
    var title: String
    var foregroundColor: Color = .white
    var backgroundColor: Color
    @ObservedObject var calculator: CalculatorViewModel
    
    var body: some View {
        ButtonView(title: title, foregroundColor: foregroundColor, backgroundColor: backgroundColor) {
            switch title {
            case "AC": calculator.clear()
            case "±": calculator.toggleSign()
            case "%": calculator.calculatePercentage()
            case ".": calculator.touchDot()
            case "" : break
            default : calculator.touchDigit(title)
            }
        }
    }
}

struct OperatorButton: View {
    var buttons: [String]
    @ObservedObject var calculator: CalculatorViewModel
    
    var body: some View {
        ForEach(buttons, id: \.self) { title in
            ButtonView(title: title, backgroundColor: .orange) {
                calculator.setOperation(title)
            }
        }
    }
}

//struct Button: View {
//    let title: String
//    var foregroundColor: Color = .white
//    var backgroundColor: Color
//    let action: () -> Void
//    
//    var body: some View {
//        SwiftUI.Button(action: action) {
//            Text(title)
//                .foregroundStyle(foregroundColor)
//                .font(.largeTitle)
//                .frame(minWidth: 50, maxWidth: 80, minHeight: 50, maxHeight: 80)
//                .background(backgroundColor)
//                .clipShape(Circle())
//                .shadow(radius: 7)
//        }
//    }
//}


struct ButtonView: View {
    let title: String
    var foregroundColor: Color = .white
    var backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .foregroundStyle(foregroundColor)
                .font(.largeTitle)
                .frame(minWidth: 50, maxWidth: 80, minHeight: 50, maxHeight: 80)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(radius: 7)
        })
    }
}

#Preview {
    ContentView()
}
