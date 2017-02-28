 
--# info

-- Build 585
-- Mon Feb 27 19:26:12 2017

-- The Light
-- by @mbhhc
-- 感谢 @破晓_年华 的优化
-- 感谢 @dt_st9 的秒针

--# Main

supportedOrientations(LANDSCAPE_ANY)
displayMode(OVERLAY)
displayMode(FULLSCREEN)

function setup()
    
    if readText("Documents:lTimes")==nil then
        saveText("Documents:lTimes","0")
        saveText("Documents:rTimes","0")
    end
    
    lunchTimes=tonumber(readText("Documents:lTimes"))
    restartTimes=tonumber(readText("Documents:rTimes"))
    
    if lunchTimes==restartTimes then
        lunchTimes=lunchTimes+1
        saveText("Documents:lTimes",lunchTimes)
        restart()
    else
        restartTimes=lunchTimes
        saveText("Documents:rTimes",restartTimes)
        --[=[
        saveProjectTab("info","\n"..[[-- Build ]]..lunchTimes.."\n"..[[-- ]]..os.date().."\n\n"..[[-- The Light
-- by @mbhhc
-- 感谢 @破晓_年华 的优化
-- 感谢 @dt_st9 的秒针
]])
        --]=]
    end

    
    --程序正式开始
    print("Hello Light!")
    
    parameter.action("CLEAN",function()
        for i=1,20 do
            saveText("Documents:".."c1l"..i,"false,false,false")
        end
        
        data={}
        data[1]={}
        for i=1,20 do
            data[1][i]={}
            data[1][i][1],data[1][i][2],data[1][i][3]=load("return "..readText("Documents:".."c1l"..i))()
        end
        print("Cleaned")
    end)
    parameter.boolean("win_test",true)
    
    Start=start()
    function StartLoop()
        tween(2,Start,{hen=WIDTH},tween.easing.cubicOut,
        function() tween(2,Start,{shu=0},tween.easing.cubicIn,
        function() tween(2,Start,{shu=HEIGHT},tween.easing.cubicOut,
        function() tween(2,Start,{hen=0},tween.easing.cubicIn,
        function() Start.shu=HEIGHT Start.hen=0 StartLoop() 
        end) end) end) end)
    end
    StartLoop()
    
    Chooselevel=chooselevel()
    
    Game={}
    
    nowActivity=Start
    coverAlpha=0
    
    if readText("Documents:c1l1")==nil then
        for i=1,20 do
            saveText("Documents:".."c1l"..i,"false,false,false")
        end
    end
    
    data={}
    data[1]={}
    for i=1,20 do
        data[1][i]={}
        data[1][i][1],data[1][i][2],data[1][i][3]=load("return "..readText("Documents:".."c1l"..i))()
    end
    
end

function draw()
    nowActivity:draw()
    rectMode(CORNER)
    resetMatrix()
    fill(0, 0, 0, coverAlpha)
    noStroke()
    rect(-5,-5,WIDTH+5,HEIGHT+5)
end

function touched(t)
    if not pauseTouch then
        nowActivity:touched(t)
    end
end

function collide(c)
    nowActivity:collide(c)
end

function changeTo(name)
    if coverid then
        tween.stop(coverid)
    end
    pauseTouch=true
    tween(1,_G,{coverAlpha=255},tween.easing.linear,
    function()
        pauseTouch=false
        nowActivity=name
        coverid=tween(1,_G,{coverAlpha=0},tween.easing.linear)
    end)
end

function makeBox(x,y,w,h,r)
    
    local body = physics.body(POLYGON,vec2(-w/2, h/2),
    vec2(-w/2, -h/2), vec2(w/2, -h/2), vec2(w/2, h/2))
    
    body.x = x
    body.y = y
    body.angle = r
    
    body.interpolate = true
    
    return body
end

function drawBody(body,colo)
    pushStyle()
    pushMatrix()
    
    noStroke()
    fill(colo,colo,colo,255)
    translate(body.x, body.y)
    rotate(body.angle)
    
    if body.shapeType == POLYGON then
        
        local points = body.points
        polygon(table.unpack(points))
        
    elseif body.shapeType == CIRCLE then
        
        ellipse(0,0,body.radius*2)
    end
    
    popMatrix()
    popStyle()
end

function math.little(num)
    return num-math.floor(num)
end

function wait(time,callback)
    local a={}
    a.b=time
    tween(time,a,{b=0},tween.easing.linear,callback)
end

function polygon(...)
    
    local tab={...}
    local m=mesh()
    m.vertices=triangulate(tab)
    m:setColors(fill())
    m:draw()
    
    for k,v in pairs(tab) do
        
        if k>=2 then
            line(v.x,v.y,tab[k-1].x,tab[k-1].y)
        end
        
        if k==#tab then
            line(v.x,v.y,tab[1].x,tab[1].y)
        end
    end
end
--# sounds
sounds={
"ZgBAWQBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAUwBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBATABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBARgBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAQABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAOQBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAMwBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBALABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAJgBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAIABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",

"ZgBAIABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAJgBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBALABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAMwBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAOQBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAQABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBARgBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBATABAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAUwBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
"ZgBAWQBAQEBAQEBAywlPPh9mAT9T51A+VQBAf0BAQEBAQEBA",
}

local num=1

function gameSound()
    sound(DATA,sounds[num])
    num=num+1
    if num>#sounds then
        num=1
    end
end

function gameSoundReset()
    num=1
end

--# levels
--[[
方块类型代码：
灰色目标方块：1
白色反射方块：2
中空吸光方块：3
可旋转方块：4
]]

levels={{}}
levels[1][1]={
{WIDTH/2, HEIGHT/4*1, WIDTH/50,HEIGHT/2, 0},
{WIDTH/2, HEIGHT/8*7, WIDTH/3,WIDTH/50, 0},
lightStart=vec2(WIDTH/5,HEIGHT/5),
lightEnd={WIDTH/4*3, HEIGHT/8, WIDTH/3,WIDTH/50, 0},
lightTime=5.5,
achievement={
{name="从正面击中灰色方块以通关",func=function(c,t)
    if c.y>HEIGHT/8 then
        return true
    else
        return false
    end
end},
{name="从反面击中灰色方块以通关",func=function(c,t)
    if c.y<HEIGHT/8 then
        return true
    else
        return false
    end
end},
{name="被方块反射3次后通关",func=function(c,t,ct)
    if t==3 then
        return true
    else
        return false
    end
end}
},
--teach={"大家好我是新手教程","你需要让光线射入灰色的方块中以通过游戏","看到右边的滑条了吗？","你可以滑动它来改变光线射出的方向","点击右上角的关卡数即可查看本关要完成的成就","祝你找到光明！"}
}

levels[1][2]={
{WIDTH/4, HEIGHT/2+WIDTH/4, WIDTH/50,HEIGHT/3, -45},
{WIDTH/4*3, HEIGHT/2+WIDTH/4, WIDTH/50,HEIGHT/3, 45},
{WIDTH/4, HEIGHT/2-WIDTH/4, WIDTH/50,HEIGHT/3, 45},
{WIDTH/4*3, HEIGHT/2-WIDTH/4, WIDTH/50,HEIGHT/4, -45},
{WIDTH/20*19,HEIGHT/2,WIDTH/50,HEIGHT/4,-35},
lightStart=vec2(WIDTH/2,HEIGHT/2),
lightEnd={WIDTH/4*3+WIDTH/50, HEIGHT/2-WIDTH/4-WIDTH/50, WIDTH/50,HEIGHT/3, -45},
lightTime=3.5,
achievement={
{name="不击中屏幕边缘以通关",func=function(c,t,ct)
    if ct==0 then
        return true
    else
        return false
    end
end},
{name="击中屏幕边缘1次以通关",func=function(c,t,ct)
    if ct==1 then
        return true
    else
        return false
    end
end},
{name="击中屏幕边缘2次以通关",func=function(c,t,ct)
    if ct==2 then
        return true
    else
        return false
    end
end}
}
}

levels[1][3]={
{WIDTH/2, HEIGHT/2+HEIGHT/20, WIDTH/50,HEIGHT/2+HEIGHT/10, 0},
{WIDTH/2, HEIGHT/4, WIDTH/2,WIDTH/50, 0},
lightStart=vec2(WIDTH/2,HEIGHT/6),
lightEnd={WIDTH/2+WIDTH/50, HEIGHT/2-HEIGHT/10,WIDTH/50,HEIGHT/4, 0},
lightTime=10,
achievement={
{name="击中灰色方块以通关",func=function(c,t)
    return true
end},
{name="碰撞屏幕边缘5次以通关",func=function(c,t,ct)
    if ct==5 then
        return true
    else
        return false
    end
end},
{name="被方块反射3次后通关",func=function(c,t,ct)
    if t==3 then
        return true
    else
        return false
    end
end}
},
}

--# start
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

--# chooselevel
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
    
    self.before=button3(WIDTH-200,HEIGHT-90,100,100,function()
        if self.chapter~="X" then
            self.chapter=self.chapter-1
            if self.chapter==0 then
                self.chapter="X"
            end
        end
    end)
    self.next=button3(WIDTH-100,HEIGHT-90,100,100,function()
        if self.chapter=="X" then
            self.chapter=1
        else
            self.chapter=self.chapter+1
        end
    end)
    
    self.back=button3(300,HEIGHT-90,550,150,function() changeTo(Start) end)
    
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
--# game
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
    
    self.slider=UISlider(HEIGHT-150,0,6.28,WIDTH-70,HEIGHT/2,0,
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
                
                saveText("Documents:".."c"..self.chapernum.."l"..self.levelnum,achieve[1]..","..achieve[2]..","..achieve[3])
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
--# button
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

--# button2
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

--# button3
button3=class()

function button3:init(x,y,wid,hei,callback)
    self.x=x
    self.y=y
    self.wid=wid
    self.hei=hei
    self.istouching=false
    self.callback=callback or function() end
end

function button3:draw()
    rectMode(CENTER)
    fill(0, 0, 0, 0)
    stroke(255, 255, 255, 255)
    strokeWidth(4)
    rect(self.x,self.y,self.wid,self.hei)
end

function button3:touched(t)
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
--# slider
UISlider = class()
function UISlider:init(length,min,max,x,y,startPos,callback1,callback2)
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
function UISlider:draw()
    stroke(255, 255, 255, 255)
    strokeWidth(2)
    line(self.pos.x,self.pos.y+self.length/2,self.pos.x,self.pos.y-self.length/2+(self.length-self.buttonPos))
    stroke(64, 64, 64, 255)
    line(self.pos.x,self.pos.y+self.length/2-self.buttonPos,self.pos.x,self.pos.y-self.length/2)
    
    fill(255, 255, 255, 255)
    ellipse(self.pos.x,self.pos.y+self.length/2-self.buttonPos,29,29)
    
    self.num = self.buttonPos*((self.max-self.min)/self.length)
end
function UISlider:touched(touch)
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
