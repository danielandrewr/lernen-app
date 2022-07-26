//
//  UIHelper.swift
//  Lernen
//
//  Created by Daniel Roong on 21/07/22.
//

import SwiftUI

extension View {
    
    func leadingHelper() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func trailingHelper() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func centerHelper() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func safeAreaBounds() -> UIEdgeInsets {
        guard let bounds = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeAreaBounds = bounds.windows.first?.safeAreaInsets else { return .zero }
        
        return safeAreaBounds
    }
    
    func dotShaped(isToday: Bool) -> some View {
        self.frame(width: 45, height: 80)
            .background(
                ZStack {
                    if isToday {
                        Capsule()
                            .fill(Color.Primary)
                            .matchedGeometryEffect(id: "todaysdate", in: JourneyView().focus)
                    }
                })
            
    }
}
