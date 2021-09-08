//
//  ContentView.swift
//  Calculate.it iOS
//
//  Created by Mark Howard on 06/08/2021.
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
            return Color(.secondaryLabel)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
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
    @State var percentageNumber = "5%"

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
                            Button(action: {UIPasteboard.general.string = value}) {
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
        NavigationView {
            GroupBox(label: Label("Tip", systemImage: "dollarsign.circle")) {
                VStack {
                    HStack {
                        Text("Total: ")
                        Spacer()
                        TextField("Enter Total...", text: $tipText)
                            .keyboardType(.decimalPad)
                            .onReceive(Just(tipText)) { newValue in
                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                            if filtered != newValue {
                                                self.tipText = filtered
                                            }
                                    }
                    }
                    HStack {
                        Picker("Percentage: \(percentageNumber)", selection: $percentagePick) {
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
                        .onChange(of: percentagePick) { new in
                            if percentagePick == 1 {
                                percentageNumber = "5%"
                            } else if percentagePick == 2 {
                                percentageNumber = "10%"
                            } else if percentagePick == 3 {
                                percentageNumber = "15%"
                            } else if percentagePick == 4 {
                                percentageNumber = "20%"
                            } else if percentagePick == 5 {
                                percentageNumber = "25%"
                            } else if percentagePick == 6 {
                                percentageNumber = "30%"
                            } else if percentagePick == 7 {
                                percentageNumber = "35%"
                            } else if percentagePick == 8 {
                                percentageNumber = "40%"
                            } else if percentagePick == 9 {
                                percentageNumber = "45%"
                            } else if percentagePick == 10 {
                                percentageNumber = "50%"
                            } else {
                                print("Error")
                            }
                        }
                    }
                    HStack {
                        Picker("People: \(peopleNumber)", selection: $peoplePick) {
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
                        Text("Tip To Pay: \(tipToPay) For 1 Person")
                        Spacer()
                    }
                    Button(action: {if percentagePick == 1 {
                        var _1div = 0.00
                        _1div = Double(tipText) ?? 0
                        print(_1div)
                        _1div = _1div / 100
                        print(_1div)
                        _1div = _1div * 5
                        print(_1div)
                        tipToPay = String(format: "%.2f", _1div)
                    } else if percentagePick == 2 {
                        var _2div = 0.00
                        _2div = Double(tipText) ?? 0
                        print(_2div)
                        _2div = _2div / 100
                        print(_2div)
                        _2div = _2div * 10
                        print(_2div)
                        tipToPay = String(format: "%.2f", _2div)
                    } else if percentagePick == 3 {
                        var _3div = 0.00
                        _3div = Double(tipText) ?? 0
                        print(_3div)
                        _3div = _3div / 100
                        print(_3div)
                        _3div = _3div * 15
                        print(_3div)
                        tipToPay = String(format: "%.2f", _3div)
                    } else {
                      print("Error Percentage Selection")
                    }
                    }) {
                        Text("Calculate Tip...")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)).foregroundColor(.accentColor))
                    }
                }
            }
            .padding()
                .navigationTitle("Tip")
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {self.showingTip = false}) {
                            Text("Done")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {hideKeyboard()}) {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
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
            return ((UIScreen.main.bounds.width - (3*12)) / 5) * 5
        }
        if item == .divide {
            return ((UIScreen.main.bounds.width - (5*12)) / 5) * 2
        }
        if item == .add {
            return ((UIScreen.main.bounds.width - (5*12)) / 5) * 2
        }
        if item == .subtract {
            return ((UIScreen.main.bounds.width - (5*12)) / 5) * 2
        }
        if item == .mutliply {
            return ((UIScreen.main.bounds.width - (5*12)) / 5) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 5
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
