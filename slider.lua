slider = class()
function slider:init(length,min,max,x,y,startPos,callback1,callback2)
    self.length = length
    self.min = min
    self.max = max
    self.pos = vec2(x,y)
    self.buttonPos = startPos
    self.isTouching = false
    self.num = 0
    self.callback1=callback1
    self.callback2=callback2
end
function slider:draw()
    stroke(255, 255, 255, 255)
    strokeWidth(2)
    line(self.pos.x,self.pos.y+self.length/2,self.pos.x,self.pos.y-self.length/2+(self.length-self.buttonPos))
    stroke(64, 64, 64, 255)
    line(self.pos.x,self.pos.y+self.length/2-self.buttonPos,self.pos.x,self.pos.y-self.length/2)
    
    fill(255, 255, 255, 255)
    ellipse(self.pos.x,self.pos.y+self.length/2-self.buttonPos,29,29)
    
    self.num = self.buttonPos*((self.max-self.min)/self.length)
end
function slider:touched(touch)
    if touch.state == BEGAN and touch.y >=self.pos.y+self.length/2-self.buttonPos-25 and touch.y <=self.pos.y+self.length/2-self.buttonPos+25 and touch.x >= self.pos.x-25 and touch.x <= self.pos.x+25 then
        self.isTouching = true
        self.callback1()
    end
    
    if touch.state ~= ENDED and self.isTouching == true then
        if touch.y>=self.pos.y-self.length/2 and touch.y<=self.pos.y+self.length/2 then
            self.buttonPos = self.pos.y+self.length/2-touch.y
        end
        if touch.y<=self.pos.y-self.length/2 then
            self.buttonPos = self.length
        end
        if touch.y>=self.pos.y+self.length/2 then
            self.buttonPos = 0
        end
    end
    
    if touch.state == ENDED and self.isTouching==true then
        self.isTouching = false
        self.callback2()
    end
    
    
end
