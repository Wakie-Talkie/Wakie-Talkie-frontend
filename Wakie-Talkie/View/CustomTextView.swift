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
    var textColor = UIColor(Color("Black"))
    var borderColor: UIColor
    var height: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
      //  textView.text = placeholder
      //  textView.textColor = placeholderColor
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5) // 상단 여백 추가
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.tag = 100 // Tag to identify the placeholder label
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)
        placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8).isActive = true

        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if let placeholderLabel = uiView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !text.isEmpty
        }
        uiView.text = text
        uiView.textColor = textColor
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
            if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = true
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
                    placeholderLabel.isHidden = false
                }
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = !textView.text.isEmpty
            }
        }
    }
}
