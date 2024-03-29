//
//  CardView.swift
//  FlashCard
//
//  Created by Daichi Morihara on 2022/01/16.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)?
    @State private var showingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                if showingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(dragGesture)
        .onTapGesture {
            showingAnswer.toggle()
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                feedback.prepare()
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    // remove card
                    if offset.width > 0 {
                        feedback.notificationOccurred(.success)
                    } else {
                        feedback.notificationOccurred(.error)
                    }
                    removal?()
                } else {
                    offset = .zero
                }
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
