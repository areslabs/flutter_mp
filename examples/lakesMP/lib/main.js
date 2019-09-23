Component({
    properties: {},
    attached() {
        var uiDesStr = wx.__self.getUides('__main__')
        //TODO 替换为更加高效的方式
        var uiDes = JSON.parse(uiDesStr)
        this.setData({
            _r: uiDes
        })
    },
})