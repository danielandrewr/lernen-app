//
//  CircularProgressBar.swift
//  Lernen
//
//  Created by Daniel Roong on 25/07/22.
//

import SwiftUI

struct CircularProgressBar: View {
    
    // MARK: ProgressBar Indicators
    @State var progress: Float
    @State var circleProgress: Float = 0.0
    @State var counter = 0
    
    var body: some View {
        ZStack {
            // MARK: Base Circle
            Circle()
                .stroke(
                    Color.Primary.opacity(0.4),
                    lineWidth: 20
                )
                .foregroundColor(Color.gray)
                .frame(width: 250, height: 250)
            
            // MARK: Progress Circle
            Circle()
                .trim(from: 0, to: CGFloat(circleProgress))
                .stroke(
                    Color.Tertiary,
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .onAppear(perform: { self.animateProgressBar() })
            
            Text(" \(Int(self.counter * 100))%")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(Color.Primary)
                .padding()
                .centerHelper()
                .onAppear {
                    self.animateProgressCount(counter: self.$counter)
                }
        }
    }
    
    // MARK: Animate the CircularProgressBar on View Appearing
    func animateProgressBar() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            withAnimation {
                if self.circleProgress >= self.progress {
                    timer.invalidate()
                } else {
                    self.circleProgress += self.progress
                }
            }
        }
    }
    
    func animateProgressCount(counter: Binding<Int>) {
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            withAnimation {
                counter.wrappedValue += 1
                if counter.wrappedValue == Int(progress) {
                    timer.invalidate()
                }
            }
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(progress: 0.55)
            .frame(width: 250, height: 250, alignment: .center)
    }
}
