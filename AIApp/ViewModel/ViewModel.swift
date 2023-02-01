//
//  ViewModel.swift
//  AIApp
//
//  Created by Steve Bernard on 31/01/2023.
//

import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) ->Void) {
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
}
