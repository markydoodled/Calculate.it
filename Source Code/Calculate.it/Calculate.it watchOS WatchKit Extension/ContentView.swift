//
//  ContentView.swift
//  Calculate.it watchOS WatchKit Extension
//
//  Created by Mark Howard on 14/08/2021.
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
            return Color(.gray)
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
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ScrollView {
                    Text(value)
                        .bold()
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                }
                .padding()
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {self.didTap(button: .clear)}) {
                            Text("AC")
                                .bold()
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                        row1
                        row2
                        row3
                        row4
                }
            }
        }
        }
        .sheet(isPresented: $showingTip) {
            tip
        }
    }
    var row1: some View {
        HStack {
           Spacer()
            Button(action: {self.didTap(button: .seven)}) {
                Text("7")
                    .bold()
                    .foregroundColor(.white)
            }
            Button(action: {self.didTap(button: .eight)}) {
                Text("8")
                    .bold()
                    .foregroundColor(.white)
            }
            Button(action: {self.didTap(button: .nine)}) {
                Text("9")
                    .bold()
                    .foregroundColor(.white)
            }
            Button(action: {self.didTap(button: .mutliply)}) {
                Text("x")
                    .bold()
                    .foregroundColor(.accentColor)
            }
            Spacer()
        }
    }
    var row2: some View {
        HStack {
            Spacer()
            Button(action: {self.didTap(button: .four)}) {
                 Text("4")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .five)}) {
                 Text("5")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .six)}) {
                 Text("6")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .subtract)}) {
                 Text("-")
                     .bold()
                     .foregroundColor(.accentColor)
             }
             Spacer()
        }
    }
    var row3: some View {
        HStack {
            Spacer()
            Button(action: {self.didTap(button: .one)}) {
                 Text("1")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .two)}) {
                 Text("2")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .three)}) {
                 Text("3")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .add)}) {
                 Text("+")
                     .bold()
                     .foregroundColor(.accentColor)
             }
             Spacer()
        }
    }
    var row4: some View {
        HStack {
            Spacer()
            Button(action: {self.didTap(button: .zero)}) {
                 Text("0")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .tip)}) {
                 Text("$")
                     .bold()
                     .foregroundColor(.white)
             }
            Button(action: {self.didTap(button: .equal)}) {
                 Text("=")
                     .bold()
                     .foregroundColor(.accentColor)
             }
            Button(action: {self.didTap(button: .divide)}) {
                 Text("÷")
                     .bold()
                     .foregroundColor(.accentColor)
             }
             Spacer()
        }
    }
    var percentage: some View {
        Picker("Percentage:", selection: $percentagePick) {
                Text("5%")
            .tag(1)
                Text("10%")
            .tag(2)
                Text("15%")
            .tag(3)
            Text("20%")
        .tag(4)
            Text("25%")
        .tag(5)
            Text("30%")
        .tag(6)
            Text("35%")
        .tag(7)
            Text("40%")
        .tag(8)
            Text("45%")
        .tag(9)
            Text("50%")
        .tag(10)
        }
        .navigationTitle("Percentage")
    }
    var person: some View {
        Picker("People:", selection: $peoplePick) {
            Text("1")
                .tag(1)
            Text("2")
                .tag(2)
            Text("3")
                .tag(3)
            Text("4")
                .tag(4)
            Text("5")
                .tag(5)
        }
            .navigationTitle("People")
    }
    var tip: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        TextField("Enter Total...", text: $tipText)
                            .onReceive(Just(tipText)) { newValue in
                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                            if filtered != newValue {
                                                self.tipText = filtered
                                            }
                                    }
                    }
                    NavigationLink(destination: percentage) {
                        Text("Percentage")
                    }
                    NavigationLink(destination: person) {
                        Text("People")
                    }
                    HStack {
                        Spacer()
                        Text("\(tipToPay) For \(peopleNumber)")
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
                        print("Error Percentage Selection")
                    }
                    }) {
                        Text("Calculate")
                            .bold()
                            .foregroundColor(.accentColor)
                            .padding()
                    }
                }
            .padding()
                .navigationTitle("Tip")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {self.showingTip = false}) {
                            Text("Done")
                        }
                    }
                }
        }
    }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
