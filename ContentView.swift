//
//  ContentView.swift
//  QuickCalc
//
//  Created by Matthew Yien on 4/29/25.
//

import SwiftUI

enum CalcButton: String {
    case one = "1", two = "2", three = "3", four = "4", five = "5"
    case six = "6", seven = "7", eight = "8", nine = "9", zero = "0"
    case add = "+", subtract = "-", divide = "÷", multiply = "x"
    case equal = "=", clear = "AC", decimal = ".", modulo = "%"
    case negpos = "-/+"
    case empty = "" // Placeholder button
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negpos, .modulo:
            return Color(.lightGray)
        case .empty:
            return .clear
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, modulo, none
}

struct ContentView: View {
    @State private var value = "0"
    @State private var runningNumber: Double = 0
    @State private var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negpos, .modulo, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal, .empty] // Add placeholder to complete row
    ]
    
    var operationDisplay: String {
        switch currentOperation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .modulo: return "%"
        case .none: return ""
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Top display
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        if runningNumber != 0 && currentOperation != .none {
                            Text("\(runningNumber.cleanValue) \(operationDisplay)")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        Text(value)
                            .bold()
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            if item == .empty {
                                Color.clear
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                            } else {
                                Button(action: {
                                    self.didTap(button: item)
                                }) {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight()
                                        )
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item) / 2)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .modulo:
            self.currentOperation = {
                switch button {
                case .add: return .add
                case .subtract: return .subtract
                case .multiply: return .multiply
                case .divide: return .divide
                case .modulo: return .modulo
                default: return .none
                }
            }()
            self.runningNumber = Double(self.value) ?? 0
            self.value = "0"
            
        case .equal:
            let currentValue = Double(self.value) ?? 0
            var result: Double = 0
            switch self.currentOperation {
            case .add: result = runningNumber + currentValue
            case .subtract: result = runningNumber - currentValue
            case .multiply: result = runningNumber * currentValue
            case .divide: result = currentValue != 0 ? runningNumber / currentValue : 0
            case .modulo: result = currentValue != 0 ? runningNumber.truncatingRemainder(dividingBy: currentValue) : 0
            case .none: return
            }
            self.value = result.cleanValue
            self.currentOperation = .none
            self.runningNumber = 0
            
        case .clear:
            self.value = "0"
            self.runningNumber = 0
            self.currentOperation = .none
            
        case .decimal:
            if !self.value.contains(".") {
                self.value += "."
            }
            
        case .negpos:
            if let doubleValue = Double(value) {
                self.value = (-doubleValue).cleanValue
            }
            
        default:
            let number = button.rawValue
            if self.value == "0" {
                self.value = number
            } else {
                self.value += number
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

// Format double to remove .0 if not needed
extension Double {
    var cleanValue: String {
        self.truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) :
            String(self)
    }
}