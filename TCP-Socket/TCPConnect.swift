//
//  TCPConnect.swift
//  TCP-Socket
//
//  Created by Maximilian Gravemeyer on 18.12.20.
//

import Foundation
import Network

    class TCPConnect: NSObject {
    private var talking: NWConnection?
    private var listening: NWListener?

    func receive(on connection: NWConnection) {
        connection.receiveMessage { (data, context, isComplete, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data, !data.isEmpty {
                let backToString = String(decoding: data, as: UTF8.self)
                print("b2S",backToString)
            }
        }
    }
        func listenTCP(host: NWEndpoint.Host,port: NWEndpoint.Port) {
        do {
            let parameters = NWParameters.tcp.copy()
            parameters.requiredLocalEndpoint = .hostPort(host: host, port: port)
            self.listening = try NWListener(using: parameters)
            self.listening?.stateUpdateHandler = {(newState) in
                switch newState {
                case .ready:
                print("ready")
                default:
                break
                }
            }
        self.listening?.newConnectionHandler = {(newConnection) in
            newConnection.stateUpdateHandler = {newState in
                switch newState {
                    case .ready:
                    print("new connection")
                    self.receive(on: newConnection)
                    default:
                    break
                }
            }
            newConnection.start(queue: DispatchQueue(label: "new client"))
        }
        } catch {
        print("unable to create listener")
        }
        self.listening?.start(queue: .main)
    }
}
