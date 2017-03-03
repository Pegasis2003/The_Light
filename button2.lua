button2 = class()

function button2:init(tex,x,y,wid,hei,callback)
    self.x=x
    self.y=y
    local w,h=textSize(tex)
    self.wid=wid or w+50
    self.hei=hei or h+50
    self.text=tex
    self.istouching=false
    self.fontSize=30
    self.callback=callback or function() end
    self.alpha=255
end

function button2:draw(a)
    self.alpha=a or self.alpha
    rectMode(CENTER)
    textMode(CENTER)
    strokeWidth(3)
    stroke(0, 0, 0, self.alpha)
    fill(255, 255, 255, self.alpha)
    if self.istouching then fill(0, 0, 0, self.alpha) end
    rect(self.x,self.y,self.wid,self.hei)
    fill(0, 0, 0, self.alpha)
    if self.istouching then fill(255, 255, 255, self.alpha) end
    fontSize(self.fontSize)
    text(self.text,self.x,self.y)
end

function button2:touched(t)
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
