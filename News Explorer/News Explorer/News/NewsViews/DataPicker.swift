//
//  DataPicker.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 05.10.2023.
//

import SwiftUI

struct DateFilterView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var dateFilterEnabled: Bool

    var body: some View {
        VStack {
            Toggle("Enable Date Filter", isOn: $dateFilterEnabled)
                .font(.headline)
            if dateFilterEnabled {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            }
        }
        .padding(.horizontal, 50)
    }
}

