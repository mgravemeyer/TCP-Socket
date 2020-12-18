//
//  ContentView.swift
//  TCP-Socket
//
//  Created by Maximilian Gravemeyer on 18.12.20.
//

import SwiftUI
import Network

struct ContentView: View {
    let communication = TCPConnect()
    let ip = NWEndpoint.Host.init("127.0.0.1")
    let port = NWEndpoint.Port.init(integerLiteral: 1984)
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                communication.listenTCP(host: ip ,port: port)
            }
    }
}
