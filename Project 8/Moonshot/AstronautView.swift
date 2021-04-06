//
//  AstronautView.swift
//  Moonshot
//
//  Created by Piotr Chojnowski on 31/03/2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    Image(self.astronaut.id)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    Text(self.astronaut.name)
                        .bold()
                        .padding(.top)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Missions taken part in: ")
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        ForEach(missions) { mission in
                            HStack {
                                Image(systemName: "square.fill")
                                    .font(.caption)
                                Text(mission.displayName)
                                    .padding(.vertical, 4)
                            }
                            .padding([.leading, .trailing], 16)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
                    Spacer()
                }
            }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
