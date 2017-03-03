displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_ANY)
function setup()
    local success=function(data)
        Update=update()
        load("Update.updateData="..data)()
        up=true
    end
    local fail=function() alert("fail","") close() end
    http.request("https://raw.githubusercontent.com/Pegasis2003/The_Light/master/updateData.txt",success,fail)
end

function draw()
    if up then
        Update:draw()
    else
        background(0, 0, 0, 255)
        textMode(CORNER)
        fontSize(60)
        fill(255, 255, 255, 255)
        font("HelveticaNeue-Light")
        text("CONNECTING......",50,HEIGHT-120)
    end
end

function touched(t)
    if up then
        Update:touched(t)
    end
end

function wait(time,callback)
    local a={}
    a.b=time
    tween(time,a,{b=0},tween.easing.linear,callback)
end

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
        local fail=function() self.downloadError() close() end
        http.request("https://raw.githubusercontent.com/Pegasis2003/The_Light/master/"..self.updateData.classes[self.downloadNum]..".lua",success,fail)
            
    end
    
    self.update=button("UPDATE",200,150,200,100,function()
        self.updating=true
        wait(1,self.download())
        self.timeOutId=tween(30,self,{timeOut=0},tween.easing.linear,
        function()
            self.timeOutError() close()
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

button = class()

function button:init(tex,x,y,wid,hei,callback)
    self.x=x
    self.y=y
    self.wid=wid
    self.hei=hei
    self.text=tex
    self.istouching=false
    self.fontSize=30
    self.callback=callback or function() end
    self.show=false
end

function button:draw(c,l)
    rectMode(CENTER)
    textMode(CENTER)
    strokeWidth(3)
    stroke(255, 255, 255, 255)
    fill(0, 0, 0, 255)
    if self.istouching then fill(255, 255, 255, 255) end
    rect(self.x,self.y,self.wid,self.hei)
    fill(255, 255, 255, 255)
    if self.istouching then fill(0, 0, 0, 255) end
    fontSize(self.fontSize)
    text(self.text,self.x,self.y)
    if self.show then
        strokeWidth(2)
        noSmooth()
        if data[c][l][1]==true then
            stroke(255, 255, 255, 255)
        else
            stroke(100, 100, 100, 255)
        end
        line(self.x-45,self.y-40,self.x-17,self.y-40)
        if data[c][l][2]==true then
            stroke(255, 255, 255, 255)
        else
            stroke(100, 100, 100, 255)
        end
        line(self.x-15,self.y-40,self.x+15,self.y-40)
        if data[c][l][3]==true then
            stroke(255, 255, 255, 255)
        else
            stroke(100, 100, 100, 255)
        end
        line(self.x+17,self.y-40,self.x+45,self.y-40)
        smooth()
    end
end

function button:touched(t)
    if t.x>self.x-self.wid/2 and t.x<self.x+self.wid/2 and t.y>self.y-self.hei/2 and t.y<self.y+self.hei/2 then
        if t.state==BEGAN or t.state==MOVING then
            self.istouching=true
            
        end
        if t.state==ENDED and self.istouching==true then
            self.istouching=false
            self.callback()
        end
    else
        self.istouching=false
    end
end

processBar = class()

function processBar:init(tex,x,y,w,h)
    self.text=tex
    self.x=x
    self.y=y
    self.h=h
    self.w=w
    self.process=0
end

function processBar:draw()
    rectMode(CENTER)
    strokeWidth(3)
    stroke(255, 255, 255, 255)
    fill(0, 0, 0, 255)
    rect(self.x,self.y,self.w,self.h)
    
    fontSize(25)
    textMode(CORNER)
    fill(127, 127, 127, 255)
    text(self.text,self.x-self.w/2+20,self.y-13)
    
    rectMode(CORNER)
    fill(255, 255, 255, 255)
    rect(self.x-self.w/2,self.y-self.h/2,self.w*self.process,self.h)
    
    clip(self.x-self.w/2,self.y-self.h/2,self.w*self.process,self.h)
    fill(0, 0, 0, 255)
    text(self.text,self.x-self.w/2+20,self.y-13)
    clip()
end

function processBar:touched(touch)
    
end
