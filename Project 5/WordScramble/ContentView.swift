//
//  ContentView.swift
//  WordScramble
//
//  Created by Piotr Chojnowski on 22/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                .listStyle(PlainListStyle())
                
                Text("score: \(score)")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(minWidth: 50, idealWidth: 300, maxWidth: .infinity, minHeight: 32, idealHeight: 44, maxHeight: 60, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(6.0)
                    .padding()
                    .shadow(color: .blue, radius: 8, x: 0, y: 2)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button("next word", action: nextGameRound)
                                    .padding()
                                    .frame(width: 128, height: 40, alignment: .center)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }

        usedWords.insert(answer, at: 0)
        score += answer.utf16.count
        newWord = ""
    }
    
    func nextGameRound() {
        usedWords.removeAll()
        startGame()
    }
    
    func startGame() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("missing file!")
        }
        
        guard let startWords = try? String(contentsOf: url) else {
            fatalError("Cannot read file!")
        }
        
        let allWords = startWords.components(separatedBy: .newlines)
        rootWord = allWords.randomElement() ?? "nothing"
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            guard let pos = tempWord.firstIndex(of: letter) else {
                return false
            }
            
            tempWord.remove(at: pos)
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.utf16.count > 2, word != rootWord else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
