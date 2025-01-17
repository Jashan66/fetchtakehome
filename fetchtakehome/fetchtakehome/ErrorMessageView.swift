//
//  ErrorMessageView.swift
//  fetchtakehome
//
//  Created by Jashan Rahal on 1/15/25.
//
import SwiftUI


struct ErrorMessageView: View {
    let errorMessage: String
    var body: some View{
        
        Text(errorMessage)
            .font(.headline)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
            .cornerRadius(10)
    }
}
