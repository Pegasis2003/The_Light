touchArea=class()

function touchArea:init(x,y,wid,hei,callback)
    self.x=x
    self.y=y
    self.wid=wid
    self.hei=hei
    self.istouching=false
    self.callback=callback or function() end
end

function touchArea:draw()
    rectMode(CENTER)
    fill(0, 0, 0, 0)
    stroke(255, 255, 255, 255)
    strokeWidth(4)
    rect(self.x,self.y,self.wid,self.hei)
end

function touchArea:touched(t)
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
