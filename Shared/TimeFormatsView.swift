//
//  TimeFormatsView.swift
//  Memento mori
//
//  Created by lars on 08/08/2020.
//

import SwiftUI

struct TimeFormatsView: View {
    var body: some View {
        #if os (iOS)
        VStack {
            
            VStack {
                VStack {
                    Text("☥")
                        .font(.title2)
                    Text("Total number of days")
                }
                Text("\(totalYMD)")
                    .font(.title2)
                // writing each component separately
//                Text("\(totalDaysYears!)y \(totalDaysMonths!)m \(totalDaysDays!)d")
//                    .font(.title2)
               Text("(\(totalDays!) days)")
            }
            Spacer()
            VStack {
                VStack {
                    Image(systemName: "heart.slash")
                        .foregroundColor(.red)
                    Text("Lived number of days")
                }
                Text("\(livedYMD)")
                    .font(.title2)
                Text("(\(livedDays!) days)")
            }
            Spacer()
            VStack {
                VStack {
                    Image(systemName: "bolt.heart")
                        .foregroundColor(.green)
                    Text("Remaining number of days")
                }
                Text("\(remainingYMD)")
                    .font(.title2)
                Text("(\(remainingDays!) days)")
                
                
            }
            Spacer()
        }
        #elseif os(watchOS)
        VStack {
            
            HStack {
                Text("☥")
                    .font(.title2)
                
                VStack {
//                    Text("\(totalDaysYears!)y \(totalDaysMonths!)m \(totalDaysDays!)d")
//                        .font(.title3)
//                    Text("(\(totalDays!) days)")
                    Text("\(totalYMD)")
                }
                Text("\(totalDays!) days")
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "heart.slash")
                    .foregroundColor(.red)
                
                VStack {
                    Text("\(livedYMD)")
                        .font(.title3)
                        .strikethrough(true, color: Color.red)
                    Text("(\(livedDays!) days)")
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "bolt.heart")
                    .foregroundColor(.green)
                
                VStack {
                    Text("\(remainingYMD)d")
                        .font(.title3)
                    Text("(\(remainingDays!) days)")
                }
            }
           
        }
        #endif
    }
}

struct TimeFormatsView_Previews: PreviewProvider {
    static var previews: some View {
        TimeFormatsView()
    }
}
