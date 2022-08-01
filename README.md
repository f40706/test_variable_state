//每次更新TestSubView重新建立時，如果View id沒有改變，等於生命週期尚未結束時

//Binding、State、StateObject皆不會被清除

//ObservedObject就算是UI刷新都會被清除


//將下方的.id(count)打開強制結束生命週期時

//除了Binding沒有被清除

//其餘State、StateObject、ObservedObject全部被清除

詳細參考TestUIView.swift
