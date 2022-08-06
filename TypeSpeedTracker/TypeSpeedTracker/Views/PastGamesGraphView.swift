import Foundation
import SwiftUI
import SwiftUICharts
 
struct PastGamesGraphView: View {
    @ObservedObject var view_model = PastGamesGraphViewModel()
    
    var body: some View {
        VStack {
            if (view_model.sufficient_games) {
                
                Text("WPM Over Time")
                //The following repository was used for displaying graphs: https://github.com/willdale/SwiftUICharts
                FilledLineChart(chartData: view_model.graphData)
                          .yAxisLabels(chartData: view_model.graphData)
                          .infoBox(chartData: view_model.graphData)
                          .headerBox(chartData: view_model.graphData)
                          .legends(chartData: view_model.graphData, columns: [GridItem(.flexible()), GridItem(.flexible())])
                          .id(view_model.graphData.id)
                          .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 250, maxHeight: 400, alignment: .center)
                          .navigationTitle("Title")
            } else {
                Text("Complete more games to see your progress")
            }
        }
    }
}
