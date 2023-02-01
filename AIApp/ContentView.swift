//
//  ContentView.swift
//  AIApp
//
//  Created by Steve Bernard on 31/01/2023.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(models, id: \.self) { string in
                    Text(string)
                }
            }
        }
        
            Spacer()
            
            HStack {
                TextField("Type here...", text: $text)
                Button("Send") {
                    send()
                    self.text = ""
                }
            }
        
        .onAppear {
            viewModel.setup()
        }
        .padding()
    }
    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        models.append("Me: \(text)")
        viewModel.send(text: text) { response in
            DispatchQueue.main.sync {
                self.models.append("AI: "+response)
                self.text = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
