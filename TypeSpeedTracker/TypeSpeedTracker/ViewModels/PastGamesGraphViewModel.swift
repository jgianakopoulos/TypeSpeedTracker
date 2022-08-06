import Foundation
import SwiftUICharts

class PastGamesGraphViewModel : PastGamesViewModel {
    var sufficient_games: Bool = false
    override init() {
        super.init()
        formatForLineGraph()
    }

    @Published var graphData: LineChartData = LineChartData(
        dataSets: LineDataSet(
            dataPoints: [],
            legendTitle:"Words Per Minute",
            style:LineStyle(lineColour: ColourStyle(colour: .blue),
            lineType: .curvedLine)))
    
    func formatForLineGraph() {
        self.fetchPastGames()
        var lineGraphData = [LineChartDataPoint]()
        
        if (pastGames.count < 2) {
            sufficient_games = false
            return
        }
        
        sufficient_games = true
        for (index, game) in pastGames.enumerated() {
            let value = LineChartDataPoint(value:game.wpm,xAxisLabel: String(index), description:game.author)
            lineGraphData.append(value);
        }
        
        self.graphData = LineChartData(
            dataSets: LineDataSet(dataPoints: lineGraphData,
                             legendTitle:"Words Per Minute",
                             style:LineStyle(lineColour: ColourStyle(colour: .blue), lineType: .line))
        )
    }
}
