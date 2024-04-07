//
//  WebSocket.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import Foundation

protocol WebSocketManagerDelegate: AnyObject {
    func didReceiveData(_ data: Data)
    func didCloseConnection(_ manager: WebSocketManager)
}

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    private let url: URL
    weak var delegate: WebSocketManagerDelegate?
    
    init(url: URL) {
        self.url = url
    }
    
    func connectAndSend(query: String) {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        let queryDict = ["query": query]
        if let jsonData = try? JSONSerialization.data(withJSONObject: queryDict, options: []), let jsonString = String(data: jsonData, encoding: .utf8) {
            send(data: jsonString)
        }
        receiveMessage()
    }
    
    private func send(data: String) {
        let message = URLSessionWebSocketTask.Message.string(data)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            }
        }
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket receiving error: \(error)")
                DispatchQueue.main.async {
                    self?.delegate?.didCloseConnection(self!)
                }
            case .success(.string(let response)):
                if let data = response.data(using: .utf8) {
                    self?.delegate?.didReceiveData(data)
                }
                self?.receiveMessage() // Listen for the next message
            case .success(.data(let data)):
                self?.delegate?.didReceiveData(data)
                self?.receiveMessage() // Listen for the next message
            default:
                print("Received unexpected message type")
                self?.receiveMessage()
            }
        }
    }
    
    func close() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
}
