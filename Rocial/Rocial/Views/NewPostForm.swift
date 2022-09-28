//
//  NewPostForm.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/12/22.
//

import SwiftUI

struct NewPostForm: View {
    @StateObject var viewModel: FormViewModel<Post>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                }
                Section("Content") {
                    TextEditor(text: $viewModel.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: viewModel.submit) {
                    if viewModel.isWorking {
                        ProgressView()
                    }else{
                        Text("Create Post")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(viewModel.submit)
            .navigationTitle("New Post")
            .onChange(of: viewModel.isWorking) { isWorking in
                guard !isWorking, viewModel.error == nil else { return }
                dismiss()
            }
        }
        .alert("Cannot create post", error: $viewModel.error)
        .disabled(viewModel.isWorking)
    }
    
 
}
enum FormState {
    case idle, working, error
    var isError: Bool {
        get {
            self == .error
        }
        set {
            guard !newValue else { return }
            self = .idle
        }
    }
}

struct NewPostForm_Previews: PreviewProvider {
    static var previews: some View {
        NewPostForm(viewModel: FormViewModel(initialValue: Post.testPost, action: { _ in }))
    }
}
