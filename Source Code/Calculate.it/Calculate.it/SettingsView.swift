//
//  SettingsView.swift
//  Calculate.it
//
//  Created by Mark Howard on 13/08/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        GroupBox(label: Label("Misc.", systemImage: "ellipsis.circle")) {
                    VStack {
                        HStack {
                            Text("Version")
                                .bold()
                            Spacer()
                            Text("1.0")
                        }
                        .padding(.bottom)
                        HStack {
                            Text("Build")
                                .bold()
                            Spacer()
                            Text("1")
                        }
                    }
                    .padding()
                }
                .padding()
                .frame(width: 300, height: 150)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
