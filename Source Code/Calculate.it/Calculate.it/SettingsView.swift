//
//  SettingsView.swift
//  Calculate.it
//
//  Created by Mark Howard on 13/08/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
               GroupBox(label: Label("Info", systemImage: "info.circle")) {
                   VStack {
                       HStack {
                           Spacer()
                           VStack {
               Text("Version: 1.1.2")
               Text("Build: 1")
                           }
                           Spacer()
                       }
                   }
               }
               GroupBox(label: Label("Misc.", systemImage: "ellipsis.circle")) {
                   VStack {
                       HStack {
                           Spacer()
                       Button(action: {SendEmail.send()}) {
                           Text("Send Some Feedback")
                       }
                           Spacer()
                       }
                   }
               }
           }
            .padding(20)
            .frame(width: 350, height: 150)
        }
        }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

class SendEmail: NSObject {
    static func send() {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
        service.recipients = ["markhoward2005@gmail.com"]
        service.subject = "Calculate.it Feedback"

        service.perform(withItems: ["Please Fill Out All Necessary Sections:", "Report A Bug - ", "Rate The App - ", "Suggest An Improvment - "])
    }
}
