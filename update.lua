update = class()
function update:init()
    self.updating=false
    self.updateData={}
    self.timeOut=30
    self.timeOutId=0
    self.downloadNum=1
    self.updateCode={}
    
    function self.timeOutError()
        alert("连接超时","The Light")
    end
    function self.downloadError()
        alert("下载错误","The Light")
    end
    function self.updateSuccess()
        alert("更新完成","The Light")
    end
    
    function self.download()
        local success=function(data)
            self.updateCode[self.downloadNum]={self.updateData.classes[self.downloadNum],data}
            if self.downloadNum==#self.updateData.classes then
                for i=1,#self.updateCode do
                    saveProjectTab(self.updateCode[i][1],self.updateCode[i][2])
                end
                self.updateSuccess()
                restart()
            else
                self.downloadNum=self.downloadNum+1
                self.download(self.downloadNum)
            end
        end
        local fail=function() self.downloadError() changeTo(Start) end
        http.request("https://raw.githubusercontent.com/Pegasis2003/The_Light/master/"..self.updateData.classes[self.downloadNum]..".lua",success,fail)
            
    end
    
    self.update=button("UPDATE",200,150,200,100,function()
        self.updating=true
        wait(1,self.download())
        self.timeOutId=tween(30,self,{timeOut=0},tween.easing.linear,
        function()
            self.timeOutError() changeTo(Start)
        end)
    end)
    self.update.fontSize=40
    self.cancel=button("CANCEL",WIDTH-200,150,200,100,function() close() end)
    self.cancel.fontSize=40
    
    self.process=processBar("正在下载数据......",WIDTH/2,170,WIDTH-200,70)
end

function update:draw()
    background(0, 0, 0, 255)
    textMode(CORNER)
    fontSize(60)
    fill(255, 255, 255, 255)
    font("Helvetica")
    text("有新版本可用: "..self.updateData.name,50,HEIGHT-120)
    
    font("HelveticaNeue-Light")
    fontSize(27)
    local _,h=textSize(self.updateData.note)
    textWrapWidth(WIDTH-300)
    text(self.updateData.note,150,HEIGHT-h-200)
    textWrapWidth(0)
    
    if not self.updating then
        font("HelveticaNeue-Light")
        self.update:draw()
        self.cancel:draw()
    else
        self.process.process=self.downloadNum/#self.updateData.classes
        self.process:draw()
    end
end

function update:touched(t)
    if not self.updating then
        self.update:touched(t)
        self.cancel:touched(t)
    end
end
