start = class()

function start:init()
    self.shu=HEIGHT
    self.hen=0
    self.istouching=false
end

function start:draw()
    background(0, 0, 0, 255)
    
    textMode(CENTER)
    rectMode(CENTER)
    strokeWidth(3)
    
    --底层
    fill(255, 255, 255, 255)
    fontSize(120)
    font("HelveticaNeue-UltraLight")
    text("The Light",WIDTH/2,HEIGHT/3*2.3)
    fontSize(20)
    font("HelveticaNeue-Light")
    text("By @Pegasis",WIDTH-70,20)
    fill(0, 0, 0, 255)
    if self.istouching then fill(255, 255, 255, 255) end
    stroke(255, 255, 255, 255)
    rect(WIDTH/2,HEIGHT/3,300,70)
    fill(255, 255, 255, 255)
    if self.istouching then fill(0, 0, 0, 255) end
    fontSize(30)
    text("开 始 游 戏",WIDTH/2,HEIGHT/3)
    
    --顶层
    clip(WIDTH/2-self.hen/2,HEIGHT/2-self.shu/2,self.hen,self.shu)
    fill(255, 255, 255, 255)
    rect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    fill(0, 0, 0, 255)
    fontSize(120)
    font("HelveticaNeue-UltraLight")
    text("The Light",WIDTH/2,HEIGHT/3*2.3)
    fontSize(20)
    font("HelveticaNeue-Light")
    text("By @Pegasis",WIDTH-70,20)
    fill(255, 255, 255, 255)
    if self.istouching then fill(0, 0, 0, 255) end
    stroke(0, 0, 0, 255)
    rect(WIDTH/2,HEIGHT/3,300,70)
    fill(0, 0, 0, 255)
    if self.istouching then fill(255, 255, 255, 255) end
    fontSize(30)
    text("开 始 游 戏",WIDTH/2,HEIGHT/3)
    clip()
    
end

function start:touched(t)
    if t.x>WIDTH/2-150 and t.x<WIDTH/2+150 and t.y>HEIGHT/3-35 and t.y<HEIGHT/3+35 then
        if t.state==BEGAN or t.state==MOVING then
            self.istouching=true
            
        end
        if t.state==ENDED and self.istouching==true then
            self.istouching=false
            changeTo(Chooselevel)
        end
    else
        self.istouching=false
    end
end

function start:collide(c)
    
end
