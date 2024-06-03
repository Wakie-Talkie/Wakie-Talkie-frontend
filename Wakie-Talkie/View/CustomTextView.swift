//
//  CustomTextView.swift
//  Wakie-Talkie
//
//  Created by jiin on 6/3/24.
//

import SwiftUI

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    var textColor: UIColor
    var borderColor: UIColor
    var height: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = placeholder
        textView.textColor = placeholderColor
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5) // 상단 여백 추가
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty {
            uiView.text = placeholder
            uiView.textColor = placeholderColor
        } else {
            uiView.text = text
            uiView.textColor = textColor
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView

        init(_ parent: CustomTextView) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == parent.placeholderColor {
                textView.text = nil
                textView.textColor = parent.textColor
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = parent.placeholderColor
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
