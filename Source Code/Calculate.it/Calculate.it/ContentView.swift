//
//  ContentView.swift
//  Calculate.it
//
//  Created by Mark Howard on 13/08/2021.
//

import SwiftUI
import Combine

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    case tip = "Tip"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .accentColor
        case .clear, .negative, .percent, .tip:
            return Color(.secondaryLabelColor)
        default:
            return Color(NSColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}


struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State var showingTip = false
    @State var tipText = ""
    @State var tipToPay = "0.00"
    @State var percentagePick = 1
    @State var peoplePick = 1
    @State var peopleNumber = "1 Person"
    let buttons: [[CalcButton]] = [
        [.clear],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .tip, .equal, .divide],
    ]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    ScrollView {
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .contextMenu {
                            Button(action: {NSPasteboard.general.setString(value, forType: .string)}) {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                        }
                }
                }
                .padding()
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding(.bottom, 3)
                }
                .padding(.bottom)
            }
        }
        .sheet(isPresented: $showingTip) {
            tip
        }
    }
    var tip: some View {
            GroupBox(label: Label("Tip", systemImage: "dollarsign.circle")) {
                VStack {
                    HStack {
                        Text("Total: ")
                        Spacer()
                        TextField("Enter Total...", text: $tipText)
                            .onReceive(Just(tipText)) { newValue in
                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                            if filtered != newValue {
                                                self.tipText = filtered
                                            }
                                    }
                    }
                    HStack {
                        Picker("Percentage:", selection: $percentagePick) {
                            Button(action: {}) {
                                Text("5%")
                            }
                            .tag(1)
                            Button(action: {}) {
                                Text("10%")
                            }
                            .tag(2)
                            Button(action: {}) {
                                Text("15%")
                            }
                            .tag(3)
                            Button(action: {}) {
                                Text("20%")
                            }
                            .tag(4)
                            Button(action: {}) {
                                Text("25%")
                            }
                            .tag(5)
                            Button(action: {}) {
                                Text("30%")
                            }
                            .tag(6)
                            Button(action: {}) {
                                Text("35%")
                            }
                            .tag(7)
                            Button(action: {}) {
                                Text("40%")
                            }
                            .tag(8)
                            Button(action: {}) {
                                Text("45%")
                            }
                            .tag(9)
                            Button(action: {}) {
                                Text("50%")
                            }
                            .tag(10)
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    HStack {
                        Picker("People:", selection: $peoplePick) {
                            Button(action: {}) {
                                Text("1 Person")
                            }
                            .tag(1)
                            Button(action: {}) {
                                Text("2 People")
                            }
                            .tag(2)
                            Button(action: {}) {
                                Text("3 People")
                            }
                            .tag(3)
                            Button(action: {}) {
                                Text("4 People")
                            }
                            .tag(4)
                            Button(action: {}) {
                                Text("5 People")
                            }
                            .tag(5)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: peoplePick) { new in
                            if peoplePick == 1 {
                                peopleNumber = "1 Person"
                            } else if peoplePick == 2 {
                                peopleNumber = "2 People"
                            } else if peoplePick == 3 {
                                peopleNumber = "3 People"
                            } else if peoplePick == 4 {
                                peopleNumber = "4 People"
                            } else if peoplePick == 5 {
                                peopleNumber = "5 People"
                            } else {
                                print("Error")
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        Text("Tip To Pay: \(tipToPay) For \(peopleNumber)")
                        Spacer()
                    }
                    HStack {
                    Button(action: {if percentagePick == 1 {
                        var _1div = 0.00
                        _1div = Double(tipText) ?? 0
                        print(_1div)
                        _1div = _1div / 100
                        print(_1div)
                        _1div = _1div * 5
                        print(_1div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _1div = _1div / 2
                        } else if peoplePick == 3 {
                            _1div = _1div / 3
                        } else if peoplePick == 4 {
                            _1div = _1div / 4
                        } else if peoplePick == 5 {
                            _1div = _1div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _1div)
                    } else if percentagePick == 2 {
                        var _2div = 0.00
                        _2div = Double(tipText) ?? 0
                        print(_2div)
                        _2div = _2div / 100
                        print(_2div)
                        _2div = _2div * 10
                        print(_2div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _2div = _2div / 2
                        } else if peoplePick == 3 {
                            _2div = _2div / 3
                        } else if peoplePick == 4 {
                            _2div = _2div / 4
                        } else if peoplePick == 5 {
                            _2div = _2div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _2div)
                    } else if percentagePick == 3 {
                        var _3div = 0.00
                        _3div = Double(tipText) ?? 0
                        print(_3div)
                        _3div = _3div / 100
                        print(_3div)
                        _3div = _3div * 15
                        print(_3div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _3div = _3div / 2
                        } else if peoplePick == 3 {
                            _3div = _3div / 3
                        } else if peoplePick == 4 {
                            _3div = _3div / 4
                        } else if peoplePick == 5 {
                            _3div = _3div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _3div)
                    } else if percentagePick == 4 {
                        var _4div = 0.00
                        _4div = Double(tipText) ?? 0
                        print(_4div)
                        _4div = _4div / 100
                        print(_4div)
                        _4div = _4div * 20
                        print(_4div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _4div = _4div / 2
                        } else if peoplePick == 3 {
                            _4div = _4div / 3
                        } else if peoplePick == 4 {
                            _4div = _4div / 4
                        } else if peoplePick == 5 {
                            _4div = _4div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _4div)
                    } else if percentagePick == 5 {
                        var _5div = 0.00
                        _5div = Double(tipText) ?? 0
                        print(_5div)
                        _5div = _5div / 100
                        print(_5div)
                        _5div = _5div * 25
                        print(_5div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _5div = _5div / 2
                        } else if peoplePick == 3 {
                            _5div = _5div / 3
                        } else if peoplePick == 4 {
                            _5div = _5div / 4
                        } else if peoplePick == 5 {
                            _5div = _5div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _5div)
                    } else if percentagePick == 6 {
                        var _6div = 0.00
                        _6div = Double(tipText) ?? 0
                        print(_6div)
                        _6div = _6div / 100
                        print(_6div)
                        _6div = _6div * 30
                        print(_6div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _6div = _6div / 2
                        } else if peoplePick == 3 {
                            _6div = _6div / 3
                        } else if peoplePick == 4 {
                            _6div = _6div / 4
                        } else if peoplePick == 5 {
                            _6div = _6div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _6div)
                    } else if percentagePick == 7 {
                        var _7div = 0.00
                        _7div = Double(tipText) ?? 0
                        print(_7div)
                        _7div = _7div / 100
                        print(_7div)
                        _7div = _7div * 35
                        print(_7div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _7div = _7div / 2
                        } else if peoplePick == 3 {
                            _7div = _7div / 3
                        } else if peoplePick == 4 {
                            _7div = _7div / 4
                        } else if peoplePick == 5 {
                            _7div = _7div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _7div)
                    } else if percentagePick == 8 {
                        var _8div = 0.00
                        _8div = Double(tipText) ?? 0
                        print(_8div)
                        _8div = _8div / 100
                        print(_8div)
                        _8div = _8div * 40
                        print(_8div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _8div = _8div / 2
                        } else if peoplePick == 3 {
                            _8div = _8div / 3
                        } else if peoplePick == 4 {
                            _8div = _8div / 4
                        } else if peoplePick == 5 {
                            _8div = _8div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _8div)
                    } else if percentagePick == 9 {
                        var _9div = 0.00
                        _9div = Double(tipText) ?? 0
                        print(_9div)
                        _9div = _9div / 100
                        print(_9div)
                        _9div = _9div * 45
                        print(_9div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _9div = _9div / 2
                        } else if peoplePick == 3 {
                            _9div = _9div / 3
                        } else if peoplePick == 4 {
                            _9div = _9div / 4
                        } else if peoplePick == 5 {
                            _9div = _9div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _9div)
                    } else if percentagePick == 10 {
                        var _10div = 0.00
                        _10div = Double(tipText) ?? 0
                        print(_10div)
                        _10div = _10div / 100
                        print(_10div)
                        _10div = _10div * 50
                        print(_10div)
                        if peoplePick == 1 {
                            print("1 Person Do Nothing")
                        } else if peoplePick == 2 {
                            _10div = _10div / 2
                        } else if peoplePick == 3 {
                            _10div = _10div / 3
                        } else if peoplePick == 4 {
                            _10div = _10div / 4
                        } else if peoplePick == 5 {
                            _10div = _10div / 5
                        } else {
                            print("Error People Pick")
                        }
                        tipToPay = String(format: "%.2f", _10div)
                    } else {
                        print("Error Percentage Pick")
                    }
                    }) {
                        Text("Calculate Tip...")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)).foregroundColor(.accentColor))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                        Spacer()
                    Button(action: {self.showingTip = false}) {
                        Text("Done")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)).foregroundColor(.accentColor))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .padding()
            .onAppear() {
                if peoplePick == 1 {
                    peopleNumber = "1 Person"
                } else if peoplePick == 2 {
                    peopleNumber = "2 People"
                } else if peoplePick == 3 {
                    peopleNumber = "3 People"
                } else if peoplePick == 4 {
                    peopleNumber = "4 People"
                } else if peoplePick == 5 {
                    peopleNumber = "5 People"
                } else {
                    print("Error")
                }
            }
    }
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide:
                    if value == "0" {
                        print("Divided By Zero")
                    } else {
                        self.value = "\(runningValue / currentValue)"
                    }
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            if button == .negative {
                
            } else if button == .decimal {
                
            } else if button == .percent {
                
            }
        case .tip:
            if button == .tip {
                self.showingTip = true
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }

    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .clear {
            return ((CGFloat(325) - (3*12)) / 5) * 5
        }
        if item == .divide {
            return ((CGFloat(325) - (5*12)) / 5) * 2
        }
        if item == .add {
            return ((CGFloat(325) - (5*12)) / 5) * 2
        }
        if item == .subtract {
            return ((CGFloat(325) - (5*12)) / 5) * 2
        }
        if item == .mutliply {
            return ((CGFloat(325) - (5*12)) / 5) * 2
        }
        return (CGFloat(65) - (5*12) / 5)
    }

    func buttonHeight() -> CGFloat {
        return (CGFloat(65) - (5*12) / 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
