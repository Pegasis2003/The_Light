game = class()

function game:init(chapter,level)
    self.level=levels[chapter][level]
    self.chapernum=chapter
    self.levelnum=level
    self.gameState=1
    self.istouching=false
    self.lightStartCircleWidth=5
    gameSoundReset()
    fontSize(30)
    function self.nextTeach()
        if self.level.teach[self.teach+1]~=nil then
            self.nextTeachTime=textSize(self.level.teach[self.teach])/160
            tween(self.nextTeachTime,self,{nextTeachTime=0},tween.easing.linear,function()
                tween(0.7,self,{teach=self.teach+1},tween.easing.cubicInOut,function()
                    self.nextTeach()
                end)
            end)
        else
            self.nextTeachTime=textSize(self.level.teach[self.teach])/160
            tween(self.nextTeachTime,self,{nextTeachTime=0},tween.easing.linear,function()
                tween(1,self,{teachMove=-150},tween.easing.cubicInOut,function()
                    self.teach=0
                end)
            end)
        end
    end
    if self.level.teach~=nil then
        self.teach=1
        self.teachMove=-150
        wait(1,function()
            tween(1,self,{teachMove=0},tween.easing.cubicInOut,function() self.nextTeach() end)
        end)
    else
        self.teach=0
    end
    
    self.achievementMove=0
    self.achievementButton1=button("",50,HEIGHT-50,200,100,function()
        tween(0.7,self,{achievementMove=200},tween.easing.cubicInOut)
    end)
    self.achievementButton2=button("",50,HEIGHT-250,200,100,function()
        tween(0.7,self,{achievementMove=0},tween.easing.cubicInOut)
    end)
    
    physics.gravity(0,0)
    physics.continuous=true
    physics.resume()
    
    self.boxes={}
    self.boxes[1]=makeBox(5,HEIGHT/2,10,HEIGHT,0)
    self.boxes[1].type=STATIC
    self.boxes[2]=makeBox(WIDTH-5,HEIGHT/2,10,HEIGHT,0)
    self.boxes[2].type=STATIC
    self.boxes[3]=makeBox(WIDTH/2,5,WIDTH,10,0)
    self.boxes[3].type=STATIC
    self.boxes[4]=makeBox(WIDTH/2,HEIGHT-5,WIDTH,10,0)
    self.boxes[4].type=STATIC
    for i=5,#self.level+4 do
        local box=makeBox(table.unpack(self.level[i-4]))
        box.type=STATIC
        box.friction=0
        self.boxes[#self.boxes+1]=box
    end
    self.boxes.lightEnd=makeBox(table.unpack(self.level.lightEnd))
    self.boxes.lightEnd.type=STATIC
    
    self.lightStart=self.level.lightStart
    
    self.light=physics.body(CIRCLE,5)
    self.light.x=self.lightStart.x
    self.light.y=self.lightStart.y
    self.light.bullet=true
    self.light.interpolate=true
    self.light.restitution=1
    self.light.friction=0
    
    self.lightPath={alpha=255,x=self.light.x,y=self.light.y}
    self.lightTime=self.level.lightTime
    
    self.circus={}
    
    function self.initLight()
        self.lightMoveid=tween(self.level.lightTime,self,{lightTime=0},tween.easing.linear,function()
            physics.pause()
            self.gameState=1
            self.collideTime=0
            self.collideClipTime=0
            tween(1,self,{lightStartCircleWidth=5},tween.easing.cubicIn)
            tween(0.7,self,{sliderTranslate=0},tween.easing.cubicOut)
            self.light.linearVelocity=vec2(0,0)
            self.light.x=self.lightStart.x
            self.light.y=self.lightStart.y
            self.lightPath={alpha=255,x=self.light.x,y=self.light.y}
            
            self.lightTime=self.level.lightTime
            physics.resume()
        end)
    end
    
    self.slider=slider(HEIGHT-150,0,6.28,WIDTH-70,HEIGHT/2,0,
    function() end,
    function()
        self.initLight()
        self.light:applyForce(vec2(self.forceX,self.forceY))
        tween(1,self,{lightStartCircleWidth=0},tween.easing.cubicOut)
        tween(0.7,self,{sliderTranslate=200},tween.easing.cubicIn)
        self.gameState=2
    end)
    self.b1=button2("NEXT",WIDTH-200,HEIGHT/6*3,300,70,function()
        physics.pause()
        for i=1,#self.boxes do
            self.boxes[i]:destroy()
        end
        self.boxes.lightEnd:destroy()
        self.light:destroy()
        Game[#Game+1]=game(self.chapernum,self.levelnum+1)
        changeTo(Game[#Game])
    end)
    self.b2=button2("RESTART",WIDTH-200,HEIGHT/6*2,300,70,function()
        tween(0.7,self.win,{alpha=0},tween.easing.linear,function()
            tween(1.3,self.win,{x=self.boxes.lightEnd.x,y=self.boxes.lightEnd.y,w=self.level.lightEnd[3],h=self.level.lightEnd[4],col=127,angle=self.boxes.lightEnd.angle},tween.easing.cubicInOut,function()
                self.win.is=0
            end)
        end)
        self.collideTime=0
        self.lightStartCircleWidth=5
        self.sliderTranslate=0
        self.gameState=1
        self.circus={}
        gameSoundReset()
        physics.pause()    
        self.light.linearVelocity=vec2(0,0)
        self.light.x=self.lightStart.x
        self.light.y=self.lightStart.y
        self.lightPath={alpha=255,x=self.light.x,y=self.light.y}
        
        self.lightTime=self.level.lightTime
        self.readyMap=image(WIDTH,HEIGHT)
        setContext(self.readyMap)
        fill(255, 255, 255, 255)
        noStroke()
        for i=1,#self.boxes do
            drawBody(self.boxes[i],255)
        end
        drawBody(self.boxes.lightEnd,127)
        setContext()
        physics.resume()
    end)
    self.b3=button2("CHOOSE LEVEL",WIDTH-200,HEIGHT/6*1,300,70,function()
        for i=1,#self.boxes do
            self.boxes[i]:destroy()
        end
        self.boxes.lightEnd:destroy()
        self.light:destroy()
        changeTo(Chooselevel)
    end)
    
    self.readyMap=image(WIDTH,HEIGHT)
    setContext(self.readyMap)
    fill(255, 255, 255, 255)
    noStroke()
    for i=1,#self.boxes do
        drawBody(self.boxes[i],255)
    end
    drawBody(self.boxes.lightEnd,127)
    setContext()
    
    self.sliderTranslate=0
    
    self.win={x=self.boxes.lightEnd.x,y=self.boxes.lightEnd.y,w=self.level.lightEnd[3],h=self.level.lightEnd[4],col=127,alpha=0,angle=self.boxes.lightEnd.angle,is=0}
    
    self.collideTime=0
    self.collideClipTime=0
    self.achievement={}
    self.achievement[1]=data[self.chapernum][self.levelnum][1]
    self.achievement[2]=data[self.chapernum][self.levelnum][2]
    self.achievement[3]=data[self.chapernum][self.levelnum][3]
    
end

function game:draw()
    background(0, 0, 0, 255)
    
    if self.gameState==2 then
        setContext(self.readyMap)
        stroke(self.lightPath.alpha,255)
        strokeWidth(3)
        smooth()
        line(self.light.x,self.light.y,self.lightPath.x,self.lightPath.y)
        setContext()
        
        self.lightPath={alpha=self.lightTime/self.level.lightTime*255,x=self.light.x,y=self.light.y}
    end
    sprite(self.readyMap,WIDTH/2,HEIGHT/2)
    
    
    fill(0, 0, 0, 0)
    strokeWidth(10)
    for i=1,#self.circus do
        local v=self.circus[i]
        if self.circus[i].num~=1 then
            stroke(255, 255, 255, 255*(1-v.num))
            ellipse(v.x,v.y,255*v.num)
        end
    end
    
    if self.slider.isTouching==true then
        strokeWidth(4)
        stroke(185, 185, 185, 255)
        self.forceX,self.forceY = 50* math.sin(self.slider.num),50* math.cos(self.slider.num)
        line(self.lightStart.x,self.lightStart.y,self.forceX*7+self.lightStart.x,self.forceY*7+self.lightStart.y)
    end
    
    fill(0, 0, 0, 255)
    stroke(255, 255, 255, 255)
    strokeWidth(self.lightStartCircleWidth)
    ellipse(self.lightStart.x,self.lightStart.y,30)
    
    fill(255, 255, 255, 255)
    fontSize(20)
    font("HelveticaNeue-Light")
    textMode(CORNER)
    text("CHAPTER  "..self.chapernum.."\nLEVEL  "..self.levelnum,20,HEIGHT-60-self.achievementMove)
    
    translate(self.sliderTranslate,0)
    self.slider:draw()
    translate(-self.sliderTranslate,0)
    
    rectMode(CENTER)
    fill(self.win.col,255)
    noStroke()
    
    if self.win.is~=0 then
        translate(self.win.x,self.win.y)
        rotate(self.win.angle)
        polygon(vec2(-self.win.w/2,-self.win.h/2),vec2(-self.win.w/2,self.win.h/2),vec2(self.win.w/2,self.win.h/2),vec2(self.win.w/2,-self.win.h/2))
        resetMatrix()
        
        fill(0,0,0,self.win.alpha)
        fontSize(200)
        textMode(CENTER)
        font("HelveticaNeue-UltraLight")
        text("P A S S",WIDTH/2,HEIGHT/5*4)
        font("HelveticaNeue-Light")
        fontSize(17)
        text("C H A P T E R   "..self.chapernum.."      L E V E L  "..self.levelnum,WIDTH/2,HEIGHT/5*4+100)
        
        self.b1:draw(self.win.alpha)
        self.b2:draw(self.win.alpha)
        self.b3:draw(self.win.alpha)
        
        font("Helvetica")
        fontSize(24)
        textMode(CORNER)
        fill(0, 0, 0, self.win.alpha)
        for i=1,#self.level.achievement do
            text(self.level.achievement[i].name,50,HEIGHT/6*(4-i)-12)
        end
        
        for i=1,#self.achievement do
            if self.achievement[i] then
                text("完成",450,HEIGHT/6*(4-i)-12)
            else
                text("未完成",450,HEIGHT/6*(4-i)-12)
            end
        end
    end
    
    if self.teach~=0 then
        rectMode(CORNER)
        fill(255, 255, 255, 255)
        noStroke()
        rect(0,0+self.teachMove,WIDTH,150)
        fill(0, 0, 0, 255)
        fontSize(30)
        textMode(CORNER)
        text(self.level.teach[math.floor(self.teach)],50-math.little(self.teach)*WIDTH,55+self.teachMove)
        text(self.level.teach[math.floor(self.teach)+1] or "",50+WIDTH-math.little(self.teach)*WIDTH,55+self.teachMove)
    end
    
    if self.achievementMove~=0 then
        rectMode(CORNER)
        fill(255, 255, 255, 255)
        noStroke()
        rect(0,HEIGHT-self.achievementMove,WIDTH,200)
        fill(0, 0, 0, 255)
        fontSize(30)
        font("Helvetica")
        textMode(CORNER)
        text("成就",50,HEIGHT+150-self.achievementMove)
        fontSize(20)
        for i=1,#self.level.achievement do
            text(self.level.achievement[i].name,100,HEIGHT+105-((i-1)*40)-self.achievementMove)
        end
        
        for i=1,#self.achievement do
            if self.achievement[i] then
                text("完成",WIDTH-200,HEIGHT+105-((i-1)*40)-self.achievementMove)
            else
                text("未完成",WIDTH-200,HEIGHT+105-((i-1)*40)-self.achievementMove)
            end
        end
    end
    
end

function game:touched(t)
    if self.teach==0 then
        if self.gameState==1 then
            if self.achievementMove==0 then
                self.achievementButton1:touched(t)
                self.slider:touched(t)
            elseif self.achievementMove==200 then
                self.achievementButton2:touched(t)
            end
        elseif self.gameState==2 then
            if self.achievementMove==0 then
                self.achievementButton1:touched(t)
            elseif self.achievementMove==200 then
                self.achievementButton2:touched(t)
            end
        elseif self.gameState==3 then
            self.b1:touched(t)
            self.b2:touched(t)
            self.b3:touched(t)
        end
    else
        
    end
end

function game:collide(c)
    local a=true
    if c.state==BEGAN then
        for i=1,4 do
            if c.bodyA==self.boxes[i] or c.bodyB==self.boxes[i] then
                self.collideClipTime=self.collideClipTime+1
                a=false
            end
        end
        if a then
            if not (c.bodyA==self.boxes.lightEnd or c.bodyB==self.boxes.lightEnd) then
                self.collideTime=self.collideTime+1
            end
        end
    end
    
    if c.state==0 then
        gameSound()
        
        self.circus[#self.circus+1]={num=0,x=c.points[1].x,y=c.points[1].y}
        tween(0.7,self.circus[#self.circus],{num=1},tween.easing.linear)
        
        if win_test then
            if c.bodyA==self.boxes.lightEnd or c.bodyB==self.boxes.lightEnd then
                for i=1,#self.achievement do
                    if not self.achievement[i] then
                        self.achievement[i]=self.level.achievement[i].func(vec2(c.points[1].x,c.points[1].y),self.collideTime,self.collideClipTime)
                    end
                end
                
                self.collideTime=0
                self.collideClipTime=0
                
                local achieve={}
                achieve[1],achieve[2],achieve[3]="false","false","false"
                for i=1,#self.achievement do
                    if  self.achievement[i] then
                        achieve[i]="true"
                        data[self.chapernum][self.levelnum][1]=self.achievement[i]
                    end
                    
                end
                
                saveText("Project:".."c"..self.chapernum.."l"..self.levelnum,achieve[1]..","..achieve[2]..","..achieve[3])
                tween.stop(self.lightMoveid)
                physics.pause()
                self.win.is=1
                tween(1,self,{achievementMove=0},tween.easing.cubicInOut)
                tween(1.3,self.win,{x=WIDTH/2,y=HEIGHT/2,w=WIDTH,h=HEIGHT,col=255,angle=0},tween.easing.cubicInOut,function()
                    tween(1,self,{achievementMove=0},tween.easing.cubicInOut)
                    tween(0.7,self.win,{alpha=255},tween.easing.linear)
                    self.gameState=3
                    
                end)
                tween.stop(self.lightMoveid)
                
            end
        end
        
    end
    
end
