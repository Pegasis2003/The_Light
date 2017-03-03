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
