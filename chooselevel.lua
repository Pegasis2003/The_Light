chooselevel = class()

function chooselevel:init()
    self.UIs={}
    
    for i=1,4 do
        for ii=1,5 do
            self.UIs[(i-1)*5+ii]=button((i-1)*5+ii,WIDTH/6*ii,(HEIGHT-100)-(HEIGHT-100)/5*i,100,100)
            self.UIs[(i-1)*5+ii].show=true
            self.UIs[(i-1)*5+ii].fontSize=40
            self.UIs[(i-1)*5+ii].callback=function()
                Game[#Game+1]=game(self.chapter,(i-1)*5+ii)
                changeTo(Game[#Game])
            end
        end
    end
    
    self.before=touchArea(WIDTH-200,HEIGHT-90,100,100,function()
        if self.chapter~="X" then
            self.chapter=self.chapter-1
            if self.chapter==0 then
                self.chapter="X"
            end
        end
    end)
    self.next=touchArea(WIDTH-100,HEIGHT-90,100,100,function()
        if self.chapter=="X" then
            self.chapter=1
        else
            self.chapter=self.chapter+1
        end
    end)
    
    self.back=touchArea(300,HEIGHT-90,550,150,function() changeTo(Start) end)
    
    self.chapter=1
    
    self.chapterDraw={}
    self.chapterDraw["X"]=function()
        textMode(CENTER)
        fontSize(27)
        font("Helvetica")
        fill(255, 255, 255, 255)
        text("此区域暂未开放",WIDTH/2,HEIGHT/2+30)
        text("你可以在这里制作属于自己的关卡",WIDTH/2,HEIGHT/2)
        text("或导入其他人的关卡",WIDTH/2,HEIGHT/2-30)
    end
    self.chapterDraw[1]=function()
        for i=1,#self.UIs do
            self.UIs[i]:draw(self.chapter,i)
        end
    end
    
    self.chapterTouched={}
    self.chapterTouched["X"]=function(t)
        
    end
    self.chapterTouched[1]=function(t)
        for i=1,#self.UIs do
            self.UIs[i]:touched(t)
        end
    end
    
end

function chooselevel:draw()
    background(0, 0, 0, 255)
    
    textMode(CORNER)
    fontSize(70)
    if self.back.istouching then
        fill(127, 127, 127, 255)
    else
        fill(255, 255, 255, 255)
    end
    font("HelveticaNeue-UltraLight")
    text("C H A P T E R   "..self.chapter,50,HEIGHT-120)
    textMode(CENTER)
    font("HelveticaNeue-Light")
    if self.chapter~="X" then
        if self.before.istouching then
            fill(127, 127, 127, 255)
        else
            fill(255, 255, 255, 255)
        end
        text("<",WIDTH-200,HEIGHT-80)
    end
    if self.chapter~=1 then
        if self.next.istouching then
            fill(127, 127, 127, 255)
        else
            fill(255, 255, 255, 255)
        end
        text(">",WIDTH-100,HEIGHT-80)
    end
    
    font("CourierNewPSMT")
    
    self.chapterDraw[self.chapter]()
end


function chooselevel:touched(t)
    self.chapterTouched[self.chapter](t)

    self.back:touched(t)
    
    if self.chapter~="X" then
        self.before:touched(t)
    end
    if self.chapter~=1 then
        self.next:touched(t)
    end
end

function chooselevel:collide(c)
    
end
