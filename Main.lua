supportedOrientations(LANDSCAPE_ANY)
displayMode(OVERLAY)
displayMode(FULLSCREEN)

function setup()
    
    if readText("Project:userGroup")==nil then
        saveText("Project:userGroup","Player")
    end
    userGroup=readText("Project:userGroup")
    
    if readText("Project:lTimes")==nil then
        saveText("Project:lTimes","0")
        saveText("Project:rTimes","0")
    end
    
    lunchTimes=tonumber(readText("Project:lTimes"))
    restartTimes=tonumber(readText("Project:rTimes"))
    
    if lunchTimes==restartTimes then
        lunchTimes=lunchTimes+1
        saveText("Project:lTimes",lunchTimes)
        restart()
    else
        restartTimes=lunchTimes
        saveText("Project:rTimes",restartTimes)
    end
    
    --用户组
    if userGroup=="Developer" then
        saveProjectTab("info","\n"..[[   build=]]..lunchTimes.."\n"..[[-- ]]..os.date().."\n\n"..[[-- The Light
-- by @mbhhc
-- 感谢 @破晓_年华 的优化
-- 感谢 @dt_st9 的秒针
]])
            
        parameter.action("CLEAN",function()
            for i=1,20 do
                saveText("Project:".."c1l"..i,"false,false,false")
            end
                    
            data={}
            data[1]={}
            for i=1,20 do
                data[1][i]={}
                data[1][i][1],data[1][i][2],data[1][i][3]=load("return "..readText("Project:".."c1l"..i))()
            end
            print("Cleaned")
        end)
        parameter.boolean("win_test",true)
    else
        win_test=false
    end
    
    --更新检测
    local success=function(data)
        Update=update()
        load("Update.updateData="..data)()
        if Update.updateData.build>build then
            changeTo(Update)
        end
    end
    local fail=function() end
    http.request("https://raw.githubusercontent.com/Pegasis2003/The_Light/master/updateData.txt",success,fail)
    
    --程序正式开始
    print("Hello Light!")
    
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
    
    if not Update then
        Update=update()
    end
    --nowActivity=Update
    nowActivity=Start
    
    coverAlpha=0
    
    if readText("Project:c1l1")==nil then
        for i=1,20 do
            saveText("Project:".."c1l"..i,"false,false,false")
        end
    end
    
    data={}
    data[1]={}
    for i=1,20 do
        data[1][i]={}
        data[1][i][1],data[1][i][2],data[1][i][3]=load("return "..readText("Project:".."c1l"..i))()
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
