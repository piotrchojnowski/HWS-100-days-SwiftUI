//
//  MissionView.swift
//  Moonshot
//
//  Created by Piotr Chojnowski on 30/03/2021.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
        let missions: [Mission]
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    
                    Text(mission.launchDate?.formattedString() ?? "N/A")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    
                    Text(self.mission.description)
                        .layoutPriority(1)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination:
                                        AstronautView(astronaut: crewMember.astronaut, missions: crewMember.missions)) {
                            
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 92, height: 64, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundColor(.primary)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, allMissions: [Mission], astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                
                let astronautMissions = allMissions.filter { (mission) -> Bool in
                    mission.crew.contains { (role) -> Bool in
                        role.name == match.id
                    }
                }
                
                matches.append(CrewMember(role: member.role, astronaut: match, missions: astronautMissions))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
}

private extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], allMissions: [], astronauts: astronauts)
    }
}
