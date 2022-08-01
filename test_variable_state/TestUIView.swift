//
//  TestUIView.swift
//  dashcam
//
//  Created by CHUN BI Hsu on 2022/7/31.
//

import SwiftUI
//EnvironmentObject資料共享，搭配environmentObject將資料注入，注入進來的資料不管哪個層級都能夠讀取
//使用上勁量避免使用，除非與整個App較為相關之處，例如風格、螢幕翻轉等等再去使用
//否則管理上會很麻煩，因為他沒有層級問題，程式碼一多，會讓整個變得毫無架構

//每次更新TestSubView重新建立時，如果View id沒有改變，等於生命週期尚未結束時
//EnvironmentObject、Binding、State、StateObject皆不會被清除
//ObservedObject就算是UI刷新都會被清除

//將下方的.id(count)打開強制結束生命週期時
//EnvironmentObject、Binding沒有被清除
//其餘State、StateObject、ObservedObject全部被清除

class TestObservable: ObservableObject {
    @Published var testCount = 0
}

struct TestSubView: View {
    @Binding var testBiding: Int
    @State var testState: Int = 0
    @ObservedObject var testObservable1: TestObservable = TestObservable()
    @StateObject var testObservable2: TestObservable = TestObservable()
    @EnvironmentObject var applicationViewModel: TestObservable
    var body: some View {
        HStack {
            Button(action: {
                testState += 1
                testObservable1.testCount += 1
                testObservable2.testCount += 1
                applicationViewModel.testCount += 1
            }, label: {
                Rectangle().fill(Color.red)
                    .frame(width: 50, height: 50, alignment: .center)
            })
            Text("testBiding = \(testBiding), \n" +
                 "testState = \(testState), \n" +
                 "testObservedObject = \(testObservable1.testCount), \n" +
                 "testStateObject = \(testObservable2.testCount), \n" +
                 "applicationViewModel = \(applicationViewModel.testCount)"
            )
        }
    }
}

struct TestUIView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var count = 0
    var body: some View {
        VStack {
            Button(action: {
                count += 1
            }, label: {
                Rectangle().fill(Color.gray)
                    .frame(width: 50, height: 50, alignment: .center)
            })
            Text("\(count)")
            TestSubView(testBiding: $count)
                .id(count)
        }
    }
}

struct TestUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestUIView()
    }
}
