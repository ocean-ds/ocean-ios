////
////  teste.swift
////  OceanComponents
////
////  Created by Acassio Mendonça on 04/03/24.
////
//
//import SwiftUI
//import Charts
//
//struct MyChart: UIViewRepresentable {
//    let entries: [PieChartDataEntry]
//
//    func makeUIView(context: Context) -> some PieChartView {
//        return PieChartView()
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        let dataSet = PieChartDataSet(entries: entries)
//        uiView.data = PieChartData(dataSet: dataSet)
//    }
//}
//
//struct MyChart_Previews: PreviewProvider {
//    static var previews: some View {
//        MyChart(entries: [.init(value: 10),
//                          .init(value: 20),
//                          .init(value: 30),
//                          .init(value: 40),
//                          .init(value: 100)])
//    }
//}
