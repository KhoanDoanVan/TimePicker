//
//  ContentView.swift
//  TimePicker
//
//  Created by Đoàn Văn Khoan on 30/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    var body: some View {
        HStack(spacing: 0) {
            CustomView("hours", 0...24, $hours)
            CustomView("mins", 0...60, $minutes)
            CustomView("secs", 0...60, $seconds)
        }
    }
    
    @ViewBuilder
    private func CustomView(
        _ title: String,
        _ range: ClosedRange<Int>,
        _ selection: Binding<Int>
    ) -> some View {
        PickerViewWithoutIndicator(selection: selection) {
            ForEach(range, id: \.self) { value in
                Text("\(value)")
                    .frame(width: 35, alignment: .trailing)
                    .tag(value)
                    .offset(x: -30)
            }
        }
        .overlay {
            Text(title)
                .font(.callout)
                .frame(width: 50, alignment: .leading)
                .lineLimit(1)
                .offset(x: 20)
        }
    }
}

// MARK: - Helper
struct PickerViewWithoutIndicator<Content: View, Selection: Hashable>: View {
    
    @Binding var selection: Selection
    @ViewBuilder var content: Content
    @State private var isHidden: Bool = false
    
    var body: some View {
        Picker("", selection: $selection) {
            if !isHidden {
                RemovePickerIndicator {
                    isHidden = true
                }
                
                content
            }
        }
        .pickerStyle(.wheel)
    }
}

fileprivate
struct RemovePickerIndicator: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
//        DispatchQueue.main.async {
//            if let pickerView = view.pickerView {
//                if pickerView.subviews.count >= 2 {
//                    pickerView.subviews[1].backgroundColor = .clear
//                }
//                result()
//            }
//        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

fileprivate
extension UIView {
    var pickerView: UIPickerView? {
        if let view = superview as? UIPickerView {
            return view
        }
        
        return superview?.pickerView
    }
}

#Preview {
    ContentView()
}
