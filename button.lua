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
