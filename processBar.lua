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
