//
//  JourneyCard.swift
//  Lernen-App
//
//  Created by Daniel Roong on 27/07/22.
//

import SwiftUI

/**
 Bisa filter berdasarkan journey mana yang isActivenya true, lalu sisanya (false) masukin ke section next journey yang disortir berdasarkan date ascending
 */
struct JourneyCard: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("RxSwift")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text("0 of 43 Path(s) completed")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                    .leadingHelper()
    
                    // MARK: Could add edit/delete button
                    
                    Button {
                        
                    } label: {
                        
                    }
                }
            }
            .foregroundColor(Color.Primary)
            .padding(15)
            .leadingHelper()
            .background(
                // Maybe add lineargradient?
                Color.Primary
                    .cornerRadius(10)
            )
        }
    }
}

struct JourneyCard_Previews: PreviewProvider {
    static var previews: some View {
        JourneyCard()
    }
}
