-- v190 至尊版·汉化 | 去后门·无付费墙·全功能整合
version = "Rework"
ver = "v023.91-至尊版"

-- ====================== LOAD UI ======================
-- This is just an example.


--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.64  |  2026-04-05  |  Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()local b=(cloneref or clonereference or function(b)return b end)

local d=b(game:GetService"ReplicatedStorage":WaitForChild("GetIcons",99999):InvokeServer())

local function parseIconString(e)
if type(e)=="string"then
local f=e:find":"
if f then
local g=e:sub(1,f-1)
local h=e:sub(f+1)
return g,h
end
end
return nil,e
end

function d.AddIcons(e,f)
if type(e)~="string"or type(f)~="table"then
error"AddIcons: packName must be string, iconsData must be table"
return
end

if not d.Icons[e]then
d.Icons[e]={
Icons={},
Spritesheets={}
}
end

for g,h in pairs(f)do
if type(h)=="number"or(type(h)=="string"and h:match"^rbxassetid://")then
local i=h
if type(h)=="number"then
i="rbxassetid://"..tostring(h)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=Vector2.new(0,0),
ImageRectPosition=Vector2.new(0,0),
Parts=nil
}
d.Icons[e].Spritesheets[i]=i

elseif type(h)=="table"then
if h.Image and h.ImageRectSize and h.ImageRectPosition then
local i=h.Image
if type(i)=="number"then
i="rbxassetid://"..tostring(i)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=h.ImageRectSize,
ImageRectPosition=h.ImageRectPosition,
Parts=h.Parts
}

if not d.Icons[e].Spritesheets[i]then
d.Icons[e].Spritesheets[i]=i
end
else
warn("AddIcons: Invalid spritesheet data format for icon '"..g.."'")
end
else
warn("AddIcons: Unsupported data type for icon '"..g.."': "..type(h))
end
end
end

function d.SetIconsType(e)
d.IconsType=e
end

local e
function d.Init(f,g)
d.New=f
d.IconThemeTag=g

e=f
return d
end

function d.Icon(f,g,h)
h=h~=false
local i,j=parseIconString(f)

local l=i or g or d.IconsType
local m=j

local p=d.Icons[l]

if p and p.Icons and p.Icons[m]then
return{
p.Spritesheets[tostring(p.Icons[m].Image)],
p.Icons[m],
}
elseif p and p[m]and string.find(p[m],"rbxassetid://")then
return h and{
p[m],
{ImageRectSize=Vector2.new(0,0),ImageRectPosition=Vector2.new(0,0)}
}or p[m]
end
return nil
end

function d.GetIcon(f,g)
return d.Icon(f,g,false)
end


function d.Icon2(f,g,h)
return d.Icon(f,g,true)
end

function d.Image(f)
local g={
Icon=f.Icon or nil,
Type=f.Type,
Colors=f.Colors or{(d.IconThemeTag or Color3.new(1,1,1)),Color3.new(1,1,1)},
Transparency=f.Transparency or{0,0},
Size=f.Size or UDim2.new(0,24,0,24),

IconFrame=nil,
}

local h={}
local i={}

for j,l in next,g.Colors do
h[j]={
ThemeTag=typeof(l)=="string"and l,
Color=typeof(l)=="Color3"and l,
}
end

for j,l in next,g.Transparency do
i[j]={
ThemeTag=typeof(l)=="string"and l,
Value=typeof(l)=="number"and l,
}
end


local j=d.Icon2(g.Icon,g.Type)
local l=typeof(j)=="string"and string.find(j,'rbxassetid://')

if d.New then
local m=e or d.New



local p=m("ImageLabel",{
Size=g.Size,
BackgroundTransparency=1,
ImageColor3=h[1].Color or nil,
ImageTransparency=i[1].Value or nil,
ThemeTag=h[1].ThemeTag and{
ImageColor3=h[1].ThemeTag,
ImageTransparency=i[1].ThemeTag,
},
Image=l and j or j[1],
ImageRectSize=l and nil or j[2].ImageRectSize,
ImageRectOffset=l and nil or j[2].ImageRectPosition,
})


if not l and j[2].Parts then
for r,u in next,j[2].Parts do
local v=d.Icon(u,g.Type)

m("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ImageColor3=h[1+r].Color or nil,
ImageTransparency=i[1+r].Value or nil,
ThemeTag=h[1+r].ThemeTag and{
ImageColor3=h[1+r].ThemeTag,
ImageTransparency=i[1+r].ThemeTag,
},
Image=v[1],
ImageRectSize=v[2].ImageRectSize,
ImageRectOffset=v[2].ImageRectPosition,
Parent=p,
})
end
end

g.IconFrame=p
else
local m=Instance.new"ImageLabel"
m.Size=g.Size
m.BackgroundTransparency=1
m.ImageColor3=h[1].Color
m.ImageTransparency=i[1].Value or nil
m.Image=l and j or j[1]
m.ImageRectSize=l and nil or j[2].ImageRectSize
m.ImageRectOffset=l and nil or j[2].ImageRectPosition


if not l and j[2].Parts then
for p,r in next,j[2].Parts do
local u=d.Icon(r,g.Type)

local v=Instance.New"ImageLabel"
v.Size=UDim2.new(1,0,1,0)
v.BackgroundTransparency=1
v.ImageColor3=h[1+p].Color
v.ImageTransparency=i[1+p].Value or nil
v.Image=u[1]
v.ImageRectSize=u[2].ImageRectSize
v.ImageRectOffset=u[2].ImageRectPosition
v.Parent=m
end
end

g.IconFrame=m
end


return g
end

return d end function a.b()
return function(b)
return{


Primary="Icon",

White=Color3.new(1,1,1),
Black=Color3.new(0,0,0),

Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

PanelBackground="White",
PanelBackgroundTransparency=.95,

WindowBackground="Background",

WindowShadow="Black",


WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Icon",
WindowTopbarButtonIcon="Icon",

WindowSearchBarBackground="Background",

TabBackground="Hover",
TabBackgroundHover="Hover",
TabBackgroundHoverTransparency=.97,
TabBackgroundActive="Hover",
TabBackgroundActiveTransparency=0.93,
TabText="Text",
TabTextTransparency=0.3,
TabTextTransparencyActive=0,
TabTitle="Text",
TabIcon="Icon",
TabIconTransparency=0.4,
TabIconTransparencyActive=0.1,
TabBorderTransparency=1,
TabBorderTransparencyActive=0.75,
TabBorder="White",


ElementBackground="Text",
ElementBackgroundTransparency=.93,
ElementBackgroundHover=b:AddColor("ElementBackground","#ffffff",0.1),
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",

PopupBackground="Background",
PopupBackgroundTransparency="BackgroundTransparency",
PopupTitle="Text",
PopupContent="Text",
PopupIcon="Icon",

DialogBackground="Background",
DialogBackgroundTransparency="BackgroundTransparency",
DialogTitle="Text",
DialogContent="Text",
DialogIcon="Icon",

Toggle="Button",
ToggleBar="White",

Checkbox="Primary",
CheckboxIcon="White",
CheckboxBorder="White",
CheckboxBorderTransparency=.75,

SliderIcon="Icon",

Slider="Primary",
SliderThumb="White",
SliderIconFrom="SliderIcon",
SliderIconTo="SliderIcon",

Tooltip=Color3.fromHex"4C4C4C",
TooltipText="White",
TooltipSecondary="Primary",
TooltipSecondaryText="White",

TabSectionIcon="Icon",

SectionIcon="Icon",

SectionExpandIcon="White",
SectionExpandIconTransparency=.4,
SectionBox="White",
SectionBoxTransparency=.95,
SectionBoxBorder="White",
SectionBoxBorderTransparency=.75,
SectionBoxBackground="White",
SectionBoxBackgroundTransparency=.95,

SearchBarBorder="White",
SearchBarBorderTransparency=.75,

Notification="Background",
NotificationTitle="Text",
NotificationTitleTransparency=0,
NotificationContent="Text",
NotificationContentTransparency=.4,
NotificationDuration="White",
NotificationDurationTransparency=.95,
NotificationBorder="White",
NotificationBorderTransparency=.75,

DropdownTabBorder="White",

LabelBackground="White",
LabelBackgroundTransparency=.95,
}

end end function a.c()
local b=(cloneref or clonereference or function(b)
return b
end)

local d=b(game:GetService"RunService")
local e=b(game:GetService"UserInputService")
local f=b(game:GetService"TweenService")
local g=b(game:GetService"LocalizationService")
local h=b(game:GetService"HttpService")local i=

d.Heartbeat

local j="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local l
if d:IsStudio()or not writefile then
l=a.load'a'
else
l=loadstring(
game.HttpGetAsync and game:HttpGetAsync(j)or h:GetAsync(j)
)()
end

l.SetIconsType"lucide"

local m

local p
p={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=l,
Signals={},
Objects={},
LocalizationObjects={},
FontObjects={},
Language=string.match(g.SystemLocaleId,"^[a-z]+"),
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
},
VideoFrame={
BorderSizePixel=0,
},
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=nil,
Shapes={Square=
"rbxassetid://82909646051652",
["Square-Outline"]="rbxassetid://72946211851948",Squircle=

"rbxassetid://80999662900595",SquircleOutline=
"rbxassetid://117788349049947",
["Squircle-Outline"]="rbxassetid://117817408534198",SquircleOutline2=

"rbxassetid://117817408534198",

["Shadow-sm"]="rbxassetid://84825982946844",

["Squircle-TL-TR"]="rbxassetid://73569156276236",
["Squircle-BL-BR"]="rbxassetid://93853842912264",
["Squircle-TL-TR-Outline"]="rbxassetid://136702870075563",
["Squircle-BL-BR-Outline"]="rbxassetid://75035847706564",

["Glass-0.7"]="rbxassetid://79047752995006",
["Glass-1"]="rbxassetid://97324581055162",
["Glass-1.4"]="rbxassetid://95071123641270",
},
ThemeChangeCallbacks={},
}

function p.Init(r)
m=r

p.ThemeFallbacks=a.load'b'(p)
end

function p.AddSignal(r,u)
local v=r:Connect(u)
table.insert(p.Signals,v)
return v
end

function p.DisconnectAll()
for r,u in next,p.Signals do
local v=table.remove(p.Signals,r)
v:Disconnect()
end
end

function p.SafeCallback(r,...)
if not r then
return
end

local u,v=pcall(r,...)
if not u then
if m and m.Window and m.Window.Debug then local
x, z=v:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..v)

return m:Notify{
Title="DEBUG Mode: Error",
Content=not z and v or v:sub(z+1),
Duration=8,
}
end
end
end

function p.Gradient(r,u)
if m and m.Gradient then
return m:Gradient(r,u)
end

local v={}
local x={}

for z,A in next,r do
local B=tonumber(z)
if B then
B=math.clamp(B/100,0,1)
table.insert(v,ColorSequenceKeypoint.new(B,A.Color))
table.insert(x,NumberSequenceKeypoint.new(B,A.Transparency or 0))
end
end

table.sort(v,function(z,A)
return z.Time<A.Time
end)
table.sort(x,function(z,A)
return z.Time<A.Time
end)

if#v<2 then
error"ColorSequence requires at least 2 keypoints"
end

local z={
Color=ColorSequence.new(v),
Transparency=NumberSequence.new(x),
}

if u then
for A,B in pairs(u)do
z[A]=B
end
end

return z
end

function p.SetTheme(r)
local u=p.Theme
p.Theme=r
p.UpdateTheme(nil,false)

for v,x in next,p.ThemeChangeCallbacks do
p.SafeCallback(x,r,u)
end
end

function p.AddFontObject(r)
table.insert(p.FontObjects,r)
p.UpdateFont(p.Font)
end

function p.UpdateFont(r)
p.Font=r
for u,v in next,p.FontObjects do
v.FontFace=Font.new(r,v.FontFace.Weight,v.FontFace.Style)
end
end

function p.GetThemeProperty(r,u)
local function getValue(v,x)
local z=x[v]

if z==nil then
return nil
end

if typeof(z)=="string"and string.sub(z,1,1)=="#"then
return Color3.fromHex(z)
end

if typeof(z)=="Color3"then
return z
end

if typeof(z)=="number"then
return z
end

if typeof(z)=="table"and z.Color and z.Transparency then
return z
end

if typeof(z)=="function"then
return z(x)
end

return z
end

local v=getValue(r,u)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local x=p.GetThemeProperty(v,u)
if x~=nil then
return x
end
else
return v
end
end

local x=p.ThemeFallbacks[r]
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,u)
else
return getValue(r,{[r]=x})
end
end

v=getValue(r,p.Themes.Dark)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local z=p.GetThemeProperty(v,p.Themes.Dark)
if z~=nil then
return z
end
else
return v
end
end

if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,p.Themes.Dark)
else
return getValue(r,{[r]=x})
end
end

return nil
end

function p.AddThemeObject(r,u,v)
if p.Objects[r]then
for x,z in pairs(u)do
p.Objects[r].Properties[x]=z
end
else
p.Objects[r]={Object=r,Properties=u}
end

if not v then
p.UpdateTheme(r,false)
end
return r
end

function p.AddLangObject(r)
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object

p.SetLangForObject(r)

return v
end

function p.UpdateTheme(r,u,v,x,z,A)
local function ApplyTheme(B)
for C,F in pairs(B.Properties or{})do
local G=p.GetThemeProperty(F,p.Theme)
if G~=nil then
if typeof(G)=="Color3"then
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end

if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
elseif typeof(G)=="table"and G.Color and G.Transparency then
B.Object[C]=Color3.new(1,1,1)

local H=B.Object:FindFirstChild"LibraryGradient"
if not H then
H=Instance.new"UIGradient"
H.Name="LibraryGradient"
H.Parent=B.Object
end

H.Color=G.Color
H.Transparency=G.Transparency

for J,L in pairs(G)do
if J~="Color"and J~="Transparency"and H[J]~=nil then
H[J]=L
end
end
elseif typeof(G)=="number"then
if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
end
else
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end
end
end
end

if r then
local B=p.Objects[r]
if B then
ApplyTheme(B)
end
else
for B,C in pairs(p.Objects)do
ApplyTheme(C)
end
end
end

function p.SetThemeTag(r,u,v,x,z)
p.AddThemeObject(r,u)
p.UpdateTheme(r,false,true,v,x,z)
end

function p.SetLangForObject(r)
if p.Localization and p.Localization.Enabled then
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object
local x=u.TranslationId

local z=p.Localization.Translations[p.Language]
if z and z[x]then
v.Text=z[x]
else
local A=p.Localization
and p.Localization.Translations
and p.Localization.Translations.en
or nil
if A and A[x]then
v.Text=A[x]
else
v.Text="["..x.."]"
end
end
end
end

function p.ChangeTranslationKey(r,u,v)
if p.Localization and p.Localization.Enabled then
local x=string.match(v,"^"..p.Localization.Prefix.."(.+)")
if x then
for z,A in ipairs(p.LocalizationObjects)do
if A.Object==u then
A.TranslationId=x
p.SetLangForObject(z)
return
end
end

table.insert(p.LocalizationObjects,{
TranslationId=x,
Object=u,
})
p.SetLangForObject(#p.LocalizationObjects)
end
end
end

function p.UpdateLang(r)
if r then
p.Language=r
end

for u=1,#p.LocalizationObjects do
local v=p.LocalizationObjects[u]
if v.Object and v.Object.Parent~=nil then
p.SetLangForObject(u)
else
p.LocalizationObjects[u]=nil
end
end
end

function p.SetLanguage(r)
p.Language=r
p.UpdateLang()
end

function p.Icon(r,u)
return l.Icon2(r,nil,u~=false)
end

function p.AddIcons(r,u)
return l.AddIcons(r,u)
end

function p.New(r,u,v)
local x=Instance.new(r)

for z,A in next,p.DefaultProperties[r]or{}do
x[z]=A
end

for z,A in next,u or{}do
if z~="ThemeTag"then
x[z]=A
end
if p.Localization and p.Localization.Enabled and z=="Text"then
local B=string.match(A,"^"..p.Localization.Prefix.."(.+)")
if B then
local C=#p.LocalizationObjects+1
p.LocalizationObjects[C]={TranslationId=B,Object=x}

p.SetLangForObject(C)
end
end
end

for z,A in next,v or{}do
A.Parent=x
end

if u and u.ThemeTag then
p.AddThemeObject(x,u.ThemeTag)
end
if u and u.FontFace then
p.AddFontObject(x)
end
return x
end

function p.Tween(r,u,v,...)
return f:Create(r,TweenInfo.new(u,...),v)
end

function p.NewRoundFrame(r,u,v,x,z,A)
local function getImageForType(B)
return p.Shapes[B]
end

local function getSliceCenterForType(B)
return not table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},B)
and Rect.new(256,256,256,256)
or Rect.new(512,512,512,512)
end

local B=p.New(z and"ImageButton"or"ImageLabel",{
Image=getImageForType(u),
ScaleType="Slice",
SliceCenter=getSliceCenterForType(u),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=v.ThemeTag and v.ThemeTag,
},x)

for C,F in pairs(v or{})do
if C~="ThemeTag"then
B[C]=F
end
end

local function UpdateSliceScale(C)
local F=not table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},u)
and(C/(256))
or(C/512)
B.SliceScale=math.max(F,0.0001)
end

local C={}

function C.SetRadius(F,G)
UpdateSliceScale(G)
end

function C.SetType(F,G)
u=G
B.Image=getImageForType(G)
B.SliceCenter=getSliceCenterForType(G)
UpdateSliceScale(r)
end

function C.UpdateShape(F,G,H)
if H then
u=H
B.Image=getImageForType(H)
B.SliceCenter=getSliceCenterForType(H)
end
if G then
r=G
end
UpdateSliceScale(r)
end

function C.GetRadius(F)
return r
end

function C.GetType(F)
return u
end

UpdateSliceScale(r)

return B,A and C or nil
end

local r=p.New local u=
p.Tween

function p.SetDraggable(v)
p.CanDraggable=v
end

function p.Drag(v,x,z)
local A
local B,C,F
local G={
CanDraggable=true,
}

if not x or typeof(x)~="table"then
x={v}
end

local function update(H)
if not B or not G.CanDraggable then
return
end

local J=H.Position-C
p.Tween(v,0.02,{
Position=UDim2.new(
F.X.Scale,
F.X.Offset+J.X,
F.Y.Scale,
F.Y.Offset+J.Y
),
}):Play()
end

for H,J in pairs(x)do
J.InputBegan:Connect(function(L)
if
(
L.UserInputType==Enum.UserInputType.MouseButton1
or L.UserInputType==Enum.UserInputType.Touch
)and G.CanDraggable
then
if A==nil then
A=J
B=true
C=L.Position
F=v.Position

if z and typeof(z)=="function"then
z(true,A)
end

L.Changed:Connect(function()
if L.UserInputState==Enum.UserInputState.End then
B=false
A=nil

if z and typeof(z)=="function"then
z(false,nil)
end
end
end)
end
end
end)

J.InputChanged:Connect(function(L)
if B and A==J then
if
L.UserInputType==Enum.UserInputType.MouseMovement
or L.UserInputType==Enum.UserInputType.Touch
then
update(L)
end
end
end)
end

e.InputChanged:Connect(function(H)
if B and A~=nil then
if
H.UserInputType==Enum.UserInputType.MouseMovement
or H.UserInputType==Enum.UserInputType.Touch
then
update(H)
end
end
end)

function G.Set(H,J)
G.CanDraggable=J
end

return G
end

l.Init(r,"Icon")

function p.SanitizeFilename(v)
local x=v:match"([^/]+)$"or v

x=x:gsub("%.[^%.]+$","")

x=x:gsub("[^%w%-_]","_")

if#x>50 then
x=x:sub(1,50)
end

return x
end

function p.Image(v,x,z,A,B,C,F,G)
A=A or"Temp"
x=p.SanitizeFilename(x)

local H=r("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
r("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(p.Icon(v)or F)and{
ImageColor3=C and(G or"Icon")or nil,
}or nil,
},{
r("UICorner",{
CornerRadius=UDim.new(0,z),
}),
}),
})
if p.Icon(v)then
H.ImageLabel:Destroy()

local J=l.Image{
Icon=v,
Size=UDim2.new(1,0,1,0),
Colors={
(C and(G or"Icon")or false),
"Button",
},
}.IconFrame
J.Parent=H
elseif string.find(v,"http")and not string.find(v,"roblox.com")then
local J="WindUI/"..A.."/assets/."..B.."-"..x..".png"
local L,M=pcall(function()
task.spawn(function()
local L=p.Request
and p.Request{
Url=v,
Method="GET",
}.Body
or{}

if not d:IsStudio()and writefile then
writefile(J,L)
end


local M,N=pcall(getcustomasset,J)
if M then
H.ImageLabel.Image=N
else
warn(
string.format(
"[ WindUI.Creator ] Failed to load custom asset '%s': %s",
J,
tostring(N)
)
)
H:Destroy()

return
end
end)
end)
if not L then
warn(
"[ WindUI.Creator ]  '"..identifyexecutor()
or"Studio".."' doesnt support the URL Images. Error: "..M
)

H:Destroy()
end
elseif v==""then
H.Visible=false
else
H.ImageLabel.Image=v
end

return H
end

function p.Color3ToHSB(v)
local x,z,A=v.R,v.G,v.B
local B=math.max(x,z,A)
local C=math.min(x,z,A)
local F=B-C

local G=0
if F~=0 then
if B==x then
G=(z-A)/F%6
elseif B==z then
G=(A-x)/F+2
else
G=(x-z)/F+4
end
G=G*60
else
G=0
end

local H=(B==0)and 0 or(F/B)
local J=B

return{
h=math.floor(G+0.5),
s=H,
b=J,
}
end

function p.GetPerceivedBrightness(v)
local x=v.R
local z=v.G
local A=v.B
return 0.299*x+0.587*z+0.114*A
end

function p.GetTextColorForHSB(v,x)
local z=p.Color3ToHSB(v)local
A, B, C=z.h, z.s, z.b
if p.GetPerceivedBrightness(v)>(x or 0.5)then
return Color3.fromHSV(A/360,0,0.05)
else
return Color3.fromHSV(A/360,0,0.98)
end
end

function p.GetAverageColor(v)
local x,z,A=0,0,0
local B=v.Color.Keypoints
for C,F in ipairs(B)do

x=x+F.Value.R
z=z+F.Value.G
A=A+F.Value.B
end
local C=#B
return Color3.new(x/C,z/C,A/C)
end

function p.GenerateUniqueID(v)
return h:GenerateGUID(false)
end

function p.OnThemeChange(v,x)
if typeof(x)~="function"then
return
end

local z=h:GenerateGUID(false)
p.ThemeChangeCallbacks[z]=x

return{
Disconnect=function()
p.ThemeChangeCallbacks[z]=nil
end,
}
end

function p.AddColor(v,x,z,A)
A=math.clamp(A or 1,0,1)
if typeof(z)=="string"then z=Color3.fromHex(z)end

return function(B)
local C
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
C=p.GetThemeProperty(x,B)
elseif typeof(x)=="string"then
C=Color3.fromHex(x)
else
C=x
end

if not C or typeof(C)~="Color3"then
return nil
end

return Color3.new(
math.clamp(C.R+z.R*A,0,1),
math.clamp(C.G+z.G*A,0,1),
math.clamp(C.B+z.B*A,0,1)
)
end
end

return p end function a.d()

local b={}







function b.New(d,e,f)
local g={
Enabled=e.Enabled or false,
Translations=e.Translations or{},
Prefix=e.Prefix or"loc:",
DefaultLanguage=e.DefaultLanguage or"en"
}

f.Localization=g

return g
end



return b end function a.e()
local b=a.load'c'
local d=b.New
local e=b.Tween

local f={
Size=UDim2.new(0,300,1,-156),
SizeLower=UDim2.new(0,300,1,-56),
UICorner=18,
UIPadding=14,

Holder=nil,
NotificationIndex=0,
Notifications={}
}

function f.Init(g)
local h={
Lower=false
}

function h.SetLower(j)
h.Lower=j
h.Frame.Size=j and f.SizeLower or f.Size
end

h.Frame=d("Frame",{
Position=UDim2.new(1,-29,0,56),
AnchorPoint=Vector2.new(1,0),
Size=f.Size,
Parent=g,
BackgroundTransparency=1,




},{
d("UIListLayout",{
HorizontalAlignment="Center",
SortOrder="LayoutOrder",
VerticalAlignment="Bottom",
Padding=UDim.new(0,8),
}),
d("UIPadding",{
PaddingBottom=UDim.new(0,29)
})
})
return h
end

function f.New(g)
local h={
Title=g.Title or"Notification",
Content=g.Content or nil,
Icon=g.Icon or nil,
IconThemed=g.IconThemed,
Background=g.Background,
BackgroundImageTransparency=g.BackgroundImageTransparency,
Duration=g.Duration or 5,
Buttons=g.Buttons or{},
CanClose=g.CanClose~=false,
UIElements={},
Closed=false,
}



f.NotificationIndex=f.NotificationIndex+1
f.Notifications[f.NotificationIndex]=h









local j

if h.Icon then





















j=b.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.Window,
"Notification",
h.IconThemed
)
j.Size=UDim2.new(0,26,0,26)
j.Position=UDim2.new(0,f.UIPadding,0,f.UIPadding)

end

local l
if h.CanClose then
l=d("ImageButton",{
Image=b.Icon"x"[1],
ImageRectSize=b.Icon"x"[2].ImageRectSize,
ImageRectOffset=b.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
Size=UDim2.new(0,16,0,16),
Position=UDim2.new(1,-f.UIPadding,0,f.UIPadding),
AnchorPoint=Vector2.new(1,0),
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=.4,
},{
d("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})
end

local m=b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(0,0,1,0),
ThemeTag={
ImageTransparency="NotificationDurationTransparency",
ImageColor3="NotificationDuration",
},

})

local p=d("Frame",{
Size=UDim2.new(1,
h.Icon and-28-f.UIPadding or 0,
1,0),
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
AutomaticSize="Y",
},{
d("UIPadding",{
PaddingTop=UDim.new(0,f.UIPadding),
PaddingLeft=UDim.new(0,f.UIPadding),
PaddingRight=UDim.new(0,f.UIPadding),
PaddingBottom=UDim.new(0,f.UIPadding),
}),
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,-30-f.UIPadding,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextSize=18,
ThemeTag={
TextColor3="NotificationTitle",
TextTransparency="NotificationTitleTransparency",
},
Text=h.Title,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold)
}),
d("UIListLayout",{
Padding=UDim.new(0,f.UIPadding/3)
})
})

if h.Content then
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,

TextSize=15,
ThemeTag={
TextColor3="NotificationContent",
TextTransparency="NotificationContentTransparency",
},
Text=h.Content,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
Parent=p
})
end


local r=b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(2,0,1,0),
AnchorPoint=Vector2.new(0,1),
AutomaticSize="Y",
ImageTransparency=.05,
ThemeTag={
ImageColor3="Notification"
},

},{
b.NewRoundFrame(f.UICorner,"Glass-1",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="NotificationBorder",
ImageTransparency="NotificationBorderTransparency",
},
}),
d("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="DurationFrame",
},{
d("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ClipsDescendants=true,
},{
m,
}),





}),
d("ImageLabel",{
Name="Background",
Image=h.Background,
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ScaleType="Crop",
ImageTransparency=h.BackgroundImageTransparency

},{
d("UICorner",{
CornerRadius=UDim.new(0,f.UICorner),
})
}),

p,
j,l,
})

local u=d("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=g.Holder
},{
r
})

function h.Close(v)
if not h.Closed then
h.Closed=true
e(u,0.45,{Size=UDim2.new(1,0,0,-8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(r,0.55,{Position=UDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
task.wait(.45)
u:Destroy()
end
end

task.spawn(function()
task.wait()
e(u,0.45,{Size=UDim2.new(
1,
0,
0,
r.AbsoluteSize.Y
)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(r,0.45,{Position=UDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if h.Duration then
m.Size=UDim2.new(0,r.DurationFrame.AbsoluteSize.X,1,0)
e(r.DurationFrame.Frame,h.Duration,{Size=UDim2.new(0,0,1,0)},Enum.EasingStyle.Linear,Enum.EasingDirection.InOut):Play()
task.wait(h.Duration)
h:Close()
end
end)

if l then
b.AddSignal(l.TextButton.MouseButton1Click,function()
h:Close()
end)
end


return h
end

return f end function a.f()












local b=4294967296;local d=b-1;local function c(e,f)local g,h=0,1;while e~=0 or f~=0 do local j,l=e%2,f%2;local m=(j+l)%2;g=g+m*h;e=math.floor(e/2)f=math.floor(f/2)h=h*2 end;return g%b end;local function k(e,f,g,...)local h;if f then e=e%b;f=f%b;h=c(e,f)if g then h=k(h,g,...)end;return h elseif e then return e%b else return 0 end end;local function n(e,f,g,...)local h;if f then e=e%b;f=f%b;h=(e+f-c(e,f))/2;if g then h=n(h,g,...)end;return h elseif e then return e%b else return d end end;local function o(e)return d-e end;local function q(e,f)if f<0 then return lshift(e,-f)end;return math.floor(e%4294967296/2^f)end;local function s(e,f)if f>31 or f<-31 then return 0 end;return q(e%b,f)end;local function lshift(e,f)if f<0 then return s(e,-f)end;return e*2^f%4294967296 end;local function t(e,f)e=e%b;f=f%32;local g=n(e,2^f-1)return s(e,f)+lshift(g,32-f)end;local e={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(f)return string.gsub(f,".",function(g)return string.format("%02x",string.byte(g))end)end;local function y(f,g)local h=""for j=1,g do local l=f%256;h=string.char(l)..h;f=(f-l)/256 end;return h end;local function D(f,g)local h=0;for j=g,g+3 do h=h*256+string.byte(f,j)end;return h end;local function E(f,g)local h=64-(g+9)%64;g=y(8*g,8)f=f.."\128"..string.rep("\0",h)..g;assert(#f%64==0)return f end;local function I(f)f[1]=0x6a09e667;f[2]=0xbb67ae85;f[3]=0x3c6ef372;f[4]=0xa54ff53a;f[5]=0x510e527f;f[6]=0x9b05688c;f[7]=0x1f83d9ab;f[8]=0x5be0cd19;return f end;local function K(f,g,h)local j={}for l=1,16 do j[l]=D(f,g+(l-1)*4)end;for l=17,64 do local m=j[l-15]local p=k(t(m,7),t(m,18),s(m,3))m=j[l-2]j[l]=(j[l-16]+p+j[l-7]+k(t(m,17),t(m,19),s(m,10)))%b end;local l,m,p,r,u,v,x,z=h[1],h[2],h[3],h[4],h[5],h[6],h[7],h[8]for A=1,64 do local B=k(t(l,2),t(l,13),t(l,22))local C=k(n(l,m),n(l,p),n(m,p))local F=(B+C)%b;local G=k(t(u,6),t(u,11),t(u,25))local H=k(n(u,v),n(o(u),x))local J=(z+G+H+e[A]+j[A])%b;z=x;x=v;v=u;u=(r+J)%b;r=p;p=m;m=l;l=(J+F)%b end;h[1]=(h[1]+l)%b;h[2]=(h[2]+m)%b;h[3]=(h[3]+p)%b;h[4]=(h[4]+r)%b;h[5]=(h[5]+u)%b;h[6]=(h[6]+v)%b;h[7]=(h[7]+x)%b;h[8]=(h[8]+z)%b end;local function Z(f)f=E(f,#f)local g=I{}for h=1,#f,64 do K(f,h,g)end;return w(y(g[1],4)..y(g[2],4)..y(g[3],4)..y(g[4],4)..y(g[5],4)..y(g[6],4)..y(g[7],4)..y(g[8],4))end;local f;local g={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local h={["/"]="/"}for j,l in pairs(g)do h[l]=j end;local j=function(j)return"\\"..(g[j]or string.format("u%04x",j:byte()))end;local l=function(l)return"null"end;local m=function(m,p)local r={}p=p or{}if p[m]then error"circular reference"end;p[m]=true;if rawget(m,1)~=nil or next(m)==nil then local u=0;for v in pairs(m)do if type(v)~="number"then error"invalid table: mixed or invalid key types"end;u=u+1 end;if u~=#m then error"invalid table: sparse array"end;for v,x in ipairs(m)do table.insert(r,f(x,p))end;p[m]=nil;return"["..table.concat(r,",").."]"else for u,v in pairs(m)do if type(u)~="string"then error"invalid table: mixed or invalid key types"end;table.insert(r,f(u,p)..":"..f(v,p))end;p[m]=nil;return"{"..table.concat(r,",").."}"end end;local p=function(p)return'"'..p:gsub('[%z\1-\31\\"]',j)..'"'end;local r=function(r)if r~=r or r<=-math.huge or r>=math.huge then error("unexpected number value '"..tostring(r).."'")end;return string.format("%.14g",r)end;local u={["nil"]=l,table=m,string=p,number=r,boolean=tostring}f=function(v,x)local z=type(v)local A=u[z]if A then return A(v,x)end;error("unexpected type '"..z.."'")end;local v=function(v)return f(v)end;local x;local z=function(...)local z={}for A=1,select("#",...)do z[select(A,...)]=true end;return z end;local A=z(" ","\t","\r","\n")local B=z(" ","\t","\r","\n","]","}",",")local C=z("\\","/",'"',"b","f","n","r","t","u")local F=z("true","false","null")local G={["true"]=true,["false"]=false,null=nil}local H=function(H,J,L,M)for N=J,#H do if L[H:sub(N,N)]~=M then return N end end;return#H+1 end;local J=function(J,L,M)local N=1;local O=1;for P=1,L-1 do O=O+1;if J:sub(P,P)=="\n"then N=N+1;O=1 end end;error(string.format("%s at line %d col %d",M,N,O))end;local L=function(L)local M=math.floor;if L<=0x7f then return string.char(L)elseif L<=0x7ff then return string.char(M(L/64)+192,L%64+128)elseif L<=0xffff then return string.char(M(L/4096)+224,M(L%4096/64)+128,L%64+128)elseif L<=0x10ffff then return string.char(M(L/262144)+240,M(L%262144/4096)+128,M(L%4096/64)+128,L%64+128)end;error(string.format("invalid unicode codepoint '%x'",L))end;local M=function(M)local N=tonumber(M:sub(1,4),16)local O=tonumber(M:sub(7,10),16)if O then return L((N-0xd800)*0x400+O-0xdc00+0x10000)else return L(N)end end;local N=function(N,O)local P=""local Q=O+1;local R=Q;while Q<=#N do local S=N:byte(Q)if S<32 then J(N,Q,"control character in string")elseif S==92 then P=P..N:sub(R,Q-1)Q=Q+1;local T=N:sub(Q,Q)if T=="u"then local U=N:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",Q+1)or N:match("^%x%x%x%x",Q+1)or J(N,Q-1,"invalid unicode escape in string")P=P..M(U)Q=Q+#U else if not C[T]then J(N,Q-1,"invalid escape char '"..T.."' in string")end;P=P..h[T]end;R=Q+1 elseif S==34 then P=P..N:sub(R,Q-1)return P,Q+1 end;Q=Q+1 end;J(N,O,"expected closing quote for string")end;local O=function(O,P)local Q=H(O,P,B)local R=O:sub(P,Q-1)local S=tonumber(R)if not S then J(O,P,"invalid number '"..R.."'")end;return S,Q end;local P=function(P,Q)local R=H(P,Q,B)local S=P:sub(Q,R-1)if not F[S]then J(P,Q,"invalid literal '"..S.."'")end;return G[S],R end;local Q=function(Q,R)local S={}local T=1;R=R+1;while 1 do local U;R=H(Q,R,A,true)if Q:sub(R,R)=="]"then R=R+1;break end;U,R=x(Q,R)S[T]=U;T=T+1;R=H(Q,R,A,true)local V=Q:sub(R,R)R=R+1;if V=="]"then break end;if V~=","then J(Q,R,"expected ']' or ','")end end;return S,R end;local R=function(R,S)local T={}S=S+1;while 1 do local U,V;S=H(R,S,A,true)if R:sub(S,S)=="}"then S=S+1;break end;if R:sub(S,S)~='"'then J(R,S,"expected string for key")end;U,S=x(R,S)S=H(R,S,A,true)if R:sub(S,S)~=":"then J(R,S,"expected ':' after key")end;S=H(R,S+1,A,true)V,S=x(R,S)T[U]=V;S=H(R,S,A,true)local W=R:sub(S,S)S=S+1;if W=="}"then break end;if W~=","then J(R,S,"expected '}' or ','")end end;return T,S end;local S={['"']=N,["0"]=O,["1"]=O,["2"]=O,["3"]=O,["4"]=O,["5"]=O,["6"]=O,["7"]=O,["8"]=O,["9"]=O,["-"]=O,t=P,f=P,n=P,["["]=Q,["{"]=R}x=function(T,U)local V=T:sub(U,U)local W=S[V]if W then return W(T,U)end;J(T,U,"unexpected character '"..V.."'")end;local T=function(T)if type(T)~="string"then error("expected argument of type string, got "..type(T))end;local U,V=x(T,H(T,1,A,true))V=H(T,V,A,true)if V<=#T then J(T,V,"trailing garbage")end;return U end;
local U,V,W=v,T,Z;





local X={}

local Y=(cloneref or clonereference or function(Y)return Y end)


function X.New(_,aa)

local ab=_;
local ac=aa;
local ad=true;


local ae=function(ae)end;


repeat task.wait(1)until game:IsLoaded();


local af=false;
local ag,ah,ai,aj,ak,al,am,an,ao=setclipboard or toclipboard,request or http_request or syn_request,string.char,tostring,string.sub,os.time,math.random,math.floor,gethwid or function()return Y(game:GetService"Players").LocalPlayer.UserId end
local ap,aq="",0;


local ar="https://api.platoboost.app";
local as=ah{
Url=ar.."/public/connectivity",
Method="GET"
};
if as.StatusCode~=200 and as.StatusCode~=429 then
ar="https://api.platoboost.net";
end


function cacheLink()
if aq+(600)<al()then
local at=ah{
Url=ar.."/public/start",
Method="POST",
Body=U{
service=ab,
identifier=W(ao())
},
Headers={
["Content-Type"]="application/json",
["User-Agent"]="Roblox/Exploit"
}
};

if at.StatusCode==200 then
local au=V(at.Body);

if au.success==true then
ap=au.data.url;
aq=al();
return true,ap
else
ae(au.message);
return false,au.message
end
elseif at.StatusCode==429 then
local au="you are being rate limited, please wait 20 seconds and try again.";
ae(au);
return false,au
end

local au="Failed to cache link.";
ae(au);
return false,au
else
return true,ap
end
end

cacheLink();


local at=function()
local at=""
for au=1,16 do
at=at..ai(an(am()*(26))+97)
end
return at
end


for au=1,5 do
local av=at();
task.wait(0.2)
if at()==av then
local aw="platoboost nonce error.";
ae(aw);
error(aw);
end
end


local au=function()
local au,av=cacheLink();

if au then
ag(av);
end
end


local av=function(av)
local aw=at();
local ax=ar.."/public/redeem/"..aj(ab);

local ay={
identifier=W(ao()),
key=av
}

if ad then
ay.nonce=aw;
end

local az=ah{
Url=ax,
Method="POST",
Body=U(ay),
Headers={
["Content-Type"]="application/json"
}
};

if az.StatusCode==200 then
local aA=V(az.Body);

if aA.success==true then
if aA.data.valid==true then
if ad then
if aA.data.hash==W("true".."-"..aw.."-"..ac)then
return true
else
ae"failed to verify integrity.";
return false
end
else
return true
end
else
ae"key is invalid.";
return false
end
else
if ak(aA.message,1,27)=="unique constraint violation"then
ae"you already have an active key, please wait for it to expire before redeeming it.";
return false
else
ae(aA.message);
return false
end
end
elseif az.StatusCode==429 then
ae"you are being rate limited, please wait 20 seconds and try again.";
return false
else
ae"server returned an invalid status code, please try again later.";
return false
end
end


local aw=function(aw)
if af==true then
return false,("A request is already being sent, please slow down.")
else
af=true;
end

local ax=at();
local ay=ar.."/public/whitelist/"..aj(ab).."?identifier="..W(ao()).."&key="..aw;

if ad then
ay=ay.."&nonce="..ax;
end

local az=ah{
Url=ay,
Method="GET",
};

af=false;

if az.StatusCode==200 then
local aA=V(az.Body);

if aA.success==true then
if aA.data.valid==true then
if ad then
if aA.data.hash==W("true".."-"..ax.."-"..ac)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if ak(aw,1,4)=="KEY_"then
return true,av(aw)
else
return false,("Key is invalid.")
end
end
else
return false,(aA.message)
end
elseif az.StatusCode==429 then
return false,("You are being rate limited, please wait 20 seconds and try again.")
else
return false,("Server returned an invalid status code, please try again later.")
end
end


local ax=function(ax)
local ay=at();
local az=ar.."/public/flag/"..aj(ab).."?name="..ax;

if ad then
az=az.."&nonce="..ay;
end

local aA=ah{
Url=az,
Method="GET",
};

if aA.StatusCode==200 then
local aB=V(aA.Body);

if aB.success==true then
if ad then
if aB.data.hash==W(aj(aB.data.value).."-"..ay.."-"..ac)then
return aB.data.value
else
ae"failed to verify integrity.";
return nil
end
else
return aB.data.value
end
else
ae(aB.message);
return nil
end
else
return nil
end
end


return{
Verify=aw,
GetFlag=ax,
Copy=au,
}
end


return X end function a.g()






local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ab=aa(game:GetService"HttpService")
local ac={}

function ac.New(ad)
local ae=gethwid or function()
return aa(game:GetService"Players").LocalPlayer.UserId
end
local af,ag=request or http_request or syn_request,setclipboard or toclipboard

function ValidateKey(ah)
local ai="https://new.pandadevelopment.net/api/v1/keys/validate"

local aj={
ServiceID=ad,
HWID=tostring(ae()),
Key=tostring(ah),
}

local ak=ab:JSONEncode(aj)
local al,am=pcall(function()
return af{
Url=ai,
Method="POST",
Headers={
["User-Agent"]="Roblox/Exploit",
["Content-Type"]="application/json",
},
Body=ak,
}
end)

if al and am then
if am.Success then
local an,ao=pcall(function()
return ab:JSONDecode(am.Body)
end)

if an and ao then
if ao.Authenticated_Status and ao.Authenticated_Status=="Success"then
return true,"Authenticated"
else
local ap=ao.Note or"Unknown reason"
return false,"Authentication failed: "..ap
end
else
return false,"JSON decode error"
end
else
warn(
" HTTP request was not successful. Code: "
..tostring(am.StatusCode)
.." Message: "
..am.StatusMessage
)
return false,"HTTP request failed: "..am.StatusMessage
end
else
return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://new.pandadevelopment.net/getkey/"..tostring(ad).."?hwid="..tostring(ae())
end

function CopyLink()
return ag(GetKeyLink())
end

return{
Verify=ValidateKey,
Copy=CopyLink,
}
end

return ac end function a.h()









local aa={}


function aa.New(ab,ac)
local ad="https://sdkapi-public.luarmor.net/library.lua"

local ae=loadstring(
game.HttpGetAsync and game:HttpGetAsync(ad)
or HttpService:GetAsync(ad)
)()
local af=setclipboard or toclipboard

ae.script_id=ab

function ValidateKey(ag)
local ah=ae.check_key(ag);


if(ah.code=="KEY_VALID")then
return true,"Whitelisted!"

elseif(ah.code=="KEY_HWID_LOCKED")then
return false,"Key linked to a different HWID. Please reset it using our bot"

elseif(ah.code=="KEY_INCORRECT")then
return false,"Key is wrong or deleted!"
else
return false,"Key check failed:"..ah.message.." Code: "..ah.code
end
end

function CopyLink()
af(tostring(ac))
end

return{
Verify=ValidateKey,
Copy=CopyLink
}
end


return aa end function a.i()








local aa={}

function aa.New(ab,ac,ad)
JunkieProtected.API_KEY=ac
JunkieProtected.PROVIDER=ad
JunkieProtected.SERVICE_ID=ab

local function ValidateKey(ae)
if not ae or ae==""then
print"No key provided!"

return false,"No key provided. Please get a key."
end

local af=JunkieProtected.IsKeylessMode()
if af and af.keyless_mode then
print"Keyless mode enabled. Starting script..."
return true,"Keyless mode enabled. Starting script..."
end

local ag=JunkieProtected.ValidateKey{Key=ae}
if ag=="valid"then
print"Key is valid! Starting script..."
load()
if _G.JD_IsPremium then
print"Premium user detected!"
else
print"Standard user"
end

return true,"Key is valid!"
else
local ah=JunkieProtected.GetKeyLink()
print"Invalid key!"

return false,"Invalid key. Get one from:"..ah
end
end

local function copyLink()
local ae=JunkieProtected.GetKeyLink()

if setclipboard then
setclipboard(ae)
end
end
return{
Verify=ValidateKey,
Copy=copyLink
}
end

return aa end function a.j()



return{
platoboost={
Name="Platoboost",
Icon="rbxassetid://75920162824531",
Args={"ServiceId","Secret"},

New=a.load'f'.New
},
pandadevelopment={
Name="Panda Development",
Icon="panda",
Args={"ServiceId"},

New=a.load'g'.New
},
luarmor={
Name="Luarmor",
Icon="rbxassetid://130918283130165",
Args={"ScriptId","Discord"},

New=a.load'h'.New
},
junkiedevelopment={
Name="Junkie Development",
Icon="rbxassetid://106310347705078",
Args={"ServiceId","ApiKey","Provider"},

New=a.load'i'.New
},


}end function a.k()



return[[
{
    "name": "windui",
    "version": "1.6.64",
    "main": "./dist/main.lua",
    "repository": "https://github.com/Footagesus/WindUI",
    "discord": "https://discord.gg/ftgs-development-hub-1300692552005189632",
    "author": "Footagesus",
    "description": "Roblox UI Library for scripts",
    "license": "MIT",
    "scripts": {
        "dev": "bash build/build.sh dev $INPUT_FILE",
        "build": "bash build/build.sh build $INPUT_FILE",
        "live": "python3 -m http.server 8642",
        "watch": "chokidar . -i 'node_modules' -i 'dist' -i 'build' -c 'npm run dev --'",
        "live-build": "concurrently \"npm run live\" \"npm run watch --\"",
        "example-live-build": "INPUT_FILE=main_example.lua npm run live-build",
        "updater": "python3 updater/main.py"
    },
    "keywords": [
        "ui-library",
        "ui-design",
        "script",
        "script-hub",
        "exploiting"
    ],
    "devDependencies": {
        "chokidar-cli": "^3.0.0",
        "concurrently": "^9.2.0"
    }
}
]]end function a.l()

local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween

function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=ah or"Primary"
local am=al or(not ak and 10 or 99)
local an
if af and af~=""then
an=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=ah=="White"and 0.4 or 0,
ThemeTag={
ImageColor3=ah~="White"and"Icon"or nil,
},
})
end

local ao=ac("TextButton",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=ai,
BackgroundTransparency=1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag={
ImageColor3=ah~="White"and"Button"or nil,
},
ImageColor3=ah=="White"and Color3.new(1,1,1)or nil,
Size=UDim2.new(1,0,1,0),
Name="Squircle",
ImageTransparency=ah=="Primary"and 0 or ah=="White"and 0 or 0.9,
}),

ab.NewRoundFrame(am,"Squircle",{



ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(1,0,1,0),
Name="Special",
ImageTransparency=ah=="Secondary"and 0.95 or 1,
}),

ab.NewRoundFrame(am,"Shadow-sm",{



ImageColor3=Color3.new(0,0,0),
Size=UDim2.new(1,3,1,3),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Shadow",

ImageTransparency=1,
Visible=not ak,
}),

ab.NewRoundFrame(am,not ak and"Glass-1"or"Glass-0.7",{
ThemeTag={
ImageColor3="White",
},
Size=UDim2.new(1,0,1,0),

ImageTransparency=0.6,
Name="Outline",
},{













}),

ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3=ah~="White"and"Text"or nil,
},
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=1,
},{
ac("UIPadding",{
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
an,
ac("TextLabel",{
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ae or"Button",
ThemeTag={
TextColor3=(ah~="Primary"and ah~="White")and"Text",
},
TextColor3=ah=="Primary"and Color3.new(1,1,1)
or ah=="White"and Color3.new(0,0,0)
or nil,
AutomaticSize="XY",
TextSize=18,
}),
}),
})

ab.AddSignal(ao.MouseEnter,function()
ad(ao.Frame,0.047,{ImageTransparency=0.95}):Play()
end)
ab.AddSignal(ao.MouseLeave,function()
ad(ao.Frame,0.047,{ImageTransparency=1}):Play()
end)
ab.AddSignal(ao.MouseButton1Up,function()
if aj then
aj:Close()()
end
if ag then
ab.SafeCallback(ag)
end
end)

return ao
end

return aa end function a.m()

local aa={}

local ab=a.load'c'
local ac=ab.New local ad=
ab.Tween


function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=ah or"Input"
local am=ak or 10
local an
if af and af~=""then
an=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local ao=ah~="Input"

local ap=ac("TextBox",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,an and-29 or 0,1,0),
PlaceholderText=ae,
ClearTextOnFocus=al or false,
ClipsDescendants=true,
TextWrapped=ao,
MultiLine=ao,
TextXAlignment="Left",
TextYAlignment=ah=="Input"and"Center"or"Top",

ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
})

local aq=ac("Frame",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.97,
}),
ab.NewRoundFrame(am,"Glass-1",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.75,
},{













}),
ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.95
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,ah=="Input"and 0 or 12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,ah=="Input"and 0 or 12),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment=ah=="Input"and"Center"or"Top",
HorizontalAlignment="Left",
}),
an,
ap,
})
})
})










if aj then
ab.AddSignal(ap:GetPropertyChangedSignal"Text",function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
else
ab.AddSignal(ap.FocusLost,function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
end

return aq
end


return aa end function a.n()
local aa=a.load'c'
local ab=aa.New
local ac=aa.Tween




local ad={
Holder=nil,

Parent=nil,
}


function ad.Create(ae,af,ag,ah,ai)
local aj={
UICorner=28,
UIPadding=12,

Window=ag,
WindUI=ah,

UIElements={},
}

if ae then
aj.UIPadding=0
end
if ae then
aj.UICorner=26
end

af=af or"Dialog"

if not ae then
aj.UIElements.FullScreen=ab("Frame",{
ZIndex=999,
BackgroundTransparency=1,
BackgroundColor3=Color3.fromHex"#000000",
Size=UDim2.new(1,0,1,0),
Active=false,
Visible=false,
Parent=ad.Parent
or(ag and ag.UIElements and ag.UIElements.Main and ag.UIElements.Main.Main),
},{
ab("UICorner",{
CornerRadius=UDim.new(0,ag.UICorner),
}),
})
end

ab("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

aj.UIElements.Main=ab("Frame",{
Size=UDim2.new(0,280,0,0),
ThemeTag={
BackgroundColor3=af.."Background",
},
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=false,
ZIndex=99999,
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,aj.UIPadding),
PaddingLeft=UDim.new(0,aj.UIPadding),
PaddingRight=UDim.new(0,aj.UIPadding),
PaddingBottom=UDim.new(0,aj.UIPadding),
}),
})

aj.UIElements.MainContainer=aa.NewRoundFrame(aj.UICorner,"Squircle",{
Visible=false,

ImageTransparency=ae and 0.15 or 0,
Parent=ai or aj.UIElements.FullScreen,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
AutomaticSize="XY",
ThemeTag={
ImageColor3=af.."Background",
ImageTransparency=af.."BackgroundTransparency",
},
ZIndex=9999,
},{
aa.NewRoundFrame(aj.UICorner,"Glass-1",{
ImageTransparency=0.89,
Size=UDim2.new(1,0,1,0)
}),
aj.UIElements.Main,




















})

function aj.Open(ak)
if not ae then
aj.UIElements.FullScreen.Visible=true
aj.UIElements.FullScreen.Active=true
end

task.spawn(function()
aj.UIElements.MainContainer.Visible=true

if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=0.3}):Play()
end
ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=0}):Play()


task.spawn(function()
task.wait(0.05)
aj.UIElements.Main.Visible=true
end)
end)
end
function aj.Close(ak)
if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=1}):Play()
aj.UIElements.FullScreen.Active=false
task.spawn(function()
task.wait(0.1)
aj.UIElements.FullScreen.Visible=false
end)
end
aj.UIElements.Main.Visible=false

ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=1}):Play()



task.spawn(function()
task.wait(0.1)
if not ae then
aj.UIElements.FullScreen:Destroy()
else
aj.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return aj
end

return ad end function a.o()
local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween

local ae=a.load'l'.New
local af=a.load'm'.New

function aa.new(ag,ah,ai,aj)
local ak=a.load'n'
local al=ak.Create(true,"Popup",ag.Window,ag.WindUI,ag.WindUI.ScreenGui.KeySystem)

local am={}

local an

local ao=(ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Width)or 200

local ap=430
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
ap=430+(ao/2)
end

al.UIElements.Main.AutomaticSize="Y"
al.UIElements.Main.Size=UDim2.new(0,ap,0,0)

local aq

if ag.Icon then
aq=
ab.Image(ag.Icon,ag.Title..":"..ag.Icon,0,"Temp","KeySystem",ag.IconThemed)
aq.Size=UDim2.new(0,24,0,24)
aq.LayoutOrder=-1
end

local ar=ac("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=ag.KeySystem.Title or ag.Title,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20,
})

local as=ac("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text="Key System",
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
TextTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
TextSize=16,
})

local at=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aq,
ar,
})

local au=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





at,
as,
})

local av=af("Enter Key","key",nil,"Input",function(av)
an=av
end)

local aw
if ag.KeySystem.Note and ag.KeySystem.Note~=""then
aw=ac("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ag.KeySystem.Note,
TextSize=18,
TextTransparency=0.4,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local ax=ac("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
},{
ac("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
}),
}),
})

local ay
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
local az
if ag.KeySystem.Thumbnail.Title then
az=ac("TextLabel",{
Text=ag.KeySystem.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
ay=ac("ImageLabel",{
Image=ag.KeySystem.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,ao,1,-12),
Position=UDim2.new(0,6,0,6),
Parent=al.UIElements.Main,
ScaleType="Crop",
},{
az,
ac("UICorner",{
CornerRadius=UDim.new(0,20),
}),
})
end

ac("Frame",{

Size=UDim2.new(1,ay and-ao or 0,1,0),
Position=UDim2.new(0,ay and ao or 0,0,0),
BackgroundTransparency=1,
Parent=al.UIElements.Main,
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
au,
aw,
av,
ax,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
}),
}),
})





local az=ae("Exit","log-out",function()
al:Close()()
end,"Tertiary",ax.Frame)

if ay then
az.Parent=ay
az.Size=UDim2.new(0,0,0,42)
az.Position=UDim2.new(0,10,1,-10)
az.AnchorPoint=Vector2.new(0,1)
end

if ag.KeySystem.URL then
ae("Get key","key",function()
setclipboard(ag.KeySystem.URL)
end,"Secondary",ax.Frame)
end

if ag.KeySystem.API then








local aA=240
local aB=false
local b=ae("Get key","key",nil,"Secondary",ax.Frame)

local d=ab.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,1,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
})

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=b.Frame,
},{
d,
ac("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
}),
})

local f=ab.Image("chevron-down","chevron-down",0,"Temp","KeySystem",true)

f.Size=UDim2.new(1,0,1,0)

ac("Frame",{
Size=UDim2.new(0,21,0,21),
Parent=b.Frame,
BackgroundTransparency=1,
},{
f,
})

local g=ab.NewRoundFrame(15,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Background",
},
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,5),
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
PaddingBottom=UDim.new(0,5),
}),
ac("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
}),
})

local h=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,aA,0,0),
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,0),
Parent=b,
Position=UDim2.new(1,0,1,15),
},{
g,
})

ac("TextLabel",{
Text="Select Service",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
Parent=g,
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
})

for j,l in next,ag.KeySystem.API do
local m=ag.WindUI.Services[l.Type]
if m then
local p={}
for r,u in next,m.Args do
table.insert(p,l[u])
end

local r=m.New(table.unpack(p))
r.Type=l.Type
table.insert(am,r)

local u=ab.Image(
l.Icon or m.Icon or Icons[l.Type]or"user",
l.Icon or m.Icon or Icons[l.Type]or"user",
0,
"Temp",
"KeySystem",
true
)
u.Size=UDim2.new(0,24,0,24)

local v=ab.NewRoundFrame(10,"Squircle",{
Size=UDim2.new(1,0,0,0),
ThemeTag={ImageColor3="Text"},
ImageTransparency=1,
Parent=g,
AutomaticSize="Y",
},{
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,10),
VerticalAlignment="Center",
}),
u,
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,-34,0,0),
AutomaticSize="Y",
},{
ac("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
HorizontalAlignment="Center",
}),
ac("TextLabel",{
Text=l.Title or m.Name,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.05,
TextSize=18,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
}),
ac("TextLabel",{
Text=l.Desc or"",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
Visible=l.Desc and true or false,
TextXAlignment="Left",
}),
}),
},true)

ab.AddSignal(v.MouseEnter,function()
ad(v,0.08,{ImageTransparency=0.95}):Play()
end)
ab.AddSignal(v.InputEnded,function()
ad(v,0.08,{ImageTransparency=1}):Play()
end)
ab.AddSignal(v.MouseButton1Click,function()
r.Copy()
ag.WindUI:Notify{
Title="Key System",
Content="Key link copied to clipboard.",
Image="key",
}
end)
end
end

ab.AddSignal(b.MouseButton1Click,function()
if not aB then
ad(
h,
0.3,
{Size=UDim2.new(0,aA,0,g.AbsoluteSize.Y+1)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.3,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(
h,
0.25,
{Size=UDim2.new(0,aA,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.25,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
aB=not aB
end)
end

local function handleSuccess(aA)
al:Close()()
writefile((ag.Folder or"Temp").."/"..ah..".key",tostring(aA))
task.wait(0.4)
ai(true)
end

local aA=ae("Submit","arrow-right",function()
local aA=tostring(an or"empty")local aB=
ag.Folder or ag.Title

if ag.KeySystem.KeyValidator then
local b=ag.KeySystem.KeyValidator(aA)

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
else
ag.WindUI:Notify{
Title="Key System. Error",
Content="Invalid key.",
Icon="triangle-alert",
}
end
elseif not ag.KeySystem.API then
local b=type(ag.KeySystem.Key)=="table"and table.find(ag.KeySystem.Key,aA)
or ag.KeySystem.Key==aA

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
end
else
local b,d
for f,g in next,am do
local h,j=g.Verify(aA)
if h then
b,d=true,j
break
end
d=j
end

if b then
handleSuccess(aA)
else
ag.WindUI:Notify{
Title="Key System. Error",
Content=d,
Icon="triangle-alert",
}
end
end
end,"Primary",ax)

aA.AnchorPoint=Vector2.new(1,0.5)
aA.Position=UDim2.new(1,0,0.5,0)










al:Open()
end

return aa end function a.p()




local aa=(cloneref or clonereference or function(aa)return aa end)


local function map(ab,ac,ad,ae,af)
return(ab-ac)*(af-ae)/(ad-ac)+ae
end

local function viewportPointToWorld(ab,ac)
local ad=aa(game:GetService"Workspace").CurrentCamera:ScreenPointToRay(ab.X,ab.Y)
return ad.Origin+ad.Direction*ac
end

local function getOffset()
local ab=aa(game:GetService"Workspace").CurrentCamera.ViewportSize.Y
return map(ab,0,2560,8,56)
end

return{viewportPointToWorld,getOffset}end function a.q()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=a.load'c'
local ac=ab.New


local ad,ae=unpack(a.load'p')
local af=Instance.new("Folder",aa(game:GetService"Workspace").CurrentCamera)


local function createAcrylic()
local ag=ac("Part",{
Name="Body",
Color=Color3.new(0,0,0),
Material=Enum.Material.Glass,
Size=Vector3.new(1,1,0),
Anchored=true,
CanCollide=false,
Locked=true,
CastShadow=false,
Transparency=0.98,
},{
ac("SpecialMesh",{
MeshType=Enum.MeshType.Brick,
Offset=Vector3.new(0,0,-1E-6),
}),
})

return ag
end


local function createAcrylicBlur(ag)
local ah={}

ag=ag or 0.001
local ai={
topLeft=Vector2.new(),
topRight=Vector2.new(),
bottomRight=Vector2.new(),
}
local aj=createAcrylic()
aj.Parent=af

local function updatePositions(ak,al)
ai.topLeft=al
ai.topRight=al+Vector2.new(ak.X,0)
ai.bottomRight=al+ak
end

local function render()
local ak=aa(game:GetService"Workspace").CurrentCamera
if ak then
ak=ak.CFrame
end
local al=ak
if not al then
al=CFrame.new()
end

local am=al
local an=ai.topLeft
local ao=ai.topRight
local ap=ai.bottomRight

local aq=ad(an,ag)
local ar=ad(ao,ag)
local as=ad(ap,ag)

local at=(ar-aq).Magnitude
local au=(ar-as).Magnitude

aj.CFrame=
CFrame.fromMatrix((aq+as)/2,am.XVector,am.YVector,am.ZVector)
aj.Mesh.Scale=Vector3.new(at,au,0)
end

local function onChange(ak)
local al=ae()
local am=ak.AbsoluteSize-Vector2.new(al,al)
local an=ak.AbsolutePosition+Vector2.new(al/2,al/2)

updatePositions(am,an)
task.spawn(render)
end

local function renderOnChange()
local ak=aa(game:GetService"Workspace").CurrentCamera
if not ak then
return
end

table.insert(ah,ak:GetPropertyChangedSignal"CFrame":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"ViewportSize":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"FieldOfView":Connect(render))
task.spawn(render)
end

aj.Destroying:Connect(function()
for ak,al in ah do
pcall(function()
al:Disconnect()
end)
end
end)

renderOnChange()

return onChange,aj
end

return function(ag)
local ah={}
local ai,aj=createAcrylicBlur(ag)

local ak=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
})

ab.AddSignal(ak:GetPropertyChangedSignal"AbsolutePosition",function()
ai(ak)
end)

ab.AddSignal(ak:GetPropertyChangedSignal"AbsoluteSize",function()
ai(ak)
end)

ah.AddParent=function(al)
ab.AddSignal(al:GetPropertyChangedSignal"Visible",function()

end)
end

ah.SetVisibility=function(al)
aj.Transparency=al and 0.98 or 1
end

ah.Frame=ak
ah.Model=aj

return ah
end end function a.r()


local aa=a.load'c'
local ab=a.load'q'

local ac=aa.New

return function(ad)
local ae={}

ae.Frame=ac("Frame",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(255,255,255),
BorderSizePixel=0,
},{












ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Name="Background",
ThemeTag={
BackgroundColor3="AcrylicMain",
},
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundColor3=Color3.fromRGB(255,255,255),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{










}),

ac("ImageLabel",{
Image="rbxassetid://9968344105",
ImageTransparency=0.98,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("ImageLabel",{
Image="rbxassetid://9968344227",
ImageTransparency=0.9,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ThemeTag={
ImageTransparency="AcrylicNoise",
},
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=2,
},{










}),
})


local af

task.wait()
if ad.UseAcrylic then
af=ab()

af.Frame.Parent=ae.Frame
ae.Model=af.Model
ae.AddParent=af.AddParent
ae.SetVisibility=af.SetVisibility
end

return ae,af
end end function a.s()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab={
AcrylicBlur=a.load'q',

AcrylicPaint=a.load'r',
}

function ab.init()
local ac=Instance.new"DepthOfFieldEffect"
ac.FarIntensity=0
ac.InFocusRadius=0.1
ac.NearIntensity=1

local ad={}

function ab.Enable()
for ae,af in pairs(ad)do
af.Enabled=false
end
ac.Parent=aa(game:GetService"Lighting")
end

function ab.Disable()
for ae,af in pairs(ad)do
af.Enabled=af.enabled
end
ac.Parent=nil
end

local function registerDefaults()
local function register(ae)
if ae:IsA"DepthOfFieldEffect"then
ad[ae]={enabled=ae.Enabled}
end
end

for ae,af in pairs(aa(game:GetService"Lighting"):GetChildren())do
register(af)
end

if aa(game:GetService"Workspace").CurrentCamera then
for ae,af in pairs(aa(game:GetService"Workspace").CurrentCamera:GetChildren())do
register(af)
end
end
end

registerDefaults()
ab.Enable()
end

return ab end function a.t()

local aa={}

local ab=a.load'c'
local ac=ab.New local ad=
ab.Tween


function aa.new(ae,af)
local ag={
Title=ae.Title or"Dialog",
Content=ae.Content,
Icon=ae.Icon,
IconThemed=ae.IconThemed,
Thumbnail=ae.Thumbnail,
Buttons=ae.Buttons,

IconSize=22,
}

local ah=a.load'n'
local ai=ah.Create(true,"Popup",ae.WindUI.Window,ae.WindUI,af)

local aj=200

local ak=430
if ag.Thumbnail and ag.Thumbnail.Image then
ak=430+(aj/2)
end

ai.UIElements.Main.AutomaticSize="Y"
ai.UIElements.Main.Size=UDim2.new(0,ak,0,0)



local al

if ag.Icon then
al=ab.Image(
ag.Icon,
ag.Title..":"..ag.Icon,
0,
ae.WindUI.Window,
"Popup",
true,
ae.IconThemed,
"PopupIcon"
)
al.Size=UDim2.new(0,ag.IconSize,0,ag.IconSize)
al.LayoutOrder=-1
end


local am=ac("TextLabel",{
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ag.Title,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="PopupTitle",
},
TextSize=20,
TextWrapped=true,
Size=UDim2.new(1,al and-ag.IconSize-14 or 0,0,0)
})

local an=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
al,am
})

local ao=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





an,
})

local ap
if ag.Content and ag.Content~=""then
ap=ac("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ag.Content,
TextSize=18,
TextTransparency=.2,
ThemeTag={
TextColor3="PopupContent",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local aq=ac("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
HorizontalAlignment="Right"
})
})

local ar
if ag.Thumbnail and ag.Thumbnail.Image then
local as
if ag.Thumbnail.Title then
as=ac("TextLabel",{
Text=ag.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
ar=ac("ImageLabel",{
Image=ag.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,aj,1,0),
Parent=ai.UIElements.Main,
ScaleType="Crop"
},{
as,
ac("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

ac("Frame",{

Size=UDim2.new(1,ar and-aj or 0,1,0),
Position=UDim2.new(0,ar and aj or 0,0,0),
BackgroundTransparency=1,
Parent=ai.UIElements.Main
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
ao,
ap,
aq,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})

local as=a.load'l'.New

for at,au in next,ag.Buttons do
as(au.Title,au.Icon,au.Callback,au.Variant,aq,ai)
end

ai:Open()


return ag
end

return aa end function a.u()
return function(aa,ab)
return{
Dark={
Name="Dark",

Accent=Color3.fromHex"#18181b",
Dialog=Color3.fromHex"#161616",
Outline=Color3.fromHex"#FFFFFF",
Text=Color3.fromHex"#FFFFFF",
Placeholder=Color3.fromHex"#7a7a7a",
Background=Color3.fromHex"#101010",
Button=Color3.fromHex"#52525b",
Icon=Color3.fromHex"#a1a1aa",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

SliderIcon=Color3.fromHex"#908F95",
Primary=Color3.fromHex"#0091FF",


LabelBackground=Color3.fromHex"#000000",
LabelBackgroundTransparency=0.83,

ElementBackground=Color3.fromHex"#2A2A2C",
ElementBackgroundTransparency=0,
},

Light={
Name="Light",

Accent=Color3.fromHex"#FFFFFF",
Dialog=Color3.fromHex"#f4f4f5",
Outline=Color3.fromHex"#ffffff",
Text=Color3.fromHex"#000000",
Placeholder=Color3.fromHex"#555555",
Background=Color3.fromHex"#e9e9e9",
Button=Color3.fromHex"#18181b",
Icon=Color3.fromHex"#52525b",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

TabBackground=Color3.fromHex"#ffffff",
TabBackgroundHover=Color3.fromHex"#ffffff",
TabBackgroundHoverTransparency=0.5,
TabBackgroundActive=Color3.fromHex"#ffffff",
TabBackgroundActiveTransparency=0,

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0,

LabelBackground=Color3.fromHex"#ffffff",
LabelBackgroundTransparency=0,

ElementBackground=Color3.fromHex"#EEEEEE",
ElementBackgroundTransparency=0,
},

Rose={
Name="Rose",

Accent=Color3.fromHex"#be185d",
Dialog=Color3.fromHex"#4c0519",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#d67aa6",
Background=Color3.fromHex"#1f0308",
Button=Color3.fromHex"#e95f74",
Icon=Color3.fromHex"#fb7185",

ElementBackground=Color3.fromHex"#381E23",
ElementBackgroundTransparency=0,
},

Plant={
Name="Plant",

Accent=Color3.fromHex"#166534",
Dialog=Color3.fromHex"#052e16",

Text=Color3.fromHex"#f0fdf4",
Placeholder=Color3.fromHex"#4fbf7a",
Background=Color3.fromHex"#0a1b0f",
Button=Color3.fromHex"#16a34a",
Icon=Color3.fromHex"#4ade80",

ElementBackground=Color3.fromHex"#28342A",
ElementBackgroundTransparency=0,
},

Red={
Name="Red",

Accent=Color3.fromHex"#991b1b",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#d95353",
Background=Color3.fromHex"#1c0606",
Button=Color3.fromHex"#dc2626",
Icon=Color3.fromHex"#ef4444",

ElementBackground=Color3.fromHex"#322221",
ElementBackgroundTransparency=0,
},

Indigo={
Name="Indigo",

Accent=Color3.fromHex"#3730a3",
Dialog=Color3.fromHex"#1e1b4b",

Text=Color3.fromHex"#f1f5f9",
Placeholder=Color3.fromHex"#7078d9",
Background=Color3.fromHex"#0f0a2e",
Button=Color3.fromHex"#4f46e5",
Icon=Color3.fromHex"#6366f1",

ElementBackground=Color3.fromHex"#282543",
ElementBackgroundTransparency=0,
},

Sky={
Name="Sky",

Accent=Color3.fromHex"#00d4ff",
Dialog=Color3.fromHex"#0a4d66",

Text=Color3.fromHex"#e6f7ff",
Placeholder=Color3.fromHex"#66b3cc",
Background=Color3.fromHex"#051a26",
Button=Color3.fromHex"#00a8cc",
Icon=Color3.fromHex"#2db8d9",

Toggle=Color3.fromHex"#00d9d9",
Slider=Color3.fromHex"#00d4ff",
Checkbox=Color3.fromHex"#00d4ff",

PanelBackground=Color3.fromHex"#0d3a47",
PanelBackgroundTransparency=0.8,

ElementBackground=Color3.fromHex"#172E3B",
ElementBackgroundTransparency=0,
},

Violet={
Name="Violet",

Accent=Color3.fromHex"#6d28d9",
Dialog=Color3.fromHex"#3c1361",

Text=Color3.fromHex"#faf5ff",
Placeholder=Color3.fromHex"#8f7ee0",
Background=Color3.fromHex"#1e0a3e",
Button=Color3.fromHex"#7c3aed",
Icon=Color3.fromHex"#8b5cf6",

ElementBackground=Color3.fromHex"#342650",
ElementBackgroundTransparency=0,
},

Amber={
Name="Amber",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#b45309",Transparency=0},
["100"]={Color=Color3.fromHex"#d97706",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#451a03",Transparency=0},
["100"]={Color=Color3.fromHex"#6b2e05",Transparency=0},
},{Rotation=90}),






Text=aa:Gradient({
["0"]={Color=Color3.fromHex"#fffbeb",Transparency=0},
["100"]={Color=Color3.fromHex"#fff7ed",Transparency=0},
},{Rotation=45}),

Placeholder=aa:Gradient({
["0"]={Color=Color3.fromHex"#d1a326",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#1c1003",Transparency=0},
["100"]={Color=Color3.fromHex"#3f210d",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Icon=Color3.fromHex"#f59e0b",

Toggle=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Slider=Color3.fromHex"#d97706",

Checkbox=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

ElementBackground=Color3.fromHex"#3A2E22",
ElementBackgroundTransparency=0,
},

Emerald={
Name="Emerald",

Accent=Color3.fromHex"#047857",
Dialog=Color3.fromHex"#022c22",

Text=Color3.fromHex"#ecfdf5",
Placeholder=Color3.fromHex"#3fbf8f",
Background=Color3.fromHex"#011411",
Button=Color3.fromHex"#059669",
Icon=Color3.fromHex"#10b981",

ElementBackground=Color3.fromHex"#202E2A",
ElementBackgroundTransparency=0,
},

Midnight={
Name="Midnight",

Accent=Color3.fromHex"#1e3a8a",
Dialog=Color3.fromHex"#0c1e42",

Text=Color3.fromHex"#dbeafe",
Placeholder=Color3.fromHex"#2f74d1",
Background=Color3.fromHex"#0a0f1e",
Button=Color3.fromHex"#2563eb",
Primary=Color3.fromHex"#2563eb",
Icon=Color3.fromHex"#5591f4",

ElementBackground=Color3.fromHex"#242836",
ElementBackgroundTransparency=0,
},

Crimson={
Name="Crimson",

Accent=Color3.fromHex"#b91c1c",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#6f757b",
Background=Color3.fromHex"#0c0404",
Button=Color3.fromHex"#991b1b",
Icon=Color3.fromHex"#dc2626",

ElementBackground=Color3.fromHex"#251F1F",
ElementBackgroundTransparency=0,
},

MonokaiPro={
Name="Monokai Pro",

Accent=Color3.fromHex"#fc9867",
Dialog=Color3.fromHex"#1e1e1e",

Text=Color3.fromHex"#fcfcfa",
Placeholder=Color3.fromHex"#6f6f6f",
Background=Color3.fromHex"#191622",
Button=Color3.fromHex"#ab9df2",
Icon=Color3.fromHex"#a9dc76",

ElementBackground=Color3.fromHex"#323039",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=23,
},
},

CottonCandy={
Name="Cotton Candy",

Accent=Color3.fromHex"#ec4899",
Dialog=Color3.fromHex"#2d1b3d",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#8a5fd3",
Background=Color3.fromHex"#1a0b2e",
Button=Color3.fromHex"#d946ef",
Slider=Color3.fromHex"#d946ef",
Icon=Color3.fromHex"#06b6d4",

ElementBackground=Color3.fromHex"#312643",
ElementBackgroundTransparency=0,
},

Mellowsi={
Name="Mellowsi",

Accent=Color3.fromHex"#342A1E",
Dialog=Color3.fromHex"#291C13",

Text=Color3.fromHex"#F5EBDD",
Placeholder=Color3.fromHex"#9C8A73",
Background=Color3.fromHex"#1C1002",
Button=Color3.fromHex"#342A1E",
Icon=Color3.fromHex"#C9B79C",

Toggle=Color3.fromHex"#a9873f",
Slider=Color3.fromHex"#C9A24D",
Checkbox=Color3.fromHex"#C9A24D",

ElementBackground=Color3.fromHex"#33291E",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=52,
},
},

Rainbow={
Name="Rainbow",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#00ff41",Transparency=0},
["33"]={Color=Color3.fromHex"#00ffff",Transparency=0},
["66"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["100"]={Color=Color3.fromHex"#8000ff",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#8000ff",Transparency=0},
["50"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["75"]={Color=Color3.fromHex"#00ff80",Transparency=0},
["100"]={Color=Color3.fromHex"#ff8000",Transparency=0},
},{Rotation=135}),


Text=Color3.fromHex"#ffffff",
Placeholder=Color3.fromHex"#00ff80",

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0040",Transparency=0},
["20"]={Color=Color3.fromHex"#ff4000",Transparency=0},
["40"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["60"]={Color=Color3.fromHex"#00ff40",Transparency=0},
["80"]={Color=Color3.fromHex"#0040ff",Transparency=0},
["100"]={Color=Color3.fromHex"#4000ff",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#ff8000",Transparency=0},
["50"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["75"]={Color=Color3.fromHex"#80ff00",Transparency=0},
["100"]={Color=Color3.fromHex"#00ffff",Transparency=0},
},{Rotation=60}),

Icon=Color3.fromHex"#ffffff",
},
}
end end function a.v()

local aa={}

local ab=a.load'c'
local ac=ab.New local ad=
ab.Tween

function aa.New(ae,af,ag,ah,ai)
local aj=ai or 10
local ak
if af and af~=""then
ak=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
})
end

local al=ac("TextLabel",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,ak and-29 or 0,1,0),
TextXAlignment="Left",
ThemeTag={
TextColor3=ah and"Placeholder"or"Text",
},
Text=ae,
})

local am=ac("TextButton",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1,
Text="",
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(aj,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.97,
}),
ab.NewRoundFrame(aj,"Glass-1.4",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.48,
},{













}),
ab.NewRoundFrame(aj,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3="LabelBackground",
ImageTransparency="LabelBackgroundTransparency",
},


},{
ac("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ak,
al,
}),
}),
})

return am
end

return aa end function a.w()

local aa={}

local ab=(cloneref or clonereference or function(ab)return ab end)


local ac=ab(game:GetService"UserInputService")

local ad=a.load'c'
local ae=ad.New local af=
ad.Tween


function aa.New(ag,ah,ai,aj)
local ak=ae("Frame",{
Size=UDim2.new(0,aj,1,0),
BackgroundTransparency=1,
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
Parent=ah,
ZIndex=999,
Active=true,
})

local al=ad.NewRoundFrame(aj/2,"Squircle",{
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.85,
ThemeTag={ImageColor3="Text"},
Parent=ak,
})

local am=ae("Frame",{
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
ZIndex=999,
Parent=al,
})

local an=false
local ao=0

local function updateSliderSize()
local ap=ag
local aq=ap.AbsoluteCanvasSize.Y
local ar=ap.AbsoluteWindowSize.Y

if aq<=ar then
al.Visible=false
return
end

local as=math.clamp(ar/aq,0.1,1)
al.Size=UDim2.new(1,0,as,0)
al.Visible=true
end

local function updateScrollingFramePosition()
local ap=al.Position.Y.Scale
local aq=ag.AbsoluteCanvasSize.Y
local ar=ag.AbsoluteWindowSize.Y
local as=math.max(aq-ar,0)

if as<=0 then return end

local at=math.max(1-al.Size.Y.Scale,0)
if at<=0 then return end

local au=ap/at

ag.CanvasPosition=Vector2.new(
ag.CanvasPosition.X,
au*as
)
end

local function updateThumbPosition()
if an then return end

local ap=ag.CanvasPosition.Y
local aq=ag.AbsoluteCanvasSize.Y
local ar=ag.AbsoluteWindowSize.Y
local as=math.max(aq-ar,0)

if as<=0 then
al.Position=UDim2.new(0,0,0,0)
return
end

local at=ap/as
local au=math.max(1-al.Size.Y.Scale,0)
local av=math.clamp(at*au,0,au)

al.Position=UDim2.new(0,0,av,0)
end

ad.AddSignal(ak.InputBegan,function(ap)
if(ap.UserInputType==Enum.UserInputType.MouseButton1 or ap.UserInputType==Enum.UserInputType.Touch)then
local aq=al.AbsolutePosition.Y
local ar=aq+al.AbsoluteSize.Y

if not(ap.Position.Y>=aq and ap.Position.Y<=ar)then
local as=ak.AbsolutePosition.Y
local at=ak.AbsoluteSize.Y
local au=al.AbsoluteSize.Y

local av=ap.Position.Y-as-au/2
local aw=at-au

local ax=math.clamp(av/aw,0,1-al.Size.Y.Scale)

al.Position=UDim2.new(0,0,ax,0)
updateScrollingFramePosition()
end
end
end)

ad.AddSignal(am.InputBegan,function(ap)
if ap.UserInputType==Enum.UserInputType.MouseButton1 or ap.UserInputType==Enum.UserInputType.Touch then
an=true
ao=ap.Position.Y-al.AbsolutePosition.Y

local aq
local ar

aq=ac.InputChanged:Connect(function(as)
if as.UserInputType==Enum.UserInputType.MouseMovement or as.UserInputType==Enum.UserInputType.Touch then
local at=ak.AbsolutePosition.Y
local au=ak.AbsoluteSize.Y
local av=al.AbsoluteSize.Y

local aw=as.Position.Y-at-ao
local ax=au-av

local ay=math.clamp(aw/ax,0,1-al.Size.Y.Scale)

al.Position=UDim2.new(0,0,ay,0)
updateScrollingFramePosition()
end
end)

ar=ac.InputEnded:Connect(function(as)
if as.UserInputType==Enum.UserInputType.MouseButton1 or as.UserInputType==Enum.UserInputType.Touch then
an=false
if aq then aq:Disconnect()end
if ar then ar:Disconnect()end
end
end)
end
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteWindowSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteCanvasSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"CanvasPosition",function()
if not an then
updateThumbPosition()
end
end)

updateSliderSize()
updateThumbPosition()

return ak
end


return aa end function a.x()
local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween

function aa.New(ae,af,ag)
local ah={
Title=af.Title or"Tag",
Icon=af.Icon,
Color=af.Color or Color3.fromHex"#315dff",
Radius=af.Radius or 999,
Border=af.Border or false,

TagFrame=nil,
Height=26,
Padding=10,
TextSize=14,
IconSize=16,
}

local ai
if ah.Icon then
ai=ab.Image(ah.Icon,ah.Icon,0,af.Window,"Tag",false)

ai.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.ImageLabel.ImageColor3=typeof(ah.Color)=="Color3"
and ab.GetTextColorForHSB(ah.Color)
or typeof(ah.Color)=="string"
and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme)))
end

local aj=ac("TextLabel",{
BackgroundTransparency=1,
AutomaticSize="XY",
TextSize=ah.TextSize,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ah.Title,
TextColor3=typeof(ah.Color)=="Color3"and ab.GetTextColorForHSB(ah.Color)or typeof(
ah.Color
)=="string"and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))),
})

local ak

if typeof(ah.Color)=="table"then
ak=ac"UIGradient"
for al,am in next,ah.Color do
ak[al]=am
end

aj.TextColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
if ai then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
end

local al=ab.NewRoundFrame(ah.Radius,"Squircle",{
AutomaticSize="X",
Size=UDim2.new(0,0,0,ah.Height),
Parent=ag,
ImageColor3=typeof(ah.Color)=="Color3"and ah.Color
or typeof(ah.Color)=="table"and Color3.new(1,1,1)
or nil,
ThemeTag=typeof(ah.Color)=="string"and{
ImageColor3=ah.Color,
},
},{
ak,
ab.NewRoundFrame(ah.Radius,"Glass-1",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0.75,
}),
ac("Frame",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Name="Content",
BackgroundTransparency=1,
},{
ai,
aj,
ac("UIPadding",{
PaddingLeft=UDim.new(0,ah.Padding),
PaddingRight=UDim.new(0,ah.Padding),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,ah.Padding/1.5),
}),
}),
})

function ah.SetTitle(am,an)
ah.Title=an
aj.Text=an

return ah
end

function ah.SetColor(am,an)
ah.Color=an
if typeof(an)=="table"then
local ao=ab.GetAverageColor(an)
ad(aj,0.06,{TextColor3=ab.GetTextColorForHSB(ao)}):Play()
local ap=al:FindFirstChildOfClass"UIGradient"or ac("UIGradient",{Parent=al})
for aq,ar in next,an do
ap[aq]=ar
end
ad(al,0.06,{ImageColor3=Color3.new(1,1,1)}):Play()
else
if ak then
ak:Destroy()
end
ad(aj,0.06,{TextColor3=ab.GetTextColorForHSB(an)}):Play()
if ai then
ad(ai.ImageLabel,0.06,{ImageColor3=ab.GetTextColorForHSB(an)}):Play()
end
ad(al,0.06,{ImageColor3=an}):Play()
end

return ah
end

function ah.SetIcon(am,an)
ah.Icon=an

if an then
ai=ab.Image(an,an,0,af.Window,"Tag",false)

ai.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.Parent=al

if typeof(ah.Color)=="Color3"then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ah.Color)
elseif typeof(ah.Color)=="table"then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
else
if ai then
ai:Destroy()
ai=nil
end
end
return ah
end

function ah.Destroy(am)
al:Destroy()
return ah
end

ab:OnThemeChange(function(am,an)
aj.TextColor3=ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))
ai.ImageLabel.ImageColor3=
ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))
end)

return ah
end

return aa end function a.y()

local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=aa(game:GetService"RunService")
local ac=aa(game:GetService"HttpService")

local ad

local ae
ae={
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(af)
return{
__type=af.__type,
value=af.Default:ToHex(),
transparency=af.Transparency or nil,
}
end,
Load=function(af,ag)
if af and af.Update then
af:Update(Color3.fromHex(ag.value),ag.transparency or nil)
end
end
},
Dropdown={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Select then
af:Select(ag.value)
end
end
},
Input={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Keybind={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Slider={
Save=function(af)
return{
__type=af.__type,
value=af.Value.Default,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(tonumber(ag.value))
end
end
},
Toggle={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
}
}

function ae.Init(af,ag)
if not ag.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end
if ab:IsStudio()or not writefile then
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return false
end

ad=ag
ae.Folder=ad.Folder
ae.Path="WindUI/"..tostring(ae.Folder).."/config/"

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

local ah=ae:AllConfigs()

for ai,aj in next,ah do
if isfile and readfile and isfile(aj..".json")then
ae.Configs[aj]=readfile(aj..".json")
end
end

return ae
end

function ae.SetPath(af,ag)
if not ag then
warn"[ WindUI.ConfigManager ] Custom path is not specified."
return false
end

ae.Path=ag
if not ag:match"/$"then
ae.Path=ag.."/"
end

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

return true
end

function ae.CreateConfig(af,ag,ah)
local ai={
Path=ae.Path..ag..".json",
Elements={},
CustomData={},
AutoLoad=ah or false,
Version=1.2,
}

if not ag then
return false,"No config file is selected"
end

function ai.SetAsCurrent(aj)
ad:SetCurrentConfig(ai)
end

function ai.Register(aj,ak,al)
ai.Elements[ak]=al
end

function ai.Set(aj,ak,al)
ai.CustomData[ak]=al
end

function ai.Get(aj,ak)
return ai.CustomData[ak]
end

function ai.SetAutoLoad(aj,ak)
ai.AutoLoad=ak
end

function ai.Save(aj)
if ad.PendingFlags then
for ak,al in next,ad.PendingFlags do
ai:Register(ak,al)
end
end

local ak={
__version=ai.Version,
__elements={},
__autoload=ai.AutoLoad,
__custom=ai.CustomData
}

for al,am in next,ai.Elements do
if ae.Parser[am.__type]then
ak.__elements[tostring(al)]=ae.Parser[am.__type].Save(am)
end
end

local al=ac:JSONEncode(ak)
if writefile then
writefile(ai.Path,al)
end

return ak
end

function ai.Load(aj)
if isfile and not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=pcall(function()
local ak=readfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return nil
end
return ac:JSONDecode(ak(ai.Path))
end)

if not ak then
return false,"Failed to parse config file"
end

if not al.__version then
local am={
__version=ai.Version,
__elements=al,
__custom={}
}
al=am
end

if ad.PendingFlags then
for am,an in next,ad.PendingFlags do
ai:Register(am,an)
end
end

for am,an in next,(al.__elements or{})do
if ai.Elements[am]and ae.Parser[an.__type]then
task.spawn(function()
ae.Parser[an.__type].Load(ai.Elements[am],an)
end)
end
end

ai.CustomData=al.__custom or{}

return ai.CustomData
end

function ai.Delete(aj)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=pcall(function()
delfile(ai.Path)
end)

if not ak then
return false,"Failed to delete config file: "..tostring(al)
end

ae.Configs[ag]=nil

if ad.CurrentConfig==ai then
ad.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ai.GetData(aj)
return{
elements=ai.Elements,
custom=ai.CustomData,
autoload=ai.AutoLoad
}
end


if isfile(ai.Path)then
local aj,ak=pcall(function()
return ac:JSONDecode(readfile(ai.Path))
end)

if aj and ak and ak.__autoload then
ai.AutoLoad=true

task.spawn(function()
task.wait(0.5)
local al,am=pcall(function()
return ai:Load()
end)
if al then
if ad.Debug then print("[ WindUI.ConfigManager ] AutoLoaded config: "..ag)end
else
warn("[ WindUI.ConfigManager ] Failed to AutoLoad config: "..ag.." - "..tostring(am))
end
end)
end
end


ai:SetAsCurrent()
ae.Configs[ag]=ai
return ai
end

function ae.Config(af,ag,ah)
return ae:CreateConfig(ag,ah)
end

function ae.GetAutoLoadConfigs(af)
local ag={}

for ah,ai in pairs(ae.Configs)do
if ai.AutoLoad then
table.insert(ag,ah)
end
end

return ag
end

function ae.DeleteConfig(af,ag)
if not delfile then
return false,"delfile function is not available"
end

local ah=ae.Path..ag..".json"

if not isfile(ah)then
return false,"Config file does not exist"
end

local ai,aj=pcall(function()
delfile(ah)
end)

if not ai then
return false,"Failed to delete config file: "..tostring(aj)
end

ae.Configs[ag]=nil

if ad.CurrentConfig and ad.CurrentConfig.Path==ah then
ad.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ae.AllConfigs(af)
if not listfiles then return{}end

local ag={}
if not isfolder(ae.Path)then
makefolder(ae.Path)
return ag
end

for ah,ai in next,listfiles(ae.Path)do
local aj=ai:match"([^\\/]+)%.json$"
if aj then
table.insert(ag,aj)
end
end

return ag
end

function ae.GetConfig(af,ag)
return ae.Configs[ag]
end

return ae end function a.z()
local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween


local ae=(cloneref or clonereference or function(ae)return ae end)


ae(game:GetService"UserInputService")


function aa.New(af)
local ag={
Button=nil
}

local ah













local ai=ac("TextLabel",{
Text=af.Title,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
})

local aj=ac("Frame",{
Size=UDim2.new(0,36,0,36),
BackgroundTransparency=1,
Name="Drag",
},{
ac("ImageLabel",{
Image=ab.Icon"move"[1],
ImageRectOffset=ab.Icon"move"[2].ImageRectPosition,
ImageRectSize=ab.Icon"move"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.3,
})
})
local ak=ac("Frame",{
Size=UDim2.new(0,1,1,0),
Position=UDim2.new(0,36,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=.9,
})

local al=ac("Frame",{
Size=UDim2.new(0,0,0,0),
Position=UDim2.new(0.5,0,0,28),
AnchorPoint=Vector2.new(0.5,0.5),
Parent=af.Parent,
BackgroundTransparency=1,
Active=true,
Visible=false,
})


local am=ac("UIScale",{
Scale=1,
})

local an=ac("Frame",{
Size=UDim2.new(0,0,0,44),
AutomaticSize="X",
Parent=al,
Active=false,
BackgroundTransparency=.25,
ZIndex=99,
BackgroundColor3=Color3.new(0,0,0),
},{
am,
ac("UICorner",{
CornerRadius=UDim.new(1,0)
}),
ac("UIStroke",{
Thickness=1,
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=0,
},{
ac("UIGradient",{
Color=ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff")
})
}),
aj,
ak,

ac("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),

ac("TextButton",{
AutomaticSize="XY",
Active=true,
BackgroundTransparency=1,
Size=UDim2.new(0,0,0,36),

BackgroundColor3=Color3.new(1,1,1),
},{
ac("UICorner",{
CornerRadius=UDim.new(1,-4)
}),
ah,
ac("UIListLayout",{
Padding=UDim.new(0,af.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ai,
ac("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
}),
}),
ac("UIPadding",{
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
})
})

ag.Button=an



function ag.SetIcon(ao,ap)
if ah then
ah:Destroy()
end
if ap then
ah=ab.Image(
ap,
af.Title,
0,
af.Folder,
"OpenButton",
true,
af.IconThemed
)
ah.Size=UDim2.new(0,22,0,22)
ah.LayoutOrder=-1
ah.Parent=ag.Button.TextButton
end
end

if af.Icon then
ag:SetIcon(af.Icon)
end



ab.AddSignal(an:GetPropertyChangedSignal"AbsoluteSize",function()
al.Size=UDim2.new(
0,an.AbsoluteSize.X,
0,an.AbsoluteSize.Y
)
end)

ab.AddSignal(an.TextButton.MouseEnter,function()
ad(an.TextButton,.1,{BackgroundTransparency=.93}):Play()
end)
ab.AddSignal(an.TextButton.MouseLeave,function()
ad(an.TextButton,.1,{BackgroundTransparency=1}):Play()
end)

local ao=ab.Drag(al)


function ag.Visible(ap,aq)
al.Visible=aq
end

function ag.SetScale(ap,aq)
am.Scale=aq
end

function ag.Edit(ap,aq)
local ar={
Title=aq.Title,
Icon=aq.Icon,
Enabled=aq.Enabled,
Position=aq.Position,
OnlyIcon=aq.OnlyIcon or false,
Draggable=aq.Draggable or nil,
OnlyMobile=aq.OnlyMobile,
CornerRadius=aq.CornerRadius or UDim.new(1,0),
StrokeThickness=aq.StrokeThickness or 2,
Scale=aq.Scale or 1,
Color=aq.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if ar.Enabled==false then
af.IsOpenButtonEnabled=false
end

if ar.OnlyMobile~=false then
ar.OnlyMobile=true
else
af.IsPC=false
end


if ar.Draggable==false and aj and ak then
aj.Visible=ar.Draggable
ak.Visible=ar.Draggable

if ao then
ao:Set(ar.Draggable)
end
end

if ar.Position and al then
al.Position=ar.Position
end

if ar.OnlyIcon==true and ai then
ai.Visible=false
an.TextButton.UIPadding.PaddingLeft=UDim.new(0,7)
an.TextButton.UIPadding.PaddingRight=UDim.new(0,7)
elseif ar.OnlyIcon==false then
ai.Visible=true
an.TextButton.UIPadding.PaddingLeft=UDim.new(0,11)
an.TextButton.UIPadding.PaddingRight=UDim.new(0,11)
end





if ai then
if ar.Title then
ai.Text=ar.Title
ab:ChangeTranslationKey(ai,ar.Title)
elseif ar.Title==nil then

end
end

if ar.Icon then
ag:SetIcon(ar.Icon)
end

an.UIStroke.UIGradient.Color=ar.Color
if Glow then
Glow.UIGradient.Color=ar.Color
end

an.UICorner.CornerRadius=ar.CornerRadius
an.TextButton.UICorner.CornerRadius=UDim.new(ar.CornerRadius.Scale,ar.CornerRadius.Offset-4)
an.UIStroke.Thickness=ar.StrokeThickness

ag:SetScale(ar.Scale)
end

return ag
end



return aa end function a.A()
local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak={
Container=nil,
TooltipSize=16,

TooltipArrowSizeX=ai=="Small"and 16 or 24,
TooltipArrowSizeY=ai=="Small"and 6 or 9,

PaddingX=ai=="Small"and 12 or 14,
PaddingY=ai=="Small"and 7 or 9,

Radius=999,

TitleFrame=nil,
}

ah=ah or""
aj=aj~=false

local al=ac("TextLabel",{
AutomaticSize="XY",
TextWrapped=aj,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Text=ae,
TextSize=ai=="Small"and 15 or 17,
TextTransparency=1,
ThemeTag={
TextColor3="Tooltip"..ah.."Text",
}
})

ak.TitleFrame=al

local am=ac("UIScale",{
Scale=.9
})

local an=ac("Frame",{
AnchorPoint=Vector2.new(0.5,0),
AutomaticSize="XY",
BackgroundTransparency=1,
Parent=af,

Visible=false
},{
ac("UISizeConstraint",{
MaxSize=Vector2.new(400,math.huge)
}),
ac("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
LayoutOrder=99,
Visible=ag,
Name="Arrow",
},{
ac("ImageLabel",{
Size=UDim2.new(0,ak.TooltipArrowSizeX,0,ak.TooltipArrowSizeY),
BackgroundTransparency=1,

Image="rbxassetid://105854070513330",
ThemeTag={
ImageColor3="Tooltip"..ah,
},
},{










}),
}),
ab.NewRoundFrame(ak.Radius,"Squircle",{
AutomaticSize="XY",
ThemeTag={
ImageColor3="Tooltip"..ah,
},
ImageTransparency=1,
Name="Background",
},{



ac("Frame",{



AutomaticSize="XY",
BackgroundTransparency=1,
},{
ac("UICorner",{
CornerRadius=UDim.new(0,16),
}),
ac("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),

al,
ac("UIPadding",{
PaddingTop=UDim.new(0,ak.PaddingY),
PaddingLeft=UDim.new(0,ak.PaddingX),
PaddingRight=UDim.new(0,ak.PaddingX),
PaddingBottom=UDim.new(0,ak.PaddingY),
}),
})
}),
am,
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})
ak.Container=an

function ak.Open(ao)
an.Visible=true


ad(an.Background,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al,.2,{TextTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(am,.22,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

function ak.Close(ao,ap)

ad(an.Background,.3,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al,.3,{TextTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(am,.35,{Scale=.9},Enum.EasingStyle.Quint,Enum.EasingDirection.In):Play()

ap=ap~=false
if ap then
task.wait(.35)

an.Visible=false
an:Destroy()
end
end

return ak
end



return aa end function a.B()
game:GetService"ReplicatedStorage"
local aa=a.load'c'
local ab=aa.New
local ac=aa.NewRoundFrame
local ad=aa.Tween

local ae=(cloneref or clonereference or function(ae)
return ae
end)

ae(game:GetService"UserInputService")

local function Color3ToHSB(af)
local ag,ah,ai=af.R,af.G,af.B
local aj=math.max(ag,ah,ai)
local ak=math.min(ag,ah,ai)
local al=aj-ak

local am=0
if al~=0 then
if aj==ag then
am=(ah-ai)/al%6
elseif aj==ah then
am=(ai-ag)/al+2
else
am=(ag-ah)/al+4
end
am=am*60
else
am=0
end

local an=(aj==0)and 0 or(al/aj)
local ao=aj

return{
h=math.floor(am+0.5),
s=an,
b=ao,
}
end

local function GetPerceivedBrightness(af)
local ag=af.R
local ah=af.G
local ai=af.B
return 0.299*ag+0.587*ah+0.114*ai
end

local function GetTextColorForHSB(af)
local ag=Color3ToHSB(af)local
ah, ai, aj=ag.h, ag.s, ag.b
if GetPerceivedBrightness(af)>0.5 then
return Color3.fromHSV(ah/360,0,0.05)
else
return Color3.fromHSV(ah/360,0,0.98)
end
end

local function getElementPosition(af,ag)
if type(ag)~="number"or ag~=math.floor(ag)then
return nil,1
end






local ah=#af


if ah==0 or ag<1 or ag>ah then
return nil,2
end

local function isDelimiter(ai)
if ai==nil then
return true
end
local aj=ai.__type
return aj=="Divider"or aj=="Space"or aj=="Section"or aj=="Code"
end

if isDelimiter(af[ag])then
return nil,3
end

local function calculate(ai,aj)
if aj==1 then
return"Squircle"
end
if ai==1 then
return"Squircle-TL-TR"
end
if ai==aj then
return"Squircle-BL-BR"
end
return"Square"
end

local ai=1
local aj=0

for ak=1,ah do
local al=af[ak]
if isDelimiter(al)then
if ag>=ai and ag<=ak-1 then
local am=ag-ai+1
return calculate(am,aj)
end
ai=ak+1
aj=0
else
aj=aj+1
end
end

if ag>=ai and ag<=ah then
local ak=ag-ai+1
return calculate(ak,aj)
end

return nil,4
end

return function(af)
local ag={
Title=af.Title,
Desc=af.Desc or nil,
Hover=af.Hover,
Thumbnail=af.Thumbnail,
ThumbnailSize=af.ThumbnailSize or 80,
Image=af.Image,
IconThemed=af.IconThemed or false,
ImageSize=af.ImageSize or 30,
Color=af.Color,
Scalable=af.Scalable,
Parent=af.Parent,
Justify=af.Justify or"Between",
UIPadding=af.Window.ElementConfig.UIPadding,
UICorner=af.Window.ElementConfig.UICorner,
Size=af.Size or"Default",
UIElements={},

Index=af.Index,
}

local ah=ag.Size=="Small"and-4 or ag.Size=="Large"and 4 or 0
local ai=ag.Size=="Small"and-4 or ag.Size=="Large"and 4 or 0

local aj=ag.ImageSize
local ak=ag.ThumbnailSize
local al=true


local am=0

local an
local ao
if ag.Thumbnail then
an=aa.Image(
ag.Thumbnail,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
an.Size=UDim2.new(1,0,0,ak)
end
if ag.Image then
ao=aa.Image(
ag.Image,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Image",
ag.IconThemed,
not ag.Color and true or false,
"ElementIcon"
)

if typeof(ag.Color)=="string"and not string.find(ag.Image,"rbxthumb")then
ao.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
elseif typeof(ag.Color)=="Color3"and not string.find(ag.Image,"rbxthumb")then
ao.ImageLabel.ImageColor3=GetTextColorForHSB(ag.Color)
end

ao.Size=UDim2.new(0,aj,0,aj)

am=aj
end

local function CreateText(ap,aq)
local ar=typeof(ag.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=="Color3"and GetTextColorForHSB(ag.Color)

return ab("TextLabel",{
BackgroundTransparency=1,
Text=ap or"",
TextSize=aq=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not ag.Color and("Element"..aq)or nil,
},
TextColor3=ag.Color and ar or nil,
TextTransparency=aq=="Desc"and 0.3 or 0,
TextWrapped=true,
Size=UDim2.new(ag.Justify=="Between"and 1 or 0,0,0,0),
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
FontFace=Font.new(aa.Font,aq=="Desc"and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold),
})
end

local ap=CreateText(ag.Title,"Title")
local aq=CreateText(ag.Desc,"Desc")
if not ag.Title or ag.Title==""then
aq.Visible=false
end
if not ag.Desc or ag.Desc==""then
aq.Visible=false
end

ag.UIElements.Title=ap
ag.UIElements.Desc=aq

ag.UIElements.Container=ab("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ab("UIListLayout",{
Padding=UDim.new(0,ag.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment=ag.Justify=="Between"and"Left"or"Center",
}),
an,
ab("Frame",{
Size=UDim2.new(
ag.Justify=="Between"and 1 or 0,
ag.Justify=="Between"and-af.TextOffset or 0,
0,
0
),
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
BackgroundTransparency=1,
Name="TitleFrame",
},{
ab("UIListLayout",{
Padding=UDim.new(0,ag.UIPadding),
FillDirection="Horizontal",
VerticalAlignment=af.Window.NewElements and(ag.Justify=="Between"and"Top"or"Center")
or"Center",
HorizontalAlignment=ag.Justify~="Between"and ag.Justify or"Center",
}),
ao,
ab("Frame",{
BackgroundTransparency=1,
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
Size=UDim2.new(
ag.Justify=="Between"and 1 or 0,
ag.Justify=="Between"and(ao and-am-ag.UIPadding or-am)
or 0,
1,
0
),
Name="TitleFrame",
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,(af.Window.NewElements and ag.UIPadding/2 or 0)+ai),
PaddingLeft=UDim.new(0,(af.Window.NewElements and ag.UIPadding/2 or 0)+ah),
PaddingRight=UDim.new(
0,
(af.Window.NewElements and ag.UIPadding/2 or 0)+ah
),
PaddingBottom=UDim.new(
0,
(af.Window.NewElements and ag.UIPadding/2 or 0)+ai
),
}),
ab("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ap,
aq,
}),
}),
})





local ar=aa.Image("lock","lock",0,af.Window.Folder,"Lock",false)
ar.Size=UDim2.new(0,20,0,20)
ar.ImageLabel.ImageColor3=Color3.new(1,1,1)
ar.ImageLabel.ImageTransparency=0.4

local as=ab("TextLabel",{
Text="Locked",
TextSize=18,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize="XY",
BackgroundTransparency=1,
TextColor3=Color3.new(1,1,1),
TextTransparency=0.05,
})

local at=ab("Frame",{
Size=UDim2.new(1,ag.UIPadding*2,1,ag.UIPadding*2),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ZIndex=9999999,
})

local au,av=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.25,
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
Parent=at,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
ar,
as,
},nil,true)

local aw,ax=ac(ag.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=at,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local ay,az=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=at,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local aA,aB=ac(ag.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=at,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
},nil,true)

local b,d=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=at,
},{
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local f,g=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=ag.Color and 0.05 or nil,



Parent=af.Parent,
ThemeTag={
ImageColor3=not ag.Color and"ElementBackground"or nil,
ImageTransparency=not ag.Color and"ElementBackgroundTransparency"or nil,
},
ImageColor3=ag.Color and(typeof(ag.Color)=="string"and Color3.fromHex(
aa.Colors[ag.Color]
)or typeof(ag.Color)=="Color3"and ag.Color)or nil,
},{
ag.UIElements.Container,
at,
ab("UIPadding",{
PaddingTop=UDim.new(0,ag.UIPadding),
PaddingLeft=UDim.new(0,ag.UIPadding),
PaddingRight=UDim.new(0,ag.UIPadding),
PaddingBottom=UDim.new(0,ag.UIPadding),
}),
},true,true)

ag.UIElements.Main=f
ag.UIElements.Locked=au

if ag.Hover then
aa.AddSignal(f.MouseEnter,function()
if al then

ad(b,0.12,{ImageTransparency=0.9}):Play()
ad(aA,0.12,{ImageTransparency=0.8}):Play()
aa.AddSignal(f.MouseMoved,function(h,j)
b.HoverGradient.Offset=
Vector2.new(((h-f.AbsolutePosition.X)/f.AbsoluteSize.X)-0.5,0)
aA.HoverGradient.Offset=
Vector2.new(((h-f.AbsolutePosition.X)/f.AbsoluteSize.X)-0.5,0)
end)
end
end)
aa.AddSignal(f.InputEnded,function()
if al then

ad(b,0.12,{ImageTransparency=1}):Play()
ad(aA,0.12,{ImageTransparency=1}):Play()
end
end)
end

function ag.SetTitle(h,j)
ag.Title=j
ap.Text=j
end

function ag.SetDesc(h,j)
ag.Desc=j
aq.Text=j or""
if not j then
aq.Visible=false
elseif not aq.Visible then
aq.Visible=true
end
end

function ag.Colorize(h,j,l)
if ag.Color then
j[l]=typeof(ag.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=="Color3"and GetTextColorForHSB(ag.Color)
or nil
end
end

if af.ElementTable then
aa.AddSignal(ap:GetPropertyChangedSignal"Text",function()
if ag.Title~=ap.Text then
ag:SetTitle(ap.Text)
af.ElementTable.Title=ap.Text
end
end)
aa.AddSignal(aq:GetPropertyChangedSignal"Text",function()
if ag.Desc~=aq.Text then
ag:SetDesc(aq.Text)
af.ElementTable.Desc=aq.Text
end
end)
end





function ag.SetThumbnail(h,j,l)
ag.Thumbnail=j
if l then
ag.ThumbnailSize=l
ak=l
end

if an then
if j then
an:Destroy()
an=aa.Image(
j,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
if an then
an.Size=UDim2.new(1,0,0,ak)
an.Parent=ag.UIElements.Container
local m=ag.UIElements.Container:FindFirstChild"UIListLayout"
if m then
an.LayoutOrder=-1
end
end
else
an.Visible=false

end
else
if j then
an=aa.Image(
j,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
if an then
an.Size=UDim2.new(1,0,0,ak)
an.Parent=ag.UIElements.Container
local m=ag.UIElements.Container:FindFirstChild"UIListLayout"
if m then
an.LayoutOrder=-1
end
end
end
end
end

function ag.SetImage(h,j,l)
ag.Image=j
if l then
ag.ImageSize=l
aj=l
end

if j then
local m=ao and ao.Parent or ag.UIElements.Container.TitleFrame
if ao then ao:Destroy()end

ao=aa.Image(
j,
j,
ag.UICorner-3,
af.Window.Folder,
"Image",
not ag.Color and true or false
)
if ao then
if typeof(ag.Color)=="string"and not string.find(ag.Image,"rbxthumb")then
ao.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
elseif typeof(ag.Color)=="Color3"and not string.find(ag.Image,"rbxthumb")then
ao.ImageLabel.ImageColor3=GetTextColorForHSB(ag.Color)
end


ao.Visible=true
ao.Parent=m
ao.LayoutOrder=-99

ao.Size=UDim2.new(0,aj,0,aj)
am=ag.ImageSize+ag.UIPadding
end
else
if ao then
ao.Visible=true
end
am=0
end

ag.UIElements.Container.TitleFrame.TitleFrame.Size=UDim2.new(1,-am,1,0)
end

function ag.Destroy(h)
f:Destroy()
end

function ag.Lock(h,j)
al=false
au.Active=true
au.Visible=true
as.Text=j or"Locked"
end

function ag.Unlock(h)
al=true
au.Active=false
au.Visible=false
end

function ag.Highlight(h)
local j=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.1,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.9,0.9),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=aw,
})

local l=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.15,0.8),
NumberSequenceKeypoint.new(0.5,0.1),
NumberSequenceKeypoint.new(0.85,0.8),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=ay,
})

aw.ImageTransparency=0.65
ay.ImageTransparency=0.88

ad(j,0.75,{
Offset=Vector2.new(1,0),
}):Play()

ad(l,0.75,{
Offset=Vector2.new(1,0),
}):Play()

task.spawn(function()
task.wait(0.75)
aw.ImageTransparency=1
ay.ImageTransparency=1
j:Destroy()
l:Destroy()
end)
end

function ag.UpdateShape(h)
if af.Window.NewElements then
local j
if af.ParentConfig.ParentType=="Group"then
j="Squircle"
else
j=getElementPosition(h.Elements,ag.Index)
end

if j and f then
g:SetType(j)
av:SetType(j)
az:SetType(j)
ax:SetType(j.."-Outline")
d:SetType(j)
aB:SetType(j.."-Outline")
end
end
end





return ag
end end function a.C()

local aa=a.load'c'
local ab=aa.New

local ac={}

local ad=a.load'l'.New

function ac.New(ae,af)
af.Hover=false
af.TextOffset=0
af.ParentConfig=af
af.IsButtons=af.Buttons and#af.Buttons>0 and true or false

local ag={
__type="Paragraph",
Title=af.Title or"Paragraph",
Desc=af.Desc or nil,

Locked=af.Locked or false,
}
local ah=a.load'B'(af)

ag.ParagraphFrame=ah
if af.Buttons and#af.Buttons>0 then
local ai=ab("Frame",{
Size=UDim2.new(1,0,0,38),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ah.UIElements.Container
},{
ab("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
})
})


for aj,ak in next,af.Buttons do
local al=ad(ak.Title,ak.Icon,ak.Callback,"White",ai,nil,nil,af.Window.NewElements and 999 or 10)
al.Size=UDim2.new(1,0,0,38)

end
end

return ag.__type,ag

end

return ac end function a.D()
local aa=a.load'c'local ab=
aa.New

local ac={}

function ac.New(ad,ae)
local af={
__type="Button",
Title=ae.Title or"Button",
Desc=ae.Desc or nil,
Icon=ae.Icon or"mouse-pointer-click",
IconThemed=ae.IconThemed or false,
Color=ae.Color,
Justify=ae.Justify or"Between",
IconAlign=ae.IconAlign or"Right",
Locked=ae.Locked or false,
LockedTitle=ae.LockedTitle,
Callback=ae.Callback or function()end,
UIElements={}
}

local ag=true

af.ButtonFrame=a.load'B'{
Title=af.Title,
Desc=af.Desc,
Parent=ae.Parent,




Window=ae.Window,
Color=af.Color,
Justify=af.Justify,
TextOffset=20,
Hover=true,
Scalable=true,
Tab=ae.Tab,
Index=ae.Index,
ElementTable=af,
ParentConfig=ae,
Size=ae.Size,
}














af.UIElements.ButtonIcon=aa.Image(
af.Icon,
af.Icon,
0,
ae.Window.Folder,
"Button",
not af.Color and true or nil,
af.IconThemed
)

af.UIElements.ButtonIcon.Size=UDim2.new(0,20,0,20)
af.UIElements.ButtonIcon.Parent=af.Justify=="Between"and af.ButtonFrame.UIElements.Main or af.ButtonFrame.UIElements.Container.TitleFrame
af.UIElements.ButtonIcon.LayoutOrder=af.IconAlign=="Left"and-99999 or 99999
af.UIElements.ButtonIcon.AnchorPoint=Vector2.new(1,0.5)
af.UIElements.ButtonIcon.Position=UDim2.new(1,0,0.5,0)

af.ButtonFrame:Colorize(af.UIElements.ButtonIcon.ImageLabel,"ImageColor3")

function af.Lock(ah)
af.Locked=true
ag=false
return af.ButtonFrame:Lock(af.LockedTitle)
end
function af.Unlock(ah)
af.Locked=false
ag=true
return af.ButtonFrame:Unlock()
end

if af.Locked then
af:Lock()
end

aa.AddSignal(af.ButtonFrame.UIElements.Main.MouseButton1Click,function()
if ag then
task.spawn(function()
aa.SafeCallback(af.Callback)
end)
end
end)
return af.__type,af
end

return ac end function a.E()
local aa={}

local ab=a.load'c'
local ac=ab.New
local ad=ab.Tween

local ae=game:GetService"UserInputService"

function aa.New(af,ag,ah,ai,aj,ak,al)
local am={
GlassSpritesheet={
Id="rbxassetid://77297718671545",
MirroredId="rbxassetid://92258969882244",
Size=Vector2.new(102,128),
Total=80,
Cols=10,
}
}

function am.GetGlassFrame(an,ao:number):(string,Vector2,Vector2)
local ap=am.GlassSpritesheet
local aq:number

if ao<=0.4 then
aq=math.floor((ao/0.4)*(ap.Total-1))
elseif ao<0.6 then
aq=ap.Total-1
else
aq=math.floor(((ao-0.6)/0.4)*(ap.Total-1))
end

aq=math.clamp(aq,0,ap.Total-1)

local ar=ao>=0.6
if ar then
aq=(ap.Total-1)-aq
end

local as=ar and ap.MirroredId or ap.Id

return as,
ap.Size,
Vector2.new(
(aq%ap.Cols)*ap.Size.X,
math.floor(aq/ap.Cols)*ap.Size.Y
)
end

local an=12
local ao
if ag and ag~=""then
ao=ac("ImageLabel",{
Size=UDim2.new(0,13,0,13),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=ab.Icon(ag)[1],
ImageRectOffset=ab.Icon(ag)[2].ImageRectPosition,
ImageRectSize=ab.Icon(ag)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
})
end

local ap=ac("Frame",{
Size=UDim2.new(0,2,0,26),
BackgroundTransparency=1,
Parent=ai,
})

local aq=ab.NewRoundFrame(an,"Squircle",{
ImageTransparency=.85,
ThemeTag={
ImageColor3="Text"
},
Parent=ap,
Size=UDim2.new(0,ak and(52)or(40.8),0,24),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(0,0,0.5,0),
Name="ToggleFrame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Toggle",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(an,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
},{
ac("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
}
})
}),


ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(0,ak and 30 or 20,0,20),
Position=UDim2.new(0,2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=1,
Name="Frame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0,

AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Bar"
},{
ab.NewRoundFrame(an,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=1,
},{













ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="GlassBackground",
ImageTransparency=0,
ThemeTag={
ImageColor3="ElementBackground",
},
ZIndex=-1,
}),
ac("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Glass",
ImageTransparency=0,
},{
ac("UICorner",{
CornerRadius=UDim.new(1,0),
})
}),
ab.NewRoundFrame(an,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=0.3,
}),
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="BarOverlay",
ThemeTag={
ImageColor3="ToggleBar",
},
ZIndex=999,
})
}),
ao,
ac("UIScale",{
Scale=1,
})
}),
}),
ac("TextButton",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Name="Hitbox",
Text="",
})
})

local ar
local as

local at=ak and 30 or 20
local au=aq.Size.X.Offset

function am.Set(av,aw,ax,ay)
if not ay then
if aw then
ad(aq.Frame,0.35,{
Position=UDim2.new(0,au-at-2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Toggle"},0.15)
ad(aq.Frame.Bar.Highlight.Glass,0.15,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(aq.Frame,0.35,{
Position=UDim2.new(0,2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Text"},0.15)
ad(aq.Frame.Bar.Highlight.Glass,0.15,{ImageTransparency=0.85},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
else
if aw then
aq.Frame.Position=UDim2.new(0,au-at-2,0.5,0)
else
aq.Frame.Position=UDim2.new(0,2,0.5,0)
end
end

if aw then
ad(aq.Layer,0.1,{
ImageTransparency=0,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Toggle"},0.1)
ad(aq.Frame.Bar.Highlight.Glass,0.1,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=0,
}):Play()
end

local az,aA,aB=am:GetGlassFrame(1)

aq.Frame.Bar.Highlight.Glass.Image=az
aq.Frame.Bar.Highlight.Glass.ImageRectSize=aA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=aB
else
ad(aq.Layer,0.1,{
ImageTransparency=1,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Text"},0.1)
ad(aq.Frame.Bar.Highlight.Glass,0.1,{ImageTransparency=0.85},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=1,
}):Play()
end

local az,aA,aB=am:GetGlassFrame(0)

aq.Frame.Bar.Highlight.Glass.Image=az
aq.Frame.Bar.Highlight.Glass.ImageRectSize=aA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=aB
end

ax=ax~=false

task.spawn(function()
if aj and ax then
ab.SafeCallback(aj,aw)
end
end)
end


function am.Animate(av,aw,ax)
if not al.Window.IsToggleDragging then
al.Window.IsToggleDragging=true

local ay=aw.Position.X
local az=aw.Position.Y
local aA=aq.Frame.Position.X.Offset
local aB=false
local b=false

ad(aq.Frame.Bar.UIScale,0.28,{Scale=1.5},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aq.Frame.Bar.Highlight.BarOverlay,0.28,{ImageTransparency=.86},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if ar then ar:Disconnect()end

ar=ae.InputChanged:Connect(function(d)
if not al.Window.IsToggleDragging then return end
if d.UserInputType~=Enum.UserInputType.MouseMovement and d.UserInputType~=Enum.UserInputType.Touch then return end
if aB then return end

local f=math.abs(d.Position.X-ay)
math.abs(d.Position.Y-az)

if not b and f>8 then
b=true
end

local g=d.Position.X-ay
local h=math.max(2,math.min(aA+g,au-at-2))

local j=math.clamp((h-2)/(au-at-4),0,1)

local l,m,p=am:GetGlassFrame(j)
aq.Frame.Bar.Highlight.Glass.Image=l
aq.Frame.Bar.Highlight.Glass.ImageRectSize=m
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=p

ad(aq.Frame,0.12,{
Position=UDim2.new(0,h,0.5,0)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)

if as then as:Disconnect()end

as=ae.InputEnded:Connect(function(d)
if not al.Window.IsToggleDragging then return end
if d.UserInputType~=Enum.UserInputType.MouseButton1 and d.UserInputType~=Enum.UserInputType.Touch then return end

al.Window.IsToggleDragging=false

if ar then ar:Disconnect()ar=nil end
if as then as:Disconnect()as=nil end

if aB then return end

if not b then
ax:Set(not ax.Value,true,false)
else
local f=aq.Frame.Position.X.Offset
local g=f+at/2
local h=g>au/2
ax:Set(h,true,false)
end

ad(aq.Frame.Bar.UIScale,0.23,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aq.Frame.Bar.Highlight.BarOverlay,0.23,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end
end

return ap,am
end

return aa end function a.F()
local aa={}

local ab=a.load'c'local ac=
ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak={}

af=af or"sfsymbols:checkmark"

local al=9

local am=ab.Image(
af,
af,
0,
(aj and aj.Window.Folder or"Temp"),
"Checkbox",
true,
false,
"CheckboxIcon"
)
am.Size=UDim2.new(1,-26+ag,1,-26+ag)
am.AnchorPoint=Vector2.new(0.5,0.5)
am.Position=UDim2.new(0.5,0,0.5,0)


local an=ab.NewRoundFrame(al,"Squircle",{
ImageTransparency=.85,
ThemeTag={
ImageColor3="Text"
},
Parent=ah,
Size=UDim2.new(0,26,0,26),
},{
ab.NewRoundFrame(al,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Checkbox",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(al,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ThemeTag={
ImageColor3="CheckboxBorder",
ImageTransparency="CheckboxBorderTransparency",
},
},{







}),

am,
},true)

function ak.Set(ao,ap)
if ap then
ad(an.Layer,0.06,{
ImageTransparency=0,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=0,
}):Play()
else
ad(an.Layer,0.05,{
ImageTransparency=1,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=1,
}):Play()
end

task.spawn(function()
if ai then
ab.SafeCallback(ai,ap)
end
end)
end

return an,ak
end


return aa end function a.G()
local aa=a.load'c'local ab=
aa.New local ac=
aa.Tween

local ad=a.load'E'.New
local ae=a.load'F'.New

local af={}

function af.New(ag,ah)
local ai={
__type="Toggle",
Title=ah.Title or"Toggle",
Desc=ah.Desc or nil,
Locked=ah.Locked or false,
LockedTitle=ah.LockedTitle,
Value=ah.Value,
Icon=ah.Icon or nil,
IconSize=ah.IconSize or 23,
Type=ah.Type or"Toggle",
Callback=ah.Callback or function()end,
UIElements={}
}
ai.ToggleFrame=a.load'B'{
Title=ai.Title,
Desc=ai.Desc,




Window=ah.Window,
Parent=ah.Parent,
TextOffset=(52),
Hover=false,
Tab=ah.Tab,
Index=ah.Index,
ElementTable=ai,
ParentConfig=ah,
}

local aj=true

if ai.Value==nil then
ai.Value=false
end



function ai.Lock(ak)
ai.Locked=true
aj=false
return ai.ToggleFrame:Lock(ai.LockedTitle)
end
function ai.Unlock(ak)
ai.Locked=false
aj=true
return ai.ToggleFrame:Unlock()
end

if ai.Locked then
ai:Lock()
end

local ak=ai.Value

local al,am
if ai.Type=="Toggle"then
al,am=ad(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callback,ah.Window.NewElements,ah)
elseif ai.Type=="Checkbox"then
al,am=ae(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callback,ah)
else
error("Unknown Toggle Type: "..tostring(ai.Type))
end

al.AnchorPoint=Vector2.new(1,ah.Window.NewElements and 0 or 0.5)
al.Position=UDim2.new(1,0,ah.Window.NewElements and 0 or 0.5,0)

function ai.Set(an,ao,ap,aq)
if aj then
am:Set(ao,ap,aq or false)
ak=ao
ai.Value=ao
end
end

ai:Set(ak,false,ah.Window.NewElements)


if ah.Window.NewElements and am.Animate then
if ai.Type=="Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.InputBegan,function(an)
if not ah.Window.IsToggleDragging and an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch then
am:Animate(an,ai)
end
end)
end





else
if ai.Type=="Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
elseif ai.Type=="Checkbox"then
aa.AddSignal(al.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
end
end

return ai.__type,ai
end

return af end function a.H()
local aa=(cloneref or clonereference or function(aa)return aa end)


local ac=aa(game:GetService"UserInputService")
local ad=aa(game:GetService"RunService")

local ae=a.load'c'
local af=ae.New
local ag=ae.Tween


local ah={}

local ai=false

function ah.New(aj,ak)
local al={
__type="Slider",
Title=ak.Title or nil,
Desc=ak.Desc or nil,
Locked=ak.Locked or nil,
LockedTitle=ak.LockedTitle,
Value=ak.Value or{},
Icons=ak.Icons or nil,
IsTooltip=ak.IsTooltip or false,
IsTextbox=ak.IsTextbox,
Step=ak.Step or 1,
Callback=ak.Callback or function()end,
UIElements={},
IsFocusing=false,

Width=ak.Width or 130,
TextBoxWidth=ak.Window.NewElements and 40 or 30,
ThumbSize=13,
IconSize=26,
}
if al.Icons=={}then
al.Icons={
From="sfsymbols:sunMinFill",
To="sfsymbols:sunMaxFill",
}
end
if al.IsTextbox==nil and al.Title==nil then al.IsTextbox=false else al.IsTextbox=al.IsTextbox~=false end

local am
local an
local ao
local ap=al.Value.Default or al.Value.Min or 0

local aq=ap
local ar=(ap-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Value.Min or 0))

local as=true
local at=al.Step%1~=0

local function FormatValue(au)
if at then
return tonumber(string.format("%.2f",au))
end
return math.floor(au+0.5)
end

local function CalculateValue(au)
if at then
return math.floor(au/al.Step+0.5)*al.Step
else
return math.floor(au/al.Step+0.5)*al.Step
end
end

local au,av
local aw=32
if al.Icons then
if al.Icons.From then
au=ae.Image(
al.Icons.From,
al.Icons.From,
0,
ak.Window.Folder,
"SliderIconFrom",
true,
true,
"SliderIconFrom"
)
au.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
aw=aw+al.IconSize-2
end
if al.Icons.To then
av=ae.Image(
al.Icons.To,
al.Icons.To,
0,
ak.Window.Folder,
"SliderIconTo",
true,
true,
"SliderIconTo"
)
av.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
aw=aw+al.IconSize-2
end
end
al.SliderFrame=a.load'B'{
Title=al.Title,
Desc=al.Desc,
Parent=ak.Parent,
TextOffset=al.Width,
Hover=false,
Tab=ak.Tab,
Index=ak.Index,
Window=ak.Window,
ElementTable=al,
ParentConfig=ak,
}


al.UIElements.SliderIcon=ae.NewRoundFrame(99,"Squircle",{
ImageTransparency=.95,
Size=UDim2.new(1,not al.IsTextbox and-aw or(-al.TextBoxWidth-8),0,4),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(ar,0,1,0),
ImageTransparency=.1,
ThemeTag={
ImageColor3="Slider",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),0,ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="SliderThumb",
},
Name="Thumb",
},{
ae.NewRoundFrame(99,"Glass-1",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=.6,
},{













}),
})
})
})

al.UIElements.SliderContainer=af("Frame",{
Size=UDim2.new(al.Title==nil and 1 or 0,al.Title==nil and 0 or al.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,al.IsTextbox and(ak.Window.NewElements and-16 or 0)or 0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Parent=al.SliderFrame.UIElements.Main,
},{
af("UIListLayout",{
Padding=UDim.new(0,al.Title~=nil and 8 or 12),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=al.Icons and(al.Icons.From and(al.Icons.To and"Center"or"Left")or al.Icons.To and"Right")or"Center",
}),
au,
al.UIElements.SliderIcon,
av,
af("TextBox",{
Size=UDim2.new(0,al.TextBoxWidth,0,0),
TextXAlignment="Left",
Text=FormatValue(ap),
ThemeTag={
TextColor3="Text"
},
TextTransparency=.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
Visible=al.IsTextbox,
})
})

local ax
if al.IsTooltip then
ax=a.load'A'.New(ap,al.UIElements.SliderIcon.Frame.Thumb,true,"Secondary","Small",false)
ax.Container.AnchorPoint=Vector2.new(0.5,1)
ax.Container.Position=UDim2.new(0.5,0,0,-8)
end

function al.Lock(ay)
al.Locked=true
as=false
return al.SliderFrame:Lock(al.LockedTitle)
end
function al.Unlock(ay)
al.Locked=false
as=true
return al.SliderFrame:Unlock()
end

if al.Locked then
al:Lock()
end


local ay=ak.Tab.UIElements.ContainerFrame

function al.Set(az,aA,aB)
if as then
if not al.IsFocusing and not ai and(not aB or(aB.UserInputType==Enum.UserInputType.MouseButton1 or aB.UserInputType==Enum.UserInputType.Touch))then
if aB then
am=(aB.UserInputType==Enum.UserInputType.Touch)
ay.ScrollingEnabled=false
ai=true

local b=am and aB.Position.X or ac:GetMouseLocation().X
local d=math.clamp((b-al.UIElements.SliderIcon.AbsolutePosition.X)/al.UIElements.SliderIcon.AbsoluteSize.X,0,1)
aA=CalculateValue(al.Value.Min+d*(al.Value.Max-al.Value.Min))
aA=math.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(d,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then ax.TitleFrame.Text=FormatValue(aA)end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end

an=ad.RenderStepped:Connect(function()
local f=am and aB.Position.X or ac:GetMouseLocation().X
local g=math.clamp((f-al.UIElements.SliderIcon.AbsolutePosition.X)/al.UIElements.SliderIcon.AbsoluteSize.X,0,1)
aA=CalculateValue(al.Value.Min+g*(al.Value.Max-al.Value.Min))

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(g,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then ax.TitleFrame.Text=FormatValue(aA)end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end)


ao=ac.InputEnded:Connect(function(f)
if(f.UserInputType==Enum.UserInputType.MouseButton1 or f.UserInputType==Enum.UserInputType.Touch)and aB==f then
an:Disconnect()
ao:Disconnect()
ai=false
ay.ScrollingEnabled=true

if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,.2,{ImageTransparency=0,Size=UDim2.new(0,ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),0,ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2))},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end
if ax then ax:Close(false)end
end
end)
else
aA=math.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

local b=math.clamp((aA-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Value.Min or 0)),0,1)
aA=CalculateValue(al.Value.Min+b*(al.Value.Max-al.Value.Min))

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(b,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then ax.TitleFrame.Text=FormatValue(aA)end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end
end
end
end

function al.SetMax(az,aA)
al.Value.Max=aA

local aB=tonumber(al.Value.Default)or aq
if aB>aA then
al:Set(aA)
else
local b=math.clamp((aB-(al.Value.Min or 0))/(aA-(al.Value.Min or 0)),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(b,0,1,0)}):Play()
end
end

function al.SetMin(az,aA)
al.Value.Min=aA

local aB=tonumber(al.Value.Default)or aq
if aB<aA then
al:Set(aA)
else
local b=math.clamp((aB-aA)/((al.Value.Max or 100)-aA),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(b,0,1,0)}):Play()
end
end

ae.AddSignal(al.UIElements.SliderContainer.TextBox.FocusLost,function(az)
if az then
local aA=tonumber(al.UIElements.SliderContainer.TextBox.Text)
if aA then
al:Set(aA)
else
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aq)
if ax then ax.TitleFrame.Text=FormatValue(aq)end
end
end
end)

ae.AddSignal(al.UIElements.SliderContainer.InputBegan,function(az)
if al.Locked or ai then
return
end

al:Set(ap,az)

if az.UserInputType==Enum.UserInputType.MouseButton1 or az.UserInputType==Enum.UserInputType.Touch then

if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,.24,{ImageTransparency=.85,Size=UDim2.new(0,(ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize))+8,0,al.ThumbSize+8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
if ax then ax:Open()end

end
end)

return al.__type,al
end

return ah end function a.I()
local aa=(cloneref or clonereference or function(aa)return aa end)

local ac=aa(game:GetService"UserInputService")

local ad=a.load'c'
local ae=ad.New local af=
ad.Tween

local ag={
UICorner=6,
UIPadding=8,
}

local ah=a.load'v'.New

function ag.New(ai,aj)
local function NormalizeKeyCode(ak)
if typeof(ak)=="EnumItem"then
return ak.Name
elseif type(ak)=="string"then
return ak
else
return"F"
end
end

local ak={
__type="Keybind",
Title=aj.Title or"Keybind",
Desc=aj.Desc or nil,
Locked=aj.Locked or false,
LockedTitle=aj.LockedTitle,
Value=NormalizeKeyCode(aj.Value)or"F",
Callback=aj.Callback or function()end,
CanChange=aj.CanChange or true,
Picking=false,
UIElements={},
}

local al=true

ak.KeybindFrame=a.load'B'{
Title=ak.Title,
Desc=ak.Desc,
Parent=aj.Parent,
TextOffset=85,
Hover=ak.CanChange,
Tab=aj.Tab,
Index=aj.Index,
Window=aj.Window,
ElementTable=ak,
ParentConfig=aj,
}

ak.UIElements.Keybind=ah(ak.Value,nil,ak.KeybindFrame.UIElements.Main,nil,aj.Window.NewElements and 12 or 10)

ak.UIElements.Keybind.Size=UDim2.new(
0,24
+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
ak.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
ak.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)

ae("UIScale",{
Parent=ak.UIElements.Keybind,
Scale=.85,
})

ad.AddSignal(ak.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",function()
ak.UIElements.Keybind.Size=UDim2.new(
0,24
+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
end)

function ak.Lock(am)
ak.Locked=true
al=false
return ak.KeybindFrame:Lock(ak.LockedTitle)
end
function ak.Unlock(am)
ak.Locked=false
al=true
return ak.KeybindFrame:Unlock()
end

function ak.Set(am,an)
local ao=NormalizeKeyCode(an)
ak.Value=ao
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=ao
end

if ak.Locked then
ak:Lock()
end

ad.AddSignal(ak.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if al then
if ak.CanChange then
ak.Picking=true
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."

task.wait(0.2)

local am
am=ac.InputBegan:Connect(function(an)
local ao

if an.UserInputType==Enum.UserInputType.Keyboard then
ao=an.KeyCode.Name
elseif an.UserInputType==Enum.UserInputType.MouseButton1 then
ao="MouseLeft"
elseif an.UserInputType==Enum.UserInputType.MouseButton2 then
ao="MouseRight"
end

local ap
ap=ac.InputEnded:Connect(function(aq)
if aq.KeyCode.Name==ao or ao=="MouseLeft"and aq.UserInputType==Enum.UserInputType.MouseButton1 or ao=="MouseRight"and aq.UserInputType==Enum.UserInputType.MouseButton2 then
ak.Picking=false

ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=ao
ak.Value=ao

am:Disconnect()
ap:Disconnect()
end
end)
end)
end
end
end)

ad.AddSignal(ac.InputBegan,function(am,an)
if ac:GetFocusedTextBox()then
return
end

if not al then
return
end

if am.UserInputType==Enum.UserInputType.Keyboard then
if am.KeyCode.Name==ak.Value then
ad.SafeCallback(ak.Callback,am.KeyCode.Name)
end
elseif am.UserInputType==Enum.UserInputType.MouseButton1 and ak.Value=="MouseLeft"then
ad.SafeCallback(ak.Callback,"MouseLeft")
elseif am.UserInputType==Enum.UserInputType.MouseButton2 and ak.Value=="MouseRight"then
ad.SafeCallback(ak.Callback,"MouseRight")
end
end)

return ak.__type,ak
end

return ag end function a.J()
local aa=a.load'c'
local ac=aa.New local ad=
aa.Tween

local ae={
UICorner=8,
UIPadding=8,
}local af=a.load'l'


.New
local ag=a.load'm'.New

function ae.New(ah,ai)
local aj={
__type="Input",
Title=ai.Title or"Input",
Desc=ai.Desc or nil,
Type=ai.Type or"Input",
Locked=ai.Locked or false,
LockedTitle=ai.LockedTitle,
InputIcon=ai.InputIcon or false,
Placeholder=ai.Placeholder or"Enter Text...",
Value=ai.Value or"",
Callback=ai.Callback or function()end,
ClearTextOnFocus=ai.ClearTextOnFocus or false,
UIElements={},

Width=150,
}

local ak=true

aj.InputFrame=a.load'B'{
Title=aj.Title,
Desc=aj.Desc,
Parent=ai.Parent,
TextOffset=aj.Width,
Hover=false,
Tab=ai.Tab,
Index=ai.Index,
Window=ai.Window,
ElementTable=aj,
ParentConfig=ai,
}

local al=ag(
aj.Placeholder,
aj.InputIcon,
aj.Type=="Textarea"and aj.InputFrame.UIElements.Container or aj.InputFrame.UIElements.Main,
aj.Type,
function(al)
aj:Set(al,true)
end,
nil,
ai.Window.NewElements and 12 or 10,
aj.ClearTextOnFocus
)

if aj.Type=="Input"then
al.Size=UDim2.new(0,aj.Width,0,36)
al.Position=UDim2.new(1,0,ai.Window.NewElements and 0 or 0.5,0)
al.AnchorPoint=Vector2.new(1,ai.Window.NewElements and 0 or 0.5)
else
al.Size=UDim2.new(1,0,0,148)
end

ac("UIScale",{
Parent=al,
Scale=1,
})

function aj.Lock(am)
aj.Locked=true
ak=false
return aj.InputFrame:Lock(aj.LockedTitle)
end
function aj.Unlock(am)
aj.Locked=false
ak=true
return aj.InputFrame:Unlock()
end


function aj.Set(am,an,ao)
if ak then
aj.Value=an
aa.SafeCallback(aj.Callback,an)

if not ao then
al.Frame.Frame.TextBox.Text=an
end
end
end

function aj.SetPlaceholder(am,an)
al.Frame.Frame.TextBox.PlaceholderText=an
aj.Placeholder=an
end

aj:Set(aj.Value)

if aj.Locked then
aj:Lock()
end

return aj.__type,aj
end

return ae end function a.K()
local aa=a.load'c'
local ac=aa.New

local ae={}

function ae.New(af,ag)
local ah=ac("Frame",{
Size=ag.ParentType~="Group"and UDim2.new(1,0,0,1)or UDim2.new(0,1,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local ai=ac("Frame",{
Parent=ag.Parent,
Size=ag.ParentType~="Group"and UDim2.new(1,-7,0,7)or UDim2.new(0,7,1,-7),
BackgroundTransparency=1,
},{
ah
})

return"Divider",{__type="Divider",ElementFrame=ai}
end

return ae end function a.L()
local aa={}

local ac=(cloneref or clonereference or function(ac)
return ac
end)

local ae=ac(game:GetService"UserInputService")
local af=ac(game:GetService"Players").LocalPlayer:GetMouse()
local ag=ac(game:GetService"Workspace").CurrentCamera

local ah=workspace.CurrentCamera

local ai=a.load'm'.New

local aj=a.load'c'
local ak=aj.New
local al=aj.Tween

function aa.New(am,an,ao,ap,aq)
local ar={}

if not an.Callback then
aq="Menu"
end

an.UIElements.UIListLayout=ak("UIListLayout",{
Padding=UDim.new(0,ao.MenuPadding/1.5),
FillDirection="Vertical",
HorizontalAlignment="Center",
})

an.UIElements.Menu=aj.NewRoundFrame(ao.MenuCorner,"Squircle",{
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
},{
ak("UIPadding",{
PaddingTop=UDim.new(0,ao.MenuPadding),
PaddingLeft=UDim.new(0,ao.MenuPadding),
PaddingRight=UDim.new(0,ao.MenuPadding),
PaddingBottom=UDim.new(0,ao.MenuPadding),
}),
ak("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ao.MenuPadding),
}),
ak("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,an.SearchBarEnabled and-ao.MenuPadding-ao.SearchBarHeight),

ClipsDescendants=true,
LayoutOrder=999,
Name="Frame",
},{
ak("UICorner",{
CornerRadius=UDim.new(0,ao.MenuCorner-ao.MenuPadding),
}),
ak("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),
ScrollBarThickness=0,
ScrollingDirection="Y",
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
ScrollBarImageTransparency=1,
},{
an.UIElements.UIListLayout,
}),
}),
})

an.UIElements.MenuCanvas=ak("Frame",{
Size=UDim2.new(0,an.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,

Parent=am.WindUI.DropdownGui,
AnchorPoint=Vector2.new(1,0),
},{
an.UIElements.Menu,
ak("UISizeConstraint",{
MinSize=Vector2.new(170,0),
MaxSize=Vector2.new(300,400),
}),
})

local function RecalculateCanvasSize()
an.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=
UDim2.fromOffset(0,an.UIElements.UIListLayout.AbsoluteContentSize.Y)
end

local function RecalculateListSize()
local as=ah.ViewportSize.Y*0.6

local at=an.UIElements.UIListLayout.AbsoluteContentSize.Y
local au=an.SearchBarEnabled and(ao.SearchBarHeight+(ao.MenuPadding*3))
or(ao.MenuPadding*2)
local av=at+au

if av>as then
an.UIElements.MenuCanvas.Size=
UDim2.fromOffset(an.UIElements.MenuCanvas.AbsoluteSize.X,as)
else
an.UIElements.MenuCanvas.Size=
UDim2.fromOffset(an.UIElements.MenuCanvas.AbsoluteSize.X,av)
end
end

function UpdatePosition()
local as=an.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local at=an.UIElements.MenuCanvas

local au=ag.ViewportSize.Y
-(as.AbsolutePosition.Y+as.AbsoluteSize.Y)
-ao.MenuPadding
-54
local av=at.AbsoluteSize.Y+ao.MenuPadding

local aw=-54
if au<av then
aw=av-au-54
end

at.Position=UDim2.new(
0,
as.AbsolutePosition.X+as.AbsoluteSize.X,
0,
as.AbsolutePosition.Y+as.AbsoluteSize.Y-aw+(ao.MenuPadding*2)
)
end

local as

function ar.Display(at)
local au=an.Values
local av=""

if an.Multi then
local aw={}
if typeof(an.Value)=="table"then
for ax,ay in ipairs(an.Value)do
local az=typeof(ay)=="table"and ay.Title or ay
aw[az]=true
end
end

for ax,ay in ipairs(au)do
local az=typeof(ay)=="table"and ay.Title or ay
if aw[az]then
av=av..az..", "
end
end

if#av>0 then
av=av:sub(1,#av-2)
end
else
av=typeof(an.Value)=="table"and(an.Value.Title or an.Value[1])or an.Value or""
end

if an.UIElements.Dropdown then
an.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(av==""and"--"or av)
end
end

local function Callback(at)
ar:Display()
if an.Callback then
task.spawn(function()
aj.SafeCallback(an.Callback,an.Value)
end)
else
task.spawn(function()
aj.SafeCallback(at)
end)
end
end

function ar.LockValues(at,au)
if not au then
return
end

for av,aw in next,an.Tabs do
if aw and aw.UIElements and aw.UIElements.TabItem then
local ax=aw.Name
local ay=false

for az,aA in next,au do
if ax==aA then
ay=true
break
end
end

if ay then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.6}):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.6}):Play()
end

aw.UIElements.TabItem.Active=false
aw.Locked=true
else
if aw.Selected then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=0.95}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=0.75}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
else
al(aw.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(
aw.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=aq=="Dropdown"and 0.4 or 0.05}
):Play()
if aw.UIElements.TabIcon then
al(
aw.UIElements.TabIcon.ImageLabel,
0.1,
{ImageTransparency=aq=="Dropdown"and 0.2 or 0}
):Play()
end
end

aw.UIElements.TabItem.Active=true
aw.Locked=false
end
end
end
end

function ar.Refresh(at,au)
for av,aw in next,an.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not aw:IsA"UIListLayout"then
aw:Destroy()
end
end

an.Tabs={}

if an.SearchBarEnabled then
if not as then
as=ai("Search...","search",an.UIElements.Menu,nil,function(av)
for aw,ax in next,an.Tabs do
if string.find(string.lower(ax.Name),string.lower(av),1,true)then
ax.UIElements.TabItem.Visible=true
else
ax.UIElements.TabItem.Visible=false
end
RecalculateListSize()
RecalculateCanvasSize()
end
end,true)
as.Size=UDim2.new(1,0,0,ao.SearchBarHeight)
as.Position=UDim2.new(0,0,0,0)
as.Name="SearchBar"
end
end

for av,aw in next,au do
if aw.Type~="Divider"then
local ax={
Name=typeof(aw)=="table"and aw.Title or aw,
Desc=typeof(aw)=="table"and aw.Desc or nil,
Icon=typeof(aw)=="table"and aw.Icon or nil,
IconSize=typeof(aw)=="table"and aw.IconSize or nil,
Original=aw,
Selected=false,
Locked=typeof(aw)=="table"and aw.Locked or false,
UIElements={},
}
local ay
if ax.Icon then
ay=aj.Image(ax.Icon,ax.Icon,0,am.Window.Folder,"Dropdown",true)
ay.Size=
UDim2.new(0,ax.IconSize or ao.TabIcon,0,ax.IconSize or ao.TabIcon)
ay.ImageLabel.ImageTransparency=aq=="Dropdown"and 0.2 or 0
ax.UIElements.TabIcon=ay
end
ax.UIElements.TabItem=aj.NewRoundFrame(
ao.MenuCorner-ao.MenuPadding,
"Squircle",
{
Size=UDim2.new(1,0,0,36),
AutomaticSize=ax.Desc and"Y",
ImageTransparency=1,
Parent=an.UIElements.Menu.Frame.ScrollingFrame,
ImageColor3=Color3.new(1,1,1),
Active=not ax.Locked,
},
{
aj.NewRoundFrame(ao.MenuCorner-ao.MenuPadding,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="DropdownTabBorder",
},
ImageTransparency=1,
Name="Highlight",
},{













}),
ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ak("UIListLayout",{
Padding=UDim.new(0,ao.TabPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,ao.TabPadding),
PaddingLeft=UDim.new(0,ao.TabPadding),
PaddingRight=UDim.new(0,ao.TabPadding),
PaddingBottom=UDim.new(0,ao.TabPadding),
}),
ak("UICorner",{
CornerRadius=UDim.new(0,ao.MenuCorner-ao.MenuPadding),
}),
ay,
ak("Frame",{
Size=UDim2.new(1,ay and-ao.TabPadding-ao.TabIcon or 0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Name="Title",
},{
ak("TextLabel",{
Text=ax.Name,
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=aq=="Dropdown"and 0.4 or 0.05,
LayoutOrder=999,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
}),
ak("TextLabel",{
Text=ax.Desc or"",
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=aq=="Dropdown"and 0.6 or 0.35,
LayoutOrder=999,
AutomaticSize="Y",
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
Visible=ax.Desc and true or false,
Name="Desc",
}),
ak("UIListLayout",{
Padding=UDim.new(0,ao.TabPadding/3),
FillDirection="Vertical",
}),
}),
}),
},
true
)

if ax.Locked then
ax.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0.6
if ax.UIElements.TabIcon then
ax.UIElements.TabIcon.ImageLabel.ImageTransparency=0.6
end
end

if an.Multi and typeof(an.Value)=="string"then
for az,aA in next,an.Values do
if typeof(aA)=="table"then
if aA.Title==an.Value then
an.Value={aA}
end
else
if aA==an.Value then
an.Value={an.Value}
end
end
end
end

if an.Multi then
local az=false
if typeof(an.Value)=="table"then
for aA,aB in ipairs(an.Value)do
local b=typeof(aB)=="table"and aB.Title or aB
if b==ax.Name then
az=true
break
end
end
end
ax.Selected=az
else
local az=typeof(an.Value)=="table"and an.Value.Title or an.Value
ax.Selected=az==ax.Name
end

if ax.Selected and not ax.Locked then
ax.UIElements.TabItem.ImageTransparency=0.95
ax.UIElements.TabItem.Highlight.ImageTransparency=0.75
ax.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0
if ax.UIElements.TabIcon then
ax.UIElements.TabIcon.ImageLabel.ImageTransparency=0
end
end

an.Tabs[av]=ax

ar:Display()

if aq=="Dropdown"then
aj.AddSignal(ax.UIElements.TabItem.MouseButton1Click,function()
if ax.Locked then
return
end

if an.Multi then
if not ax.Selected then
ax.Selected=true
al(ax.UIElements.TabItem,0.1,{ImageTransparency=0.95}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=0.75}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
table.insert(an.Value,ax.Original)
else
if not an.AllowNone and#an.Value==1 then
return
end
ax.Selected=false
al(ax.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.4}):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end

for az,aA in next,an.Value do
if typeof(aA)=="table"and(aA.Title==ax.Name)or(aA==ax.Name)then
table.remove(an.Value,az)
break
end
end
end
else
for az,aA in next,an.Tabs do
al(aA.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aA.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(
aA.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=0.4}
):Play()
if aA.UIElements.TabIcon then
al(aA.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end
aA.Selected=false
end
ax.Selected=true
al(ax.UIElements.TabItem,0.1,{ImageTransparency=0.95}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=0.75}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
an.Value=ax.Original
end
Callback()
end)
elseif aq=="Menu"then
if not ax.Locked then
aj.AddSignal(ax.UIElements.TabItem.MouseEnter,function()
al(ax.UIElements.TabItem,0.08,{ImageTransparency=0.95}):Play()
end)
aj.AddSignal(ax.UIElements.TabItem.InputEnded,function()
al(ax.UIElements.TabItem,0.08,{ImageTransparency=1}):Play()
end)
end
aj.AddSignal(ax.UIElements.TabItem.MouseButton1Click,function()
if ax.Locked then
return
end
Callback(aw.Callback or function()end)
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'K'
:New{Parent=an.UIElements.Menu.Frame.ScrollingFrame}
end
end










an.UIElements.MenuCanvas.Size=UDim2.new(
0,
an.MenuWidth+6+6+5+5+18+6+6,
an.UIElements.MenuCanvas.Size.Y.Scale,
an.UIElements.MenuCanvas.Size.Y.Offset
)
Callback()

an.Values=au
end

ar:Refresh(an.Values)

function ar.Select(at,au)
if au then
an.Value=au
else
if an.Multi then
an.Value={}
else
an.Value=nil
end
end
ar:Refresh(an.Values)
end

RecalculateListSize()
RecalculateCanvasSize()

function ar.Open(at)
if ap then
an.UIElements.Menu.Visible=true
an.UIElements.MenuCanvas.Visible=true
an.UIElements.MenuCanvas.Active=true
an.UIElements.Menu.Size=UDim2.new(1,0,0,0)
al(an.UIElements.Menu,0.1,{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.05,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
an.Opened=true
end)

UpdatePosition()
end
end

function ar.Close(at)
an.Opened=false

al(an.UIElements.Menu,0.25,{
Size=UDim2.new(1,0,0,0),
ImageTransparency=1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
an.UIElements.Menu.Visible=false
end)

task.spawn(function()
task.wait(0.25)
an.UIElements.MenuCanvas.Visible=false
an.UIElements.MenuCanvas.Active=false
end)
end

aj.AddSignal(
(
an.UIElements.Dropdown and an.UIElements.Dropdown.MouseButton1Click
or an.DropdownFrame.UIElements.Main.MouseButton1Click
),
function()
ar:Open()
end
)

aj.AddSignal(ae.InputBegan,function(at)
if
at.UserInputType==Enum.UserInputType.MouseButton1
or at.UserInputType==Enum.UserInputType.Touch
then
local au=an.UIElements.MenuCanvas
local av,aw=au.AbsolutePosition,au.AbsoluteSize

local ax=an.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local ay=ax.AbsolutePosition
local az=ax.AbsoluteSize

local aA=af.X>=ay.X
and af.X<=ay.X+az.X
and af.Y>=ay.Y
and af.Y<=ay.Y+az.Y

local aB=af.X>=av.X
and af.X<=av.X+aw.X
and af.Y>=av.Y
and af.Y<=av.Y+aw.Y

if am.Window.CanDropdown and an.Opened and not aA and not aB then
ar:Close()
end
end
end)

aj.AddSignal(
an.UIElements.Dropdown and an.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition"
or an.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePosition",
UpdatePosition
)

return ar
end

return aa end function a.M()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")
aa(game:GetService"Players").LocalPlayer:GetMouse()local ac=
aa(game:GetService"Workspace").CurrentCamera

local ae=a.load'c'
local af=ae.New local ag=
ae.Tween

local ah=a.load'v'.New local ai=a.load'm'
.New
local aj=a.load'L'.New local ak=

workspace.CurrentCamera

local al={
UICorner=10,
UIPadding=12,
MenuCorner=15,
MenuPadding=5,
TabPadding=10,
SearchBarHeight=39,
TabIcon=18,
}

function al.New(am,an)
local ao={
__type="Dropdown",
Title=an.Title or"Dropdown",
Desc=an.Desc or nil,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Values=an.Values or{},
MenuWidth=an.MenuWidth or 180,
Value=an.Value,
AllowNone=an.AllowNone,
SearchBarEnabled=an.SearchBarEnabled or false,
Multi=an.Multi,
Callback=an.Callback or nil,

UIElements={},

Opened=false,
Tabs={},

Width=150,
}

if ao.Multi and not ao.Value then
ao.Value={}
end
if ao.Values and typeof(ao.Value)=="number"then
ao.Value=ao.Values[ao.Value]
end

local ap=true

ao.DropdownFrame=a.load'B'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Callback and ao.Width or 20,
Hover=not ao.Callback and true or false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
}

if ao.Callback then
ao.UIElements.Dropdown=
ah("",nil,ao.DropdownFrame.UIElements.Main,nil,an.Window.NewElements and 12 or 10)

ao.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size=
UDim2.new(1,ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

ao.UIElements.Dropdown.Size=UDim2.new(0,ao.Width,0,36)
ao.UIElements.Dropdown.Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0)
ao.UIElements.Dropdown.AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5)





end

ao.DropdownMenu=aj(an,ao,al,ap,"Dropdown")

ao.Display=ao.DropdownMenu.Display
ao.Refresh=ao.DropdownMenu.Refresh
ao.Select=ao.DropdownMenu.Select
ao.Open=ao.DropdownMenu.Open
ao.Close=ao.DropdownMenu.Close

af("ImageLabel",{
Image=ae.Icon"chevrons-up-down"[1],
ImageRectOffset=ae.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=ae.Icon"chevrons-up-down"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,ao.UIElements.Dropdown and-12 or 0,0.5,0),
ThemeTag={
ImageColor3="Icon",
},
AnchorPoint=Vector2.new(1,0.5),
Parent=ao.UIElements.Dropdown and ao.UIElements.Dropdown.Frame
or ao.DropdownFrame.UIElements.Main,
})

function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.DropdownFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(aq)
ao.Locked=false
ap=true
return ao.DropdownFrame:Unlock()
end

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.N()







local aa={}
local ae={
lua={
"and","break","or","else","elseif","if","then","until","repeat","while","do","for","in","end",
"local","return","function","export",
},
rbx={
"game","workspace","script","math","string","table","task","wait","select","next","Enum",
"tick","assert","shared","loadstring","tonumber","tostring","type",
"typeof","unpack","Instance","CFrame","Vector3","Vector2","Color3","UDim","UDim2","Ray","BrickColor",
"OverlapParams","RaycastParams","Axes","Random","Region3","Rect","TweenInfo",
"collectgarbage","not","utf8","pcall","xpcall","_G","setmetatable","getmetatable","os","pairs","ipairs"
},
operators={
"#","+","-","*","%","/","^","=","~","=","<",">",
}
}

local af={
numbers=Color3.fromHex"#FAB387",
boolean=Color3.fromHex"#FAB387",
operator=Color3.fromHex"#94E2D5",
lua=Color3.fromHex"#CBA6F7",
rbx=Color3.fromHex"#F38BA8",
str=Color3.fromHex"#A6E3A1",
comment=Color3.fromHex"#9399B2",
null=Color3.fromHex"#F38BA8",
call=Color3.fromHex"#89B4FA",
self_call=Color3.fromHex"#89B4FA",
local_property=Color3.fromHex"#CBA6F7",
}

local function createKeywordSet(ah)
local aj={}
for ak,al in ipairs(ah)do
aj[al]=true
end
return aj
end

local ah=createKeywordSet(ae.lua)
local aj=createKeywordSet(ae.rbx)
local ak=createKeywordSet(ae.operators)

local function getHighlight(al,am)
local an=al[am]

if af[an.."_color"]then
return af[an.."_color"]
end

if tonumber(an)then
return af.numbers
elseif an=="nil"then
return af.null
elseif an:sub(1,2)=="--"then
return af.comment
elseif ak[an]then
return af.operator
elseif ah[an]then
return af.lua
elseif aj[an]then
return af.rbx
elseif an:sub(1,1)=="\""or an:sub(1,1)=="\'"then
return af.str
elseif an=="true"or an=="false"then
return af.boolean
end

if al[am+1]=="("then
if al[am-1]==":"then
return af.self_call
end

return af.call
end

if al[am-1]=="."then
if al[am-2]=="Enum"then
return af.rbx
end

return af.local_property
end
end

function aa.run(al)
local am={}
local an=""

local ao=false
local ap=false
local aq=false

for ar=1,#al do
local as=al:sub(ar,ar)

if ap then
if as=="\n"and not aq then
table.insert(am,an)
table.insert(am,as)
an=""

ap=false
elseif al:sub(ar-1,ar)=="]]"and aq then
an=an.."]"

table.insert(am,an)
an=""

ap=false
aq=false
else
an=an..as
end
elseif ao then
if as==ao and al:sub(ar-1,ar-1)~="\\"or as=="\n"then
an=an..as
ao=false
else
an=an..as
end
else
if al:sub(ar,ar+1)=="--"then
table.insert(am,an)
an="-"
ap=true
aq=al:sub(ar+2,ar+3)=="[["
elseif as=="\""or as=="\'"then
table.insert(am,an)
an=as
ao=as
elseif ak[as]then
table.insert(am,an)
table.insert(am,as)
an=""
elseif as:match"[%w_]"then
an=an..as
else
table.insert(am,an)
table.insert(am,as)
an=""
end
end
end

table.insert(am,an)

local ar={}

for as,at in ipairs(am)do
local au=getHighlight(am,as)

if au then
local av=string.format("<font color = \"#%s\">%s</font>",au:ToHex(),at:gsub("<","&lt;"):gsub(">","&gt;"))

table.insert(ar,av)
else
table.insert(ar,at)
end
end

return table.concat(ar)
end

return aa end function a.O()
local aa={}

local ae=a.load'c'
local af=ae.New
local ah=ae.Tween

local aj=a.load'N'

function aa.New(ak,al,am,an,ao)
local ap={
Radius=12,
Padding=10
}

local aq=af("TextLabel",{
Text="",
TextColor3=Color3.fromHex"#CDD6F4",
TextTransparency=0,
TextSize=14,
TextWrapped=false,
LineHeight=1.15,
RichText=true,
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
AutomaticSize="XY",
},{
af("UIPadding",{
PaddingTop=UDim.new(0,ap.Padding+3),
PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),
PaddingBottom=UDim.new(0,ap.Padding+3),
})
})
aq.Font="Code"

local ar=af("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticCanvasSize="X",
ScrollingDirection="X",
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
},{
aq
})

local as=af("TextButton",{
BackgroundTransparency=1,
Size=UDim2.new(0,30,0,30),
Position=UDim2.new(1,-ap.Padding/2,0,ap.Padding/2),
AnchorPoint=Vector2.new(1,0),
Visible=an and true or false,
},{
ae.NewRoundFrame(ap.Radius-4,"Squircle",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Button",
},{
af("UIScale",{
Scale=1,
}),
af("ImageLabel",{
Image=ae.Icon"copy"[1],
ImageRectSize=ae.Icon"copy"[2].ImageRectSize,
ImageRectOffset=ae.Icon"copy"[2].ImageRectPosition,
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Size=UDim2.new(0,12,0,12),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.1,
})
})
})

ae.AddSignal(as.MouseEnter,function()
ah(as.Button,.05,{ImageTransparency=.95}):Play()
ah(as.Button.UIScale,.05,{Scale=.9}):Play()
end)
ae.AddSignal(as.InputEnded,function()
ah(as.Button,.08,{ImageTransparency=1}):Play()
ah(as.Button.UIScale,.08,{Scale=1}):Play()
end)

local at=ae.NewRoundFrame(ap.Radius,"Squircle",{



ImageColor3=Color3.fromHex"#212121",
ImageTransparency=.035,
Size=UDim2.new(1,0,0,20+(ap.Padding*2)),
AutomaticSize="Y",
Parent=am,
},{
ae.NewRoundFrame(ap.Radius,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.955,
}),
af("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
},{
ae.NewRoundFrame(ap.Radius,"Squircle-TL-TR",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.96,
Size=UDim2.new(1,0,0,20+(ap.Padding*2)),
Visible=al and true or false
},{
af("ImageLabel",{
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Image="rbxassetid://132464694294269",



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.2,
}),
af("TextLabel",{
Text=al,



TextColor3=Color3.fromHex"#ffffff",
TextTransparency=.2,
TextSize=16,
AutomaticSize="Y",
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
BackgroundTransparency=1,
TextTruncate="AtEnd",
Size=UDim2.new(1,as and-20-(ap.Padding*2),0,0)
}),
af("UIPadding",{

PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),

}),
af("UIListLayout",{
Padding=UDim.new(0,ap.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ar,
af("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
})
}),
as,
})

ap.CodeFrame=at

ae.AddSignal(aq:GetPropertyChangedSignal"TextBounds",function()
ar.Size=UDim2.new(1,0,0,(aq.TextBounds.Y/(ao or 1))+((ap.Padding+3)*2))
end)

function ap.Set(au)
aq.Text=aj.run(au)
end

function ap.Destroy()
at:Destroy()
ap=nil
end

ap.Set(ak)

ae.AddSignal(as.MouseButton1Click,function()
if an then
an()
local au=ae.Icon"check"
as.Button.ImageLabel.Image=au[1]
as.Button.ImageLabel.ImageRectSize=au[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=au[2].ImageRectPosition

task.wait(1)
local av=ae.Icon"copy"
as.Button.ImageLabel.Image=av[1]
as.Button.ImageLabel.ImageRectSize=av[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=av[2].ImageRectPosition
end
end)
return ap
end


return aa end function a.P()
local aa=a.load'c'local ae=
aa.New


local af=a.load'O'

local ah={}

function ah.New(aj,ak)
local al={
__type="Code",
Title=ak.Title,
Code=ak.Code,
OnCopy=ak.OnCopy,
}

local am=not al.Locked











local an=af.New(al.Code,al.Title,ak.Parent,function()
if am then
local an=al.Title or"code"
local ao,ap=pcall(function()
toclipboard(al.Code)

if al.OnCopy then al.OnCopy()end
end)
if not ao then
ak.WindUI:Notify{
Title="Error",
Content="The "..an.." is not copied. Error: "..ap,
Icon="x",
Duration=5,
}
end
end
end,ak.WindUI.UIScale,al)

function al.SetCode(ao,ap)
an.Set(ap)
al.Code=ap
end

function al.Set(ao,ap)
return al.SetCode(ap)
end

function al.Destroy(ao)
an.Destroy()
al=nil
end

al.ElementFrame=an.CodeFrame

return al.__type,al
end

return ah end function a.Q()
local aa=a.load'c'
local ae=aa.New local af=
aa.Tween

local ah=(cloneref or clonereference or function(ah)return ah end)

local aj=ah(game:GetService"UserInputService")
ah(game:GetService"TouchInputService")
local ak=ah(game:GetService"RunService")
local al=ah(game:GetService"Players")

local am=ak.RenderStepped
local an=al.LocalPlayer
local ao=an:GetMouse()

local ap=a.load'l'.New
local aq=a.load'm'.New

local ar={
UICorner=9,

}

function ar.Colorpicker(as,at,au,av,aw)
local ax={
__type="Colorpicker",
Title=at.Title,
Desc=at.Desc,
Default=at.Value or at.Default,
Callback=at.Callback,
Transparency=at.Transparency,
UIElements=at.UIElements,

TextPadding=10,
}

function ax.SetHSVFromRGB(ay,az)
local aA,aB,b=Color3.toHSV(az)
ax.Hue=aA
ax.Sat=aB
ax.Vib=b
end

ax:SetHSVFromRGB(ax.Default)

local ay=a.load'n'
local az=ay.Create(nil,"Dialog",au,av,au.UIElements.Main.Main)

ax.ColorpickerFrame=az

az.UIElements.Main.Size=UDim2.new(1,0,0,0)



local aA,aB,b=ax.Hue,ax.Sat,ax.Vib

ax.UIElements.Title=ae("TextLabel",{
Text=ax.Title,
TextSize=20,
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=az.UIElements.Main
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,ax.TextPadding/2),
PaddingLeft=UDim.new(0,ax.TextPadding/2),
PaddingRight=UDim.new(0,ax.TextPadding/2),
PaddingBottom=UDim.new(0,ax.TextPadding/2),
})
})





local d=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=HueDragHolder,
BackgroundColor3=ax.Default
},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})
})

ax.UIElements.SatVibMap=ae("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40+ax.TextPadding),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(aA,1,1),
BackgroundTransparency=0,
Parent=az.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=45,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),

d,
})

ax.UIElements.Inputs=ae("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(ax.Transparency and 240 or 210,40+ax.TextPadding),
BackgroundTransparency=1,
Parent=az.UIElements.Main
},{
ae("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
})
})





local f=ae("Frame",{
BackgroundColor3=ax.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=ax.Transparency,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

ae("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(85,208+ax.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=az.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),







f,
})

local g=ae("Frame",{
BackgroundColor3=ax.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=0,
ZIndex=9,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

ae("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,208+ax.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=az.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),







aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),
g,
})

local h={}

for j=0,1,0.1 do
table.insert(h,ColorSequenceKeypoint.new(j,Color3.fromHSV(j,1,1)))
end

local j=ae("UIGradient",{
Color=ColorSequence.new(h),
Rotation=90,
})

local l=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local m=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=l,


BackgroundColor3=ax.Default
},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})
})

local p=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(180,40+ax.TextPadding),
Parent=az.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
j,
l,
})


function CreateNewInput(r,u)
local v=aq(r,nil,ax.UIElements.Inputs)

ae("TextLabel",{
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=17,
FontFace=Font.new(aa.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=v.Frame,
Text=r,
})

ae("UIScale",{
Parent=v,
Scale=.85,
})

v.Frame.Frame.TextBox.Text=u
v.Size=UDim2.new(0,150,0,42)

return v
end

local function ToRGB(r)
return{
R=math.floor(r.R*255),
G=math.floor(r.G*255),
B=math.floor(r.B*255)
}
end

local r=CreateNewInput("Hex","#"..ax.Default:ToHex())

local u=CreateNewInput("Red",ToRGB(ax.Default).R)
local v=CreateNewInput("Green",ToRGB(ax.Default).G)
local x=CreateNewInput("Blue",ToRGB(ax.Default).B)
local z
if ax.Transparency then
z=CreateNewInput("Alpha",((1-ax.Transparency)*100).."%")
end

local A=ae("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254+ax.TextPadding),
BackgroundTransparency=1,
Parent=az.UIElements.Main,
LayoutOrder=4,
},{
ae("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
}),






})

local B={
{
Title="Cancel",
Variant="Secondary",
Callback=function()end
},
{
Title="Apply",
Icon="chevron-right",
Variant="Primary",
Callback=function()aw(Color3.fromHSV(ax.Hue,ax.Sat,ax.Vib),ax.Transparency)end
}
}

for C,F in next,B do
local G=ap(F.Title,F.Icon,F.Callback,F.Variant,A,az,false)
G.Size=UDim2.new(0.5,-3,0,40)
G.AutomaticSize="None"
end



local C,F,G
if ax.Transparency then
local H=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.fromOffset(0,0),
BackgroundTransparency=1,
})

F=ae("ImageLabel",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
ThemeTag={
BackgroundColor3="Text",
},
Parent=H,

},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})

})

G=ae("Frame",{
Size=UDim2.fromScale(1,1),
},{
ae("UIGradient",{
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
Rotation=270,
}),
ae("UICorner",{
CornerRadius=UDim.new(0,6),
}),
})

C=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(210,40+ax.TextPadding),
Parent=az.UIElements.Main,
BackgroundTransparency=1,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
ae("ImageLabel",{
Image="rbxassetid://14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
G,
H,
})
end

function ax.Round(H,J,L)
if L==0 then
return math.floor(J)
end
J=tostring(J)
return J:find"%."and tonumber(J:sub(1,J:find"%."+L))or J
end


function ax.Update(H,J,L)
if J then aA,aB,b=Color3.toHSV(J)else aA,aB,b=ax.Hue,ax.Sat,ax.Vib end

ax.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(aA,1,1)
d.Position=UDim2.new(aB,0,1-b,0)
d.BackgroundColor3=Color3.fromHSV(aA,aB,b)
g.BackgroundColor3=Color3.fromHSV(aA,aB,b)
m.BackgroundColor3=Color3.fromHSV(aA,1,1)
m.Position=UDim2.new(0.5,0,aA,0)

r.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(aA,aB,b):ToHex()
u.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aA,aB,b)).R
v.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aA,aB,b)).G
x.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aA,aB,b)).B

if L or ax.Transparency then
g.BackgroundTransparency=ax.Transparency or L
G.BackgroundColor3=Color3.fromHSV(aA,aB,b)
F.BackgroundColor3=Color3.fromHSV(aA,aB,b)
F.BackgroundTransparency=ax.Transparency or L
F.Position=UDim2.new(0.5,0,1-ax.Transparency or L,0)
z.Frame.Frame.TextBox.Text=ax:Round((1-ax.Transparency or L)*100,0).."%"
end
end

ax:Update(ax.Default,ax.Transparency)




local function GetRGB()
local H=Color3.fromHSV(ax.Hue,ax.Sat,ax.Vib)
return{R=math.floor(H.r*255),G=math.floor(H.g*255),B=math.floor(H.b*255)}
end



local function clamp(H,J,L)
return math.clamp(tonumber(H)or 0,J,L)
end

aa.AddSignal(r.Frame.Frame.TextBox.FocusLost,function(H)
if H then
local J=r.Frame.Frame.TextBox.Text:gsub("#","")
local L,M=pcall(Color3.fromHex,J)
if L and typeof(M)=="Color3"then
ax.Hue,ax.Sat,ax.Vib=Color3.toHSV(M)
ax:Update()
ax.Default=M
end
end
end)

local function updateColorFromInput(H,J)
aa.AddSignal(H.Frame.Frame.TextBox.FocusLost,function(L)
if L then
local M=H.Frame.Frame.TextBox
local N=GetRGB()
local O=clamp(M.Text,0,255)
M.Text=tostring(O)

N[J]=O
local P=Color3.fromRGB(N.R,N.G,N.B)
ax.Hue,ax.Sat,ax.Vib=Color3.toHSV(P)
ax:Update()
end
end)
end

updateColorFromInput(u,"R")
updateColorFromInput(v,"G")
updateColorFromInput(x,"B")

if ax.Transparency then
aa.AddSignal(z.Frame.Frame.TextBox.FocusLost,function(H)
if H then
local J=z.Frame.Frame.TextBox
local L=clamp(J.Text,0,100)
J.Text=tostring(L)

ax.Transparency=1-L*0.01
ax:Update(nil,ax.Transparency)
end
end)
end



local H=ax.UIElements.SatVibMap
aa.AddSignal(H.InputBegan,function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 or J.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=H.AbsolutePosition.X
local M=L+H.AbsoluteSize.X
local N=math.clamp(ao.X,L,M)

local O=H.AbsolutePosition.Y
local P=O+H.AbsoluteSize.Y
local Q=math.clamp(ao.Y,O,P)

ax.Sat=(N-L)/(M-L)
ax.Vib=1-((Q-O)/(P-O))
ax:Update()

am:Wait()
end
end
end)

aa.AddSignal(p.InputBegan,function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 or J.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=p.AbsolutePosition.Y
local M=L+p.AbsoluteSize.Y
local N=math.clamp(ao.Y,L,M)

ax.Hue=((N-L)/(M-L))
ax:Update()

am:Wait()
end
end
end)

if ax.Transparency then
aa.AddSignal(C.InputBegan,function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 or J.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=C.AbsolutePosition.Y
local M=L+C.AbsoluteSize.Y
local N=math.clamp(ao.Y,L,M)

ax.Transparency=1-((N-L)/(M-L))
ax:Update()

am:Wait()
end
end
end)
end

return ax
end

function ar.New(as,at)
local au={
__type="Colorpicker",
Title=at.Title or"Colorpicker",
Desc=at.Desc or nil,
Locked=at.Locked or false,
LockedTitle=at.LockedTitle,
Default=at.Default or Color3.new(1,1,1),
Callback=at.Callback or function()end,

UIScale=at.UIScale,
Transparency=at.Transparency,
UIElements={}
}

local av=true



au.ColorpickerFrame=a.load'B'{
Title=au.Title,
Desc=au.Desc,
Parent=at.Parent,
TextOffset=40,
Hover=false,
Tab=at.Tab,
Index=at.Index,
Window=at.Window,
ElementTable=au,
ParentConfig=at,
}

au.UIElements.Colorpicker=aa.NewRoundFrame(ar.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=au.Default,
Parent=au.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,26,0,26),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=2
},nil,true)


function au.Lock(aw)
au.Locked=true
av=false
return au.ColorpickerFrame:Lock(au.LockedTitle)
end
function au.Unlock(aw)
au.Locked=false
av=true
return au.ColorpickerFrame:Unlock()
end

if au.Locked then
au:Lock()
end


function au.Update(aw,ax,ay)
au.UIElements.Colorpicker.ImageTransparency=ay or 0
au.UIElements.Colorpicker.ImageColor3=ax
au.Default=ax
if ay then
au.Transparency=ay
end
end

function au.Set(aw,ax,ay)
return au:Update(ax,ay)
end

aa.AddSignal(au.UIElements.Colorpicker.MouseButton1Click,function()
if av then
ar:Colorpicker(au,at.Window,at.WindUI,function(aw,ax)
au:Update(aw,ax)
au.Default=aw
au.Transparency=ax
aa.SafeCallback(au.Callback,aw,ax)
end).ColorpickerFrame:Open()
end
end)

return au.__type,au
end

return ar end function a.R()
local aa=a.load'c'
local ae=aa.New
local af=aa.Tween

local ah={}

function ah.New(aj,ak)
local al={
__type="Section",
Title=ak.Title or"Section",
Desc=ak.Desc,
Icon=ak.Icon,
IconThemed=ak.IconThemed,
TextXAlignment=ak.TextXAlignment or"Left",
TextSize=ak.TextSize or 19,
DescTextSize=ak.DescTextSize or 16,
Box=ak.Box or false,
BoxBorder=ak.BoxBorder or false,
FontWeight=ak.FontWeight or Enum.FontWeight.SemiBold,
DescFontWeight=ak.DescFontWeight or Enum.FontWeight.Medium,
TextTransparency=ak.TextTransparency or 0.05,
DescTextTransparency=ak.DescTextTransparency or 0.4,
Opened=ak.Opened or false,
UIElements={},

HeaderSize=42,
IconSize=20,
Padding=10,

Elements={},

Expandable=false,
}

local am


function al.SetIcon(an,ao)
al.Icon=ao or nil
if am then am:Destroy()end
if ao then
am=aa.Image(
ao,
ao..":"..al.Title,
0,
ak.Window.Folder,
al.__type,
true,
al.IconThemed,
"SectionIcon"
)
am.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
end
end

local an=ae("Frame",{
Size=UDim2.new(0,al.IconSize,0,al.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ae("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=aa.Icon"chevron-down"[1],
ImageRectSize=aa.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=aa.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageTransparency="SectionExpandIconTransparency",
ImageColor3="SectionExpandIcon",
},
})
})


if al.Icon then
al:SetIcon(al.Icon)
end

local ao=ae("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ae("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment=al.TextXAlignment,
VerticalAlignment="Center",
Padding=UDim.new(0,4)
})
})

local ap,aq

local function createTitle(ar,as)
return ae("TextLabel",{
BackgroundTransparency=1,
TextXAlignment=al.TextXAlignment,
AutomaticSize="Y",
TextSize=as=="Title"and al.TextSize or al.DescTextSize,
TextTransparency=as=="Title"and al.TextTransparency or al.DescTextTransparency,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aa.Font,as=="Title"and al.FontWeight or al.DescFontWeight),


Text=ar,
Size=UDim2.new(
1,
0,
0,
0
),
TextWrapped=true,
Parent=ao,
})
end

ap=createTitle(al.Title,"Title")
if al.Desc then
aq=createTitle(al.Desc,"Desc")
end

local function UpdateTitleSize()
local ar=0
if am then
ar=ar-(al.IconSize+8)
end
if an.Visible then
ar=ar-(al.IconSize+8)
end
ao.Size=UDim2.new(1,ar,0,0)
end


local ar=aa.NewRoundFrame(ak.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Parent=ak.Parent,
ClipsDescendants=true,
AutomaticSize="Y",
ThemeTag={
ImageTransparency=al.Box and"SectionBoxBackgroundTransparency"or nil,
ImageColor3="SectionBoxBackground",
},
ImageTransparency=not al.Box and 1 or nil,
},{
aa.NewRoundFrame(ak.Window.ElementConfig.UICorner,ak.Window.NewElements and"Glass-1"or"SquircleOutline",{
Size=UDim2.new(1,0,1,0),

ThemeTag={
ImageTransparency="SectionBoxBorderTransparency",
ImageColor3="SectionBoxBorder",
},
Visible=al.Box and al.BoxBorder,
Name="Outline",
}),
ae("TextButton",{
Size=UDim2.new(1,0,0,al.Expandable and 0 or(not aq and al.HeaderSize or 0)),
BackgroundTransparency=1,
AutomaticSize=(not al.Expandable or aq)and"Y"or nil,
Text="",
Name="Top",
},{
al.Box and ae("UIPadding",{
PaddingTop=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
PaddingLeft=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
PaddingRight=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
PaddingBottom=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
})or nil,
am,
ao,
ae("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
an,
}),
ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=false,
Position=UDim2.new(0,0,0,al.HeaderSize)
},{
al.Box and ae("UIPadding",{
PaddingLeft=UDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingRight=UDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingBottom=UDim.new(0,ak.Window.ElementConfig.UIPadding),
})or nil,
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ak.Tab.Gap),
VerticalAlignment="Top",
}),
})
})





al.ElementFrame=ar

if aq then
ar.Top:GetPropertyChangedSignal"AbsoluteSize":Connect(function()
ar.Content.Position=UDim2.new(0,0,0,ar.Top.AbsoluteSize.Y/ak.UIScale)

if al.Opened then al:Open(true)else al.Close(true)end
end)
end


local as=ak.ElementsModule

as.Load(al,ar.Content,as.Elements,ak.Window,ak.WindUI,function()
if not al.Expandable then
al.Expandable=true
an.Visible=true
UpdateTitleSize()
end
end,as,ak.UIScale,ak.Tab)


UpdateTitleSize()

function al.SetTitle(at,au)
al.Title=au
ap.Text=au
end

function al.SetDesc(at,au)
al.Desc=au
if not aq then
aq=createTitle(au,"Desc")
end
aq.Text=au
end

function al.Destroy(at)
for au,av in next,al.Elements do
av:Destroy()
end








ar:Destroy()
end

function al.Open(at,au)
if al.Expandable then
al.Opened=true
if au then
ar.Size=UDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y)/ak.UIScale+(ar.Content.AbsoluteSize.Y/ak.UIScale))
an.ImageLabel.Rotation=180
else
af(ar,0.33,{
Size=UDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y)/ak.UIScale+(ar.Content.AbsoluteSize.Y/ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

af(an.ImageLabel,0.2,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
end
function al.Close(at,au)
if al.Expandable then
al.Opened=false
if au then
ar.Size=UDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y/ak.UIScale))
an.ImageLabel.Rotation=0
else
af(ar,0.26,{
Size=UDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y/ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
af(an.ImageLabel,0.2,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
end

aa.AddSignal(ar.Top.MouseButton1Click,function()
if al.Expandable then
if al.Opened then
al:Close()
else
al:Open()
end
end
end)

aa.AddSignal(ar.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if al.Opened then
al:Open(true)
end
end)

task.spawn(function()
task.wait(0.02)
if al.Expandable then








ar.Size=UDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,ar.Top.AbsoluteSize.Y/ak.UIScale)
ar.AutomaticSize="None"
ar.Top.Size=UDim2.new(1,0,0,(not aq and al.HeaderSize or 0))
ar.Top.AutomaticSize=(not al.Expandable or aq)and"Y"or"None"
ar.Content.Visible=true
end
if al.Opened then
al:Open()
end

end)

return al.__type,al
end

return ah end function a.S()

local aa=a.load'c'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak=ae("Frame",{
Parent=aj.Parent,
Size=not table.find({"Group","HStack"},aj.ParentType)and UDim2.new(1,-7,0,7*(aj.Columns or 1))or UDim2.new(0,7*(aj.Columns or 1),0,0),
BackgroundTransparency=1,
})

return"Space",{__type="Space",ElementFrame=ak}
end

return af end function a.T()
local aa=a.load'c'
local ae=aa.New

local af={}

local function ParseAspectRatio(ah)
if type(ah)=="string"then
local aj,ak=ah:match"(%d+):(%d+)"
if aj and ak then
return tonumber(aj)/tonumber(ak)
end
elseif type(ah)=="number"then
return ah
end
return nil
end

function af.New(ah,aj)
local ak={
__type="Image",
Image=aj.Image or"",
AspectRatio=aj.AspectRatio or"16:9",
Radius=aj.Radius or aj.Window.ElementConfig.UICorner,
}
local al=aa.Image(
ak.Image,
ak.Image,
ak.Radius,
aj.Window.Folder,
"Image",
false
)
if al and al.Parent then
al.Parent=aj.Parent
al.Size=UDim2.new(1,0,0,0)
al.BackgroundTransparency=1












local am=ParseAspectRatio(ak.AspectRatio)
local an

if am then
an=ae("UIAspectRatioConstraint",{
Parent=al,
AspectRatio=am,
AspectType="ScaleWithParentSize",
DominantAxis="Width"
})
end

function ak.Destroy(ao)
al:Destroy()
end
end

return ak.__type,ak
end

return af end function a.U()
local aa=a.load'c'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak={
__type="Group",
Elements={},
ElementFrame=nil,
}

local al=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=aj.Parent,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6))
}),
})

ak.ElementFrame=al

local am=aj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,
function(an,ao)
local ap=aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6)

local aq={}
local ar=0

for as,at in next,ao do
if at.__type=="Space"then
ar=ar+(at.ElementFrame.Size.X.Offset or 6)
elseif at.__type=="Divider"then
ar=ar+(at.ElementFrame.Size.X.Offset or 1)
else
table.insert(aq,at)
end
end

local as=#aq
if as==0 then return end

local at=1/as

local au=ap*(as-1)

local av=-(au+ar)

local aw=math.floor(av/as)
local ax=av-(aw*as)

for ay,az in next,aq do
local aA=aw
if ay<=math.abs(ax)then
aA=aA-1
end

if az.ElementFrame then
az.ElementFrame.Size=UDim2.new(at,aA,1,0)
end
end
end,
am,
aj.UIScale,
aj.Tab
)



return ak.__type,ak
end

return af end function a.V()
local aa=a.load'c'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak={
__type="HStack",
AutoSpace=aj.AutoSpace or false,
Elements={},
ElementFrame=nil,
}

local al=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=aj.Parent,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6))
}),
})

ak.ElementFrame=al

local am=aj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,
function(an,ao)
local ap=aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6)

local aq={}
local ar=0

for as,at in next,ao do
if at.__type=="Space"then
ar=ar+(at.ElementFrame.Size.X.Offset or 6)
elseif at.__type=="Divider"then
ar=ar+(at.ElementFrame.Size.X.Offset or 1)
else
table.insert(aq,at)
end
end

local as=#aq
if as==0 then return end

local at=1/as

local au=ap*(as-1)

local av=-(au+ar)

local aw=math.floor(av/as)
local ax=av-(aw*as)

for ay,az in next,aq do
local aA=aw
if ay<=math.abs(ax)then
aA=aA-1
end

if az.ElementFrame then
az.ElementFrame.Size=UDim2.new(at,aA,1,0)
end
end
end,
am,
aj.UIScale,
aj.Tab
)

if ak.AutoSpace then
for an in next,am.Elements do
if an~="Space"and an~="Divider"then
local ao=ak[an]
ak[an]=function(ap,aq)
if#ak.Elements>0 then
ak:Space()
end
return ao(ap,aq)
end
end
end
end


return ak.__type,ak
end

return af end function a.W()
local aa=a.load'c'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak={
__type="VStack",
Elements={},
ElementFrame=nil,
}

local al=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=aj.Parent,
},{
ae("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment="Center",

Padding=UDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6))
}),
})

ak.ElementFrame=al

local am=aj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,







































nil,
am,
aj.UIScale,
aj.Tab
)



return ak.__type,ak
end

return af end function a.X()
return{
Elements={
Paragraph=a.load'C',
Button=a.load'D',
Toggle=a.load'G',
Slider=a.load'H',
Keybind=a.load'I',
Input=a.load'J',
Dropdown=a.load'M',
Code=a.load'P',
Colorpicker=a.load'Q',
Section=a.load'R',
Divider=a.load'K',
Space=a.load'S',
Image=a.load'T',
Group=a.load'U',
HStack=a.load'V',
VStack=a.load'W',

},
Load=function(aa,ae,af,ah,aj,ak,al,am,an)
for ao,ap in next,af do
aa[ao]=function(aq,ar)
ar=ar or{}
ar.Tab=an or aa
ar.ParentType=aa.__type
ar.ParentTable=aa
ar.Index=#aa.Elements+1
ar.GlobalIndex=#ah.AllElements+1
ar.Parent=ae
ar.Window=ah
ar.WindUI=aj
ar.UIScale=am
ar.ElementsModule=al local

as, at=ap:New(ar)

if ar.Flag and typeof(ar.Flag)=="string"then
if ah.CurrentConfig then
ah.CurrentConfig:Register(ar.Flag,at)

if ah.PendingConfigData and ah.PendingConfigData[ar.Flag]then
local au=ah.PendingConfigData[ar.Flag]

local av=ah.ConfigManager
if av.Parser[au.__type]then
task.defer(function()
local aw,ax=pcall(function()
av.Parser[au.__type].Load(at,au)
end)

if aw then
ah.PendingConfigData[ar.Flag]=nil
else
warn(
"[ WindUI ] Failed to apply pending config for '"
..ar.Flag
.."': "
..tostring(ax)
)
end
end)
end
end
else
ah.PendingFlags=ah.PendingFlags or{}
ah.PendingFlags[ar.Flag]=at
end
end

local au
for av,aw in next,at do
if typeof(aw)=="table"and av~="ElementFrame"and av:match"Frame$"then
au=aw
break
end
end

if au then
at.ElementFrame=au.UIElements.Main
function at.SetTitle(av,aw)
return au.SetTitle and au:SetTitle(aw)
end
function at.SetDesc(av,aw)
return au.SetDesc and au:SetDesc(aw)
end
function at.SetImage(av,aw,ax)
return au.SetImage and au:SetImage(aw,ax)
end
function at.SetThumbnail(av,aw,ax)
return au.SetThumbnail and au:SetThumbnail(aw,ax)
end
function at.Highlight(av)
au:Highlight()
end
function at.Destroy(av)
au:Destroy()

table.remove(ah.AllElements,ar.GlobalIndex)
table.remove(aa.Elements,ar.Index)
table.remove(an.Elements,ar.Index)
aa:UpdateAllElementShapes(aa)
end
end

ah.AllElements[ar.Index]=at
aa.Elements[ar.Index]=at
if an then
an.Elements[ar.Index]=at
end

if ah.NewElements then
aa:UpdateAllElementShapes(aa)
end

if ak then
ak(at,aa.Elements)
end
return at
end
end
function aa.UpdateAllElementShapes(ao,ap)
for aq,ar in next,ap.Elements do
local as
for at,au in pairs(ar)do
if typeof(au)=="table"and at:match"Frame$"then
as=au
break
end
end

if as then

as.Index=aq
if as.UpdateShape then

as.UpdateShape(ap)
end
end
end
end
end,
}end function a.Y()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ae=game:GetService"Players"

aa(game:GetService"UserInputService")
local af=ae.LocalPlayer:GetMouse()

local ah=a.load'c'
local aj=ah.New

local ak=a.load'A'.New
local al=a.load'w'.New



local am={


Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(am)end,
}

function am.Init(an,ao,ap,aq)
Window=an
WindUI=ao
am.ToolTipParent=ap
am.TabHighlight=aq
return am
end

function am.New(an,ao)
local ap={
__type="Tab",
Title=an.Title or"Tab",
Desc=an.Desc,
Icon=an.Icon,
IconColor=an.IconColor,
IconShape=an.IconShape,
IconThemed=an.IconThemed,
Locked=an.Locked,
ShowTabTitle=an.ShowTabTitle,
TabTitleAlign=an.TabTitleAlign or"Left",
CustomEmptyPage=(an.CustomEmptyPage and next(an.CustomEmptyPage)~=nil)and an.CustomEmptyPage
or{Icon="lucide:frown",IconSize=48,Title="This tab is Empty",Desc=nil},
Border=an.Border,
Selected=false,
Index=nil,
Parent=an.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=Window.UICorner-(Window.UIPadding/2),

Gap=Window.NewElements and 1 or 6,

TabPaddingX=4+(Window.UIPadding/2),
TabPaddingY=3+(Window.UIPadding/2),
TitlePaddingY=0,
}









if ap.IconShape then
ap.TabPaddingX=2+(Window.UIPadding/4)
ap.TabPaddingY=2+(Window.UIPadding/4)
ap.TitlePaddingY=2+(Window.UIPadding/4)
end

am.TabCount=am.TabCount+1

local aq=am.TabCount
ap.Index=aq

ap.UIElements.Main=ah.NewRoundFrame(ap.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=UDim2.new(1,-7,0,0),
AutomaticSize="Y",
Parent=an.Parent,
ThemeTag={
ImageColor3="TabBackground",
},
ImageTransparency=1,
},{
ah.NewRoundFrame(ap.UICorner,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="TabBorder",
},
ImageTransparency=1,
Name="Outline",
},{













}),
ah.NewRoundFrame(ap.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
aj("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,2+(Window.UIPadding/2)),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aj("TextLabel",{
Text=ap.Title,
ThemeTag={
TextColor3="TabTitle",
},
TextTransparency=not ap.Locked and 0.4 or 0.7,
TextSize=15,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(ah.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize="Y",
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
},{
aj("UIPadding",{
PaddingTop=UDim.new(0,ap.TitlePaddingY),


PaddingBottom=UDim.new(0,ap.TitlePaddingY),
}),
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,ap.TabPaddingY),
PaddingLeft=UDim.new(0,ap.TabPaddingX),
PaddingRight=UDim.new(0,ap.TabPaddingX),
PaddingBottom=UDim.new(0,ap.TabPaddingY),
}),
}),
},true)

local ar=0
local as
local at

if ap.Icon then
as=ah.Image(
ap.Icon,
ap.Icon..":"..ap.Title,
0,
Window.Folder,
ap.__type,
ap.IconColor and false or true,
ap.IconThemed,
"TabIcon"
)
as.Size=UDim2.new(0,16,0,16)
if ap.IconColor then
as.ImageLabel.ImageColor3=ap.IconColor
end
if not ap.IconShape then
as.Parent=ap.UIElements.Main.Frame
ap.UIElements.Icon=as
as.ImageLabel.ImageTransparency=not ap.Locked and 0 or 0.7
ar=-18-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,ar,0,0)
elseif ap.IconColor then
ah.NewRoundFrame(
ap.IconShape~="Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Squircle",
{
Size=UDim2.new(0,26,0,26),
ImageColor3=ap.IconColor,
Parent=ap.UIElements.Main.Frame,
},
{
as,
ah.NewRoundFrame(
ap.IconShape~="Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Glass-1.4",
{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0,
Name="Outline",
},
{













}
),
}
)
as.AnchorPoint=Vector2.new(0.5,0.5)
as.Position=UDim2.new(0.5,0,0.5,0)
as.ImageLabel.ImageTransparency=0
as.ImageLabel.ImageColor3=ah.GetTextColorForHSB(ap.IconColor,0.68)
ar=-28-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,ar,0,0)
end

at=
ah.Image(ap.Icon,ap.Icon..":"..ap.Title,0,Window.Folder,ap.__type,true,ap.IconThemed)
at.Size=UDim2.new(0,16,0,16)
at.ImageLabel.ImageTransparency=not ap.Locked and 0 or 0.7
ar=-30




end

ap.UIElements.ContainerFrame=aj("ScrollingFrame",{
Size=UDim2.new(1,0,1,ap.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
aj("UIPadding",{
PaddingTop=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
aj("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,ap.Gap),
HorizontalAlignment="Center",
}),
})





ap.UIElements.ContainerFrameCanvas=aj("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
Parent=Window.UIElements.MainBar,
ZIndex=5,
},{
ap.UIElements.ContainerFrame,
aj("Frame",{
Size=UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=ap.ShowTabTitle or false,
Name="TabTitle",
},{
at,
aj("TextLabel",{
Text=ap.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=20,
TextTransparency=0.1,
Size=UDim2.new(0,0,1,0),
FontFace=Font.new(ah.Font,Enum.FontWeight.SemiBold),

RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
AutomaticSize="X",
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
aj("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=ap.TabTitleAlign,
}),
}),
aj("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
Position=UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=ap.ShowTabTitle or false,
}),
})

am.Containers[aq]=ap.UIElements.ContainerFrameCanvas
am.Tabs[aq]=ap

ap.ContainerFrame=ap.UIElements.ContainerFrameCanvas

ah.AddSignal(ap.UIElements.Main.MouseButton1Click,function()
if not ap.Locked then
am:SelectTab(aq)
end
end)

if Window.ScrollBarEnabled then
al(ap.UIElements.ContainerFrame,ap.UIElements.ContainerFrameCanvas,Window,3)
end

local au
local av
local aw
local ax=false


if ap.Desc then
ah.AddSignal(ap.UIElements.Main.InputBegan,function()
ax=true
av=task.spawn(function()
task.wait(0.35)
if ax and not au then
au=ak(ap.Desc,am.ToolTipParent,true)
au.Container.AnchorPoint=Vector2.new(0.5,0.5)

local function updatePosition()
if au then
au.Container.Position=UDim2.new(0,af.X,0,af.Y-4)
end
end

updatePosition()
aw=af.Move:Connect(updatePosition)
au:Open()
end
end)
end)
end

ah.AddSignal(ap.UIElements.Main.MouseEnter,function()
if not ap.Locked then
ah.SetThemeTag(ap.UIElements.Main.Frame,{
ImageTransparency="TabBackgroundHoverTransparency",
ImageColor3="TabBackgroundHover",
},0.1)
end
end)
ah.AddSignal(ap.UIElements.Main.InputEnded,function()
if ap.Desc then
ax=false
if av then
task.cancel(av)
av=nil
end
if aw then
aw:Disconnect()
aw=nil
end
if au then
au:Close()
au=nil
end
end

if not ap.Locked then
ah.SetThemeTag(ap.UIElements.Main.Frame,{
ImageTransparency="TabBorderTransparency",
},0.1)
end
end)

function ap.ScrollToTheElement(ay,az)
ap.UIElements.ContainerFrame.ScrollingEnabled=false

ah.Tween(ap.UIElements.ContainerFrame,0.45,{
CanvasPosition=Vector2.new(
0,
ap.Elements[az].ElementFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.48)

if ap.Elements[az].Highlight then
ap.Elements[az]:Highlight()
end
ap.UIElements.ContainerFrame.ScrollingEnabled=true
end)

return ap
end



local ay=a.load'X'

ay.Load(
ap,
ap.UIElements.ContainerFrame,
ay.Elements,
Window,
WindUI,
nil,
ay,
ao,
ap
)

function ap.LockAll(az)

for aA,aB in next,Window.AllElements do
if aB.Tab and aB.Tab.Index and aB.Tab.Index==ap.Index and aB.Lock then
aB:Lock()
end
end
end
function ap.UnlockAll(az)
for aA,aB in next,Window.AllElements do
if aB.Tab and aB.Tab.Index and aB.Tab.Index==ap.Index and aB.Unlock then
aB:Unlock()
end
end
end
function ap.GetLocked(az)
local aA={}

for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index==ap.Index and b.Locked==true then
table.insert(aA,b)
end
end

return aA
end
function ap.GetUnlocked(az)
local aA={}

for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index==ap.Index and b.Locked==false then
table.insert(aA,b)
end
end

return aA
end

function ap.Select(az)
return am:SelectTab(ap.Index)
end

task.spawn(function()
local az
if ap.CustomEmptyPage.Icon then
az=
ah.Image(ap.CustomEmptyPage.Icon,ap.CustomEmptyPage.Icon,0,"Temp","EmptyPage",true)
az.Size=
UDim2.fromOffset(ap.CustomEmptyPage.IconSize or 48,ap.CustomEmptyPage.IconSize or 48)
end

local aA=aj("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=ap.UIElements.ContainerFrame,
},{
aj("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),











az,
ap.CustomEmptyPage.Title
and aj("TextLabel",{
AutomaticSize="XY",
Text=ap.CustomEmptyPage.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
TextTransparency=0.5,
BackgroundTransparency=1,
FontFace=Font.new(ah.Font,Enum.FontWeight.Medium),
})
or nil,
ap.CustomEmptyPage.Desc
and aj("TextLabel",{
AutomaticSize="XY",
Text=ap.CustomEmptyPage.Desc,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.65,
BackgroundTransparency=1,
FontFace=Font.new(ah.Font,Enum.FontWeight.Regular),
})
or nil,
})





local aB
aB=ah.AddSignal(ap.UIElements.ContainerFrame.ChildAdded,function()
aA.Visible=false
aB:Disconnect()
end)
end)

return ap
end

function am.OnChange(an,ao)
am.OnChangeFunc=ao
end

function am.SelectTab(an,ao)
if not am.Tabs[ao].Locked then
am.SelectedTab=ao

for ap,aq in next,am.Tabs do
if not aq.Locked then
ah.SetThemeTag(aq.UIElements.Main,{
ImageTransparency="TabBorderTransparency",
},0.15)
if aq.Border then
ah.SetThemeTag(aq.UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparency",
},0.15)
end
ah.SetThemeTag(aq.UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparency",
},0.15)
if aq.UIElements.Icon and not aq.IconColor then
ah.SetThemeTag(aq.UIElements.Icon.ImageLabel,{
ImageTransparency="TabIconTransparency",
},0.15)
end
aq.Selected=false
end
end
ah.SetThemeTag(am.Tabs[ao].UIElements.Main,{
ImageTransparency="TabBackgroundActiveTransparency",
},0.15)
if am.Tabs[ao].Border then
ah.SetThemeTag(am.Tabs[ao].UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparencyActive",
},0.15)
end
ah.SetThemeTag(am.Tabs[ao].UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparencyActive",
},0.15)
if am.Tabs[ao].UIElements.Icon and not am.Tabs[ao].IconColor then
ah.SetThemeTag(am.Tabs[ao].UIElements.Icon.ImageLabel,{
ImageTransparency="TabIconTransparencyActive",
},0.15)
end
am.Tabs[ao].Selected=true

task.spawn(function()
for ap,aq in next,am.Containers do
aq.AnchorPoint=Vector2.new(0,0.05)
aq.Visible=false
end
am.Containers[ao].Visible=true
local ap=game:GetService"TweenService"

local aq=TweenInfo.new(0.15,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local ar=ap:Create(am.Containers[ao],aq,{
AnchorPoint=Vector2.new(0,0),
})
ar:Play()
end)

am.OnChangeFunc(ao)
end
end

return am end function a.Z()

local aa={}


local ae=a.load'c'
local af=ae.New
local ah=ae.Tween

local aj=a.load'Y'

function aa.New(ak,al,am,an,ao)
local ap={
Title=ak.Title or"Section",
Icon=ak.Icon,
IconThemed=ak.IconThemed,
Opened=ak.Opened or false,

HeaderSize=42,
IconSize=18,

Expandable=false,
}

local aq
if ap.Icon then
aq=ae.Image(
ap.Icon,
ap.Icon,
0,
am,
"Section",
true,
ap.IconThemed,
"TabSectionIcon"
)

aq.Size=UDim2.new(0,ap.IconSize,0,ap.IconSize)
aq.ImageLabel.ImageTransparency=.25
end

local ar=af("Frame",{
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
BackgroundTransparency=1,
Visible=false
},{
af("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=ae.Icon"chevron-down"[1],
ImageRectSize=ae.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=ae.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.7,
})
})

local as=af("Frame",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Parent=al,
ClipsDescendants=true,
},{
af("TextButton",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
aq,
af("TextLabel",{
Text=ap.Title,
TextXAlignment="Left",
Size=UDim2.new(
1,
aq and(-ap.IconSize-10)*2
or(-ap.IconSize-10),

1,
0
),
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ae.Font,Enum.FontWeight.SemiBold),
TextSize=14,
BackgroundTransparency=1,
TextTransparency=.7,

TextWrapped=true
}),
af("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
ar,
af("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
af("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,ap.HeaderSize)
},{
af("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ao.Gap),
VerticalAlignment="Bottom",
}),
})
})


function ap.Tab(at,au)
if not ap.Expandable then
ap.Expandable=true
ar.Visible=true
end
au.Parent=as.Content
return aj.New(au,an)
end

function ap.Open(at)
if ap.Expandable then
ap.Opened=true
ah(as,0.33,{
Size=UDim2.new(1,0,0,ap.HeaderSize+(as.Content.AbsoluteSize.Y/an))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ah(ar.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function ap.Close(at)
if ap.Expandable then
ap.Opened=false
ah(as,0.26,{
Size=UDim2.new(1,0,0,ap.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ah(ar.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

ae.AddSignal(as.TextButton.MouseButton1Click,function()
if ap.Expandable then
if ap.Opened then
ap:Close()
else
ap:Open()
end
end
end)

ae.AddSignal(as.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if ap.Opened then
ap:Open()
end
end)

if ap.Opened then
task.spawn(function()
task.wait()
ap:Open()
end)
end



return ap
end


return aa end function a._()
return{
Tab="table-of-contents",
Paragraph="type",
Button="square-mouse-pointer",
Toggle="toggle-right",
Slider="sliders-horizontal",
Keybind="command",
Input="text-cursor-input",
Dropdown="chevrons-up-down",
Code="terminal",
Colorpicker="palette",
}end function a.aa()
local aa=(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")

local ae={
Margin=8,
Padding=9,
}

local af=a.load'c'
local ah=af.New
local aj=af.Tween

function ae.new(ak,al,am)
local an={
IconSize=18,
Padding=14,
Radius=22,
Width=400,
MaxHeight=380,

Icons=a.load'_',
}

local ao=ah("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(1,-((an.IconSize*2)+(an.Padding*2)),0,0),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Regular),
TextSize=18,
})

local ap=ah("ImageLabel",{
Image=af.Icon"x"[1],
ImageRectSize=af.Icon"x"[2].ImageRectSize,
ImageRectOffset=af.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize),
},{
ah("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
}),
})

local aq=ah("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false,
},{
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
ah("UIPadding",{
PaddingTop=UDim.new(0,an.Padding),
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
PaddingBottom=UDim.new(0,an.Padding),
}),
})

local ar=af.NewRoundFrame(an.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="WindowSearchBarBackground",
},
ImageTransparency=0,
},{
af.NewRoundFrame(an.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Frame",
},{
ah("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








ah("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ah("ImageLabel",{
Image=af.Icon"search"[1],
ImageRectSize=af.Icon"search"[2].ImageRectSize,
ImageRectOffset=af.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize),
}),
ao,
ap,
ah("UIListLayout",{
Padding=UDim.new(0,an.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ah("UIPadding",{
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
}),
}),
}),
ah("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
ah("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=0.9,
Visible=false,
}),
aq,
ah("UISizeConstraint",{
MaxSize=Vector2.new(an.Width,an.MaxHeight),
}),
}),
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
})

local as=ah("Frame",{
Size=UDim2.new(0,an.Width,0,0),
AutomaticSize="Y",
Parent=al,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
ah("UIScale",{
Scale=0.9,
}),
ar,
af.NewRoundFrame(an.Radius,"Glass-0.7",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,


ThemeTag={
ImageColor3="SearchBarBorder",
ImageTransparency="SearchBarBorderTransparency",
},
Name="Outline",
}),
})

local function CreateSearchTab(at,au,av,aw,ax,ay)
local az=ah("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=aw or nil,
},{
af.NewRoundFrame(an.Radius-11,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main",
},{
af.NewRoundFrame(an.Radius-11,"Glass-1",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Outline",
},{








ah("UIPadding",{
PaddingTop=UDim.new(0,an.Padding-2),
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
PaddingBottom=UDim.new(0,an.Padding-2),
}),
ah("ImageLabel",{
Image=af.Icon(av)[1],
ImageRectSize=af.Icon(av)[2].ImageRectSize,
ImageRectOffset=af.Icon(av)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize),
}),
ah("Frame",{
Size=UDim2.new(1,-an.IconSize-an.Padding,0,0),
BackgroundTransparency=1,
},{
ah("TextLabel",{
Text=at,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title",
}),
ah("TextLabel",{
Text=au or"",
Visible=au and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.3,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc",
})or nil,
ah("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
}),
}),
ah("UIListLayout",{
Padding=UDim.new(0,an.Padding),
FillDirection="Horizontal",
}),
}),
},true),
ah("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-an.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=ax,

},{
af.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
}),
ah("Frame",{
Size=UDim2.new(1,-an.Padding-2,0,0),
Position=UDim2.new(0,an.Padding+2,0,0),
BackgroundTransparency=1,
},{
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right",
}),
})



az.Main.Size=UDim2.new(
1,
0,
0,
az.Main.Outline.Frame.Desc.Visible
and(((an.Padding-2)*2)+az.Main.Outline.Frame.Title.TextBounds.Y+6+az.Main.Outline.Frame.Desc.TextBounds.Y)
or(((an.Padding-2)*2)+az.Main.Outline.Frame.Title.TextBounds.Y)
)

af.AddSignal(az.Main.MouseEnter,function()
aj(az.Main,0.04,{ImageTransparency=0.95}):Play()
aj(az.Main.Outline,0.04,{ImageTransparency=0.75}):Play()
end)
af.AddSignal(az.Main.InputEnded,function()
aj(az.Main,0.08,{ImageTransparency=1}):Play()
aj(az.Main.Outline,0.08,{ImageTransparency=1}):Play()
end)
af.AddSignal(az.Main.MouseButton1Click,function()
if ay then
ay()
end
end)

return az
end

local function ContainsText(at,au)
if not au or au==""then
return false
end

if not at or at==""then
return false
end

local av=string.lower(at)
local aw=string.lower(au)

return string.find(av,aw,1,true)~=nil
end

local function Search(at)
if not at or at==""then
return{}
end

local au={}
for av,aw in next,ak.Tabs do
local ax=ContainsText(aw.Title or"",at)
local ay={}

for az,aA in next,aw.Elements do
if aA.__type~="Section"then
local aB=ContainsText(aA.Title or"",at)
local b=ContainsText(aA.Desc or"",at)

if aB or b then
ay[az]={
Title=aA.Title,
Desc=aA.Desc,
Original=aA,
__type=aA.__type,
Index=az,
}
end
end
end

if ax or next(ay)~=nil then
au[av]={
Tab=aw,
Title=aw.Title,
Icon=aw.Icon,
Elements=ay,
}
end
end
return au
end

af.AddSignal(aq.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

aj(aq,0.06,{
Size=UDim2.new(
1,
0,
0,
math.clamp(
aq.UIListLayout.AbsoluteContentSize.Y+(an.Padding*2),
0,
an.MaxHeight
)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function an.Open(at)
task.spawn(function()
ar.Frame.Visible=true
as.Visible=true
aj(as.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function an.Close(at,au)
task.spawn(function()
am()
ar.Frame.Visible=false
aj(as.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(0.12)
as.Visible=false
if au then
as:Destroy()
end
end)
end

af.AddSignal(ap.TextButton.MouseButton1Click,function()
an:Close(true)
end)

an:Open()

function an.Search(at,au)
au=au or""

local av=Search(au)

aq.Visible=true
ar.Frame.Results.Frame.Visible=true
for aw,ax in next,aq:GetChildren()do
if ax.ClassName~="UIListLayout"and ax.ClassName~="UIPadding"then
ax:Destroy()
end
end

if av and next(av)~=nil then
for aw,ax in next,av do
local ay=an.Icons.Tab
local az=CreateSearchTab(ax.Title,nil,ay,aq,true,function()
an:Close()
ak:SelectTab(aw)
end)
if ax.Elements and next(ax.Elements)~=nil then
for aA,aB in next,ax.Elements do
local b=an.Icons[aB.__type]
CreateSearchTab(
aB.Title,
aB.Desc,
b,
az:FindFirstChild"ParentContainer"and az.ParentContainer.Frame
or nil,
false,
function()
an:Close()
ak:SelectTab(aw)
if ax.Tab.ScrollToTheElement then

ax.Tab:ScrollToTheElement(aB.Index)
end

end
)

end
end
end
elseif au~=""then
ah("TextLabel",{
Size=UDim2.new(1,0,0,70),
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=0.2,
BackgroundTransparency=1,
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Parent=aq,
Name="NotFound",
})
else
aq.Visible=false
ar.Frame.Results.Frame.Visible=false
end
end

af.AddSignal(ao:GetPropertyChangedSignal"Text",function()
an:Search(ao.Text)
end)

return an
end

return ae end function a.ab()



local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ae=aa(game:GetService"UserInputService")
local af=aa(game:GetService"RunService")
local ah=aa(game:GetService"Players")

local aj=workspace.CurrentCamera

local ak=a.load's'

local al=a.load'c'
local am=al.New
local an=al.Tween


local ao=a.load'v'.New
local ap=a.load'l'.New
local aq=a.load'w'.New
local ar=a.load'x'

local as=a.load'y'



return function(at)
local au={
Title=at.Title or"UI Library",
Author=at.Author,
Icon=at.Icon,
IconSize=at.IconSize or 22,
IconThemed=at.IconThemed,
IconRadius=at.IconRadius or 0,
Folder=at.Folder,
Resizable=at.Resizable~=false,
Background=at.Background,
BackgroundImageTransparency=at.BackgroundImageTransparency or 0,
ShadowTransparency=at.ShadowTransparency or 0.6,
User=at.User or{},
Footer=at.Footer or{},
Topbar=at.Topbar or{Height=52,ButtonsType="Default"},

Size=at.Size,

MinSize=at.MinSize or Vector2.new(560,350),
MaxSize=at.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=at.TopBarButtonIconSize,

ToggleKey=at.ToggleKey,
ElementsRadius=at.ElementsRadius,
Radius=at.Radius or 16,
Transparent=at.Transparent or false,
HideSearchBar=at.HideSearchBar~=false,
ScrollBarEnabled=at.ScrollBarEnabled or false,
SideBarWidth=at.SideBarWidth or 200,
Acrylic=at.Acrylic or false,
NewElements=at.NewElements or false,
IgnoreAlerts=at.IgnoreAlerts or false,
HidePanelBackground=at.HidePanelBackground or false,
AutoScale=at.AutoScale~=false,
OpenButton=at.OpenButton,
DragFrameSize=160,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=16,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=at.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=at.Resizable~=false,
IsOpenButtonEnabled=true,

CurrentConfig=nil,
ConfigManager=nil,
AcrylicPaint=nil,
CurrentTab=nil,
TabModule=nil,

OnOpenCallback=nil,
OnCloseCallback=nil,
OnDestroyCallback=nil,

IsPC=false,

Gap=5,

TopBarButtons={},
AllElements={},

ElementConfig={},

PendingFlags={},

IsToggleDragging=false,
}

au.UICorner=au.Radius

au.TopBarButtonIconSize=au.TopBarButtonIconSize or(au.Topbar.ButtonsType=="Mac"and 11 or 16)

au.ElementConfig={
UIPadding=(au.NewElements and 10 or 13),
UICorner=au.ElementsRadius or(au.NewElements and 23 or 12),
}

local av=au.Size or UDim2.new(0,580,0,460)
au.Size=UDim2.new(
av.X.Scale,
math.clamp(av.X.Offset,au.MinSize.X,au.MaxSize.X),
av.Y.Scale,
math.clamp(av.Y.Offset,au.MinSize.Y,au.MaxSize.Y)
)

if au.Topbar=={}then
au.Topbar={Height=52,ButtonsType="Default"}
end

if not af:IsStudio()and au.Folder and writefile then
if not isfolder("WindUI/"..au.Folder)then
makefolder("WindUI/"..au.Folder)
end
if not isfolder("WindUI/"..au.Folder.."/assets")then
makefolder("WindUI/"..au.Folder.."/assets")
end
if not isfolder(au.Folder)then
makefolder(au.Folder)
end
if not isfolder(au.Folder.."/assets")then
makefolder(au.Folder.."/assets")
end
end

local aw=am("UICorner",{
CornerRadius=UDim.new(0,au.UICorner),
})

if au.Folder then
au.ConfigManager=as:Init(au)
end

if au.Acrylic then local
ax=ak.AcrylicPaint{UseAcrylic=au.Acrylic}

au.AcrylicPaint=ax
end

local ax=am("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true,
},{
am("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})
local ay=al.NewRoundFrame(au.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
am("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=al.Icon"expand"[1],
ImageRectOffset=al.Icon"expand"[2].ImageRectPosition,
ImageRectSize=al.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local az=al.NewRoundFrame(au.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})









au.UIElements.SideBar=am("ScrollingFrame",{
Size=UDim2.new(
1,
au.ScrollBarEnabled and-3-(au.UIPadding/2)or 0,
1,
not au.HideSearchBar and-45 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ClipsDescendants=true,
VerticalScrollBarPosition="Left",
},{
am("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
am("UIPadding",{



PaddingBottom=UDim.new(0,au.UIPadding/2),
}),
am("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,au.Gap),
}),
}),
am("UIPadding",{

PaddingLeft=UDim.new(0,au.UIPadding/2),
PaddingRight=UDim.new(0,au.UIPadding/2),

}),

})

au.UIElements.SideBarContainer=am("Frame",{
Size=UDim2.new(
0,
au.SideBarWidth,
1,
au.User.Enabled and-au.Topbar.Height-42-(au.UIPadding*2)or-au.Topbar.Height
),
Position=UDim2.new(0,0,0,au.Topbar.Height),
BackgroundTransparency=1,
Visible=true,
},{
am("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,not au.HideSearchBar and-45-au.UIPadding/2 or 0),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
}),
au.UIElements.SideBar,
})

if au.ScrollBarEnabled then
aq(au.UIElements.SideBar,au.UIElements.SideBarContainer.Content,au,3)
end

au.UIElements.MainBar=am("Frame",{
Size=UDim2.new(1,-au.UIElements.SideBarContainer.AbsoluteSize.X,1,-au.Topbar.Height),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="PanelBackground",
ImageTransparency="PanelBackgroundTransparency",
},


ZIndex=3,
Name="Background",
Visible=not au.HidePanelBackground,
}),
am("UIPadding",{

PaddingLeft=UDim.new(0,au.UIPadding/2),
PaddingRight=UDim.new(0,au.UIPadding/2),
PaddingBottom=UDim.new(0,au.UIPadding/2),
}),
})

local aA=am("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

if ae.TouchEnabled and not ae.KeyboardEnabled then
au.IsPC=false
elseif ae.KeyboardEnabled then
au.IsPC=true
else
au.IsPC=nil
end







local aB
if au.User then
local function GetUserThumb()local
b=ah:GetUserThumbnailAsync(
au.User.Anonymous and 1 or ah.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return b
end

aB=am("TextButton",{
Size=UDim2.new(
0,
au.UIElements.SideBarContainer.AbsoluteSize.X-(au.UIPadding/2),
0,
42+au.UIPadding
),
Position=UDim2.new(0,au.UIPadding/2,1,-(au.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
Visible=au.User.Enabled or false,
},{
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline",
},{
am("UIGradient",{
Rotation=78,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
am("ImageLabel",{
Image=GetUserThumb(),
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=0.93,
},{
am("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
am("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
am("TextLabel",{
Text=au.User.Anonymous and"Anonymous"or ah.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(al.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="DisplayName",
}),
am("TextLabel",{
Text=au.User.Anonymous and"anonymous"or ah.LocalPlayer.Name,
TextSize=15,
TextTransparency=0.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="UserName",
}),
am("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
}),
}),
am("UIListLayout",{
Padding=UDim.new(0,au.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
am("UIPadding",{
PaddingLeft=UDim.new(0,au.UIPadding/2),
PaddingRight=UDim.new(0,au.UIPadding/2),
}),
}),
})

function au.User.Enable(b)
au.User.Enabled=true
an(
au.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,au.SideBarWidth,1,-au.Topbar.Height-42-(au.UIPadding*2))},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aB.Visible=true
end
function au.User.Disable(b)
au.User.Enabled=false
an(
au.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,au.SideBarWidth,1,-au.Topbar.Height)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aB.Visible=false
end
function au.User.SetAnonymous(b,d)
if d~=false then
d=true
end
au.User.Anonymous=d
aB.UserIcon.ImageLabel.Image=GetUserThumb()
aB.UserIcon.Frame.DisplayName.Text=d and"Anonymous"or ah.LocalPlayer.DisplayName
aB.UserIcon.Frame.UserName.Text=d and"anonymous"or ah.LocalPlayer.Name
end

if au.User.Enabled then
au.User:Enable()
else
au.User:Disable()
end

if au.User.Callback then
al.AddSignal(aB.MouseButton1Click,function()
au.User.Callback()
end)
al.AddSignal(aB.MouseEnter,function()
an(aB.UserIcon,0.04,{ImageTransparency=0.95}):Play()
an(aB.Outline,0.04,{ImageTransparency=0.85}):Play()
end)
al.AddSignal(aB.InputEnded,function()
an(aB.UserIcon,0.04,{ImageTransparency=1}):Play()
an(aB.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local b
local d

local f=false
local g

local h=typeof(au.Background)=="string"and string.match(au.Background,"^video:(.+)")or nil
local j=typeof(au.Background)=="string"
and not h
and string.match(au.Background,"^(https?://.+|rbx%w+://.+)")
or nil

local function GetImageExtension(l)
local m=l:match"%.(%w+)$"or l:match"%.(%w+)%?"
if m then
m=m:lower()
if m=="jpg"or m=="jpeg"or m=="png"or m=="webp"then
return"."..m
end
end
return".png"
end

if typeof(au.Background)=="string"and h then
f=true

if string.find(h,"http")then
local l=au.Folder.."/assets/."..al.SanitizeFilename(h)..".webm"
if not isfile(l)then
local m,p=pcall(function()





local m=game.HttpGet and game:HttpGet(h)
writefile(l,m.Body)
end)
if not m then
warn("[ WindUI.Window.Background ] Failed to download video: "..tostring(p))
return
end
end

local m,p=pcall(function()
return getcustomasset(l)
end)
if not m then
warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring(p))
return
end
warn"[ WindUI.Window.Background ] VideoFrame may not work with custom video"
h=p
end

g=am("VideoFrame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=h,
Looped=true,
Volume=0,
},{
am("UICorner",{
CornerRadius=UDim.new(0,au.UICorner),
}),
})
g:Play()
elseif j then
local l=au.Folder
.."/assets/."
..al.SanitizeFilename(j)
..GetImageExtension(j)
if isfile and not isfile(l)then
local m,p=pcall(function()





local m=game.HttpGet and game:HttpGet(j)
writefile(l,m.Body)
end)
if not m then
warn("[ Window.Background ] Failed to download image: "..tostring(p))
return
end
end

local m,p=pcall(function()
return getcustomasset(l)
end)
if not m then
warn("[ Window.Background ] Failed to load custom asset: "..tostring(p))
return
end

g=am("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=p or j,
ImageTransparency=0,
ScaleType="Crop",
},{
am("UICorner",{
CornerRadius=UDim.new(0,au.UICorner),
}),
})
elseif au.Background then
g=am("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=typeof(au.Background)=="string"and au.Background or"",
ImageTransparency=1,
ScaleType="Crop",
},{
am("UICorner",{
CornerRadius=UDim.new(0,au.UICorner),
}),
})
end

local l=al.NewRoundFrame(99,"Squircle",{
ImageTransparency=0.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
am("TextButton",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
Name="Frame",
}),
})

function createAuthor(m)
return am("TextLabel",{
Text=m,
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.35,
AutomaticSize="XY",
Parent=au.UIElements.Main and au.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="WindowTopbarAuthor",
},
Name="Author",
})
end

local m
local p

if au.Author then
m=createAuthor(au.Author)
end

local r=am("TextLabel",{
Text=au.Title,
FontFace=Font.new(al.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="WindowTopbarTitle",
},
})

au.UIElements.Main=am("Frame",{
Size=au.Size,
Position=au.Position,
BackgroundTransparency=1,
Parent=at.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
},{
at.WindUI.UIScaleObj,
au.AcrylicPaint and au.AcrylicPaint.Frame or nil,
aA,
al.NewRoundFrame(au.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,-240),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="WindowBackground",
},

},{
g,
l,
ax,



}),

aw,
ay,
az,
am("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
am("UICorner",{
CornerRadius=UDim.new(0,au.UICorner),
}),
au.UIElements.SideBarContainer,
au.UIElements.MainBar,

aB,

d,
am("Frame",{
Size=UDim2.new(1,0,0,au.Topbar.Height),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar",
},{
b,






am("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left",
},{
am("UIListLayout",{
Padding=UDim.new(0,au.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
am("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
am("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Center",
}),
r,
m,
}),
am("UIPadding",{
PaddingLeft=UDim.new(0,4),
}),
}),
am("ScrollingFrame",{
Name="Center",
BackgroundTransparency=1,
AutomaticSize="Y",
ScrollBarThickness=0,
ScrollingDirection="X",
AutomaticCanvasSize="X",
CanvasSize=UDim2.new(0,0,0,0),
Size=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
Visible=false,
},{
am("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,au.UIPadding/2),
}),
}),
am("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(au.Topbar.ButtonsType=="Default"and 1 or 0,0,0.5,0),
AnchorPoint=Vector2.new(au.Topbar.ButtonsType=="Default"and 1 or 0,0.5),
Name="Right",
},{
am("UIListLayout",{
Padding=UDim.new(0,au.Topbar.ButtonsType=="Default"and 9 or 0),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),
}),
am("UIPadding",{
PaddingTop=UDim.new(0,au.UIPadding),
PaddingLeft=UDim.new(
0,
au.Topbar.ButtonsType=="Default"and au.UIPadding or au.UIPadding-2
),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,au.UIPadding),
}),
}),
}),
})

al.AddSignal(au.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"AbsoluteSize",function()
local u=0
local v=au.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContentSize.X
/at.WindUI.UIScale





u=au.UIElements.Main.Main.Topbar.Left.AbsoluteSize.X/at.WindUI.UIScale
if au.Topbar.ButtonsType~="Default"then
u=u+v+au.UIPadding-4
end



au.UIElements.Main.Main.Topbar.Center.Position=
UDim2.new(0,u+(au.UIPadding/at.WindUI.UIScale),0.5,0)
au.UIElements.Main.Main.Topbar.Center.Size=
UDim2.new(1,-u-v-((au.UIPadding*2)/at.WindUI.UIScale),1,0)
end)

if au.Topbar.ButtonsType~="Default"then
al.AddSignal(au.UIElements.Main.Main.Topbar.Right:GetPropertyChangedSignal"AbsoluteSize",function()
au.UIElements.Main.Main.Topbar.Left.Position=UDim2.new(
0,
(au.UIElements.Main.Main.Topbar.Right.AbsoluteSize.X/at.WindUI.UIScale)+au.UIPadding-4,
0,
0
)
end)
end

function au.CreateTopbarButton(u,v,x,z,A,B,C,F)
local G=al.Image(
x,
x,
0,
au.Folder,
"WindowTopbarIcon",
au.Topbar.ButtonsType=="Default"and true or false,
B,
"WindowTopbarButtonIcon"
)
G.Size=au.Topbar.ButtonsType=="Default"
and UDim2.new(0,F or au.TopBarButtonIconSize,0,F or au.TopBarButtonIconSize)
or UDim2.new(0,0,0,0)
G.AnchorPoint=Vector2.new(0.5,0.5)
G.Position=UDim2.new(0.5,0,0.5,0)
G.ImageLabel.ImageTransparency=au.Topbar.ButtonsType=="Default"and 0 or 1

if au.Topbar.ButtonsType~="Default"then
G.ImageLabel.ImageColor3=al.GetTextColorForHSB(C)
end

local H=al.NewRoundFrame(
au.Topbar.ButtonsType=="Default"and au.UICorner-(au.UIPadding/2)or 999,
"Squircle",
{
Size=au.Topbar.ButtonsType=="Default"
and UDim2.new(0,au.Topbar.Height-16,0,au.Topbar.Height-16)
or UDim2.new(0,14,0,14),
LayoutOrder=A or 999,


ZIndex=9999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageColor3=au.Topbar.ButtonsType~="Default"and(C or Color3.fromHex"#ff3030")or nil,
ThemeTag=au.Topbar.ButtonsType=="Default"and{
ImageColor3="Text",
}or nil,
ImageTransparency=au.Topbar.ButtonsType=="Default"and 1 or 0,
},
{
al.NewRoundFrame(
au.Topbar.ButtonsType=="Default"and au.UICorner-(au.UIPadding/2)or 999,
"Glass-1",
{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=au.Topbar.ButtonsType=="Default"and 1 or 0.5,
Name="Outline",
}
),
G,
am("UIScale",{
Scale=1,
}),
},
true
)

am("Frame",{
Size=au.Topbar.ButtonsType~="Default"and UDim2.new(0,24,0,24)
or UDim2.new(0,au.Topbar.Height-16,0,au.Topbar.Height-16),
BackgroundTransparency=1,
Parent=au.UIElements.Main.Main.Topbar.Right,
LayoutOrder=A or 999,
},{
H,
})



au.TopBarButtons[100-A]={
Name=v,
Object=H,
}

al.AddSignal(H.MouseButton1Click,function()
if z then
z()
end
end)
al.AddSignal(H.MouseEnter,function()
if au.Topbar.ButtonsType=="Default"then
an(H,0.15,{ImageTransparency=0.93}):Play()
an(H.Outline,0.15,{ImageTransparency=0.75}):Play()

else

an(
G.ImageLabel,
0.1,
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
an(G,0.1,{
Size=UDim2.new(
0,
F or au.TopBarButtonIconSize,
0,
F or au.TopBarButtonIconSize
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)

al.AddSignal(H.MouseButton1Down,function()
an(H.UIScale,0.2,{Scale=0.9},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)

al.AddSignal(H.MouseLeave,function()
if au.Topbar.ButtonsType=="Default"then
an(H,0.1,{ImageTransparency=1}):Play()
an(H.Outline,0.1,{ImageTransparency=1}):Play()

else

an(
G.ImageLabel,
0.1,
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
an(
G,
0.1,
{Size=UDim2.new(0,0,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end)

al.AddSignal(H.InputEnded,function()
an(H.UIScale,0.2,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end)

return H
end

function au.Topbar.Button(u,v:{
Name:string,
Icon:string,
Callback:any,
LayoutOrder:number,
IconThemed:boolean,
Color:Color3,
IconSize:number,
})
return au:CreateTopbarButton(
v.Name,
v.Icon,
v.Callback,
v.LayoutOrder or 0,
v.IconThemed,
v.Color,
v.IconSize
)
end



local u=al.Drag(
au.UIElements.Main,
{au.UIElements.Main.Main.Topbar,l.Frame},
function(u,v)
if not au.Closed then
if u and v==l.Frame then
an(l,0.1,{ImageTransparency=0.35}):Play()
else
an(l,0.2,{ImageTransparency=0.8}):Play()
end
au.Position=au.UIElements.Main.Position
au.Dragging=u
end
end
)

if not f and au.Background and typeof(au.Background)=="table"then
local v=am"UIGradient"
for x,z in next,au.Background do
v[x]=z
end

au.UIElements.BackgroundGradient=al.NewRoundFrame(au.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
Parent=au.UIElements.Main.Background,
ImageTransparency=au.Transparent and at.WindUI.TransparencyValue or 0,
},{
v,
})
end














au.OpenButtonMain=a.load'z'.New(au)

task.spawn(function()
if au.Icon then
local v=am("Frame",{
Size=UDim2.new(0,22,0,22),
BackgroundTransparency=1,
Parent=au.UIElements.Main.Main.Topbar.Left,
})

p=al.Image(
au.Icon,
au.Title,
au.IconRadius,
au.Folder,
"Window",
true,
au.IconThemed,
"WindowTopbarIcon"
)
p.Parent=v
p.Size=UDim2.new(0,au.IconSize,0,au.IconSize)
p.Position=UDim2.new(0.5,0,0.5,0)
p.AnchorPoint=Vector2.new(0.5,0.5)

au.OpenButtonMain:SetIcon(au.Icon)











else
au.OpenButtonMain:SetIcon(au.Icon)

end
end)

function au.SetToggleKey(v,x)
au.ToggleKey=x
end

function au.SetTitle(v,x)
au.Title=x
r.Text=x
end

function au.SetAuthor(v,x)
au.Author=x
if not m then
m=createAuthor(au.Author)
end

m.Text=x
end

function au.SetSize(v,x)
if typeof(x)=="UDim2"then
au.Size=x

an(au.UIElements.Main,0.08,{Size=x},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

function au.SetBackgroundImage(v,x)
au.UIElements.Main.Background.ImageLabel.Image=x
end
function au.SetBackgroundImageTransparency(v,x)
if g and g:IsA"ImageLabel"then
g.ImageTransparency=math.floor(x*10+0.5)/10
end
au.BackgroundImageTransparency=math.floor(x*10+0.5)/10
end

function au.SetBackgroundTransparency(v,x)
local z=math.floor(tonumber(x)*10+0.5)/10
at.WindUI.TransparencyValue=z
au:ToggleTransparency(z>0)
end

local v
local x
al.Icon"minimize"
al.Icon"maximize"

au:CreateTopbarButton(
"Fullscreen",
au.Topbar.ButtonsType=="Mac"and"rbxassetid://127426072704909"or"maximize",
function()
au:ToggleFullscreen()
end,
(au.Topbar.ButtonsType=="Default"and 998 or 999),
true,
Color3.fromHex"#60C762",
au.Topbar.ButtonsType=="Mac"and 9 or nil
)

function au.ToggleFullscreen(z)
local A=au.IsFullscreen

u:Set(A)

if not A then
v=au.UIElements.Main.Position
x=au.UIElements.Main.Size

au.CanResize=false
else
if au.Resizable then
au.CanResize=true
end
end

an(
au.UIElements.Main,
0.45,
{Size=A and x or UDim2.new(1,-20,1,-72)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()

an(
au.UIElements.Main,
0.45,
{Position=A and v or UDim2.new(0.5,0,0.5,26)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()



au.IsFullscreen=not A
end

au:CreateTopbarButton("Minimize","minus",function()
au:Close()






















end,(au.Topbar.ButtonsType=="Default"and 997 or 998),nil,Color3.fromHex"#F4C948")

function au.OnOpen(z,A)
au.OnOpenCallback=A
end
function au.OnClose(z,A)
au.OnCloseCallback=A
end
function au.OnDestroy(z,A)
au.OnDestroyCallback=A
end

if at.WindUI.UseAcrylic then
au.AcrylicPaint.AddParent(au.UIElements.Main)
end

function au.SetIconSize(z,A)
local B
if typeof(A)=="number"then
B=UDim2.new(0,A,0,A)
au.IconSize=A
elseif typeof(A)=="UDim2"then
B=A
au.IconSize=A.X.Offset
end

if p then
p.Size=B
end
end

function au.Open(z)
task.spawn(function()
if au.OnOpenCallback then
task.spawn(function()
al.SafeCallback(au.OnOpenCallback)
end)
end

task.wait(0.06)
au.Closed=false

an(au.UIElements.Main.Background,0.2,{
ImageTransparency=au.Transparent and at.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if au.UIElements.BackgroundGradient then
an(au.UIElements.BackgroundGradient,0.2,{
ImageTransparency=0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

an(au.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,0),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

if g then
if g:IsA"VideoFrame"then
g.Visible=true
else
an(g,0.2,{
ImageTransparency=au.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if au.OpenButtonMain and au.IsOpenButtonEnabled then
au.OpenButtonMain:Visible(false)
end


an(
aA,
0.25,
{ImageTransparency=au.ShadowTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
if UIStroke then
an(UIStroke,0.25,{Transparency=0.8},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

task.spawn(function()
task.wait(0.3)
an(
l,
0.45,
{Size=UDim2.new(0,au.DragFrameSize,0,4),ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
u:Set(true)
task.wait(0.45)
if au.Resizable then
an(
ax.ImageLabel,
0.45,
{ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
au.CanResize=true
end
end)

au.CanDropdown=true
au.UIElements.Main.Visible=true
task.spawn(function()
task.wait(0.05)
au.UIElements.Main:WaitForChild"Main".Visible=true

at.WindUI:ToggleAcrylic(true)
end)
end)
end
function au.Close(z)
local A={}

if au.OnCloseCallback then
task.spawn(function()
al.SafeCallback(au.OnCloseCallback)
end)
end

at.WindUI:ToggleAcrylic(false)

if au.UIElements.Main and au.UIElements.Main:WaitForChild"Main"then
au.UIElements.Main.Main.Visible=false
end

au.CanDropdown=false
au.Closed=true

an(au.UIElements.Main.Background,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
if au.UIElements.BackgroundGradient then
an(au.UIElements.BackgroundGradient,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

an(au.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,-240),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()


if g then
if g:IsA"VideoFrame"then
g.Visible=false
else
an(g,0.3,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
an(aA,0.25,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
an(UIStroke,0.25,{Transparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

an(
l,
0.3,
{Size=UDim2.new(0,0,0,4),ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.InOut
):Play()
an(
ax.ImageLabel,
0.3,
{ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
u:Set(false)
au.CanResize=false

task.spawn(function()
task.wait(0.4)
au.UIElements.Main.Visible=false

if au.OpenButtonMain and not au.Destroyed and not au.IsPC and au.IsOpenButtonEnabled then
au.OpenButtonMain:Visible(true)
end
end)

function A.Destroy(B)
task.spawn(function()
if au.OnDestroyCallback then
task.spawn(function()
al.SafeCallback(au.OnDestroyCallback)
end)
end
if au.AcrylicPaint and au.AcrylicPaint.Model then
au.AcrylicPaint.Model:Destroy()
end
au.Destroyed=true
task.wait(0.4)
at.WindUI.ScreenGui:Destroy()
at.WindUI.NotificationGui:Destroy()
at.WindUI.DropdownGui:Destroy()
at.WindUI.TooltipGui:Destroy()

al.DisconnectAll()

return
end)
end

return A
end
function au.Destroy(z)
return au:Close():Destroy()
end
function au.Toggle(z)
if au.Closed then
au:Open()
else
au:Close()
end
end

function au.ToggleTransparency(z,A)

au.Transparent=A
at.WindUI.Transparent=A

au.UIElements.Main.Background.ImageTransparency=A and at.WindUI.TransparencyValue or 0


end

function au.LockAll(z)
for A,B in next,au.AllElements do
if B.Lock then
B:Lock()
end
end
end
function au.UnlockAll(z)
for A,B in next,au.AllElements do
if B.Unlock then
B:Unlock()
end
end
end
function au.GetLocked(z)
local A={}

for B,C in next,au.AllElements do
if C.Locked then
table.insert(A,C)
end
end

return A
end
function au.GetUnlocked(z)
local A={}

for B,C in next,au.AllElements do
if C.Locked==false then
table.insert(A,C)
end
end

return A
end

function au.GetUIScale(z,A)
return at.WindUI.UIScale
end

function au.SetUIScale(z,A)
at.WindUI.UIScale=A
an(at.WindUI.UIScaleObj,0.2,{Scale=A},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return au
end

function au.SetToTheCenter(z)
an(
au.UIElements.Main,
0.45,
{Position=UDim2.new(0.5,0,0.5,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
return au
end

function au.SetCurrentConfig(z,A)
au.CurrentConfig=A
end

do
local z=40
local A=aj.ViewportSize
local B=au.UIElements.Main.AbsoluteSize

if not au.IsFullscreen and au.AutoScale then
local C=A.X-(z*2)
local F=A.Y-(z*2)

local G=C/B.X
local H=F/B.Y

local J=math.min(G,H)

local L=0.3
local M=1.0

local N=math.clamp(J,L,M)

local O=au:GetUIScale()or 1
local P=0.05

if math.abs(N-O)>P then
au:SetUIScale(N)
end
end
end

if au.OpenButtonMain and au.OpenButtonMain.Button then
al.AddSignal(au.OpenButtonMain.Button.TextButton.MouseButton1Click,function()


au:Open()
end)
end

al.AddSignal(ae.InputBegan,function(z,A)
if A then
return
end

if au.ToggleKey then
if z.KeyCode==au.ToggleKey then
au:Toggle()
end
end
end)

task.spawn(function()

au:Open()
end)

function au.EditOpenButton(z,A)
return au.OpenButtonMain:Edit(A)
end

if au.OpenButton and typeof(au.OpenButton)=="table"then
au:EditOpenButton(au.OpenButton)
end

local z=a.load'Y'
local A=a.load'Z'
local B=z.Init(au,at.WindUI,at.WindUI.TooltipGui)
B:OnChange(function(C)
au.CurrentTab=C
end)

au.TabModule=B

function au.Tab(C,F)
F.Parent=au.UIElements.SideBar.Frame
return B.New(F,at.WindUI.UIScale)
end

function au.SelectTab(C,F)
B:SelectTab(F)
end

function au.Section(C,F)
return A.New(
F,
au.UIElements.SideBar.Frame,
au.Folder,
at.WindUI.UIScale,
au
)
end

function au.IsResizable(C,F)
au.Resizable=F
au.CanResize=F
end

function au.SetPanelBackground(C,F)
if typeof(F)=="boolean"then
au.HidePanelBackground=F

au.UIElements.MainBar.Background.Visible=F

if B then
for G,H in next,B.Containers do
H.ScrollingFrame.UIPadding.PaddingTop=UDim.new(0,au.HidePanelBackground and 20 or 10)
H.ScrollingFrame.UIPadding.PaddingLeft=
UDim.new(0,au.HidePanelBackground and 20 or 10)
H.ScrollingFrame.UIPadding.PaddingRight=
UDim.new(0,au.HidePanelBackground and 20 or 10)
H.ScrollingFrame.UIPadding.PaddingBottom=
UDim.new(0,au.HidePanelBackground and 20 or 10)
end
end
end
end

function au.Divider(C)
local F=am("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
})
local G=am("Frame",{
Parent=au.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
F,
})

return G
end

local C=a.load'n'
function au.Dialog(F,G)
local H={
Title=G.Title or"Dialog",
Width=G.Width or 320,
Content=G.Content,
Buttons=G.Buttons or{},

TextPadding=14,
}
local J=C.Create(false,"Dialog",au,at.WindUI,au.UIElements.Main.Main)

J.UIElements.Main.Size=UDim2.new(0,H.Width,0,0)

local L=am("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=J.UIElements.Main,
},{
am("UIListLayout",{
FillDirection="Vertical",

Padding=UDim.new(0,J.UIPadding),
}),
})

local M=am("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=L,
},{
am("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,J.UIPadding),
VerticalAlignment="Center",
}),
am("UIPadding",{
PaddingTop=UDim.new(0,H.TextPadding/2),
PaddingLeft=UDim.new(0,H.TextPadding/2),
PaddingRight=UDim.new(0,H.TextPadding/2),
}),
})

local N
if G.Icon then
N=al.Image(
G.Icon,
H.Title..":"..G.Icon,
0,
au,
"Dialog",
true,
G.IconThemed
)
N.Size=UDim2.new(0,22,0,22)
N.Parent=M
end

J.UIElements.UIListLayout=am("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
VerticalFlex="SpaceBetween",
Parent=J.UIElements.Main,
})

am("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=J.UIElements.Main,
})

J.UIElements.Title=am("TextLabel",{
Text=H.Title,
TextSize=20,
FontFace=Font.new(al.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,N and-26-J.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=M,
})
if H.Content then
am("TextLabel",{
Text=H.Content,
TextSize=18,
TextTransparency=0.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=L,
},{
am("UIPadding",{
PaddingLeft=UDim.new(0,H.TextPadding/2),
PaddingRight=UDim.new(0,H.TextPadding/2),
PaddingBottom=UDim.new(0,H.TextPadding/2),
}),
})
end

local O=am("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Center",
HorizontalFlex="Fill",
})

local P=am("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=J.UIElements.Main,
LayoutOrder=4,
},{
O,






})

local Q={}

for R,S in next,H.Buttons do
local T=
ap(S.Title,S.Icon,S.Callback,S.Variant,P,J,true)
table.insert(Q,T)
T.Size=UDim2.new(1,0,1,0)
end





















































J:Open()

return J
end

local F=false

au:CreateTopbarButton("Close","x",function()
if not F then
if not au.IgnoreAlerts then
F=true

au:Dialog{

Title="Close Window",
Content="Do you want to close this window? You will not be able to open it again.",
Buttons={
{
Title="Cancel",

Callback=function()
F=false
end,
Variant="Secondary",
},
{
Title="Close Window",

Callback=function()
F=false
au:Destroy()
end,
Variant="Primary",
},
},
}
else
au:Destroy()
end
end
end,(au.Topbar.ButtonsType=="Default"and 999 or 997),nil,Color3.fromHex"#F4695F")

function au.Tag(G,H)
if au.UIElements.Main.Main.Topbar.Center.Visible==false then
au.UIElements.Main.Main.Topbar.Center.Visible=true
end
H.Window=au
return ar:New(H,au.UIElements.Main.Main.Topbar.Center)
end

local function startResizing(G)
if au.CanResize then
isResizing=true
ay.Active=true
initialSize=au.UIElements.Main.Size
initialInputPosition=G.Position


an(ax.ImageLabel,0.1,{ImageTransparency=0.35}):Play()

al.AddSignal(G.Changed,function()
if G.UserInputState==Enum.UserInputState.End then
isResizing=false
ay.Active=false


an(ax.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)
end
end

al.AddSignal(ax.InputBegan,function(G)
if
G.UserInputType==Enum.UserInputType.MouseButton1
or G.UserInputType==Enum.UserInputType.Touch
then
if au.CanResize then
startResizing(G)
end
end
end)

al.AddSignal(ae.InputChanged,function(G)
if
G.UserInputType==Enum.UserInputType.MouseMovement
or G.UserInputType==Enum.UserInputType.Touch
then
if isResizing and au.CanResize then
local H=G.Position-initialInputPosition
local J=UDim2.new(0,initialSize.X.Offset+H.X*2,0,initialSize.Y.Offset+H.Y*2)

J=UDim2.new(
J.X.Scale,
math.clamp(J.X.Offset,au.MinSize.X,au.MaxSize.X),
J.Y.Scale,
math.clamp(J.Y.Offset,au.MinSize.Y,au.MaxSize.Y)
)

an(au.UIElements.Main,0.08,{
Size=J,
},Enum.EasingStyle.Quad,Enum.EasingDirection.Out):Play()

au.Size=J
end
end
end)

al.AddSignal(ax.MouseEnter,function()
if not isResizing then
an(ax.ImageLabel,0.1,{ImageTransparency=0.35}):Play()
end
end)
al.AddSignal(ax.MouseLeave,function()
if not isResizing then
an(ax.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)



local G=0
local H=0.4
local J
local L=0

function onDoubleClick()
au:SetToTheCenter()
end

al.AddSignal(l.Frame.MouseButton1Up,function()
local M=tick()
local N=au.Position

L=L+1

if L==1 then
G=M
J=N

task.spawn(function()
task.wait(H)
if L==1 then
L=0
J=nil
end
end)
elseif L==2 then
if M-G<=H and N==J then
onDoubleClick()
end

L=0
J=nil
G=0
else
L=1
G=M
J=N
end
end)



if not au.HideSearchBar then
local M=a.load'aa'
local N=false





















local O=ao("Search","search",au.UIElements.SideBarContainer,true)
O.Size=UDim2.new(1,-au.UIPadding/2,0,39)
O.Position=UDim2.new(0,au.UIPadding/2,0,0)

al.AddSignal(O.MouseButton1Click,function()
if N then
return
end

M.new(au.TabModule,au.UIElements.Main,function()

N=false
if au.Resizable then
au.CanResize=true
end

an(az,0.1,{ImageTransparency=1}):Play()
az.Active=false
end)
an(az,0.1,{ImageTransparency=0.65}):Play()
az.Active=true

N=true
au.CanResize=false
end)
end



function au.DisableTopbarButtons(M,N)
for O,P in next,N do
for Q,R in next,au.TopBarButtons do
if R.Name==P then
R.Object.Visible=false
end
end
end
end



























return au
end end end

local aa={
Window=nil,
Theme=nil,
Creator=a.load'c',
LocalizationModule=a.load'd',
NotificationModule=a.load'e',
Themes=nil,
Transparent=false,

TransparencyValue=0.15,

UIScale=1,

ConfigManager=nil,
Version="0.0.0",

Services=a.load'j',

OnThemeChangeFunction=nil,

cloneref=nil,
UIScaleObj=nil,
}

local ae=(cloneref or clonereference or function(ae)
return ae
end)

aa.cloneref=ae

local af=ae(game:GetService"HttpService")
local ah=ae(game:GetService"Players")
local aj=ae(game:GetService"CoreGui")
local ak=ae(game:GetService"RunService")

local al=ah.LocalPlayer or nil

local am=af:JSONDecode(a.load'k')
if am then
aa.Version=am.version
end

local an=a.load'o'

local ao=aa.Creator

local ap=ao.New




local aq=a.load's'

local ar=protectgui or(syn and syn.protect_gui)or function()end

local as=gethui and gethui()or(aj or al:WaitForChild"PlayerGui")

local at=ap("UIScale",{
Scale=aa.UIScale,
})

aa.UIScaleObj=at

aa.ScreenGui=ap("ScreenGui",{
Name="WindUI",
Parent=as,
IgnoreGuiInset=true,
ScreenInsets="None",
DisplayOrder=-99999,
},{

ap("Folder",{
Name="Window",
}),






ap("Folder",{
Name="KeySystem",
}),
ap("Folder",{
Name="Popups",
}),
ap("Folder",{
Name="ToolTips",
}),
})

aa.NotificationGui=ap("ScreenGui",{
Name="WindUI/Notifications",
Parent=as,
IgnoreGuiInset=true,
})
aa.DropdownGui=ap("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=as,
IgnoreGuiInset=true,
})
aa.TooltipGui=ap("ScreenGui",{
Name="WindUI/Tooltips",
Parent=as,
IgnoreGuiInset=true,
})
ar(aa.ScreenGui)
ar(aa.NotificationGui)
ar(aa.DropdownGui)
ar(aa.TooltipGui)

ao.Init(aa)

function aa.SetParent(au,av)
if aa.ScreenGui then
aa.ScreenGui.Parent=av
end
if aa.NotificationGui then
aa.NotificationGui.Parent=av
end
if aa.DropdownGui then
aa.DropdownGui.Parent=av
end
if aa.TooltipGui then
aa.TooltipGui.Parent=av
end
end
math.clamp(aa.TransparencyValue,0,1)

local au=aa.NotificationModule.Init(aa.NotificationGui)

function aa.Notify(av,aw)
aw.Holder=au.Frame
aw.Window=aa.Window

return aa.NotificationModule.New(aw)
end

function aa.SetNotificationLower(av,aw)
au.SetLower(aw)
end

function aa.SetFont(av,aw)
ao.UpdateFont(aw)
end

function aa.OnThemeChange(av,aw)
aa.OnThemeChangeFunction=aw
end

function aa.AddTheme(av,aw)
aa.Themes[aw.Name]=aw
return aw
end

function aa.SetTheme(av,aw)
if aa.Themes[aw]then
aa.Theme=aa.Themes[aw]
ao.SetTheme(aa.Themes[aw])

if aa.OnThemeChangeFunction then
aa.OnThemeChangeFunction(aw)
end

return aa.Themes[aw]
end
return nil
end

function aa.GetThemes(av)
return aa.Themes
end
function aa.GetCurrentTheme(av)
return aa.Theme.Name
end
function aa.GetTransparency(av)
return aa.Transparent or false
end
function aa.GetWindowSize(av)
return aa.Window.UIElements.Main.Size
end
function aa.Localization(av,aw)
return aa.LocalizationModule:New(aw,ao)
end

function aa.SetLanguage(av,aw)
if ao.Localization then
return ao.SetLanguage(aw)
end
return false
end

function aa.ToggleAcrylic(av,aw)
if aa.Window and aa.Window.AcrylicPaint and aa.Window.AcrylicPaint.Model then
aa.Window.Acrylic=aw
aa.Window.AcrylicPaint.Model.Transparency=aw and 0.98 or 1
if aw then
aq.Enable()
else
aq.Disable()
end
end
end

function aa.Gradient(av,aw,ax)
local ay={}
local az={}

for aA,aB in next,aw do
local b=tonumber(aA)
if b then
b=math.clamp(b/100,0,1)

local d=aB.Color
if typeof(d)=="string"and string.sub(d,1,1)=="#"then
d=Color3.fromHex(d)
end

local f=aB.Transparency or 0

table.insert(ay,ColorSequenceKeypoint.new(b,d))
table.insert(az,NumberSequenceKeypoint.new(b,f))
end
end

table.sort(ay,function(aA,aB)
return aA.Time<aB.Time
end)
table.sort(az,function(aA,aB)
return aA.Time<aB.Time
end)

if#ay<2 then
table.insert(ay,ColorSequenceKeypoint.new(1,ay[1].Value))
table.insert(az,NumberSequenceKeypoint.new(1,az[1].Value))
end

local aA={
Color=ColorSequence.new(ay),
Transparency=NumberSequence.new(az),
}

if ax then
for aB,b in pairs(ax)do
aA[aB]=b
end
end

return aA
end

function aa.Popup(av,aw)
aw.WindUI=aa
return a.load't'.new(aw,aa.ScreenGui.Popups)
end

aa.Themes=a.load'u'(aa,ao)

ao.Themes=aa.Themes

aa:SetTheme"Dark"
aa:SetLanguage(ao.Language)

function aa.CreateWindow(av,aw)
local ax=a.load'ab'

if not ak:IsStudio()and writefile then
if not isfolder"WindUI"then
makefolder"WindUI"
end
if aw.Folder then
makefolder(aw.Folder)
else
makefolder(aw.Title)
end
end

aw.WindUI=aa
aw.Window=aa.Window
aw.Parent=aa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

local ay=true

local az=aa.Themes[aw.Theme or"Dark"]


ao.SetTheme(az)

local aA=gethwid or function()
return ah.LocalPlayer.UserId
end

local aB=aA()

if aw.KeySystem then
ay=false

local function loadKeysystem()
an.new(aw,aB,function(b)
ay=b
end)
end

local b=(aw.Folder or"Temp").."/"..aB..".key"

if aw.KeySystem.KeyValidator then
if aw.KeySystem.SaveKey and isfile(b)then
local d=readfile(b)
local f=aw.KeySystem.KeyValidator(d)

if f then
ay=true
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not aw.KeySystem.API then
if aw.KeySystem.SaveKey and isfile(b)then
local d=readfile(b)
local f=(type(aw.KeySystem.Key)=="table")and table.find(aw.KeySystem.Key,d)
or tostring(aw.KeySystem.Key)==tostring(d)

if f then
ay=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(b)then
local d=readfile(b)
local f=false

for g,h in next,aw.KeySystem.API do
local j=aa.Services[h.Type]
if j then
local l={}
for m,p in next,j.Args do
table.insert(l,h[p])
end

local m=j.New(table.unpack(l))
local p=m.Verify(d)
if p then
f=true
break
end
end
end

ay=f
if not f then
loadKeysystem()
end
else
loadKeysystem()
end
end

repeat
task.wait()
until ay
end

local b=ax(aw)

aa.Transparent=aw.Transparent
aa.Window=b

if aw.Acrylic then
aq.init()
end













return b
end

return aa
WindUI = getgenv().WindUI
-- ====================== GameLoad ======================
repeat task.wait() until game:IsLoaded()

-- ====================== LoadingGui ======================
p = game:GetService("Players").LocalPlayer
pg = p:WaitForChild("PlayerGui")

function waitLoadingGone(maxWait)
    maxWait = tonumber(maxWait) or 18
    local gui = pg:FindFirstChild("LoadingGui")
    if not gui then return true end
    WindUI:Notify({ Title = "初始化", Content = "游戏加载中，请稍候...", Duration = 3, Icon = "download" })
    local startedAt = tick()
    while gui and gui.Parent and tick() - startedAt < maxWait do
        task.wait(0.1)
    end
    if gui and gui.Parent then
        warn("[DYHUB] LoadingGui 未在预期时间内消失，继续运行。")
        return false
    end
    return true
end
waitLoadingGone(18)

WindUI:Notify({ Title = "初始化", Content = "加载完成，2秒后启动", Duration = 2, Icon = "shield-check" })
task.wait(2)

-- ====================== WAITING PART / FPS UNLOCK ======================
DYHUB_WAITING_PART_NAME = "DYHUB_WAITING_PART"
iddyhub = "rbxassetid://104487529937663"
DYHUB_WAITING_STAND_CF = CFrame.new(-23.3435822, 67, 0.341766357)
DYHUB_WAITING_PART_CF = CFrame.new(-23.3435822, 63.95, 0.341766357)
DYHUB_WAITING_PART_SIZE = Vector3.new(16, 1, 16)
DYHUB_WAITING_PART_VISIBLE_TRANSPARENCY = 1

function GetDYHUBWaitingStandCFrame()
    return DYHUB_WAITING_STAND_CF
end

function EnsureDYHUBWaitingPartImages(waitingPart)
    if not waitingPart or not waitingPart:IsA("BasePart") then return end
    local usedFaces = {}
    for _, obj in ipairs(waitingPart:GetChildren()) do
        if obj:IsA("Decal") and obj.Name == "dyhub_image" then
            if usedFaces[obj.Face] then
                obj:Destroy()
            else
                usedFaces[obj.Face] = obj
                obj.Texture = iddyhub
                obj.Transparency = 0
            end
        end
    end
    for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
        if not usedFaces[face] then
            local decal = Instance.new("Decal")
            decal.Name = "dyhub_image"
            decal.Texture = iddyhub
            decal.Face = face
            decal.Transparency = 0
            decal.Parent = waitingPart
        end
    end
end

function ConfigureDYHUBWaitingPart(waitingPart)
    if not waitingPart or not waitingPart:IsA("BasePart") then return nil end
    waitingPart.Name = DYHUB_WAITING_PART_NAME
    waitingPart.Size = DYHUB_WAITING_PART_SIZE
    waitingPart.CFrame = DYHUB_WAITING_PART_CF
    waitingPart.Anchored = true
    waitingPart.CanTouch = false
    waitingPart.CanQuery = false
    waitingPart.CastShadow = false
    waitingPart.Material = Enum.Material.SmoothPlastic
    waitingPart.Color = Color3.fromRGB(45, 130, 255)
    waitingPart.TopSurface = Enum.SurfaceType.Smooth
    waitingPart.BottomSurface = Enum.SurfaceType.Smooth
    local active = AutoFarmEnabled == true
    waitingPart.CanCollide = active
    waitingPart.Transparency = active and DYHUB_WAITING_PART_VISIBLE_TRANSPARENCY or 1
    EnsureDYHUBWaitingPartImages(waitingPart)
    return waitingPart
end

function GetDYHUBWaitingPart()
    local keep = nil
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == DYHUB_WAITING_PART_NAME and obj:IsA("BasePart") then
            if not keep then
                keep = obj
            else
                pcall(function() obj:Destroy() end)
            end
        end
    end
    return keep
end

function DestroyDYHUBWaitingPart()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == DYHUB_WAITING_PART_NAME and obj:IsA("BasePart") then
            pcall(function() obj:Destroy() end)
        end
    end
end

function EnsureDYHUBWaitingPart()
    local waitingPart = GetDYHUBWaitingPart()
    if not waitingPart then
        waitingPart = Instance.new("Part")
        waitingPart.Name = DYHUB_WAITING_PART_NAME
        waitingPart.Parent = workspace
    end
    return ConfigureDYHUBWaitingPart(waitingPart)
end

if setfpscap then
    setfpscap(240)
    WindUI:Notify({ Title = "服务", Content = "FPS 已解锁 | " .. ver, Duration = 3, Icon = "cpu" })
    warn("FPS 已解锁!")
else
    WindUI:Notify({ Title = "不支持", Content = "您的执行器不支持 setfpscap.", Duration = 3, Icon = "ban" })
end

-- ====================== CUSTOM CONFIG SYSTEM ======================
HttpService = game:GetService("HttpService")
ConfigFolder = "DYHUB_STBB"

CustomConfig = {}
CustomConfig.__index = CustomConfig

function CustomConfig.new()
    local self = setmetatable({}, CustomConfig)
    self.ConfigData = {}
    self.ConfigPath = ConfigFolder .. "/STBB_config.json"
    if isfolder and makefolder and not isfolder(ConfigFolder) then
        pcall(function() makefolder(ConfigFolder) end)
    end
    self:Load()
    return self
end

function CustomConfig:Set(key, value) self.ConfigData[key] = value end

function CustomConfig:Get(key, default)
    if self.ConfigData[key] ~= nil then return self.ConfigData[key] end
    return default
end

function CustomConfig:Save(force)
    if not writefile then return false end
    local now = tick()
    if not force and self._LastSaveAt and now - self._LastSaveAt < 0.75 then
        if not self._SaveQueued then
            self._SaveQueued = true
            task.delay(0.85, function()
                self._SaveQueued = false
                self:Save(true)
            end)
        end
        return true
    end
    local success, err = pcall(function()
        writefile(self.ConfigPath, HttpService:JSONEncode(self.ConfigData))
    end)
    if success then
        self._LastSaveAt = now
        return true
    else
        warn("[DYHUB] 保存失败:", err)
        return false
    end
end

function CustomConfig:Load()
    if isfile and readfile and isfile(self.ConfigPath) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(self.ConfigPath))
        end)
        if success and type(result) == "table" then
            self.ConfigData = result
        else
            warn("[DYHUB] 加载配置失败，使用默认值")
            self.ConfigData = {}
        end
    else
        self.ConfigData = {}
    end
end

function CustomConfig:AutoSave(interval)
    if self._AutoSaveThread then
        pcall(function() task.cancel(self._AutoSaveThread) end)
        self._AutoSaveThread = nil
    end
    self._AutoSaveThread = task.spawn(function()
        while true do
            task.wait(interval or 15)
            self:Save()
        end
    end)
end

Config = CustomConfig.new()

-- ====================== 多语言系统 ======================
local currentLanguage = Config:Get("Language", "Chinese")
local translations = {
    Chinese = {
        loading = "游戏加载中...", loaded = "加载完成，3秒后启动",
        auto_farm = "自动挂机", auto_farm_desc = "根据优先级自动刷怪",
        farm_enabled = "已开启", farm_disabled = "已关闭",
        sync_mode = "同步挂机模式", sync_desc = "辅助功能需自动挂机开启",
        sync_on = "需自动挂机", sync_off = "辅助功能独立",
        position_above = "上方", position_under = "下方",
        auto_attack = "自动攻击", auto_skill = "自动技能",
        auto_ready = "自动开局", auto_skip_heli = "自动跳过直升机",
        auto_heal = "自动补血", safe_mode = "安全模式",
        god_mode = "上帝模式", delete_map = "删除地图",
        flush_aura = "冲水光环", flush_range = "冲水范围",
        attack_speed = "攻击速度", skill_delay = "技能延迟",
        height_offset = "挂机高度偏移", safe_hp = "安全模式血量",
        god_hp = "上帝模式血量", high_hp_threshold = "高血量阈值",
        esp_enable = "启用透视", esp_mob = "怪物透视",
        esp_player = "玩家透视", esp_item = "物品透视",
        esp_highlight = "高亮", esp_distance = "距离",
        esp_health = "血量", esp_name = "名称",
        farm_settings = "挂机设置", general_settings = "通用设置",
        priority_settings = "优先级设置", override_settings = "覆写设置",
        flush_settings = "冲水设置", risky_features = "高风险功能",
        esp_visual = "透视视觉", esp_settings = "透视设置",
        local_player = "本地玩家", redeem_codes = "兑换码",
        unlock_gamepass = "解锁游戏通行证", shop_weapon = "商店武器",
        shop_misc = "商店道具", batch_section = "批量购买",
        batch_gacha_section = "批量抽卡", collect_section = "物品收集",
        collect_settings = "收集设置", vote_system = "投票系统",
        mode_switch = "模式切换", astro_params = "天文币刷取参数",
        auto_game_mode = "自动游戏模式（大厅）", extra_auto = "自动化额外",
        visual_section = "视觉效果", server_status = "服务器状态",
        others = "其他", save_settings = "保存配置",
        reset_wave = "重置波次", reset_wave_val = "重置波次值",
        bypass_jeffrey = "绕过 Jeffrey", anti_jeffrey = "反 Jeffrey",
        anti_jeffrey_range = "反 Jeffrey 范围",
        camera_mode = "相机模式", combat_debug = "战斗调试",
        anti_afk = "防挂机", bypass_barrier = "绕过边界",
        farm_astro = "农场 Astro", farm_astro_desc = "避免怪物，时间结束时前往中心",
        mode_farm = "农场模式", movement_farm = "移动模式",
        position_farm = "挂机位置", misc_farm = "辅助功能",
        skill_keys = "技能按键", serverhop = "切换服务器",
        rejoin = "重新加入", save_config = "保存配置",
        auto_save = "自动保存", delay_save = "保存间隔",
        reset_positions = "重置已确认位置",
        padding_reduce = "递减步长", padding_safe = "最小安全高度",
        anti_clip_margin = "防卡墙边距", dmg_threshold = "伤害阈值",
        select_weapon = "选择武器", buy_weapon = "购买武器",
        buy_weapon_once = "购买武器（一次）", select_misc = "选择道具",
        buy_misc = "购买道具", buy_misc_once = "购买道具（一次）",
        select_request = "选择请求", auto_request = "自动请求",
        skill_tree = "技能树", auto_skill_tree = "自动技能树",
        select_upgrade_titan = "选择 Titan Speaker 升级",
        upgrade_titan = "升级 Titan Speaker",
        select_upgrade_utcm = "选择 UTCM 升级",
        upgrade_utcm = "升级 UTCM",
        select_upgrade_tv = "选择 TV 升级",
        upgrade_tv = "升级 TV",
        gacha_character = "抽角色", gacha_skin = "抽皮肤",
        auto_gacha_character = "自动抽角色", auto_gacha_skin = "自动抽皮肤",
        use_item = "使用物品", auto_use_item = "自动使用物品",
        shop_hourly = "商店每小时", select_shop_hourly = "选择每小时物品",
        item_amount = "物品数量", buy_item = "购买物品",
        redeem_selected = "兑换选中", redeem_all = "兑换所有",
        unlock_selected = "解锁选中",
        vote_info = "投票信息", vote_mode = "投票模式",
        restore_vote = "恢复投票系统", set_vote_mode = "设置投票模式",
        auto_vote_ig = "自动投票（局内）",
        casual_info = "休闲信息", game_mode = "游戏模式",
        set_game_mode = "设置游戏模式", auto_game_mode_lobby = "自动游戏模式（大厅）",
        info_update = "更新: 2026/06/02", info_desc = "• [新增] 重置波次...",
        info_title = "至尊版", info_desc2 = "去后门·无付费墙·全功能",
        walkspeed = "移动速度", jumppower = "跳跃高度",
        lock_movement = "锁定移动属性", no_clip = "穿墙",
        fly = "飞行", fly_speed = "飞行速度",
        infinite_jump = "无限跳跃", full_bright = "全亮",
        no_fog = "去雾",
    },
    English = {
        loading = "Loading game...", loaded = "Loaded, starting in 3s",
        auto_farm = "Auto Farm", auto_farm_desc = "Priority-based auto farm",
        farm_enabled = "Enabled", farm_disabled = "Disabled",
        sync_mode = "Sync Farm Mode", sync_desc = "Aux functions need auto farm",
        sync_on = "Need auto farm", sync_off = "Aux functions independent",
        position_above = "Above", position_under = "Under",
        auto_attack = "Auto Attack", auto_skill = "Auto Skill",
        auto_ready = "Auto Start", auto_skip_heli = "Auto Skip Heli",
        auto_heal = "Auto Heal", safe_mode = "Safe Mode",
        god_mode = "God Mode", delete_map = "Delete Map",
        flush_aura = "Flush Aura", flush_range = "Flush Range",
        attack_speed = "Attack Speed", skill_delay = "Skill Delay",
        height_offset = "Height Offset", safe_hp = "Safe HP",
        god_hp = "God HP", high_hp_threshold = "High HP Threshold",
        esp_enable = "Enable ESP", esp_mob = "Mob ESP",
        esp_player = "Player ESP", esp_item = "Item ESP",
        esp_highlight = "Highlight", esp_distance = "Distance",
        esp_health = "Health", esp_name = "Name",
        farm_settings = "Farm Settings", general_settings = "General Settings",
        priority_settings = "Priority Settings", override_settings = "Override Settings",
        flush_settings = "Flush Settings", risky_features = "Risky Features",
        esp_visual = "ESP Visual", esp_settings = "ESP Settings",
        local_player = "Local Player", redeem_codes = "Redeem Codes",
        unlock_gamepass = "Unlock Gamepass", shop_weapon = "Shop Weapon",
        shop_misc = "Shop Misc", batch_section = "Batch Buy",
        batch_gacha_section = "Batch Gacha", collect_section = "Collect Item",
        collect_settings = "Collect Settings", vote_system = "Vote System",
        mode_switch = "Mode Switch", astro_params = "Astro Coin Farm Parameters",
        auto_game_mode = "Auto Game Mode (Lobby)", extra_auto = "Extra Automation",
        visual_section = "Visual Effects", server_status = "Server Status",
        others = "Others", save_settings = "Save Config",
        reset_wave = "Reset Wave", reset_wave_val = "Reset Wave Value",
        bypass_jeffrey = "Bypass Jeffrey", anti_jeffrey = "Anti Jeffrey",
        anti_jeffrey_range = "Anti Jeffrey Range",
        camera_mode = "Camera Mode", combat_debug = "Combat Debug",
        anti_afk = "Anti AFK", bypass_barrier = "Bypass Barrier",
        farm_astro = "Farm Astro", farm_astro_desc = "Avoid monsters, go to center when time ends",
        mode_farm = "Mode Farm", movement_farm = "Movement Farm",
        position_farm = "Position Farm", misc_farm = "Misc Farm",
        skill_keys = "Skill Keys", serverhop = "Serverhop",
        rejoin = "Rejoin", save_config = "Save Config",
        auto_save = "Auto Save", delay_save = "Save Delay",
        reset_positions = "Reset Confirmed Positions",
        padding_reduce = "Padding Reduce", padding_safe = "Safe Padding Min",
        anti_clip_margin = "Anti-Clip Margin", dmg_threshold = "Damage Threshold",
        select_weapon = "Select Weapon", buy_weapon = "Buy Weapon",
        buy_weapon_once = "Buy Weapon (Once)", select_misc = "Select Misc",
        buy_misc = "Buy Misc", buy_misc_once = "Buy Misc (Once)",
        select_request = "Select Request", auto_request = "Auto Request",
        skill_tree = "Skill Tree", auto_skill_tree = "Auto Skill Tree",
        select_upgrade_titan = "Select Titan Speaker Upgrade",
        upgrade_titan = "Upgrade Titan Speaker",
        select_upgrade_utcm = "Select UTCM Upgrade",
        upgrade_utcm = "Upgrade UTCM",
        select_upgrade_tv = "Select TV Upgrade",
        upgrade_tv = "Upgrade TV",
        gacha_character = "Gacha Character", gacha_skin = "Gacha Skin",
        auto_gacha_character = "Auto Gacha Character", auto_gacha_skin = "Auto Gacha Skin",
        use_item = "Use Item", auto_use_item = "Auto Use Item",
        shop_hourly = "Shop Hourly", select_shop_hourly = "Select Shop Hourly",
        item_amount = "Item Amount", buy_item = "Buy Item",
        redeem_selected = "Redeem Selected", redeem_all = "Redeem All",
        unlock_selected = "Unlock Selected",
        vote_info = "Vote Information", vote_mode = "Vote Mode",
        restore_vote = "Restore Vote System", set_vote_mode = "Set Vote Mode",
        auto_vote_ig = "Auto Vote (In-Game)",
        casual_info = "Casual Information", game_mode = "Game Mode",
        set_game_mode = "Set Game Mode", auto_game_mode_lobby = "Auto Game Mode (Lobby)",
        info_update = "Update: 06/02/2026", info_desc = "• [ Added ] Reset Wave...",
        info_title = "Premium Edition", info_desc2 = "No backdoor · No paywall · Full features",
        walkspeed = "Walk Speed", jumppower = "Jump Power",
        lock_movement = "Lock Movement", no_clip = "No Clip",
        fly = "Fly", fly_speed = "Fly Speed",
        infinite_jump = "Infinite Jump", full_bright = "Full Bright",
        no_fog = "No Fog",
    },
}

getgenv().DYHUB_T = function(key)
    return (translations[currentLanguage] and translations[currentLanguage][key]) or key
end
local function T(key)
    return getgenv().DYHUB_T(key)
end

-- ====================== WINDOW 2 ======================
Players = game:GetService("Players")
userversion = "至尊版"

-- ====================== WINDOW ======================
Window = WindUI:CreateWindow({
    Title = "DYHUB",
    IconThemed = true,
    Icon = "rbxassetid://104487529937663",
    Author = "STBB | " .. userversion,
    Folder = "DYHUB",
    Size = UDim2.fromOffset(550, 380),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.8,
    HasOutline = false,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = { Enabled = true, Anonymous = false },
})

Window:SetToggleKey(Enum.KeyCode.K)
Window:Tag({ Title = version, Color = Color3.fromHex("#db7093") })
Window:EditOpenButton({
    Title = "DYHUB - 打开",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255)),
    Draggable = true
})

-- ====================== TABS ======================
Info   = Window:Tab({ Title = "信息", Icon = "info" })
MainDivider  = Window:Divider()
Main   = Window:Tab({ Title = T("auto_farm"), Icon = "rocket" })
Main4  = Window:Tab({ Title = T("esp_enable"), Icon = "eye" })
Main2  = Window:Tab({ Title = T("local_player"), Icon = "user" })
MainDivider1 = Window:Divider()
Main5  = Window:Tab({ Title = "商店", Icon = "shopping-cart" })
Main6  = Window:Tab({ Title = T("collect_section"), Icon = "hand" })
Main7  = Window:Tab({ Title = T("game_mode"), Icon = "gamepad-2" })
MainDivider2 = Window:Divider()
Main3  = Window:Tab({ Title = "设置", Icon = "settings" })
Window:SelectTab(1)

-- ======================== INFO ========================
Info:Section({ Title = "最近更新", TextXAlignment = "Center", TextSize = 17 })
Info:Divider()
Info:Paragraph({
    Title = T("info_update"),
    Desc = T("info_desc"),
    Image = "rbxassetid://104487529937663",
    ImageSize = 30,
})
Info:Divider()
Info:Section({ Title = "DYHUB 信息", TextXAlignment = "Center", TextSize = 17 })
Info:Divider()
Info:Paragraph({ Title = T("info_title"), Desc = T("info_desc2"), Image = "rbxassetid://104487529937663", ImageSize = 30 })
-- ====================== SERVICES ======================
TweenService        = game:GetService("TweenService")
ReplicatedStorage   = game:GetService("ReplicatedStorage")
ReplicatedFirst     = game:GetService("ReplicatedFirst")
VirtualInputManager = game:GetService("VirtualInputManager")
RunService          = game:GetService("RunService")
UserInputService    = game:GetService("UserInputService")
Lighting            = game:GetService("Lighting")

-- ====================== PLAYER ======================
LocalPlayer    = Players.LocalPlayer
Client         = LocalPlayer
Character      = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ====================== GLOBAL TABLES ======================
GlobalTables = {
    redeemCodes = { "100MVisit2", "100MVisit1", "CamArmada", "CCTVBase", "ADelayedGameIsEventuallyGoodButRushedGameIsForeverBad" },
    Weapon   = { "Stungun", "Flamethrower", "Harpoon Gun", "Shot Gun", "Pulse Rifle", "Shot Harpoon Gun", "EPD", "Small Laser Gun" },
    MiscShop = { "HeadPhone", "Grenade", "Jetpack", "Lens" },
    RequestTitanSpeaker = { "Titan-Request", "SpecialTitan-Request", "Speaker-Request" },
    Gamepasst = { "All", "LuckyBoost", "RareLuckyBoost", "LegendaryLuckyBoost" },
    Gamepassts = {},
    Mode = { "Normal", "VeryHard", "Hard", "Insane", "Nightmare", "BossRush", "DarkDimension", "Hell", "ThunderStorm", "Christmas", "Zombie", "AstroV2", "Astro", "100MVisit" },
}

-- ====================== CONFIG VARIABLES ======================
skillList          = { "Q", "E", "R", "T", "Y", "G", "H", "Z", "X", "C", "V", "B", "U" }
skillDropdownValues = { "All", "Q", "E", "R", "T", "Y", "G", "H", "Z", "X", "C", "V", "B", "U" }

-- ====================== FARM HELPERS ======================
function NormalizeFarmMode(mode)
    mode = tostring(mode or "Tween")
    if mode == "tp" or mode == "Tp" or mode == "tp1" then
        return "Teleport"
    end
    if mode ~= "Teleport" and mode ~= "Tween" then
        return "Tween"
    end
    return mode
end

function NormalizeFarmTargetMode(mode)
    mode = tostring(mode or "Normal Mode")
    if mode ~= "Normal Mode" and mode ~= "Astro Holdout Mode" and mode ~= "Dark Dimension Mode" then
        return "Normal Mode"
    end
    return mode
end

function NormalizeCollectMovement(mode)
    mode = tostring(mode or "Tween")
    if mode ~= "Teleport" and mode ~= "Tween" then
        return "Tween"
    end
    return mode
end

-- ====================== CAMERA MODE HELPERS ======================
function NormalizeCameraMode(mode)
    mode = tostring(mode or "Manual")
    if mode == "Manuel" or mode:lower() == "manual" then
        return "Manual"
    end
    if mode:lower() == "classic" then
        return "Classic"
    end
    return "Manual"
end

-- ====================== STATE VARIABLES ======================
AutoFarmEnabled        = Config:Get("AutoFarmEnabled", false)
FarmPosition           = Config:Get("FarmPosition", "Above")
FarmMode               = NormalizeFarmMode(Config:Get("FarmMode", "Tween"))
FarmTargetMode         = NormalizeFarmTargetMode(Config:Get("FarmTargetMode", "Normal Mode"))
DarkDimensionCollecting = false
DarkDimensionLowValue   = 0.900
DarkDimensionSafeValue  = 0.950
DarkDimensionLastWarnAt = 0
DarkDimensionCollectToken = 0
DarkDimensionOrbSearchCooldown = 0
DarkDimensionJeffreyAvoidRange = 70
JeffreyTargetBlockUntil = {}
JeffreyLastUnsafeTargetAt = 0
JeffreySafeHoldUntil = 0
JeffreySafeRetargetDelay = 0.85
AntiJeffreyEnabled     = Config:Get("AntiJeffreyEnabled", false)
AntiJeffreyRange       = Config:Get("AntiJeffreyRange", 50)
BypassJeffreyEnabled   = Config:Get("BypassJeffreyEnabled", false)
BypassJeffreyLoopRunning = false
BypassJeffreyLastFullScanAt = 0
BypassJeffreyFullScanDelay = 3
AntiJeffreyLoopRunning = false
AntiJeffreyGuardLoopRunning = false
AntiJeffreyLastPushAt  = 0
JeffreyCacheList       = {}
JeffreyCacheAt         = 0
JeffreyCacheTTL        = 0.55
AntiJeffreyEscapeBusy  = false
AntiJeffreyLastEscapeAt = 0
AntiJeffreyEscapeCooldown = 0.32
AntiJeffreyEscapeStep  = 70
AntiJeffreyDangerRange = 20
AntiJeffreyKillZoneRange = 5
AntiJeffreyHardEscapeStep = 70
AntiJeffreyCriticalEscapeStep = 90
AntiJeffreyEscapePauseUntil = 0
AntiJeffreyForceRetargetUntil = 0
AstroModeDoorTopCF      = CFrame.new(-23.3435822, 67, 0.341766357)
AstroModeDoorBottomCF   = CFrame.new(-23.3435822, 3, 0.341766357)
AstroModeFinalRunning   = false
AstroModeLastFinalAt    = 0
MiscOptions            = Config:Get("MiscOptions", {})
SyncFarmOnly           = Config:Get("SyncFarmOnly", true)
FarmAstroTokenEnabled  = Config:Get("FarmAstroTokenEnabled", false)
FarmAstroTokenRunning  = false
FarmAstroTokenPart     = nil
FarmAstroTokenTween    = nil
FarmAstroTokenNoClipConnection = nil
FarmAstroTokenPauseCollect = false
FarmAstroTokenLastCleanNotify = 0
FarmAstroTokenLastAutoFarmNotify = 0
FarmAstroTokenTimerHold = false
FarmAstroTokenTimerIgnoreUntil = 0
FarmAstroTokenRespawnCounter = 0
FarmAstroGodModePaused = false
FarmAstroReviveGodTriggered = false
FarmAstroFinalLockActive = false
FarmAstroTimerDropping = false
FarmAstroBottomGodTriggered = false
FarmAstroWaveTimerArmed = false
FarmAstroLastWaveTimer = nil
FarmAstroReviveTimerArmed = false
FarmAstroLastReviveTimer = nil
AutoAttackEnabled      = false
AutoSkillEnabled       = false
AutoSkipHeliEnabled    = false
BoostFPS_Active_dummy  = false
AutoStartEnabled       = Config:Get("AutoStartEnabled", table.find(MiscOptions, "Auto Start") ~= nil)
AutoVoteinGameEnabled = Config:Get("AutoVoteinGameEnabled", false)
AutoVoteValue         = Config:Get("AutoVoteValue", "Christmas")
AutoVoteLoopRunning   = false
AutoVoteLastFireAt    = 0
AutoStartLastReadyAt  = 0
AutoFillUpEnabled      = false
SelectedSkills         = Config:Get("SelectedSkills", { "All" })
SafeModeEnabled        = false
SafeValue              = Config:Get("SafeValue", 50)
GodModeEnabled         = false
GodModeValue           = Config:Get("GodModeValue", 50)
GodModeTriggered       = false
ResetWaveEnabled       = false
ResetWaveValue         = Config:Get("ResetWaveValue", 10)
ResetWaveLoopRunning   = false
ResetWaveTeleporting   = false
ResetWaveTargetCF      = CFrame.new(1250, 500, 1250)
ResetWaveHoldTime      = 2
ResetWaveToken         = 0
ResetWaveLastTriggeredWave = nil
ResetWaveLastTriggeredKey  = nil
ResetWaveLastTeleportAt = 0
WaitingRespawn         = false
IdlePosition           = GetDYHUBWaitingStandCFrame() * CFrame.Angles(math.rad(0), 0, 0)
IdleHoldDistance       = 12
IdleTeleportCooldown   = 1.25
LastIdleTeleportAt     = 0
IdlePositionReached    = false
SkillDelay             = Config:Get("SkillDelay", 1)
LoopDelay              = 0.5
TweenSpeed             = 1
HeightValue            = Config:Get("HeightValue", 3)
NeedNoClip             = false
LockActive             = false
AutoStartConnection    = nil
noBarrierConnection    = nil
noBarrierActive        = Config:Get("NoBarrier", false)
CameraMode             = NormalizeCameraMode(Config:Get("CameraMode", "Manual"))
if Config:Get("CameraMode", "Manual") ~= CameraMode then
    Config:Set("CameraMode", CameraMode)
end
FarmLoopRunning        = false
AutoAttackLoopRunning  = false
AutoSkillLoopRunning   = false
FarmForceRetarget      = false
FarmCollecting         = false
CombatDebugEnabled     = Config:Get("CombatDebugEnabled", false)
CombatDebugCooldowns   = {}

function UpdateDYHUBWaitingPartCollision()
    if AutoFarmEnabled ~= true then
        if DestroyDYHUBWaitingPart then DestroyDYHUBWaitingPart() end
        part = nil
        return
    end
    local waitingPart = EnsureDYHUBWaitingPart and EnsureDYHUBWaitingPart() or GetDYHUBWaitingPart()
    if not waitingPart then return end
    part = waitingPart
    pcall(function()
        ConfigureDYHUBWaitingPart(waitingPart)
    end)
end

UpdateDYHUBWaitingPartCollision()

workspace.ChildRemoved:Connect(function(obj)
    if obj and obj.Name == DYHUB_WAITING_PART_NAME and AutoFarmEnabled == true then
        task.defer(function()
            UpdateDYHUBWaitingPartCollision()
        end)
    end
end)

function CombatDebug(tag, message, cooldown, showNotify)
    if not CombatDebugEnabled then return end
    cooldown = cooldown or 3
    local now = tick()
    local key = tostring(tag or "Debug")
    if CombatDebugCooldowns[key] and now - CombatDebugCooldowns[key] < cooldown then return end
    CombatDebugCooldowns[key] = now
    local text = "[DYHUB][" .. key .. "] " .. tostring(message or "")
    print(text)
    if showNotify and WindUI then
        pcall(function()
            WindUI:Notify({
                Title = "战斗调试",
                Content = tostring(message or ""),
                Duration = 3,
                Icon = "bug"
            })
        end)
    end
end

function IsMiscFarmAllowed()
    if FarmAstroTokenEnabled and SyncFarmOnly then return false end
    return AutoFarmEnabled or not SyncFarmOnly
end

function StopMiscFarmRuntime(reason)
    AutoAttackEnabled = false
    AutoSkillEnabled = false
    AutoSkipHeliEnabled = false
    AutoFillUpEnabled = false
    SafeModeEnabled = false
    GodModeEnabled = false
    ResetWaveEnabled = false
    ResetWaveTeleporting = false
    ResetWaveToken = (ResetWaveToken or 0) + 1
    ResetWaveLastTriggeredWave = nil
    ResetWaveLastTriggeredKey = nil
    FillUpRunning = false
    if AutoStartEnabled then
        StopAutoStart()
    end
    pcall(function() TriggerAutoSkipHeli(false) end)
    if BoostFPS_Active then
        RestoreBoostFPS()
    end
    CombatDebug("MiscGate", "辅助功能运行时已停止: " .. tostring(reason or "同步门"), 3)
end

function ApplyMiscFarmGate(reason)
    if SyncFarmOnly and not AutoFarmEnabled then
        StopMiscFarmRuntime(reason or "自动挂机已关闭")
        return false
    end
    HandleMiscOptions(MiscOptions)
    return true
end

CameraLastApplyAt = 0
CameraApplyCooldown = 0.22
CameraSyncToken = 0

function GetCameraTargetForMode(char)
    if not char or not char.Parent then return nil, nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid")
    if CameraMode == "Classic" then
        return char:FindFirstChild("Head") or humanoid or char:FindFirstChild("HumanoidRootPart"), humanoid
    end
    return humanoid or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head"), humanoid
end

function ApplyCameraMode(force)
    local now = tick()
    if force ~= true and now - (CameraLastApplyAt or 0) < (CameraApplyCooldown or 0.22) then return end
    CameraLastApplyAt = now
    pcall(function()
        local cam = workspace.CurrentCamera
        local char = LocalPlayer.Character or Character
        if not cam or not char then return end
        CameraMode = NormalizeCameraMode(CameraMode)
        local target, humanoid = GetCameraTargetForMode(char)
        if not target then return end
        if humanoid and not AutoFarmEnabled and not LockActive and not FarmCollecting then
            humanoid.AutoRotate = true
        end
        if cam.CameraType ~= Enum.CameraType.Custom then
            cam.CameraType = Enum.CameraType.Custom
        end
        if cam.CameraSubject ~= target then
            cam.CameraSubject = target
        end
    end)
end

function RequestCameraSync(force)
    CameraSyncToken = (CameraSyncToken or 0) + 1
    local token = CameraSyncToken
    task.delay(force and 0 or 0.05, function()
        if token == CameraSyncToken then
            ApplyCameraMode(force == true)
        end
    end)
end

LastFarmCameraStabilize = 0

function StabilizeFarmCamera()
    local now = tick()
    if now - (LastFarmCameraStabilize or 0) < 0.35 then return end
    LastFarmCameraStabilize = now
    if AutoFarmEnabled then
        ApplyCameraMode(false)
    end
end

function RestoreFarmCameraAndMovement()
    pcall(function()
        local char = LocalPlayer.Character or Character
        local humanoid = char and (char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid"))
        if humanoid then humanoid.AutoRotate = true end
        ApplyCameraMode(true)
    end)
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    RequestCameraSync(true)
end)

MissingRemoteWarnAt = {}

function GetRemote(name)
    local remote = ReplicatedStorage and ReplicatedStorage:FindFirstChild(name)
    if not remote then
        local now = tick()
        if not MissingRemoteWarnAt[name] or now - MissingRemoteWarnAt[name] >= 10 then
            MissingRemoteWarnAt[name] = now
            warn("[DYHUB] 缺少远程事件: " .. tostring(name))
        end
        return nil
    end
    return remote
end

-- ====================== AUTO VOTE CORE / AUTO START SYNC ======================
function GetVoteUIFrame()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    local voteGui = playerGui:FindFirstChild("OpenVoteUI")
    if not voteGui then return nil end
    return voteGui:FindFirstChild("OPEN UI")
end

function IsVoteUIOpen()
    local frame = GetVoteUIFrame()
    return frame and frame.Visible == true
end

function HideVoteUI()
    local frame = GetVoteUIFrame()
    if frame then
        pcall(function() frame.Visible = false end)
    end
end

function FireAutoVote(force)
    if not force and not IsVoteUIOpen() then return false end
    local now = tick()
    if now - AutoVoteLastFireAt < 0.25 then return false end
    AutoVoteLastFireAt = now
    local remote = GetRemote("Vote")
    if not remote then
        pcall(function() remote = ReplicatedStorage:WaitForChild("Vote", 3) end)
    end
    if not remote then return false end
    local ok, err = pcall(function()
        remote:FireServer(AutoVoteValue)
    end)
    if ok then
        HideVoteUI()
        print("[DYHUB] 自动投票已触发:", tostring(AutoVoteValue))
        return true
    else
        warn("[DYHUB] 自动投票失败:", err)
        return false
    end
end

function StartAutoVoteLoop()
    if AutoVoteLoopRunning then return end
    AutoVoteLoopRunning = true
    task.spawn(function()
        while AutoVoteinGameEnabled do
            if IsVoteUIOpen() then
                if AutoStartEnabled and IsMiscFarmAllowed() then
                    FireGetReady(0)
                else
                    FireAutoVote(false)
                end
            end
            task.wait(0.2)
        end
        AutoVoteLoopRunning = false
    end)
end
-- ====================== NEW PRIORITY SYSTEM CONFIG ======================
HighHPThreshold        = Config:Get("HighHPThreshold", 200)
_currentTargetPriority = 0
_interruptSignal       = false

VirtualUser = game:GetService("VirtualUser")
AntiAFK = Config:Get("AntiAfk", true)

AutoBuyWeaponEnabled   = Config:Get("AutoBuyWeaponEnabled", false)
AutoBuyMiscEnabled     = Config:Get("AutoBuyMiscEnabled", false)
SelectedWeapon         = Config:Get("SelectedWeapon", "Stungun")
SelectedMiscItem       = Config:Get("SelectedMiscItem", "HeadPhone")

-- ====================== FILL UP PART CONFIG ======================
FILLUP_PART_PATH   = { "HelicopterShop", "ShopXDD", "PartForShop" }
FILLUP_TARGET_POS  = Vector3.new(44.2756729, 26.3595276, -32.7318268)
FILLUP_POS_THRESHOLD = 0.5
FillUpRunning = false

function GetFillUpPart()
    local obj = workspace
    for _, key in ipairs(FILLUP_PART_PATH) do
        obj = obj:FindFirstChild(key)
        if not obj then return nil end
    end
    return obj
end

function IsFillUpPartReady()
    local p = GetFillUpPart()
    if not p then return false end
    return (p.CFrame.Position - FILLUP_TARGET_POS).Magnitude < FILLUP_POS_THRESHOLD
end

-- ====================== ALLY SYSTEM ======================
AllyNames = {
    ["Heavy Soldier Toilet V2"]  = true,
    ["Quad Laser Toilet"]        = true,
    ["Strider Rocket Laser"]     = true,
    ["Helicopter Camera"]        = true,
    ["Heavy Soldier Toilet V1"]  = true,
    ["Rocket Heli v2"]           = true,
    ["Gunner Camera man"]        = true,
    ["Attack Helicopter"]        = true,
    ["Swat Mutant"]              = true,
    ["Huge DJ Toilet"]           = true,
}

function IsAlly(mob)
    return AllyNames[mob.Name] ~= nil
end

-- ====================== TP SYSTEM ======================
function tp(pu79)
    pcall(function()
        if not pu79 or not pu79.Target then return end
        local v80 = Client and Client.Character
        if not v80 then return end
        local hum = v80:FindFirstChildOfClass("Humanoid") or v80:FindFirstChild("Humanoid")
        local hrp = v80:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if hum and hum.Sit == true then hum.Sit = false end
        NeedNoClip = true
        hrp.CFrame = pu79.Target * (pu79.Mod or CFrame.new(0, 0, 0))
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

function Tp(p82)
    pcall(function()
        if not p82 then return end
        local char = Client and Client.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if hum and hum.Sit == true then hum.Sit = false end
        for _, v86 in ipairs(char:GetDescendants()) do
            if v86:IsA("BasePart") then v86.CanCollide = false end
        end
        if not hrp:FindFirstChild("BodyClip") then
            local v87 = Instance.new("BodyVelocity")
            v87.Parent = hrp
            v87.Name = "BodyClip"
            v87.Velocity = Vector3.new(0, 0, 0)
            v87.MaxForce = Vector3.new(5, math.huge, 5)
        end
        hrp.CFrame = p82
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

function tp1(p89)
    local v90 = game.Players.LocalPlayer
    if v90 and v90.Character and v90.Character:FindFirstChild("HumanoidRootPart") then
        v90.Character:FindFirstChild("HumanoidRootPart").CFrame = p89
    else
        warn("玩家角色或 HumanoidRootPart 未找到!")
    end
end

-- ====================== UTILITY FUNCTIONS ======================
function IsValidMob(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        if Players:GetPlayerFromCharacter(obj) then return false end
        if IsAlly(obj) then return false end
        local humanoid = obj:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then return true end
    end
    return false
end

function IsMobDead(mob)
    if not mob or not mob.Parent then return true end
    local humanoid = mob:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return true end
    return false
end

function GetObjectRootPart(obj)
    if not obj or not obj.Parent then return nil end
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then
        return obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    return nil
end

function IsJeffreyName(name)
    local n = tostring(name or ""):lower()
    return n == "jeffrey" or n == "jeffery"
end

function IsValidJeffreyObject(obj)
    if not obj or not IsJeffreyName(obj.Name) then return false end
    if obj:IsA("Model") then
        local hum = obj:FindFirstChildOfClass("Humanoid") or obj:FindFirstChild("Humanoid")
        if hum and hum.Health <= 0 then return false end
        return GetObjectRootPart(obj) ~= nil
    end
    return obj:IsA("BasePart") and obj.Parent ~= nil
end

function AddJeffreyRootFromObject(obj, list, seen)
    if obj and IsJeffreyName(obj.Name) and IsValidJeffreyObject(obj) then
        local root = GetObjectRootPart(obj)
        if root and not seen[root] then
            seen[root] = true
            table.insert(list, root)
        end
    end
end

function GetJeffreyRoots(forceRefresh)
    local now = tick()
    if not forceRefresh and now - JeffreyCacheAt <= JeffreyCacheTTL then return JeffreyCacheList end
    local list, seen = {}, {}
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            AddJeffreyRootFromObject(obj, list, seen)
        end
        local living = workspace:FindFirstChild("Living")
        if living then
            for _, obj in ipairs(living:GetDescendants()) do
                AddJeffreyRootFromObject(obj, list, seen)
            end
        end
        if #list == 0 then
            for _, obj in ipairs(workspace:GetDescendants()) do
                AddJeffreyRootFromObject(obj, list, seen)
            end
        end
    end)
    JeffreyCacheList = list
    JeffreyCacheAt = now
    return JeffreyCacheList
end

function GetNearestJeffreyRoot(pos, range, forceRefresh)
    if not pos then return nil, math.huge end
    local best, bestDist = nil, math.huge
    for _, root in ipairs(GetJeffreyRoots(forceRefresh == true)) do
        if root and root.Parent then
            local dist = (root.Position - pos).Magnitude
            if dist < bestDist then
                best = root
                bestDist = dist
            end
        end
    end
    if range and bestDist > range then return nil, bestDist end
    return best, bestDist
end

function IsJeffreyNearPosition(pos, range, forceRefresh)
    local root = GetNearestJeffreyRoot(pos, range or AntiJeffreyRange, forceRefresh == true)
    return root ~= nil
end

function GetMobRootPart(mob)
    if not mob or not mob.Parent then return nil end
    return mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart or mob:FindFirstChildWhichIsA("BasePart", true)
end

function IsMobBlockedByJeffrey(mob, range)
    if not mob or not mob.Parent then return true end
    if IsJeffreyName(mob.Name) or IsMobTemporarilyBlocked(mob) then return true end
    local root = GetMobRootPart(mob)
    if not root then return true end
    range = math.max(range or DarkDimensionJeffreyAvoidRange, 65)
    if IsPositionBlockedByJeffrey(root.Position, range, false) then
        MarkMobUnsafeByJeffrey(mob, 2.5)
        return true
    end
    local cf = nil
    pcall(function() cf = GetTargetCFrame(mob, FarmPosition) end)
    if cf and IsPositionBlockedByJeffrey(cf.Position, range, false) then
        MarkMobUnsafeByJeffrey(mob, 2.5)
        return true
    end
    return false
end

function IsFarmJeffreyAvoidActive()
    if FarmTargetMode == "Dark Dimension Mode" then return AutoFarmEnabled == true end
    if FarmTargetMode == "Normal Mode" then return AutoFarmEnabled == true and AntiJeffreyEnabled == true end
    return false
end

function GetFarmJeffreyAvoidRange()
    if AntiJeffreyEnabled then return AntiJeffreyRange end
    return DarkDimensionJeffreyAvoidRange
end

function IsAntiJeffreyEscapePauseActive()
    return tick() < (AntiJeffreyEscapePauseUntil or 0)
end

function BreakFarmLockForJeffrey(reason, pauseTime)
    pauseTime = pauseTime or 0.35
    AntiJeffreyEscapePauseUntil = math.max(AntiJeffreyEscapePauseUntil or 0, tick() + pauseTime)
    AntiJeffreyForceRetargetUntil = math.max(AntiJeffreyForceRetargetUntil or 0, tick() + pauseTime + 0.2)
    FarmForceRetarget = true
    LockActive = false
    _interruptSignal = true
    WaitingRespawn = false
    pcall(function()
        RefreshCombatCharacter()
        if Character then
            local humanoid = Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Sit = false
                humanoid.AutoRotate = false
            end
        end
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    task.delay(pauseTime + 0.25, function()
        if tick() >= (AntiJeffreyForceRetargetUntil or 0) and not FarmCollecting and not DarkDimensionCollecting then
            FarmForceRetarget = false
            _interruptSignal = false
        end
    end)
end

function GetMinJeffreyDistanceAt(pos, forceRefresh)
    local minDist = math.huge
    for _, root in ipairs(GetJeffreyRoots(forceRefresh == true)) do
        if root and root.Parent then
            local d = (root.Position - pos).Magnitude
            if d < minDist then minDist = d end
        end
    end
    return minDist
end

function GetHorizontalDistance(a, b)
    if not a or not b then return math.huge end
    local dx = a.X - b.X
    local dz = a.Z - b.Z
    return math.sqrt(dx * dx + dz * dz)
end

function GetMinJeffreyHorizontalDistanceAt(pos, forceRefresh)
    local minDist = math.huge
    for _, root in ipairs(GetJeffreyRoots(forceRefresh == true)) do
        if root and root.Parent then
            local d = GetHorizontalDistance(root.Position, pos)
            if d < minDist then minDist = d end
        end
    end
    return minDist
end

function IsPositionBlockedByJeffrey(pos, range, forceRefresh)
    if not pos then return true end
    range = range or GetFarmJeffreyAvoidRange()
    return GetMinJeffreyHorizontalDistanceAt(pos, forceRefresh == true) <= range
end

function MarkMobUnsafeByJeffrey(mob, duration)
    if not mob then return end
    JeffreyTargetBlockUntil[mob] = tick() + (duration or 2.5)
    JeffreyLastUnsafeTargetAt = tick()
end

function IsMobTemporarilyBlocked(mob)
    if not mob then return true end
    local untilTime = JeffreyTargetBlockUntil[mob]
    if untilTime and tick() < untilTime then return true end
    if untilTime then JeffreyTargetBlockUntil[mob] = nil end
    return false
end

function HasAnyJeffreyRoot()
    local roots = GetJeffreyRoots(false)
    return roots and #roots > 0
end

function GetFarmTargetDangerRange()
    local base = GetFarmJeffreyAvoidRange and GetFarmJeffreyAvoidRange() or 50
    return math.max(base, DarkDimensionJeffreyAvoidRange or 70, 65)
end

function IsFarmTargetSafeFromJeffrey(mob, forceRefresh)
    if not IsFarmJeffreyAvoidActive or not IsFarmJeffreyAvoidActive() then return true end
    if not mob or not mob.Parent then return false end
    if IsJeffreyName(mob.Name) or IsMobTemporarilyBlocked(mob) then return false end
    local root = GetMobRootPart(mob)
    if not root then return false end
    local range = GetFarmTargetDangerRange()
    if IsPositionBlockedByJeffrey(root.Position, range, forceRefresh == true) then
        MarkMobUnsafeByJeffrey(mob, 2.5)
        return false
    end
    local cf = nil
    pcall(function() cf = GetTargetCFrame(mob, FarmPosition) end)
    if cf and IsPositionBlockedByJeffrey(cf.Position, range, forceRefresh == true) then
        MarkMobUnsafeByJeffrey(mob, 2.5)
        return false
    end
    return true
end

-- ============================================================
-- =============== BARRIER SAFE ESCAPE SYSTEM ==================
BarrierCacheParts = {}
BarrierCacheAt = 0
BarrierCacheTTL = 1.25
BarrierBoundsCache = nil
BarrierBoundsAt = 0
BarrierInsetPadding = 8
BarrierRayPadding = 7

function GetMapBarrierModel()
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    return map:FindFirstChild("Barrier")
end

function GetBarrierParts(forceRefresh)
    local now = tick()
    if not forceRefresh and now - (BarrierCacheAt or 0) <= (BarrierCacheTTL or 1.25) then
        return BarrierCacheParts or {}
    end
    local parts = {}
    local model = GetMapBarrierModel()
    if model then
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("BasePart") then
                table.insert(parts, obj)
            end
        end
        if model:IsA("BasePart") then
            table.insert(parts, model)
        end
    end
    BarrierCacheParts = parts
    BarrierCacheAt = now
    BarrierBoundsCache = nil
    return BarrierCacheParts
end

function AddBarrierCornerToBounds(pos, bounds)
    if not pos then return end
    if pos.X < bounds.minX then bounds.minX = pos.X end
    if pos.X > bounds.maxX then bounds.maxX = pos.X end
    if pos.Z < bounds.minZ then bounds.minZ = pos.Z end
    if pos.Z > bounds.maxZ then bounds.maxZ = pos.Z end
end

function GetBarrierBounds(forceRefresh)
    local now = tick()
    if not forceRefresh and BarrierBoundsCache and now - (BarrierBoundsAt or 0) <= (BarrierCacheTTL or 1.25) then
        return BarrierBoundsCache
    end
    local parts = GetBarrierParts(forceRefresh == true)
    if not parts or #parts == 0 then
        BarrierBoundsCache = nil
        return nil
    end
    local bounds = { minX = math.huge, maxX = -math.huge, minZ = math.huge, maxZ = -math.huge }
    for _, part in ipairs(parts) do
        if part and part.Parent and part:IsA("BasePart") then
            local sx, sy, sz = part.Size.X * 0.5, part.Size.Y * 0.5, part.Size.Z * 0.5
            local xs = { -sx, sx }
            local ys = { -sy, sy }
            local zs = { -sz, sz }
            for _, x in ipairs(xs) do
                for _, y in ipairs(ys) do
                    for _, z in ipairs(zs) do
                        AddBarrierCornerToBounds((part.CFrame * CFrame.new(x, y, z)).Position, bounds)
                    end
                end
            end
        end
    end
    if bounds.minX == math.huge or bounds.maxX == -math.huge or bounds.minZ == math.huge or bounds.maxZ == -math.huge then
        BarrierBoundsCache = nil
        return nil
    end
    BarrierBoundsCache = bounds
    BarrierBoundsAt = now
    return BarrierBoundsCache
end

function ClampValue(v, mn, mx)
    if mn > mx then
        local mid = (mn + mx) * 0.5
        return mid
    end
    if v < mn then return mn end
    if v > mx then return mx end
    return v
end

function ClampPositionInsideBarrier(pos, padding, forceRefresh)
    if not pos then return nil, false end
    local bounds = GetBarrierBounds(forceRefresh == true)
    if not bounds then return pos, false end
    padding = padding or BarrierInsetPadding or 8
    local minX, maxX = bounds.minX + padding, bounds.maxX - padding
    local minZ, maxZ = bounds.minZ + padding, bounds.maxZ - padding
    local x = ClampValue(pos.X, minX, maxX)
    local z = ClampValue(pos.Z, minZ, maxZ)
    local clamped = Vector3.new(x, pos.Y, z)
    return clamped, (math.abs(x - pos.X) > 0.05 or math.abs(z - pos.Z) > 0.05)
end

function IsPositionInsideBarrier(pos, padding, forceRefresh)
    if not pos then return false end
    local bounds = GetBarrierBounds(forceRefresh == true)
    if not bounds then return true end
    padding = padding or BarrierInsetPadding or 8
    return pos.X >= bounds.minX + padding and pos.X <= bounds.maxX - padding
        and pos.Z >= bounds.minZ + padding and pos.Z <= bounds.maxZ - padding
end

function RaycastBarrierPath(fromPos, toPos, forceRefresh)
    if not fromPos or not toPos then return nil end
    local parts = GetBarrierParts(forceRefresh == true)
    if not parts or #parts == 0 then return nil end
    local direction = toPos - fromPos
    if direction.Magnitude <= 0.1 then return nil end
    local params = RaycastParams.new()
    pcall(function() params.FilterType = Enum.RaycastFilterType.Include end)
    if tostring(params.FilterType):find("Include") == nil then
        pcall(function() params.FilterType = Enum.RaycastFilterType.Whitelist end)
    end
    params.FilterDescendantsInstances = parts
    params.IgnoreWater = true
    local ok, result = pcall(function()
        return workspace:Raycast(fromPos, direction, params)
    end)
    if ok then return result end
    return nil
end

function GetBarrierSafeEscapePosition(fromPos, wantedPos, forceRefresh)
    if not fromPos or not wantedPos then return nil, false end
    local adjusted = false
    local safePos, wasClamped = ClampPositionInsideBarrier(wantedPos, BarrierInsetPadding, forceRefresh == true)
    if wasClamped then adjusted = true end
    local hit = RaycastBarrierPath(fromPos, safePos, forceRefresh == true)
    if hit and hit.Position then
        local dir = safePos - fromPos
        if dir.Magnitude > 0.1 then
            safePos = hit.Position - dir.Unit * (BarrierRayPadding or 7)
            adjusted = true
        end
    end
    local safePos2, wasClamped2 = ClampPositionInsideBarrier(safePos, BarrierInsetPadding, false)
    if wasClamped2 then adjusted = true end
    safePos = safePos2
    if not IsPositionInsideBarrier(safePos, BarrierInsetPadding, false) then
        safePos = ClampPositionInsideBarrier(fromPos, BarrierInsetPadding, false)
        adjusted = true
    end
    return safePos, adjusted
end

workspace.DescendantAdded:Connect(function(obj)
    if obj and obj:IsA("BasePart") and obj.Name == "Barrier" then
        BarrierCacheAt = 0
        BarrierBoundsCache = nil
    end
end)

workspace.DescendantRemoving:Connect(function(obj)
    if obj and obj:IsA("BasePart") and obj.Name == "Barrier" then
        BarrierCacheAt = 0
        BarrierBoundsCache = nil
    end
end)

function MoveToJeffreySafeHold(reason)
    if not HasAnyJeffreyRoot() then return false end
    BreakFarmLockForJeffrey(reason or "Jeffrey 安全保持", 0.55)
    local cf = GetBestJeffreyEscapeCFrame(math.max(AntiJeffreyHardEscapeStep or 70, 85), true)
    if not cf then return false end
    JeffreySafeHoldUntil = tick() + 0.7
    return MoveFarmSpecialCFrame(cf, 0.18)
end

function ValidateFarmTargetBeforeMove(mob, reason)
    if IsFarmTargetSafeFromJeffrey(mob, true) then return true end
    BreakFarmLockForJeffrey(reason or "目标不安全,靠近 Jeffrey", 0.55)
    MoveToJeffreySafeHold(reason or "目标不安全")
    return false
end

function GetBestJeffreyEscapeCFrame(step, forceRefresh)
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then return nil end
    step = step or AntiJeffreyHardEscapeStep or 70
    local base = HumanoidRootPart.Position
    local look = HumanoidRootPart.CFrame.LookVector
    local dirs = {
        Vector3.new(1,0,0), Vector3.new(-1,0,0), Vector3.new(0,0,1), Vector3.new(0,0,-1),
        Vector3.new(1,0,1), Vector3.new(1,0,-1), Vector3.new(-1,0,1), Vector3.new(-1,0,-1),
    }
    local steps = { step, step * 0.75, step * 0.5, step * 0.32 }
    local bestPos, bestScore = nil, -math.huge
    for _, tryStep in ipairs(steps) do
        for _, dir in ipairs(dirs) do
            local unit = dir.Unit
            local wanted = Vector3.new(base.X + unit.X * tryStep, base.Y, base.Z + unit.Z * tryStep)
            local pos, adjusted = GetBarrierSafeEscapePosition(base, wanted, forceRefresh == true)
            if pos then
                local moveDist = (pos - base).Magnitude
                if moveDist >= 2 then
                    local score = GetMinJeffreyHorizontalDistanceAt(pos, forceRefresh == true) + math.min(moveDist, step) * 0.03
                    if adjusted then score = score - 6 end
                    if score > bestScore then
                        bestScore = score
                        bestPos = pos
                    end
                end
            end
        end
    end
    if not bestPos then
        bestPos = ClampPositionInsideBarrier(base, BarrierInsetPadding, true)
    end
    if not bestPos then return nil end
    return CFrame.new(bestPos, bestPos + look)
end

function GetJeffreyEscapeCFrame(range, step, forceRefresh)
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then return nil end
    range = range or GetFarmJeffreyAvoidRange()
    step = step or AntiJeffreyEscapeStep or 70
    local jeffrey = GetNearestJeffreyRoot(HumanoidRootPart.Position, range, forceRefresh == true)
    if not jeffrey then return nil end
    return GetBestJeffreyEscapeCFrame(step, forceRefresh == true)
end

function MoveAwayFromJeffrey(range, step, tweenTime, forceCritical)
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then return false end
    range = range or GetFarmJeffreyAvoidRange()
    local scanRange = math.max(range, AntiJeffreyDangerRange or 20)
    local jeffrey, dist = GetNearestJeffreyRoot(HumanoidRootPart.Position, scanRange, forceCritical == true)
    if not jeffrey then return false end
    local now = tick()
    local isKillZone = dist <= (AntiJeffreyKillZoneRange or 5)
    local isDanger = dist <= (AntiJeffreyDangerRange or 20)
    if AntiJeffreyEscapeBusy and not isKillZone then return true end
    if not isKillZone and now - AntiJeffreyLastEscapeAt < AntiJeffreyEscapeCooldown then return true end
    if isKillZone then
        step = math.max(step or 0, AntiJeffreyCriticalEscapeStep or 90)
        tweenTime = 0.08
    elseif isDanger then
        step = math.max(step or 0, AntiJeffreyHardEscapeStep or 70)
        tweenTime = tweenTime or 0.16
    else
        step = math.max(step or 0, AntiJeffreyEscapeStep or 70)
        tweenTime = tweenTime or 0.28
    end
    local cf = GetBestJeffreyEscapeCFrame(step, true)
    if not cf then return false end
    AntiJeffreyEscapeBusy = true
    AntiJeffreyLastEscapeAt = now
    BreakFarmLockForJeffrey("Jeffrey 逃跑", isKillZone and 0.65 or 0.45)
    local ok = false
    if MoveFarmSpecialCFrame then
        ok = MoveFarmSpecialCFrame(cf, tweenTime)
    else
        pcall(function() Character:PivotTo(cf) end)
        ok = true
    end
    task.wait(0.03)
    pcall(function()
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    AntiJeffreyEscapeBusy = false
    return ok
end

function HandleFarmJeffreyEmergency(mob)
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then return false end
    local active = IsFarmJeffreyAvoidActive()
    if not active and not AntiJeffreyEnabled then return false end
    local range = math.max(GetFarmJeffreyAvoidRange(), DarkDimensionJeffreyAvoidRange or 70, AntiJeffreyDangerRange or 20)
    local scanRange = math.max(range, AntiJeffreyDangerRange or 20)
    local jeffrey, dist = GetNearestJeffreyRoot(HumanoidRootPart.Position, scanRange, true)
    if jeffrey and dist <= (AntiJeffreyKillZoneRange or 5) then
        MoveAwayFromJeffrey(scanRange, AntiJeffreyCriticalEscapeStep, 0.08, true)
        return true
    end
    if jeffrey and dist <= (AntiJeffreyDangerRange or 20) then
        MoveAwayFromJeffrey(scanRange, AntiJeffreyHardEscapeStep, 0.16, true)
        return true
    end
    if active and mob and not IsFarmTargetSafeFromJeffrey(mob, true) then
        MarkMobUnsafeByJeffrey(mob, 3)
        BreakFarmLockForJeffrey("目标被 Jeffrey 阻挡", 0.55)
        MoveToJeffreySafeHold("目标被 Jeffrey 阻挡")
        return true
    end
    if active and not mob and HasAnyJeffreyRoot() and tick() < (JeffreySafeHoldUntil or 0) then
        BreakFarmLockForJeffrey("Jeffrey 安全保持等待", 0.35)
        return true
    end
    if active and not mob and HasAnyJeffreyRoot() and tick() - (JeffreyLastUnsafeTargetAt or 0) <= 2 then
        MoveToJeffreySafeHold("附近所有目标都不安全")
        return true
    end
    if active and not mob and jeffrey and dist <= range then
        MoveAwayFromJeffrey(scanRange, AntiJeffreyHardEscapeStep, 0.22, true)
        return true
    end
    return false
end

function ShouldFarmRetargetFromJeffrey(mob)
    return HandleFarmJeffreyEmergency(mob)
end

function ShouldDarkDimensionRetargetFromJeffrey(mob)
    return HandleFarmJeffreyEmergency(mob)
end

function PushAwayFromJeffrey()
    if not AntiJeffreyEnabled then return false end
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then return false end
    local jeffrey, dist = GetNearestJeffreyRoot(HumanoidRootPart.Position, math.max(AntiJeffreyRange, AntiJeffreyDangerRange or 20), false)
    if not jeffrey then return false end
    local now = tick()
    if dist > (AntiJeffreyDangerRange or 20) and now - AntiJeffreyLastPushAt < 0.25 then return true end
    AntiJeffreyLastPushAt = now
    if dist <= (AntiJeffreyDangerRange or 20) or AutoFarmEnabled then
        return MoveAwayFromJeffrey(math.max(AntiJeffreyRange, AntiJeffreyDangerRange or 20), AntiJeffreyHardEscapeStep, 0.16, dist <= 20)
    end
    local pushSize = math.clamp(((AntiJeffreyRange - dist) / math.max(AntiJeffreyRange, 1)) * 18, 5, 28)
    local targetCF = GetBestJeffreyEscapeCFrame(pushSize, false)
    if not targetCF then return false end
    if MoveFarmSpecialCFrame then
        return MoveFarmSpecialCFrame(targetCF, 0.18)
    end
    pcall(function()
        Character:PivotTo(targetCF)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    end)
    return true
end

function StartAntiJeffreyLoop()
    if AntiJeffreyLoopRunning then return end
    AntiJeffreyLoopRunning = true
    task.spawn(function()
        while AntiJeffreyEnabled do
            pcall(PushAwayFromJeffrey)
            task.wait(0.18)
        end
        AntiJeffreyLoopRunning = false
    end)
end

function IsJeffreyGuardActive()
    return (AutoFarmEnabled == true and IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive()) or AntiJeffreyEnabled == true
end

function StartJeffreyGuardLoop()
    if AntiJeffreyGuardLoopRunning then return end
    AntiJeffreyGuardLoopRunning = true
    task.spawn(function()
        while AutoFarmEnabled or AntiJeffreyEnabled do
            if IsJeffreyGuardActive() then
                pcall(function()
                    RefreshCombatCharacter()
                    if Character and HumanoidRootPart then
                        local range = math.max(GetFarmJeffreyAvoidRange and GetFarmJeffreyAvoidRange() or 50, AntiJeffreyDangerRange or 20)
                        local root, dist = GetNearestJeffreyRoot(HumanoidRootPart.Position, range, true)
                        if root and dist <= (AntiJeffreyDangerRange or 20) then
                            HandleFarmJeffreyEmergency(nil)
                        elseif AntiJeffreyEnabled and root and dist <= AntiJeffreyRange then
                            PushAwayFromJeffrey()
                        end
                    end
                end)
            end
            task.wait(IsAntiJeffreyEscapePauseActive() and 0.08 or 0.16)
        end
        AntiJeffreyGuardLoopRunning = false
    end)
end
-- ============================================================
-- ====================== BYPASS JEFFREY ======================
function GetBypassJeffreyObject(obj)
    if not obj then return nil end
    if IsJeffreyName(obj.Name) then return obj end
    local cur = obj.Parent
    while cur and cur ~= workspace do
        if IsJeffreyName(cur.Name) then return cur end
        cur = cur.Parent
    end
    return nil
end

function SetBypassJeffreySit(jeffrey)
    if not BypassJeffreyEnabled then return false end
    if not jeffrey or not jeffrey.Parent then return false end
    local target = GetBypassJeffreyObject(jeffrey)
    if not target or not target.Parent then return false end
    local notHumanoid = nil
    pcall(function()
        notHumanoid = target:FindFirstChild("NotHumanoid") or target:FindFirstChild("NotHumanoid", true)
    end)
    if not notHumanoid then return false end
    local ok = pcall(function()
        if notHumanoid.Sit ~= true then
            notHumanoid.Sit = true
        end
    end)
    return ok
end

function ScanBypassJeffreys(forceFullScan)
    if not BypassJeffreyEnabled then return 0 end
    local count = 0
    local seen = {}
    local function try(obj)
        local target = GetBypassJeffreyObject(obj)
        if target and not seen[target] then
            seen[target] = true
            if SetBypassJeffreySit(target) then
                count = count + 1
            end
        end
    end
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if IsJeffreyName(obj.Name) then try(obj) end
        end
        local living = workspace:FindFirstChild("Living")
        if living then
            for _, obj in ipairs(living:GetChildren()) do
                if IsJeffreyName(obj.Name) then try(obj) end
            end
            for _, obj in ipairs(living:GetDescendants()) do
                if obj.Name == "NotHumanoid" then try(obj) end
            end
        end
        local now = tick()
        if forceFullScan or now - (BypassJeffreyLastFullScanAt or 0) >= (BypassJeffreyFullScanDelay or 3) then
            BypassJeffreyLastFullScanAt = now
            for _, obj in ipairs(workspace:GetDescendants()) do
                if IsJeffreyName(obj.Name) or obj.Name == "NotHumanoid" then
                    try(obj)
                end
            end
        end
    end)
    return count
end

function StartBypassJeffreyLoop()
    if BypassJeffreyLoopRunning then return end
    BypassJeffreyLoopRunning = true
    task.spawn(function()
        while BypassJeffreyEnabled do
            pcall(function()
                ScanBypassJeffreys(false)
            end)
            task.wait(0.75)
        end
        BypassJeffreyLoopRunning = false
    end)
end

function HandleBypassJeffreyObject(obj)
    if not BypassJeffreyEnabled or not obj then return end
    if IsJeffreyName(obj.Name) or obj.Name == "NotHumanoid" or GetBypassJeffreyObject(obj) then
        task.defer(function()
            if BypassJeffreyEnabled then
                SetBypassJeffreySit(obj)
                task.wait(0.15)
                SetBypassJeffreySit(obj)
            end
        end)
    end
end

workspace.DescendantAdded:Connect(function(obj)
    if obj and IsJeffreyName(obj.Name) then
        JeffreyCacheAt = 0
        HandleBypassJeffreyObject(obj)
        if IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive() then
            FarmForceRetarget = true
            task.delay(0.25, function()
                if not IsAntiJeffreyEscapePauseActive() then FarmForceRetarget = false end
            end)
            StartJeffreyGuardLoop()
        end
    elseif obj and obj.Name == "NotHumanoid" then
        HandleBypassJeffreyObject(obj)
    end
end)

workspace.DescendantRemoving:Connect(function(obj)
    if obj and IsJeffreyName(obj.Name) then
        JeffreyCacheAt = 0
        if BypassJeffreyEnabled then
            task.delay(0.15, function()
                if BypassJeffreyEnabled then ScanBypassJeffreys(false) end
            end)
        end
    end
end)

function GetMobMaxHP(mob)
    local humanoid = mob and mob:FindFirstChild("Humanoid")
    if not humanoid then return 0 end
    return humanoid.MaxHealth or 0
end

-- ====================== MOB CACHE SYSTEM ======================
MobCacheList = {}
MobCacheDirty = true
MobCacheFolder = nil
MobCacheLastRebuild = 0
MobCacheChildAddedConnection = nil
MobCacheChildRemovedConnection = nil
MobCacheWorkspaceAddedConnection = nil
MobCacheWorkspaceRemovedConnection = nil

function InvalidateMobCache(reason)
    MobCacheDirty = true
    CombatDebug("MobCache", "缓存已失效: " .. tostring(reason or "未知"), 2)
end

function DisconnectMobCacheFolderHooks()
    if MobCacheChildAddedConnection then
        MobCacheChildAddedConnection:Disconnect()
        MobCacheChildAddedConnection = nil
    end
    if MobCacheChildRemovedConnection then
        MobCacheChildRemovedConnection:Disconnect()
        MobCacheChildRemovedConnection = nil
    end
end

function RestartCombatLoopsIfNeeded(reason)
    if AutoAttackEnabled and IsMiscFarmAllowed() and StartAutoAttack then
        CombatDebug("AutoAttackRestart", "重新启动检查: " .. tostring(reason or "未知"), 3)
        StartAutoAttack()
    end
    if AutoSkillEnabled and IsMiscFarmAllowed() and StartAutoSkill then
        CombatDebug("AutoSkillRestart", "重新启动检查: " .. tostring(reason or "未知"), 3)
        StartAutoSkill()
    end
end

function HookMobCacheFolder(folder)
    if MobCacheFolder == folder and MobCacheChildAddedConnection and MobCacheChildRemovedConnection then return end
    DisconnectMobCacheFolderHooks()
    MobCacheFolder = folder
    MobCacheList = {}
    MobCacheDirty = true
    if not folder then
        CombatDebug("MobCache", "Living 文件夹未找到.", 5)
        return
    end
    MobCacheChildAddedConnection = folder.ChildAdded:Connect(function(obj)
        InvalidateMobCache("怪物新增")
        CombatDebug("MobCacheAdded", "怪物出现: " .. tostring(obj and obj.Name or "nil"), 2)
        task.delay(0.15, function()
            InvalidateMobCache("怪物新增延迟扫描")
            RestartCombatLoopsIfNeeded("怪物新增")
        end)
        task.delay(0.75, function()
            InvalidateMobCache("怪物加载延迟扫描")
            RestartCombatLoopsIfNeeded("怪物加载")
        end)
    end)
    MobCacheChildRemovedConnection = folder.ChildRemoved:Connect(function(obj)
        InvalidateMobCache("怪物移除")
        CombatDebug("MobCacheRemoved", "怪物移除: " .. tostring(obj and obj.Name or "nil"), 2)
        task.delay(0.05, function() RestartCombatLoopsIfNeeded("怪物移除") end)
    end)
    CombatDebug("MobCache", "Living 文件夹已挂钩.", 5)
end

function SetupMobCacheWorkspaceHooks()
    if MobCacheWorkspaceAddedConnection then return end
    MobCacheWorkspaceAddedConnection = workspace.ChildAdded:Connect(function(obj)
        if obj and obj.Name == "Living" then
            HookMobCacheFolder(obj)
            InvalidateMobCache("Living 文件夹已添加")
            task.delay(0.25, function() RestartCombatLoopsIfNeeded("Living 文件夹已添加") end)
        end
    end)
    MobCacheWorkspaceRemovedConnection = workspace.ChildRemoved:Connect(function(obj)
        if obj and obj == MobCacheFolder then
            HookMobCacheFolder(nil)
            InvalidateMobCache("Living 文件夹已移除")
        end
    end)
end

function RebuildMobCache()
    local folder = workspace:FindFirstChild("Living")
    if folder ~= MobCacheFolder then
        HookMobCacheFolder(folder)
    end
    MobCacheList = {}
    if folder then
        for _, mob in ipairs(folder:GetChildren()) do
            if IsValidMob(mob) then
                table.insert(MobCacheList, mob)
            end
        end
    end
    MobCacheDirty = false
    MobCacheLastRebuild = tick()
    CombatDebug("MobCacheRebuild", "已缓存有效怪物: " .. tostring(#MobCacheList), 3)
end

function GetCachedLivingMobs(forceRefresh)
    local folder = workspace:FindFirstChild("Living")
    if folder ~= MobCacheFolder then
        HookMobCacheFolder(folder)
    end
    if forceRefresh or MobCacheDirty or tick() - MobCacheLastRebuild > 2 then
        RebuildMobCache()
    end
    local alive = {}
    for _, mob in ipairs(MobCacheList) do
        if IsValidMob(mob) then
            table.insert(alive, mob)
        else
            MobCacheDirty = true
        end
    end
    if #alive == 0 and folder and #folder:GetChildren() > 0 and not forceRefresh then
        CombatDebug("MobCacheFallback", "缓存为空但 Living 有子节点，重新构建一次.", 3)
        RebuildMobCache()
        alive = {}
        for _, mob in ipairs(MobCacheList) do
            if IsValidMob(mob) then table.insert(alive, mob) end
        end
    end
    return alive
end

SetupMobCacheWorkspaceHooks()

-- ====================== MOB SELECTION ======================
function IsAstroMob(mob)
    return mob and mob.Name and mob.Name:lower():find("astro", 1, true) ~= nil
end

function IsFarmMobAllowedByMode(mob)
    if FarmTargetMode == "Astro Holdout Mode" then
        return IsAstroMob(mob)
    end
    return true
end

function GetFarmCandidateMobs(forceRefresh)
    local source = GetCachedLivingMobs(forceRefresh == true)
    local useJeffreyAvoid = IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive()
    if FarmTargetMode ~= "Astro Holdout Mode" and not useJeffreyAvoid then
        return source
    end
    local filtered = {}
    local range = GetFarmTargetDangerRange and GetFarmTargetDangerRange() or (GetFarmJeffreyAvoidRange and GetFarmJeffreyAvoidRange() or DarkDimensionJeffreyAvoidRange)
    for _, mob in ipairs(source) do
        if IsFarmMobAllowedByMode(mob) then
            if useJeffreyAvoid and IsMobBlockedByJeffrey(mob, range) then
            else
                table.insert(filtered, mob)
            end
        end
    end
    return filtered
end

function GetNearestMob()
    if RefreshCombatCharacter then RefreshCombatCharacter() end
    if not HumanoidRootPart then return nil end
    local nearestMob, nearestDist = nil, math.huge
    for _, mob in ipairs(GetFarmCandidateMobs(false)) do
        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
        if mobRoot then
            local d = (HumanoidRootPart.Position - mobRoot.Position).Magnitude
            if d < nearestDist then
                nearestDist = d
                nearestMob = mob
            end
        end
    end
    return nearestMob
end

function GetHighestMob()
    if RefreshCombatCharacter then RefreshCombatCharacter() end
    local highestMob, highestY = nil, -math.huge
    local myY = HumanoidRootPart and HumanoidRootPart.Position.Y or 0
    for _, mob in ipairs(GetFarmCandidateMobs(false)) do
        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
        if mobRoot then
            local mobY = mobRoot.Position.Y
            if mobY > myY and mobY > highestY then
                highestY = mobY
                highestMob = mob
            end
        end
    end
    return highestMob
end

-- ============================================================
-- ====================== PRIORITY SYSTEM =====================
function GetHelicopter()
    for _, mob in ipairs(GetFarmCandidateMobs(false)) do
        if mob.Name:lower():find("helicopter") then
            return mob
        end
    end
    return nil
end

function GetGiantSTToilet()
    if FarmTargetMode == "Astro Holdout Mode" then return nil, nil end
    for _, mob in ipairs(GetFarmCandidateMobs(false)) do
        if mob.Name == "Giant ST toilet" then
            local lever = mob:FindFirstChild("lever")
            if lever then
                local prompt = lever:FindFirstChildOfClass("ProximityPrompt")
                if prompt then return mob, prompt end
            end
        end
    end
    return nil, nil
end

function GetHighHPMob()
    local bestMob, bestHP = nil, HighHPThreshold
    for _, mob in ipairs(GetFarmCandidateMobs(false)) do
        local hp = GetMobMaxHP(mob)
        if hp > bestHP then
            bestHP = hp
            bestMob = mob
        end
    end
    return bestMob
end

function GetPriorityMob()
    if RefreshCombatCharacter then RefreshCombatCharacter() end
    if not HumanoidRootPart then return nil, nil, nil, 0 end
    local giant, prompt = nil, nil
    local heli, highMob, nearMob = nil, nil, nil
    local bestHP, nearDist = HighHPThreshold, math.huge
    local candidates = GetFarmCandidateMobs(false)
    for _, mob in ipairs(candidates) do
        if not giant and FarmTargetMode ~= "Astro Holdout Mode" and mob.Name == "Giant ST toilet" then
            local lever = mob:FindFirstChild("lever")
            if lever then
                local pr = lever:FindFirstChildOfClass("ProximityPrompt")
                if pr then giant = mob; prompt = pr end
            end
        end
        if not heli and mob.Name:lower():find("helicopter") then
            heli = mob
        end
        local hp = GetMobMaxHP(mob)
        if hp > bestHP then
            bestHP = hp
            highMob = mob
        end
        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
        if mobRoot and HumanoidRootPart then
            local d = (HumanoidRootPart.Position - mobRoot.Position).Magnitude
            if d < nearDist then
                nearDist = d
                nearMob = mob
            end
        end
    end
    if giant and prompt then return giant, "GiantST", prompt, 4 end
    if heli then return heli, "Helicopter", nil, 3 end
    if highMob then return highMob, "HighHP", nil, 2 end
    if nearMob then return nearMob, "NearestMob", nil, 1 end
    return nil, nil, nil, 0
end

function CheckInterrupt(currentPriority)
    local mob, _, _, newPriority = GetPriorityMob()
    if mob and newPriority > (currentPriority or 0) then
        return true, newPriority
    end
    return false, currentPriority
end
-- ============================================================
-- ====================== MOB VISUAL BOUNDS ===================
-- ============================================================

MobBoundsCache = {}
MobBoundsCacheAt = {}
MobBoundsCacheTTL = 0.25

function ClearMobBoundsCache(mob)
    if mob then
        MobBoundsCache[mob] = nil
        MobBoundsCacheAt[mob] = nil
    else
        MobBoundsCache = {}
        MobBoundsCacheAt = {}
    end
end

function ComputeMobVisualBounds(mob)
    local minY, maxY = math.huge, -math.huge
    local centerX, centerZ, count = 0, 0, 0

    for _, part in ipairs(mob:GetDescendants()) do
        if part:IsA("BasePart") and part.Transparency < 0.9 and part.Size.Y > 0.1 then
            local pos = part.Position
            local hy  = part.Size.Y * 0.5
            if pos.Y - hy < minY then minY = pos.Y - hy end
            if pos.Y + hy > maxY then maxY = pos.Y + hy end
            centerX = centerX + pos.X
            centerZ = centerZ + pos.Z
            count   = count + 1
        end
    end

    if count == 0 then
        local hrp = mob:FindFirstChild("HumanoidRootPart")
        if hrp then
            return hrp.Position, hrp.Position.Y - 2, hrp.Position.Y + 2
        end
        return Vector3.new(0, 0, 0), 0, 4
    end

    local cx = centerX / count
    local cz = centerZ / count
    local cy = (minY + maxY) * 0.5
    return Vector3.new(cx, cy, cz), minY, maxY
end

function GetMobVisualBounds(mob)
    if not mob then return Vector3.new(0, 0, 0), 0, 4 end

    local now = tick()
    local cached = MobBoundsCache[mob]
    if cached and MobBoundsCacheAt[mob] and now - MobBoundsCacheAt[mob] <= MobBoundsCacheTTL then
        return cached[1], cached[2], cached[3]
    end

    local center, minY, maxY = ComputeMobVisualBounds(mob)
    MobBoundsCache[mob] = { center, minY, maxY }
    MobBoundsCacheAt[mob] = now
    return center, minY, maxY
end

-- ============================================================
-- ====================== MOB HEIGHT OVERRIDE =================
-- ============================================================

PADDING_REDUCE_STEP    = Config:Get("PaddingReduceStep", 2)
PADDING_SAFE_MIN       = Config:Get("PaddingSafeMin", -30)
DMG_THRESHOLD          = Config:Get("DmgThreshold", 40)
ANTI_CLIP_MARGIN       = Config:Get("AntiClipMargin", 3)
PLAYER_HALF_HEIGHT     = 3

MobHeightOverride   = {}
MobConfirmedPadding = {}
MobLastHealth       = {}
MobCheckerCancelled = {}

function GetAntiClipFloor(mob, position)
    local _, minY, maxY = GetMobVisualBounds(mob)
    local visualHeight = maxY - minY
    return -(visualHeight) + PLAYER_HALF_HEIGHT + ANTI_CLIP_MARGIN
end

function GetEffectivePadding(mob)
    if MobConfirmedPadding[mob] ~= nil then return MobConfirmedPadding[mob] end
    if MobHeightOverride[mob] ~= nil then return MobHeightOverride[mob] end
    return HeightValue
end

function ClampPaddingToAntiClip(mob, padding)
    local antiFloor = GetAntiClipFloor(mob, FarmPosition)
    local clamped = math.max(padding, antiFloor)
    clamped = math.max(clamped, PADDING_SAFE_MIN)
    return clamped
end

function StartDamageChecker(mob)
    MobCheckerCancelled[mob] = false
    task.spawn(function()
        local humanoid = mob and mob:FindFirstChild("Humanoid")
        if not humanoid then return end
        if MobConfirmedPadding[mob] ~= nil then return end

        MobLastHealth[mob]     = humanoid.Health
        MobHeightOverride[mob] = ClampPaddingToAntiClip(mob, MobHeightOverride[mob] or HeightValue)

        local lastDamageTime = tick()
        local noDamageTimer  = 0
        local hitStreak      = 0
        local lastWasHit     = false
        local reducedOnce    = false

        while mob and mob.Parent and not IsMobDead(mob) and AutoFarmEnabled do
            task.wait(0.3)
            if MobCheckerCancelled[mob] then break end
            if not mob or not mob.Parent or IsMobDead(mob) then break end
            humanoid = mob:FindFirstChild("Humanoid")
            if not humanoid then break end

            local currentHP = humanoid.Health
            local lastHP    = MobLastHealth[mob] or currentHP
            local dmgDealt  = lastHP - currentHP
            local gotHit    = dmgDealt > 0

            if gotHit then
                lastDamageTime = tick()
                noDamageTimer  = 0
                reducedOnce    = false
                if lastWasHit then hitStreak = hitStreak + 1 else hitStreak = 1 end
                lastWasHit = true
                local curPad = GetEffectivePadding(mob)
                if dmgDealt >= DMG_THRESHOLD and MobConfirmedPadding[mob] == nil then
                    if not MobCheckerCancelled[mob] then
                        MobConfirmedPadding[mob] = curPad
                        MobHeightOverride[mob]   = curPad
                    end
                    break
                end
                if hitStreak >= 2 and MobConfirmedPadding[mob] == nil then
                    if not MobCheckerCancelled[mob] then
                        MobConfirmedPadding[mob] = curPad
                        MobHeightOverride[mob]   = curPad
                    end
                    break
                end
            else
                lastWasHit    = false
                hitStreak     = 0
                noDamageTimer = tick() - lastDamageTime
            end

            if noDamageTimer >= 3 and not reducedOnce then
                reducedOnce = true
                local curPad = GetEffectivePadding(mob)
                local newPad = ClampPaddingToAntiClip(mob, curPad - PADDING_REDUCE_STEP)
                if newPad ~= curPad then MobHeightOverride[mob] = newPad end
            end

            if noDamageTimer >= 6 then
                lastDamageTime = tick()
                reducedOnce    = false
                local curPad   = GetEffectivePadding(mob)
                local newPad   = ClampPaddingToAntiClip(mob, curPad - PADDING_REDUCE_STEP)
                if newPad ~= curPad then MobHeightOverride[mob] = newPad end
            end

            MobLastHealth[mob] = currentHP
        end

        if not MobCheckerCancelled[mob] then
            MobHeightOverride[mob] = nil
            MobLastHealth[mob]     = nil
        end
    end)
end

function ResetMobOverride(mob)
    MobCheckerCancelled[mob] = true
    MobHeightOverride[mob]   = nil
    MobConfirmedPadding[mob] = nil
    MobLastHealth[mob]       = nil
    task.delay(0.5, function()
        MobCheckerCancelled[mob] = nil
    end)
end

-- ============================================================
-- ====================== TARGET CFRAME =======================
-- ============================================================
function GetTargetCFrame(mob, position)
    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
    if not mobRoot then return nil end

    local padding = GetEffectivePadding(mob)
    local center, minY, maxY = GetMobVisualBounds(mob)

    if position == "Above" then
        local safeTargetY = math.max(maxY + padding, maxY + 0.5)
        local targetPos   = Vector3.new(center.X, safeTargetY, center.Z)
        local lookAtPos   = Vector3.new(center.X, maxY, center.Z)
        local lookCF      = CFrame.new(targetPos, lookAtPos)
        return lookCF * CFrame.Angles(math.rad(-10), 0, 0)

    elseif position == "Under" then
        local safeTargetY = math.min(minY - padding, minY - 0.5)
        local targetPos   = Vector3.new(center.X, safeTargetY, center.Z)
        local lookAtPos   = Vector3.new(center.X, minY, center.Z)
        local lookCF      = CFrame.new(targetPos, lookAtPos)
        return lookCF * CFrame.Angles(math.rad(10), 0, 0)
    end
end

function GetStableFarmCFrame(cf)
    return cf
end

function WaitTweenWithTimeout(tween, timeout)
    if not tween then return false end
    timeout = tonumber(timeout) or 2

    local completed = false
    local conn
    conn = tween.Completed:Connect(function()
        completed = true
    end)

    local startedAt = tick()
    while not completed and tick() - startedAt < timeout do
        if ResetWaveTeleporting then break end
        if not AutoFarmEnabled and not FarmAstroTokenEnabled and not DarkDimensionCollecting then break end
        task.wait(0.03)
    end

    if conn then pcall(function() conn:Disconnect() end) end
    if not completed then pcall(function() tween:Cancel() end) end
    return completed
end

function MoveCharacterToFarmCFrame(cf)
    if ResetWaveTeleporting then return end
    if not Character or not HumanoidRootPart or not cf then return end

    local targetCF = GetStableFarmCFrame(cf)
    pcall(function()
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = false
            humanoid.AutoRotate = false
        end

        Character:PivotTo(targetCF)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        StabilizeFarmCamera()
    end)
end

function TeleportToMob(mob)
    local cf = GetTargetCFrame(mob, FarmPosition)
    if not cf then return end

    if FarmMode == "Tween" then
        local tweenInfo = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, { CFrame = GetStableFarmCFrame(cf) })
        tween:Play()
        WaitTweenWithTimeout(tween, (TweenSpeed or 1) + 0.45)
        if not ResetWaveTeleporting and not FarmForceRetarget then
            MoveCharacterToFarmCFrame(cf)
        end
    else
        MoveCharacterToFarmCFrame(cf)
    end
end

-- ============================================================
-- =========== DARK DIMENSION / Astro Holdout Mode MOVEMENT ===========
-- ============================================================

function MoveSpecialCharacterCFrame(cf)
    if ResetWaveTeleporting then return false end
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart or not cf then return false end

    local ok = pcall(function()
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = false
            humanoid.AutoRotate = false
        end
        Character:PivotTo(cf)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        StabilizeFarmCamera()
    end)

    return ok
end

function MoveFarmSpecialCFrame(cf, tweenTime)
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart or not cf then return false end

    if FarmMode == "Tween" then
        local ok = pcall(function()
            local tween = TweenService:Create(
                HumanoidRootPart,
                TweenInfo.new(tweenTime or TweenSpeed or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                { CFrame = cf }
            )
            tween:Play()
            WaitTweenWithTimeout(tween, (tweenTime or TweenSpeed or 0.35) + 0.45)
            if not ResetWaveTeleporting then
                MoveSpecialCharacterCFrame(cf)
            end
        end)
        return ok
    end

    return MoveSpecialCharacterCFrame(cf)
end

function StopFarmLockForSanityCollect(reason)
    DarkDimensionCollectToken = (DarkDimensionCollectToken or 0) + 1
    DarkDimensionCollecting = true
    FarmCollecting = true
    FarmForceRetarget = true
    LockActive = false
    _interruptSignal = true

    pcall(function()
        RefreshCombatCharacter()
        if Character then
            local humanoid = Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Sit = false
                humanoid.AutoRotate = false
            end
        end
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)

    pcall(function() RunService.Heartbeat:Wait() end)
    task.wait(0.03)
    return DarkDimensionCollectToken
end

function GetSanityImageLabel()
    local gui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return nil end
    local sanity = gui:FindFirstChild("SanityUI")
    if not sanity then return nil end
    return sanity:FindFirstChild("ImageLabel")
end

function GetSanityTransparency()
    local label = GetSanityImageLabel()
    if not label then return nil end
    local ok, value = pcall(function() return label.ImageTransparency end)
    if ok and type(value) == "number" then return value end
    return nil
end

function HasSanityTouchInterest(part)
    if not part or not part.Parent then return false end
    if part:FindFirstChild("TouchInterest") then return true end
    local ok, found = pcall(function() return part:FindFirstChildOfClass("TouchTransmitter") end)
    return ok and found ~= nil
end

function IsValidSanityTouchPart(part)
    return part and part:IsA("BasePart") and part.Parent and HasSanityTouchInterest(part)
end

function GetSanityTouchPart(orb)
    if not orb or not orb.Parent then return nil end
    if IsValidSanityTouchPart(orb) then return orb end

    local touch = orb:FindFirstChild("TouchInterest", true)
    if touch and touch.Parent and touch.Parent:IsA("BasePart") then
        return touch.Parent
    end

    for _, obj in ipairs(orb:GetDescendants()) do
        if IsValidSanityTouchPart(obj) then
            return obj
        end
    end

    return nil
end

function ScanSanityOrbContainer(container, bestPart, bestDist)
    if not container then return bestPart, bestDist end

    if container.Name == "OrbSanity" then
        local directPart = GetSanityTouchPart(container)
        if directPart then
            local directDist = (HumanoidRootPart.Position - directPart.Position).Magnitude
            if directDist < bestDist then
                bestPart = directPart
                bestDist = directDist
            end
        end
    end

    for _, obj in ipairs(container:GetDescendants()) do
        if obj.Name == "OrbSanity" then
            local part = GetSanityTouchPart(obj)
            if part then
                local dist = (HumanoidRootPart.Position - part.Position).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestPart = part
                end
            end
        end
    end

    return bestPart, bestDist
end

function GetNearestSanityOrbPart()
    RefreshCombatCharacter()
    if not HumanoidRootPart then return nil end

    local bestPart, bestDist = nil, math.huge
    local living = workspace:FindFirstChild("Living")
    bestPart, bestDist = ScanSanityOrbContainer(living, bestPart, bestDist)

    if not bestPart and tick() - (DarkDimensionOrbSearchCooldown or 0) > 0.4 then
        DarkDimensionOrbSearchCooldown = tick()
        bestPart, bestDist = ScanSanityOrbContainer(workspace, bestPart, bestDist)
    end

    return bestPart
end

function TouchSanityOrb(part)
    RefreshCombatCharacter()
    if not part or not part.Parent or not HumanoidRootPart then return false end

    local touchCF = part.CFrame + Vector3.new(0, 2, 0)
    MoveSpecialCharacterCFrame(touchCF)

    local ok = pcall(function()
        if firetouchinterest and HasSanityTouchInterest(part) then
            for _ = 1, 3 do
                if not HasSanityTouchInterest(part) then break end
                firetouchinterest(HumanoidRootPart, part, 0)
                task.wait(0.08)
                firetouchinterest(HumanoidRootPart, part, 1)
                task.wait(0.08)
            end
        else
            MoveSpecialCharacterCFrame(touchCF)
            task.wait(0.2)
        end
    end)

    return ok
end

function MoveToSanityOrb(part)
    if not part or not part.Parent then return false end
    local topCF = part.CFrame + Vector3.new(0, 2, 0)
    local ok = MoveFarmSpecialCFrame(topCF, 0.35)
    if ok then
        task.wait(0.05)
        MoveSpecialCharacterCFrame(topCF)
    end
    return ok
end

function WarnDarkDimensionMissingOrb()
    local now = tick()
    if now - DarkDimensionLastWarnAt < 4 then return end
    DarkDimensionLastWarnAt = now
    CombatDebug("DarkDimension", "理智值低但未找到带 TouchInterest 的 OrbSanity.", 4, false)
end

function IsDarkDimensionSanityLow()
    if FarmTargetMode ~= "Dark Dimension Mode" or DarkDimensionCollecting or not AutoFarmEnabled then return false end
    local sanity = GetSanityTransparency()
    return sanity ~= nil and sanity < DarkDimensionLowValue
end

function HandleDarkDimensionSanityEmergency()
    if not IsDarkDimensionSanityLow() then return false end
    FarmForceRetarget = true
    LockActive = false
    return HandleDarkDimensionSanity()
end

function HandleDarkDimensionSanity()
    if FarmTargetMode ~= "Dark Dimension Mode" or DarkDimensionCollecting or not AutoFarmEnabled then return false end

    local sanity = GetSanityTransparency()
    if not sanity or sanity >= DarkDimensionLowValue then return false end

    local collectToken = StopFarmLockForSanityCollect("低理智值")

    local didCollect = false
    pcall(function()
        while AutoFarmEnabled and FarmTargetMode == "Dark Dimension Mode" and DarkDimensionCollectToken == collectToken do
            RefreshCombatCharacter()
            if not Character or not HumanoidRootPart then break end
            LockActive = false
            FarmCollecting = true
            FarmForceRetarget = true

            sanity = GetSanityTransparency()
            if not sanity then break end
            if sanity >= DarkDimensionSafeValue then break end

            local part = GetNearestSanityOrbPart()
            if not part then
                WarnDarkDimensionMissingOrb()
                break
            end

            if MoveToSanityOrb(part) then
                task.wait(1.25)
                if DarkDimensionCollectToken ~= collectToken then break end
                MoveSpecialCharacterCFrame(part.CFrame + Vector3.new(0, 2, 0))
                TouchSanityOrb(part)
                didCollect = true
            end

            local waited = 0
            repeat
                task.wait(0.12)
                waited = waited + 0.12
                sanity = GetSanityTransparency()
            until not AutoFarmEnabled or FarmTargetMode ~= "Dark Dimension Mode" or not sanity or sanity >= DarkDimensionSafeValue or not part.Parent or not HasSanityTouchInterest(part) or waited >= 3
        end
    end)

    if DarkDimensionCollectToken == collectToken then
        DarkDimensionCollecting = false
        FarmCollecting = false
        _interruptSignal = false
        if AutoFarmEnabled then
            WaitingRespawn = false
            FarmForceRetarget = true
            if HandleFarmJeffreyEmergency then pcall(function() HandleFarmJeffreyEmergency(nil) end) end
            task.delay(JeffreySafeRetargetDelay or 0.85, function()
                if not DarkDimensionCollecting and not IsAntiJeffreyEscapePauseActive() then FarmForceRetarget = false end
            end)
        else
            FarmForceRetarget = false
        end
    end

    return didCollect
end

function DoAstroModeFinalDoor()
    if FarmTargetMode ~= "Astro Holdout Mode" or AstroModeFinalRunning then return false end

    local now = tick()
    if now - AstroModeLastFinalAt < 2 then return false end
    AstroModeLastFinalAt = now
    AstroModeFinalRunning = true

    local ok = pcall(function()
        RefreshCombatCharacter()
        if not Character or not HumanoidRootPart then return end
        LockActive = false
        WaitingRespawn = true
        FarmForceRetarget = true

        MoveCharacterToFarmCFrame(AstroModeDoorTopCF)
        task.wait(0.12)

        if FarmMode == "Tween" then
            MoveFarmSpecialCFrame(AstroModeDoorBottomCF, 0.45)
        else
            MoveCharacterToFarmCFrame(AstroModeDoorBottomCF)
        end

        task.wait(0.15)
        FarmForceRetarget = false
    end)

    AstroModeFinalRunning = false
    return ok
end

function LockToMob(mob)
    LockActive = true
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not AutoFarmEnabled or IsMobDead(mob) or not LockActive or FarmForceRetarget or (IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive()) then
            connection:Disconnect()
            LockActive = false
            return
        end
        if not Character or not HumanoidRootPart then return end
        local cf = GetTargetCFrame(mob, FarmPosition)
        if cf then
            MoveCharacterToFarmCFrame(cf)
        end
    end)
end
-- ====================== AUTO LOOPS ======================
function RefreshCombatCharacter()
    if not Character or not Character.Parent then
        Character = LocalPlayer.Character
    end

    if Character and (not HumanoidRootPart or HumanoidRootPart.Parent ~= Character) then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end

    Client = LocalPlayer
    return Character, HumanoidRootPart
end

function SafeGetPriorityMob()
    RefreshCombatCharacter()
    if not Character or not HumanoidRootPart then
        CombatDebug("CombatCharacter", "角色或 HumanoidRootPart 未就绪.", 4)
        return nil, nil, nil, 0
    end

    local ok, mob, mobType, extraData, priority = pcall(function()
        return GetPriorityMob()
    end)

    if ok then
        if mob then
            return mob, mobType, extraData, priority
        end

        if tick() - MobCacheLastRebuild > 0.6 then
            InvalidateMobCache("优先级返回 nil")
            local ok2, mob2, mobType2, extraData2, priority2 = pcall(function()
                RebuildMobCache()
                return GetPriorityMob()
            end)

            if ok2 and mob2 then
                CombatDebug("PriorityRecovered", "缓存重建后恢复优先级怪物: " .. tostring(mob2.Name), 3)
                return mob2, mobType2, extraData2, priority2
            end
        end

        CombatDebug("PriorityNoMob", "尚未找到有效怪物.", 4)
        return nil, nil, nil, 0
    end

    CombatDebug("PriorityError", "GetPriorityMob 失败: " .. tostring(mob), 3, true)
    warn("[DYHUB] GetPriorityMob 失败:", tostring(mob))
    InvalidateMobCache("优先级错误")
    return nil, nil, nil, 0
end

function StartAutoAttack()
    if AutoAttackLoopRunning then return end
    AutoAttackLoopRunning = true

    task.spawn(function()
        while AutoAttackEnabled do
            if FarmCollecting then
                task.wait(0.2)
            elseif IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive() then
                task.wait(0.08)
            elseif IsDarkDimensionSanityLow and IsDarkDimensionSanityLow() then
                task.wait(0.1)
            elseif IsMiscFarmAllowed() then
                local mob = SafeGetPriorityMob()
                if mob then
                    WaitingRespawn = false
                    local remote = GetRemote("LMB")
                    if remote then
                        pcall(function() remote:FireServer() end)
                    else
                        CombatDebug("AutoAttackRemote", "LMB 远程事件缺失.", 5, true)
                    end
                else
                    CombatDebug("AutoAttackNoMob", "自动攻击正在等待有效怪物.", 5)
                end
                task.wait(0.12)
            else
                CombatDebug("AutoAttackPaused", "自动攻击被同步农场/农场 Astro 暂停.", 5)
                task.wait(0.25)
            end
        end

        AutoAttackLoopRunning = false
    end)
end

function StartAutoSkill()
    if AutoSkillLoopRunning then return end
    AutoSkillLoopRunning = true

    task.spawn(function()
        while AutoSkillEnabled do
            if FarmCollecting then
                task.wait(0.2)
            elseif IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive() then
                task.wait(0.08)
            elseif IsDarkDimensionSanityLow and IsDarkDimensionSanityLow() then
                task.wait(0.1)
            elseif IsMiscFarmAllowed() then
                local mob = SafeGetPriorityMob()
                if mob then
                    WaitingRespawn = false

                    local keysToPress = {}
                    if table.find(SelectedSkills, "All") then
                        keysToPress = skillList
                    else
                        keysToPress = SelectedSkills
                    end

                    for _, key in ipairs(keysToPress) do
                        if not AutoSkillEnabled or not IsMiscFarmAllowed() or FarmCollecting or (IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive()) or (IsDarkDimensionSanityLow and IsDarkDimensionSanityLow()) then break end

                        local keyCode = Enum.KeyCode[key]
                        if keyCode then
                            pcall(function()
                                VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                                task.wait(0.05)
                                VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
                            end)
                            task.wait(SkillDelay)
                        else
                            CombatDebug("AutoSkillKey", "无效技能按键: " .. tostring(key), 5)
                        end
                    end
                else
                    CombatDebug("AutoSkillNoMob", "自动技能正在等待有效怪物.", 5)
                    task.wait(0.25)
                end
            else
                CombatDebug("AutoSkillPaused", "自动技能被同步农场/农场 Astro 暂停.", 5)
                task.wait(0.25)
            end
            task.wait(0.05)
        end

        AutoSkillLoopRunning = false
    end)
end

function TriggerAutoSkipHeli(state)
    local remote = GetRemote("SetSettingAutoSkipWave")
    if remote then pcall(function() remote:FireServer(state) end) end
end

function HasHumanoid(obj)
    if obj:IsA("Model") then
        return obj:FindFirstChildOfClass("Humanoid") ~= nil
    end
    return false
end

function IsLivingDescendant(obj)
    local current = obj
    while current and current ~= workspace do
        if current:IsA("Model") and current:FindFirstChildOfClass("Humanoid") then
            return true
        end
        current = current.Parent
    end
    return false
end

-- ====================== Delete Map (删除地图) SYSTEM ======================
BoostFPS_OriginalData = {}
BoostFPS_Active = false
BoostFPS_RestoreConnection = nil
BoostFPS_LightingData = {}

function SaveAndBoostFPS()
    if BoostFPS_Active then return end
    BoostFPS_Active = true
    BoostFPS_OriginalData = {}
    BoostFPS_LightingData = {}

    local Lighting = game:GetService("Lighting")
    BoostFPS_LightingData = {
        Brightness        = Lighting.Brightness,
        GlobalShadows     = Lighting.GlobalShadows,
        FogEnd            = Lighting.FogEnd,
        FogStart          = Lighting.FogStart,
    }
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness    = 1
        Lighting.FogEnd        = 100000
        Lighting.FogStart      = 100000
    end)
    for _, effect in ipairs(Lighting:GetChildren()) do
        pcall(function()
            if effect:IsA("Atmosphere") or effect:IsA("BloomEffect") or
               effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") or
               effect:IsA("SunRaysEffect") or effect:IsA("Sky") then
                BoostFPS_LightingData["effect_" .. effect.Name] = { class = effect.ClassName, inst = effect }
                effect.Parent = nil
            end
        end)
    end

    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if IsLivingDescendant(obj) then continue end

            if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") or obj:IsA("SpecialMesh") then
                if not IsLivingDescendant(obj) then
                    if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                        BoostFPS_OriginalData[obj] = {
                            Transparency = obj.Transparency,
                            CastShadow   = obj.CastShadow,
                            Material     = obj.Material,
                        }
                        obj.Transparency = 1
                        obj.CastShadow   = false
                        pcall(function() obj.Material = Enum.Material.SmoothPlastic end)
                    end
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                BoostFPS_OriginalData[obj] = { Transparency = obj.Transparency }
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
                   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("SelectionBox") then
                BoostFPS_OriginalData[obj] = { Enabled = obj.Enabled }
                pcall(function() obj.Enabled = false end)
            elseif obj:IsA("SpecialMesh") then
                BoostFPS_OriginalData[obj] = { TextureId = obj.TextureId }
                obj.TextureId = ""
            end
        end
    end)

    BoostFPS_RestoreConnection = workspace.DescendantAdded:Connect(function(obj)
        if not BoostFPS_Active then return end
        if IsLivingDescendant(obj) then return end
        task.wait(0.05)
        pcall(function()
            if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                if not IsLivingDescendant(obj) then
                    obj.Transparency = 1
                    obj.CastShadow   = false
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
                   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                pcall(function() obj.Enabled = false end)
            end
        end)
    end)

    print("[DYHUB] 删除地图: 开启")
end

function RestoreBoostFPS()
    if not BoostFPS_Active then return end
    BoostFPS_Active = false

    if BoostFPS_RestoreConnection then
        BoostFPS_RestoreConnection:Disconnect()
        BoostFPS_RestoreConnection = nil
    end

    local Lighting = game:GetService("Lighting")
    pcall(function()
        if BoostFPS_LightingData.Brightness        ~= nil then Lighting.Brightness        = BoostFPS_LightingData.Brightness end
        if BoostFPS_LightingData.GlobalShadows     ~= nil then Lighting.GlobalShadows     = BoostFPS_LightingData.GlobalShadows end
        if BoostFPS_LightingData.FogEnd            ~= nil then Lighting.FogEnd            = BoostFPS_LightingData.FogEnd end
        if BoostFPS_LightingData.FogStart          ~= nil then Lighting.FogStart          = BoostFPS_LightingData.FogStart end
    end)
    for key, data in pairs(BoostFPS_LightingData) do
        if type(key) == "string" and key:sub(1, 7) == "effect_" then
            pcall(function()
                if data.inst then data.inst.Parent = Lighting end
            end)
        end
    end

    for obj, data in pairs(BoostFPS_OriginalData) do
        pcall(function()
            if not obj or not obj.Parent then return end
            if data.Transparency ~= nil and (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") or obj:IsA("Decal") or obj:IsA("Texture")) then
                obj.Transparency = data.Transparency
            end
            if data.CastShadow ~= nil then obj.CastShadow = data.CastShadow end
            if data.Material   ~= nil then pcall(function() obj.Material = data.Material end) end
            if data.Enabled    ~= nil then pcall(function() obj.Enabled  = data.Enabled  end) end
            if data.TextureId  ~= nil then obj.TextureId = data.TextureId end
        end)
    end

    BoostFPS_OriginalData = {}
    BoostFPS_LightingData = {}
    print("[DYHUB] 删除地图: 关闭 (已恢复)")
end

task.spawn(function()
    while true do
        task.wait(3)
        if BoostFPS_Active then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if IsLivingDescendant(obj) then continue end
                    if (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation")) then
                        if not IsLivingDescendant(obj) then
                            if obj.Transparency < 0.99 and not BoostFPS_OriginalData[obj] then
                                obj.Transparency = 1
                                obj.CastShadow   = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ====================== PLAYER HP HELPERS ======================
function GetPlayerHPInfo()
    local humanoid = Character and Character:FindFirstChild("Humanoid")
    if not humanoid then return 100, 100 end
    return humanoid.Health, humanoid.MaxHealth
end

function IsPlayerHPFull()
    local hp, maxHp = GetPlayerHPInfo()
    if maxHp <= 0 then return true end
    return hp >= maxHp
end

function GetPlayerHealthPercent()
    local humanoid = Character and Character:FindFirstChild("Humanoid")
    if not humanoid then return 100 end
    if humanoid.MaxHealth <= 0 then return 100 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

-- ====================== GOD MODE CORE ======================
function IsCharacterDeadForGodMode(char, humanoid)
    return not char
        or not char.Parent
        or not humanoid
        or not humanoid.Parent
        or humanoid.Health <= 0
        or humanoid:GetState() == Enum.HumanoidStateType.Dead
end

function ForceGodModeOnce(reason)
    local ok, result = pcall(function()
        local char = LocalPlayer.Character
        if not char then return false end

        local humanoid = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid")
        if not humanoid then return false end
        if IsCharacterDeadForGodMode(char, humanoid) then return false end

        local destroyed = false

        local head = char:FindFirstChild("Head")
        if head then
            head:Destroy()
            destroyed = true
        end

        task.wait(0.05)

        if IsCharacterDeadForGodMode(char, humanoid) then
            CombatDebug("GodMode", "触发一次: " .. tostring(reason or "手动"), 2)
            return true
        end

        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if torso then
            torso:Destroy()
            destroyed = true
        end

        if not destroyed and not IsCharacterDeadForGodMode(char, humanoid) then
            humanoid.Health = 0
        end

        CombatDebug("GodMode", "触发一次: " .. tostring(reason or "手动"), 2)
        return true
    end)

    return ok and result == true
end

function ShouldBlockFarmAstroGodModePercent()
    return FarmAstroTokenEnabled == true
        and SyncFarmOnly == false
        and table.find(MiscOptions or {}, "God Mode") ~= nil
end

-- ====================== GOD MODE LOOP ======================
task.spawn(function()
    while true do
        task.wait(0.1)

        if GodModeEnabled and not FarmAstroGodModePaused and IsMiscFarmAllowed() and not ShouldBlockFarmAstroGodModePercent() then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end

                local humanoid = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid")
                if not humanoid then return end
                if humanoid.MaxHealth <= 0 then return end

                local hpPercent = (humanoid.Health / humanoid.MaxHealth) * 100

                if hpPercent < GodModeValue then
                    ForceGodModeOnce("HP 低于上帝模式阈值")
                end
            end)
        end
    end
end)

-- ====================== AUTO FILL UP ======================
function DoFillUp()
    local remote = GetRemote("ShopSystem")
    if not remote then return end
    for i = 1, 2 do
        pcall(function() remote:FireServer("Buy", "FillHP") end)
        if i < 2 then task.wait(0.3) end
    end
end

function StartAutoFillUpLoop()
    if FillUpRunning then return end
    FillUpRunning = true
    task.spawn(function()
        while AutoFillUpEnabled and IsMiscFarmAllowed() do
            if not IsPlayerHPFull() then
                if AutoSkipHeliEnabled then TriggerAutoSkipHeli(false) end
                local waited = 0
                while not IsFillUpPartReady() and AutoFillUpEnabled do
                    waited = waited + 0.2
                    if waited >= 30 then break end
                    task.wait(0.2)
                end
                if IsFillUpPartReady() and AutoFillUpEnabled then DoFillUp(); task.wait(1) end
                if AutoSkipHeliEnabled then TriggerAutoSkipHeli(true) end
            end
            task.wait(1)
        end
        FillUpRunning = false
    end)
end

-- ====================== BARRIER BYPASS ======================
function startNoBarrier()
    if noBarrierConnection then return end
    noBarrierConnection = RunService.Heartbeat:Connect(function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local pos = hrp.Position
            if math.abs(pos.X) > 1000 or math.abs(pos.Y) > 1000 or math.abs(pos.Z) > 1000 then
                hrp.CFrame = CFrame.new(Vector3.new(0, 50, 0))
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Health = humanoid.MaxHealth end
            end
        end)
    end)
end

function stopNoBarrier()
    if noBarrierConnection then
        noBarrierConnection:Disconnect()
        noBarrierConnection = nil
    end
end

-- ============================================================
-- ====================== AUTO START MODE ======================
function FireGetReady(delayBefore)
    if delayBefore == nil then delayBefore = 0 end
    if delayBefore > 0 then task.wait(delayBefore) end

    local now = tick()
    if now - (AutoStartLastReadyAt or 0) < 0.85 then return false end
    AutoStartLastReadyAt = now

    if AutoVoteinGameEnabled then
        FireAutoVote(true)
        task.wait(0.2)
    end

    local remote = GetRemote("GetReadyRemote")
    if not remote then return false end

    local ok, err = pcall(function()
        remote:FireServer("1", true)
        task.wait(0.2)
        remote:FireServer("1", false)
        task.wait(0.2)
        remote:FireServer("2", false)
        task.wait(0.2)
        remote:FireServer("3", false)
        task.wait(0.2)
        remote:FireServer("1", true)
    end)

    if not ok then warn("[DYHUB] GetReadyRemote 失败:", err) end
    return ok
end

function SetupAutoStartOnly(enabled)
    if AutoStartConnection then
        AutoStartConnection:Disconnect()
        AutoStartConnection = nil
    end

    if not enabled then return end

    FireGetReady(0)

    AutoStartConnection = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if AutoStartEnabled then
            task.spawn(function() FireGetReady(1) end)
        end
    end)
end

function StartAutoStart()
    AutoStartEnabled = true
    SetupAutoStartOnly(true)
end

function StopAutoStart()
    AutoStartEnabled = false
    SetupAutoStartOnly(false)
end

-- ====================== TELEPORT TO IDLE ======================
function StopIdleVelocity()
    pcall(function()
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)
end

function IsNearIdlePosition()
    if not HumanoidRootPart then return false end
    return (HumanoidRootPart.Position - IdlePosition.Position).Magnitude <= IdleHoldDistance
end

function TeleportToIdle(force)
    LockActive = false
    WaitingRespawn = true
    IdlePosition = GetDYHUBWaitingStandCFrame() * CFrame.Angles(math.rad(0), 0, 0)
    UpdateDYHUBWaitingPartCollision()

    if not Character or not Character.Parent or not HumanoidRootPart then return end

    local now = tick()

    if not force and IsNearIdlePosition() then
        IdlePositionReached = true
        StopIdleVelocity()
        return
    end

    if not force and (now - LastIdleTeleportAt) < IdleTeleportCooldown then
        StopIdleVelocity()
        return
    end

    LastIdleTeleportAt = now
    IdlePositionReached = true

    pcall(function()
        Character:PivotTo(IdlePosition)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    end)
end

-- ====================== PROXIMITY PROMPT HELPERS ======================
function ActivateProximityPrompt(prompt)
    pcall(function()
        prompt.HoldDuration = 0
        prompt.MaxActivationDistance = 50
        if fireproximityprompt then fireproximityprompt(prompt) end
        prompt:InputHoldBegin()
        task.wait(0.03)
        prompt:InputHoldEnd()
    end)
end

FlushPromptCache = {}
FlushPromptCacheDirty = true
FlushPromptCacheLastScan = 0
FlushPromptCacheTTL = 8

function IsFlushPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return false end
    local actionText = tostring(prompt.ActionText or ""):lower()
    local objectText = tostring(prompt.ObjectText or ""):lower()
    local combined = actionText .. " " .. objectText .. " " .. tostring(prompt.Name or ""):lower()
    return combined:find("flush", 1, true) ~= nil
        or combined:find("flash", 1, true) ~= nil
        or combined:find("dragon", 1, true) ~= nil
end

function RegisterFlushPrompt(obj)
    if obj and obj:IsA("ProximityPrompt") and IsFlushPrompt(obj) then
        FlushPromptCache[obj] = true
    end
end

function RebuildFlushPromptCache()
    FlushPromptCache = {}
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            RegisterFlushPrompt(obj)
        end
    end)
    FlushPromptCacheDirty = false
    FlushPromptCacheLastScan = tick()
end

workspace.DescendantAdded:Connect(function(obj)
    if obj and obj:IsA("ProximityPrompt") then
        task.defer(function() RegisterFlushPrompt(obj) end)
    end
end)

workspace.DescendantRemoving:Connect(function(obj)
    if obj and FlushPromptCache[obj] then
        FlushPromptCache[obj] = nil
    end
end)

LastFlushPromptActivateAllAt = 0

function ActivateAllFlushPrompts()
    local now = tick()
    if now - (LastFlushPromptActivateAllAt or 0) < 0.35 then return end
    LastFlushPromptActivateAllAt = now

    pcall(function()
        if FlushPromptCacheDirty or tick() - (FlushPromptCacheLastScan or 0) > (FlushPromptCacheTTL or 8) then
            RebuildFlushPromptCache()
        end

        for prompt in pairs(FlushPromptCache) do
            if prompt and prompt.Parent and IsFlushPrompt(prompt) then
                ActivateProximityPrompt(prompt)
            else
                FlushPromptCache[prompt] = nil
            end
        end
    end)
end
-- ============================================================
-- ====================== COLLECT SYSTEM ======================
-- ============================================================

CollectItems = {
    "Clock Spider", "X-18 Core", "Green Energy Core", "Weird Transmitter",
    "Astro Samples", "Weird Prism", "Key Card", "Zombie Core",
    "Flash Drives", "Presents",
}

CollectGroupMap = {
    ["Astro Samples"] = {
        "Trooper Blast","Trooper Spinner","Specialist Blaster","Specialist Spinner",
        "Specialist Sword Arm","Strider Leg","Interceptor Wing","Interceptor Goggles",
        "Interceptor Spinner","Impactor Cannon","Impactor Laser","High Impactor Cannon",
        "High Impactor Laser","Destructor Laser","Destructor Blaster","Destructor Core",
        "Obliterator Blaster","Obliterator Spinner",
    },
    ["Presents"] = {
        "Gacha Capsule",
    },
}

AutoCollectEnabled   = Config:Get("AutoCollectEnabled", false)
SelectedCollectItems = Config:Get("SelectedCollectItems", {})
CollectMode          = Config:Get("CollectMode", "Clean")
CollectMovementMode  = NormalizeCollectMovement(Config:Get("CollectMovementMode", "Tween"))

KnownCollectItems = {}
CollectRunning    = false
CollectCandidateCache = {}
CollectCacheDirty = true
CollectLastFullScan = 0

function MatchesPattern(objectName, pattern)
    local objL, patL = tostring(objectName or ""):lower(), tostring(pattern or ""):lower()
    if objL == patL then return true end
    if #objL > #patL and objL:sub(1, #patL) == patL then
        local nc = objL:sub(#patL + 1, #patL + 1)
        if nc == " " or nc == "#" or nc == "_" or nc == "-" then return true end
    end
    if CollectGroupMap[pattern] then
        for _, gName in ipairs(CollectGroupMap[pattern]) do
            if objL == gName:lower() then return true end
        end
    end
    return false
end

function IsCollectTarget(objectName)
    for _, pattern in ipairs(SelectedCollectItems) do
        if MatchesPattern(objectName, pattern) then return true end
    end
    return false
end

function IsCollectObject(obj)
    return obj and obj.Parent and (obj:IsA("Model") or obj:IsA("MeshPart") or obj:IsA("Part") or obj:IsA("BasePart"))
end

function AddCollectCandidate(obj)
    if IsCollectObject(obj) and IsCollectTarget(obj.Name) then
        CollectCandidateCache[obj] = true
        return true
    end
    return false
end

function RebuildCollectCache()
    CollectCandidateCache = {}
    if #SelectedCollectItems > 0 then
        for _, obj in ipairs(workspace:GetDescendants()) do
            AddCollectCandidate(obj)
        end
    end
    CollectCacheDirty = false
    CollectLastFullScan = tick()
end

function FindNewCollectItems()
    if CollectCacheDirty or tick() - CollectLastFullScan > 5 then
        RebuildCollectCache()
    end

    local found = {}
    for obj, _ in pairs(CollectCandidateCache) do
        if not obj or not obj.Parent or not IsCollectTarget(obj.Name) then
            CollectCandidateCache[obj] = nil
            KnownCollectItems[obj] = nil
        elseif not KnownCollectItems[obj] and IsCollectObject(obj) then
            table.insert(found, obj)
        end
    end
    return found
end

function GetItemRootPart(obj)
    if obj:IsA("Model") then return obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
    elseif obj:IsA("BasePart") or obj:IsA("MeshPart") then return obj end
    return nil
end

function GetItemTargetCFrame(itemRoot)
    if not itemRoot then return nil end
    return CFrame.new(itemRoot.Position + Vector3.new(0, 3, 0), itemRoot.Position)
end

function MoveToItem(itemRoot)
    RefreshCombatCharacter()
    if not itemRoot or not Character or not HumanoidRootPart then return false end

    local targetCF = GetItemTargetCFrame(itemRoot)
    if not targetCF then return false end

    if CollectMovementMode == "Teleport" then
        pcall(function()
            Character:PivotTo(targetCF)
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end)
        return true
    end

    local ok = pcall(function()
        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = targetCF })
        tween:Play()
        local started = tick()
        repeat
            task.wait(0.05)
            if not AutoCollectEnabled or IsItemGone(itemRoot) then
                pcall(function() tween:Cancel() end)
                break
            end
        until tween.PlaybackState ~= Enum.PlaybackState.Playing or tick() - started > math.max(TweenSpeed + 1, 3)
        pcall(function()
            Character:PivotTo(targetCF)
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end)
    end)

    return ok
end

function ActivateItemPrompts(obj)
    pcall(function()
        for _, child in ipairs(obj:GetDescendants()) do
            if child:IsA("ProximityPrompt") then
                child.HoldDuration = 0
                child.MaxActivationDistance = 50
                if fireproximityprompt then fireproximityprompt(child) end
                child:InputHoldBegin()
                task.wait(0.04)
                child:InputHoldEnd()
            end
        end
    end)
end

function IsItemGone(obj) return not obj or not obj.Parent end

function BeginCollectPause()
    FarmCollecting = true
    FarmForceRetarget = true
    LockActive = false
    if FarmAstroTokenEnabled then SetFarmAstroCollectPause(true) end
    task.wait(0.08)
end

function EndCollectPause()
    if FarmAstroTokenEnabled then SetFarmAstroCollectPause(false) end
    FarmCollecting = false
    FarmForceRetarget = true
    if AutoFarmEnabled then
        WaitingRespawn = false
        StartFarmLoop()
    end
    HandleMiscOptions(MiscOptions)
    task.delay(0.6, function()
        FarmForceRetarget = false
    end)
end

function CollectSingleItem(obj)
    if IsItemGone(obj) then return end
    local itemRoot = GetItemRootPart(obj)
    if not itemRoot then return end

    MoveToItem(itemRoot)

    local timeout = 0
    while AutoCollectEnabled and not IsItemGone(obj) and timeout < 8 do
        itemRoot = GetItemRootPart(obj)
        if not itemRoot then break end

        if timeout == 0 or timeout % 0.3 < 0.16 then
            local targetCF = GetItemTargetCFrame(itemRoot)
            pcall(function()
                if targetCF and Character and HumanoidRootPart then
                    Character:PivotTo(targetCF)
                    HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                end
            end)
        end

        ActivateItemPrompts(obj)
        task.wait(0.15)
        timeout = timeout + 0.15
    end

    KnownCollectItems[obj] = true
end

function AllMobsDead()
    return #GetFarmCandidateMobs(false) == 0
end

function StartAutoCollectLoop()
    if CollectRunning then return end
    CollectRunning = true
    task.spawn(function()
        while AutoCollectEnabled do
            if FarmAstroTokenEnabled and CollectMode == "Clean" then
                NotifyFarmAstroCleanMode()
                task.wait(1)
                continue
            end

            if #SelectedCollectItems > 0 then
                local itemsToCollect = FindNewCollectItems()
                if #itemsToCollect > 0 then
                    if CollectMode == "IDGF" then
                        BeginCollectPause()
                        for _, obj in ipairs(itemsToCollect) do
                            if not AutoCollectEnabled then break end
                            if not IsItemGone(obj) then CollectSingleItem(obj) else KnownCollectItems[obj] = true end
                        end
                        EndCollectPause()

                    elseif CollectMode == "Clean" then
                        local waitedClean = 0
                        while not AllMobsDead() and AutoCollectEnabled do
                            task.wait(0.5)
                            waitedClean = waitedClean + 0.5
                            if waitedClean >= 120 then break end
                        end
                        if not AutoCollectEnabled then break end

                        if AutoSkipHeliEnabled then TriggerAutoSkipHeli(false) end
                        BeginCollectPause()
                        for _, obj in ipairs(FindNewCollectItems()) do
                            if not AutoCollectEnabled then break end
                            if not IsItemGone(obj) then CollectSingleItem(obj) else KnownCollectItems[obj] = true end
                        end
                        EndCollectPause()
                        if AutoSkipHeliEnabled then TriggerAutoSkipHeli(true) end

                        if not IsPlayerHPFull() and AutoFillUpEnabled then
                            local fw = 0
                            while not IsPlayerHPFull() and AutoFillUpEnabled and AutoCollectEnabled do
                                task.wait(0.5)
                                fw = fw + 0.5
                                if fw >= 60 then break end
                            end
                        end
                    end
                else
                    for obj, _ in pairs(KnownCollectItems) do
                        if IsItemGone(obj) then KnownCollectItems[obj] = nil end
                    end
                end
            end
            task.wait(0.65)
        end
        FarmCollecting = false
        CollectRunning = false
    end)
end

workspace.DescendantAdded:Connect(function(obj)
    if not AutoCollectEnabled or #SelectedCollectItems == 0 then return end
    if AddCollectCandidate(obj) then
        CombatDebug("CollectItem", "新物品已缓存: " .. tostring(obj.Name), 3)
    end
end)

-- ============================================================
-- ====================== FARM ASTRO TOKEN ====================
-- ============================================================
FARM_ASTRO_TOKEN_IMAGE = "rbxassetid://104487529937663"
FARM_ASTRO_TOP_A       = CFrame.new(-680, 167, 505)
FARM_ASTRO_TOP_B       = CFrame.new(495, 167, 505)

FARM_ASTRO_LOW_A       = CFrame.new(-680, -15, -555)
FARM_ASTRO_LOW_B       = CFrame.new(500, -15, -555)
FARM_ASTRO_TIMER_TOP_CF = CFrame.new(-23.3435822, 67, 0.341766357)
FARM_ASTRO_TIMER_BOTTOM_CF = CFrame.new(-23.3435822, 2, 0.341766357)
FARM_ASTRO_TIMER_SAFE_CF = FARM_ASTRO_TIMER_BOTTOM_CF
FARM_ASTRO_TIMER_PART_OFFSET = CFrame.new(0, -4, 0)
FARM_ASTRO_TWEEN_TIME  = 0.3
FARM_ASTRO_TIMER_DROP_TIME = 0.35

function NotifyFarmAstroAutoFarm()
    local now = tick()
    if now - FarmAstroTokenLastAutoFarmNotify < 3 then return end
    FarmAstroTokenLastAutoFarmNotify = now
    WindUI:Notify({
        Title = "农场 Astro Token",
        Content = "请先关闭自动挂机再使用农场 Astro Token。",
        Duration = 4,
        Icon = "triangle-alert"
    })
end

function NotifyFarmAstroCleanMode()
    local now = tick()
    if now - FarmAstroTokenLastCleanNotify < 5 then return end
    FarmAstroTokenLastCleanNotify = now
    WindUI:Notify({
        Title = "农场 Astro Token",
        Content = "农场 Astro Token 不会击杀怪物，因此清理模式无法收集物品。请选择 IDGF 模式。",
        Duration = 5,
        Icon = "triangle-alert"
    })
end

function CheckFarmAstroCollectMode()
    if FarmAstroTokenEnabled and AutoCollectEnabled and CollectMode == "Clean" then
        NotifyFarmAstroCleanMode()
        return false
    end
    return true
end

function GetFarmAstroTimerLabel()
    local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    local wavesGui = playerGui:FindFirstChild("WavesGui")
    if not wavesGui then return nil end
    local frame = wavesGui:FindFirstChild("Frame")
    if not frame then return nil end
    return frame:FindFirstChild("Timer")
end

function GetFarmAstroTimerValue()
    local timerLabel = GetFarmAstroTimerLabel()
    if not timerLabel then return nil end
    local textValue = tostring(timerLabel.Text or "")
    local numberText = textValue:match("(%d+)%s*$") or textValue:match("(%d+)")
    if numberText then return tonumber(numberText) end
    return nil
end

function UpdateFarmAstroWaveTimerArmed(timerValue)
    FarmAstroLastWaveTimer = timerValue
    if timerValue ~= nil and timerValue > 10 then
        FarmAstroWaveTimerArmed = true
    end
end

function IsFarmAstroTimerEnding()
    if tick() < FarmAstroTokenTimerIgnoreUntil then return false end
    local timerValue = GetFarmAstroTimerValue()
    UpdateFarmAstroWaveTimerArmed(timerValue)
    return timerValue ~= nil and timerValue <= 10 and FarmAstroWaveTimerArmed == true
end

function IsFarmAstroTimerResetForNextWave()
    local timerValue = GetFarmAstroTimerValue()
    return timerValue ~= nil and timerValue > 10
end

function ShouldKeepFarmAstroFinalLock()
    if not FarmAstroTokenEnabled then return false end
    if FarmAstroFinalLockActive or FarmAstroTokenTimerHold or FarmAstroTimerDropping then return true end
    local timerValue = GetFarmAstroTimerValue()
    return timerValue ~= nil and timerValue <= 3 and FarmAstroWaveTimerArmed == true
end

function HoldFarmAstroBottomLockOnce()
    pcall(function()
        local char, hrp, hum = GetFarmAstroCharacter()
        if not char or not hrp then return end
        if hum then
            hum.Sit = false
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
        char:PivotTo(FARM_ASTRO_TIMER_BOTTOM_CF)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

function IsFarmAstroGodModeSelected()
    return table.find(MiscOptions or {}, "God Mode") ~= nil
end

function PauseFarmAstroGodModeForTimer()
    if not FarmAstroTokenEnabled then return false end
    if SyncFarmOnly then return false end
    if not IsFarmAstroGodModeSelected() then return false end
    if FarmAstroGodModePaused then return true end
    if tick() < FarmAstroTokenTimerIgnoreUntil then return false end

    local timerValue = GetFarmAstroTimerValue()
    UpdateFarmAstroWaveTimerArmed(timerValue)
    if timerValue ~= nil and timerValue <= 10 and FarmAstroWaveTimerArmed == true then
        FarmAstroGodModePaused = true
        GodModeTriggered = false
        CombatDebug("FarmAstroGodSync", "上帝模式百分比在波次计时器 " .. tostring(timerValue) .. " 处暂停", 2, false)
        return true
    end

    return false
end

function ResumeFarmAstroGodModeAfterRespawn(reason)
    local wasPaused = FarmAstroGodModePaused
    FarmAstroGodModePaused = false
    FarmAstroReviveGodTriggered = false
    FarmAstroReviveTimerArmed = false
    FarmAstroLastReviveTimer = nil
    FarmAstroFinalLockActive = false
    FarmAstroTimerDropping = false
    FarmAstroBottomGodTriggered = false
    FarmAstroReviveTimerArmed = false
    FarmAstroLastReviveTimer = nil
    FarmAstroWaveTimerArmed = false
    FarmAstroLastWaveTimer = nil

    if wasPaused and IsFarmAstroGodModeSelected() then
        CombatDebug("FarmAstroGodSync", "上帝模式在 " .. tostring(reason or "重生") .. " 后恢复", 2, false)
        task.defer(function()
            HandleMiscOptions(MiscOptions)
        end)
    end
end

function IsFarmAstroReviveState()
    local char, hrp, humanoid = GetFarmAstroCharacter()
    if not char or not hrp or not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    return humanoid.Health <= 1.05
end

function GetFarmAstroReviveTimerLabel()
    if not IsFarmAstroReviveState() then return nil end
    local char, hrp = GetFarmAstroCharacter()
    if not char or not hrp then return nil end
    local reviveUI = hrp:FindFirstChild("ReviveUI")
    if not reviveUI then return nil end
    if reviveUI.Enabled == false then return nil end
    local frame = reviveUI:FindFirstChild("Frame")
    if not frame then return nil end
    if frame:IsA("GuiObject") and frame.Visible == false then return nil end
    local label = frame:FindFirstChild("TextLabel")
    if not label then return nil end
    if label:IsA("GuiObject") and label.Visible == false then return nil end
    return label
end

function GetFarmAstroReviveTimerValue()
    local label = GetFarmAstroReviveTimerLabel()
    if not label then return nil end
    local textValue = tostring(label.Text or "")
    local numberText = textValue:match("^%s*[Tt][Ii][Mm][Ee][Rr]%s*:%s*(%d+)%s*$")
    if numberText then return tonumber(numberText) end
    return nil
end

function UpdateFarmAstroReviveTimerArmed(timerValue)
    FarmAstroLastReviveTimer = timerValue
    if not IsFarmAstroReviveState() then
        FarmAstroReviveTimerArmed = false
        return
    end
    if timerValue ~= nil and timerValue > 5 then
        FarmAstroReviveTimerArmed = true
    end
end

function CheckFarmAstroReviveGodModeOnce()
    if not FarmAstroTokenEnabled or not ShouldBlockFarmAstroGodModePercent() then
        FarmAstroReviveGodTriggered = false
        FarmAstroReviveTimerArmed = false
        FarmAstroLastReviveTimer = nil
        return
    end

    local reviveTimer = GetFarmAstroReviveTimerValue()
    UpdateFarmAstroReviveTimerArmed(reviveTimer)

    if reviveTimer == 5 and FarmAstroReviveTimerArmed == true then
        if not FarmAstroReviveGodTriggered then
            if ForceGodModeOnce("农场 Astro 复活计时器") then
                FarmAstroReviveGodTriggered = true
                FarmAstroReviveTimerArmed = false
            end
        end
    elseif reviveTimer == nil then
        FarmAstroReviveGodTriggered = false
        FarmAstroReviveTimerArmed = false
        FarmAstroLastReviveTimer = nil
    elseif reviveTimer > 5 then
        FarmAstroReviveGodTriggered = false
    end
end

function CheckFarmAstroBottomGodMode()
    if not FarmAstroTokenEnabled or not ShouldBlockFarmAstroGodModePercent() then return end
    if not FarmAstroFinalLockActive then return end
    if FarmAstroBottomGodTriggered then return end

    local reviveTimer = GetFarmAstroReviveTimerValue()
    UpdateFarmAstroReviveTimerArmed(reviveTimer)

    if reviveTimer == 5 and FarmAstroReviveTimerArmed == true then
        if ForceGodModeOnce("农场 Astro 底部锁定复活计时器") then
            FarmAstroBottomGodTriggered = true
            FarmAstroReviveGodTriggered = true
            FarmAstroReviveTimerArmed = false
        end
    elseif reviveTimer == nil then
        FarmAstroBottomGodTriggered = false
        FarmAstroReviveTimerArmed = false
        FarmAstroLastReviveTimer = nil
    elseif reviveTimer > 5 then
        FarmAstroBottomGodTriggered = false
    end
end

function FarmAstroRuntimeChecks()
    if not FarmAstroTokenEnabled then return end
    PauseFarmAstroGodModeForTimer()
    CheckFarmAstroReviveGodModeOnce()
    CheckFarmAstroBottomGodMode()
end


function GetFarmAstroCharacter()
    local char = LocalPlayer.Character or Character
    if (not char or not char.Parent) and workspace:FindFirstChild("Living") then
        char = workspace.Living:FindFirstChild(LocalPlayer.Name) or workspace.Living:FindFirstChild(LocalPlayer.DisplayName)
    end
    if char and char ~= Character then Character = char end
    if char and (not HumanoidRootPart or HumanoidRootPart.Parent ~= char) then
        HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    end
    return char, HumanoidRootPart, char and (char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Humanoid"))
end

function CreateFarmAstroTokenPart()
    if FarmAstroTokenPart and FarmAstroTokenPart.Parent then return FarmAstroTokenPart end

    local part = Instance.new("Part")
    part.Name = "farm_astro_token"
    part.Size = Vector3.new(10, 1, 10)
    part.Anchored = true
    part.CanCollide = true
    part.CanTouch = false
    part.CanQuery = false
    part.Material = Enum.Material.Neon
    part.Transparency = 1
    part.CFrame = FARM_ASTRO_TOP_A
    part.Parent = workspace

    for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
        local decal = Instance.new("Decal")
        decal.Name = "farm_astro_token_image"
        decal.Texture = FARM_ASTRO_TOKEN_IMAGE
        decal.Face = face
        decal.Transparency = 0
        decal.Parent = part
    end

    FarmAstroTokenPart = part
    return part
end

function FarmAstroSnapCharacterToPart()
    if not FarmAstroTokenPart or FarmAstroTokenPauseCollect then return end
    pcall(function()
        local char, hrp, hum = GetFarmAstroCharacter()
        if not char or not hrp then return end
        if hum then
            hum.Sit = false
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
        char:PivotTo(FarmAstroTokenPart.CFrame * CFrame.new(0, 4, 0))
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

function CancelFarmAstroTween()
    if FarmAstroTokenTween then
        pcall(function() FarmAstroTokenTween:Cancel() end)
        FarmAstroTokenTween = nil
    end
end

function MoveFarmAstroToTimerSafe()
    if FarmAstroFinalLockActive then return end

    CancelFarmAstroTween()
    CreateFarmAstroTokenPart()

    FarmAstroTokenTimerHold = false
    FarmAstroTimerDropping = true
    FarmAstroFinalLockActive = false
    FarmAstroBottomGodTriggered = false
    FarmAstroReviveTimerArmed = false
    FarmAstroLastReviveTimer = nil
    FarmAstroWaveTimerArmed = false
    FarmAstroLastWaveTimer = nil

    pcall(function()
        if FarmAstroTokenPart and FarmAstroTokenPart.Parent then
            FarmAstroTokenPart.CFrame = FARM_ASTRO_TIMER_BOTTOM_CF * FARM_ASTRO_TIMER_PART_OFFSET
        end
    end)

    pcall(function()
        local char, hrp, hum = GetFarmAstroCharacter()
        if not char or not hrp then return end
        if hum then
            hum.Sit = false
            hum.PlatformStand = false
            hum.AutoRotate = true
        end

        char:PivotTo(FARM_ASTRO_TIMER_TOP_CF)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    pcall(function()
        local char, hrp, hum = GetFarmAstroCharacter()
        if not char or not hrp then return end
        local tween = TweenService:Create(
            hrp,
            TweenInfo.new(FARM_ASTRO_TIMER_DROP_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            { CFrame = FARM_ASTRO_TIMER_BOTTOM_CF }
        )
        tween:Play()
        WaitTweenWithTimeout(tween, (FARM_ASTRO_TIMER_DROP_TIME or 0.35) + 0.45)
        if hum then
            hum.Sit = false
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
        char:PivotTo(FARM_ASTRO_TIMER_BOTTOM_CF)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    FarmAstroTimerDropping = false
    FarmAstroTokenTimerHold = true
    FarmAstroFinalLockActive = true
    CheckFarmAstroBottomGodMode()
end

function WaitFarmAstroRespawnAfterTimer()
    MoveFarmAstroToTimerSafe()
    local lockStartedAt = tick()

    while FarmAstroTokenEnabled do
        FarmAstroRuntimeChecks()
        if FarmAstroFinalLockActive or FarmAstroTokenTimerHold then
            HoldFarmAstroBottomLockOnce()
        end

        if tick() - lockStartedAt >= 0.25 and IsFarmAstroTimerResetForNextWave() then
            break
        end

        task.wait(0.1)
    end

    FarmAstroTokenTimerHold = false
    FarmAstroFinalLockActive = false
    FarmAstroTimerDropping = false
    FarmAstroBottomGodTriggered = false
    FarmAstroReviveGodTriggered = false
    FarmAstroReviveTimerArmed = false
    FarmAstroLastReviveTimer = nil
    FarmAstroWaveTimerArmed = false
    FarmAstroLastWaveTimer = nil
    FarmAstroTokenTimerIgnoreUntil = tick() + 2
    ResumeFarmAstroGodModeAfterRespawn("农场 Astro 计时器重置")
end

FarmAstroNoClipParts = FarmAstroNoClipParts or {}
FarmAstroNoClipChar = nil
FarmAstroNoClipPartsAt = 0

function RebuildFarmAstroNoClipParts(char)
    FarmAstroNoClipParts = {}
    FarmAstroNoClipChar = char
    FarmAstroNoClipPartsAt = tick()
    if not char then return end

    pcall(function()
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                table.insert(FarmAstroNoClipParts, obj)
            end
        end
    end)
end

function ApplyFarmAstroNoClipToCharacter(char)
    if not char then return end
    if FarmAstroNoClipChar ~= char or tick() - (FarmAstroNoClipPartsAt or 0) > 1.25 then
        RebuildFarmAstroNoClipParts(char)
    end

    for i = #FarmAstroNoClipParts, 1, -1 do
        local obj = FarmAstroNoClipParts[i]
        if obj and obj.Parent then
            obj.CanCollide = false
        else
            table.remove(FarmAstroNoClipParts, i)
        end
    end
end

function StartFarmAstroNoClip()
    if FarmAstroTokenNoClipConnection then return end
    FarmAstroTokenNoClipConnection = RunService.Heartbeat:Connect(function()
        if not FarmAstroTokenEnabled then return end
        pcall(function()
            local char, hrp, hum = GetFarmAstroCharacter()
            if not char then return end
            ApplyFarmAstroNoClipToCharacter(char)
            if hum then hum.Sit = false; hum.PlatformStand = false end
            if not FarmAstroTokenPauseCollect and hrp then
                if FarmAstroTimerDropping then
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                elseif FarmAstroFinalLockActive or FarmAstroTokenTimerHold then
                    char:PivotTo(FARM_ASTRO_TIMER_BOTTOM_CF)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                elseif FarmAstroTokenPart and FarmAstroTokenPart.Parent then
                    char:PivotTo(FarmAstroTokenPart.CFrame * CFrame.new(0, 4, 0))
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end)
    end)
end

function StopFarmAstroNoClip()
    if FarmAstroTokenNoClipConnection then
        FarmAstroTokenNoClipConnection:Disconnect()
        FarmAstroTokenNoClipConnection = nil
    end
end

function SetFarmAstroCollectPause(state)
    FarmAstroTokenPauseCollect = state == true
    CancelFarmAstroTween()
end

function TweenFarmAstroTokenTo(cf, duration)
    if not FarmAstroTokenPart or not FarmAstroTokenPart.Parent then return false end
    FarmAstroRuntimeChecks()
    if IsFarmAstroTimerEnding() then
        MoveFarmAstroToTimerSafe()
        return "timer_end"
    end
    CancelFarmAstroTween()

    FarmAstroTokenTween = TweenService:Create(
        FarmAstroTokenPart,
        TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
        { CFrame = cf }
    )
    FarmAstroTokenTween:Play()

    while FarmAstroTokenEnabled do
        FarmAstroRuntimeChecks()
        if IsFarmAstroTimerEnding() then
            MoveFarmAstroToTimerSafe()
            return "timer_end"
        end
        if FarmAstroTokenPauseCollect then
            CancelFarmAstroTween()
            return true
        end
        if not FarmAstroTokenTween or FarmAstroTokenTween.PlaybackState ~= Enum.PlaybackState.Playing then break end
        task.wait(0.05)
    end

    if not FarmAstroTokenEnabled then
        CancelFarmAstroTween()
        return false
    end

    FarmAstroTokenTween = nil
    pcall(function() FarmAstroTokenPart.CFrame = cf end)
    return true
end

function StartFarmAstroToken()
    if FarmAstroTokenRunning then return end
    if AutoFarmEnabled then
        FarmAstroTokenEnabled = false
        Config:Set("FarmAstroTokenEnabled", false)
        Config:Save()
        NotifyFarmAstroAutoFarm()
        return
    end

    FarmAstroTokenRunning = true
    NeedNoClip = true
    LockActive = false
    AutoAttackEnabled = false
    AutoSkillEnabled = false
    FarmAstroTokenTimerHold = false
    FarmAstroWaveTimerArmed = false
    FarmAstroLastWaveTimer = nil
    CreateFarmAstroTokenPart()
    StartFarmAstroNoClip()
    CheckFarmAstroCollectMode()
    HandleMiscOptions(MiscOptions)

    task.spawn(function()
        while FarmAstroTokenEnabled do
            if FarmAstroTokenPauseCollect then
                repeat task.wait(0.2) until not FarmAstroTokenPauseCollect or not FarmAstroTokenEnabled
            end
            if not FarmAstroTokenEnabled then break end

            FarmAstroRuntimeChecks()

            if FarmAstroFinalLockActive or FarmAstroTokenTimerHold then
                WaitFarmAstroRespawnAfterTimer()
                continue
            end

            if IsFarmAstroTimerEnding() then
                WaitFarmAstroRespawnAfterTimer()
                continue
            end

            CreateFarmAstroTokenPart()
            FarmAstroTokenPart.CFrame = FARM_ASTRO_TOP_A
            FarmAstroSnapCharacterToPart()

            local topResult = TweenFarmAstroTokenTo(FARM_ASTRO_TOP_B, FARM_ASTRO_TWEEN_TIME)
            if topResult == "timer_end" then
                WaitFarmAstroRespawnAfterTimer()
                continue
            end
            if not topResult then break end

            if FarmAstroTokenPauseCollect then continue end
            if IsFarmAstroTimerEnding() then
                WaitFarmAstroRespawnAfterTimer()
                continue
            end

            FarmAstroTokenPart.CFrame = FARM_ASTRO_LOW_A
            FarmAstroSnapCharacterToPart()

            local lowResult = TweenFarmAstroTokenTo(FARM_ASTRO_LOW_B, FARM_ASTRO_TWEEN_TIME)
            if lowResult == "timer_end" then
                WaitFarmAstroRespawnAfterTimer()
                continue
            end
            if not lowResult then break end
        end

        CancelFarmAstroTween()
        StopFarmAstroNoClip()
        if FarmAstroTokenPart then pcall(function() FarmAstroTokenPart:Destroy() end) end
        FarmAstroTokenPart = nil
        FarmAstroTokenPauseCollect = false
        FarmAstroTokenTimerHold = false
        FarmAstroFinalLockActive = false
        FarmAstroTimerDropping = false
        FarmAstroBottomGodTriggered = false
        FarmAstroReviveGodTriggered = false
        FarmAstroWaveTimerArmed = false
        FarmAstroLastWaveTimer = nil
        FarmAstroTokenRunning = false
        RestoreFarmCameraAndMovement()
        ResumeFarmAstroGodModeAfterRespawn("农场 Astro 已停止")
        HandleMiscOptions(MiscOptions)
    end)
end

function StopFarmAstroToken(saveState)
    FarmAstroTokenEnabled = false
    FarmAstroTokenTimerHold = false
    FarmAstroFinalLockActive = false
    FarmAstroTimerDropping = false
    FarmAstroBottomGodTriggered = false
    FarmAstroReviveGodTriggered = false
    FarmAstroReviveTimerArmed = false
    FarmAstroLastReviveTimer = nil
    FarmAstroWaveTimerArmed = false
    FarmAstroLastWaveTimer = nil
    ResumeFarmAstroGodModeAfterRespawn("农场 Astro 已禁用")
    if saveState then
        Config:Set("FarmAstroTokenEnabled", false)
        Config:Save()
    end
    CancelFarmAstroTween()
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if FarmAstroTokenEnabled then
            FarmAstroRuntimeChecks()
        else
            FarmAstroReviveGodTriggered = false
            FarmAstroBottomGodTriggered = false
            FarmAstroWaveTimerArmed = false
            FarmAstroLastWaveTimer = nil
        end
    end
end)

-- ============================================================
-- ====================== MAIN FARM LOOP (NEW SYSTEM) =========
-- ============================================================
FarmLoopToken = FarmLoopToken or 0

function StartFarmLoop()
    if FarmLoopRunning then return end
    FarmLoopRunning = true
    FarmLoopToken = (FarmLoopToken or 0) + 1
    local thisFarmLoopToken = FarmLoopToken

    task.spawn(function()
        local ok, err = pcall(function()
            task.spawn(function()
                while AutoFarmEnabled and FarmLoopRunning and FarmLoopToken == thisFarmLoopToken do
                    if WaitingRespawn and not LockActive and not FarmCollecting then
                        pcall(function()
                            RefreshCombatCharacter()
                            UpdateDYHUBWaitingPartCollision()
                            if Character and HumanoidRootPart then
                                if IsNearIdlePosition() then
                                    IdlePositionReached = true
                                    HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                                    HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                                else
                                    TeleportToIdle(false)
                                end
                            end
                        end)
                    else
                        IdlePositionReached = false
                    end
                    task.wait(0.35)
                end
            end)

            while AutoFarmEnabled and FarmLoopToken == thisFarmLoopToken do
                RefreshCombatCharacter()

                if ResetWaveTeleporting then
                    LockActive = false
                    FarmForceRetarget = true
                    _interruptSignal = true
                    task.wait(0.12)
                    continue
                end

                if not Character or not HumanoidRootPart then
                    task.wait(0.5)
                    continue
                end

                if FarmCollecting then
                    task.wait(0.2)
                    continue
                end

                if FarmTargetMode == "Dark Dimension Mode" and HandleDarkDimensionSanity() then
                    task.wait(0.1)
                    continue
                end

                if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(nil) then
                    task.wait(0.12)
                    continue
                end

                local mob, mobType, extraData, priority = SafeGetPriorityMob()

                if mob and ValidateFarmTargetBeforeMove and not ValidateFarmTargetBeforeMove(mob, "预目标门") then
                    task.wait(0.18)
                    continue
                end

                if mob then
                    if FarmTargetMode == "Astro Holdout Mode" then AstroModeFinalRunning = false end
                    WaitingRespawn = false
                    IdlePositionReached = false
                    _currentTargetPriority = priority

                    if mobType == "GiantST" and extraData then
                        if ValidateFarmTargetBeforeMove and not ValidateFarmTargetBeforeMove(mob, "巨型目标门") then
                            task.wait(0.18)
                            continue
                        end
                        TeleportToMob(mob)
                        if ValidateFarmTargetBeforeMove and not ValidateFarmTargetBeforeMove(mob, "巨型移动后门") then
                            task.wait(0.18)
                            continue
                        end
                        if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(mob) then
                            task.wait(0.12)
                            continue
                        end

                        local giantLockConn
                        giantLockConn = RunService.Heartbeat:Connect(function()
                            if IsMobDead(mob) or not mob.Parent or not AutoFarmEnabled or FarmCollecting or FarmForceRetarget or (IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive()) or IsDarkDimensionSanityLow() or (IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive() and IsMobBlockedByJeffrey(mob, GetFarmTargetDangerRange and GetFarmTargetDangerRange() or 70)) then
                                if giantLockConn then giantLockConn:Disconnect() end
                                return
                            end
                            local lockCF = GetTargetCFrame(mob, FarmPosition)
                            if lockCF and Character and HumanoidRootPart then
                                MoveCharacterToFarmCFrame(lockCF)
                            end
                        end)

                        repeat
                            task.wait(0.2)
                            if HandleDarkDimensionSanityEmergency and HandleDarkDimensionSanityEmergency() then break end
                            if FarmCollecting or FarmForceRetarget then break end
                            if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(mob) then
                                break
                            end
                            ActivateProximityPrompt(extraData)
                            ActivateAllFlushPrompts()
                        until IsMobDead(mob) or not mob.Parent or not AutoFarmEnabled

                        if giantLockConn then pcall(function() giantLockConn:Disconnect() end) end

                    else
                        if SafeModeEnabled and GetPlayerHealthPercent() < SafeValue then
                            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
                            if mobRoot then
                                local safePos = mobRoot.Position + Vector3.new(0, 111, 0)
                                pcall(function()
                                    Character:PivotTo(CFrame.new(safePos))
                                    HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                                    HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                                end)
                            end
                            task.wait(0.5)
                        else
                            if ValidateFarmTargetBeforeMove and not ValidateFarmTargetBeforeMove(mob, "普通目标门") then
                                task.wait(0.18)
                                ResetMobOverride(mob)
                                ClearMobBoundsCache(mob)
                                continue
                            end
                            StartDamageChecker(mob)
                            TeleportToMob(mob)
                            if ValidateFarmTargetBeforeMove and not ValidateFarmTargetBeforeMove(mob, "普通移动后门") then
                                task.wait(0.18)
                                ResetMobOverride(mob)
                                ClearMobBoundsCache(mob)
                                continue
                            end
                            if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(mob) then
                                task.wait(0.12)
                                ResetMobOverride(mob)
                                ClearMobBoundsCache(mob)
                                continue
                            end

                            LockActive = true
                            local lockConn
                            lockConn = RunService.Heartbeat:Connect(function()
                                if not AutoFarmEnabled or IsMobDead(mob) or not LockActive or FarmCollecting or FarmForceRetarget or (IsAntiJeffreyEscapePauseActive and IsAntiJeffreyEscapePauseActive()) or IsDarkDimensionSanityLow() or (IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive() and IsMobBlockedByJeffrey(mob, GetFarmTargetDangerRange and GetFarmTargetDangerRange() or 70)) then
                                    if lockConn then lockConn:Disconnect() end
                                    LockActive = false
                                    return
                                end
                                if not Character or not HumanoidRootPart then return end
                                local cf = GetTargetCFrame(mob, FarmPosition)
                                if cf then
                                    MoveCharacterToFarmCFrame(cf)
                                end
                            end)

                            repeat
                                task.wait(0.15)
                                if HandleDarkDimensionSanityEmergency and HandleDarkDimensionSanityEmergency() then break end
                                if FarmCollecting or FarmForceRetarget then break end
                                if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(mob) then
                                    break
                                end

                                local shouldInterrupt, newPriority = CheckInterrupt(priority)
                                if shouldInterrupt then
                                    _interruptSignal = true
                                    break
                                end
                            until IsMobDead(mob) or not AutoFarmEnabled

                            if lockConn then pcall(function() lockConn:Disconnect() end) end
                            LockActive = false
                            if ResetWaveTeleporting then
                                FarmForceRetarget = true
                                _interruptSignal = true
                            else
                                _interruptSignal = false
                                FarmForceRetarget = false
                            end
                            ResetMobOverride(mob)
                            ClearMobBoundsCache(mob)
                        end
                    end

                else
                    _currentTargetPriority = 0
                    if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(nil) then
                        task.wait(0.25)
                    elseif IsFarmJeffreyAvoidActive and IsFarmJeffreyAvoidActive() and HasAnyJeffreyRoot and HasAnyJeffreyRoot() and tick() - (JeffreyLastUnsafeTargetAt or 0) <= 2.5 then
                        MoveToJeffreySafeHold("无安全农场目标")
                        task.wait(0.25)
                    elseif FarmTargetMode == "Astro Holdout Mode" then
                        CombatDebug("AstroMode", "未找到 Astro 怪物。进入最终门。", 5)
                        DoAstroModeFinalDoor()
                    else
                        TeleportToIdle()
                    end
                    repeat
                        task.wait(0.5)
                        if HandleFarmJeffreyEmergency and HandleFarmJeffreyEmergency(nil) then break end
                    until ResetWaveTeleporting or FarmCollecting or SafeGetPriorityMob() ~= nil or not AutoFarmEnabled
                    WaitingRespawn = false
                end

                task.wait(0.12)
            end
        end)

        if not ok then
            warn("[DYHUB] 农场循环错误:", tostring(err))
            CombatDebug("FarmLoopError", tostring(err), 3, true)
        end

        WaitingRespawn = false
        FarmCollecting = false
        if ResetWaveTeleporting then
            FarmForceRetarget = true
            _interruptSignal = true
        else
            FarmForceRetarget = false
            _interruptSignal = false
            RestoreFarmCameraAndMovement()
        end
        _currentTargetPriority = 0
        FarmLoopRunning = false

        if AutoFarmEnabled and not ResetWaveTeleporting then
            task.delay(0.5, function()
                if AutoFarmEnabled and not ResetWaveTeleporting then StartFarmLoop() end
            end)
        end
    end)
end


-- ====================== RESET WAVE SYSTEM ======================
function GetResetWaveLabel()
    local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end

    local wavesGui = playerGui:FindFirstChild("WavesGui")
    if not wavesGui then return nil end

    local frame = wavesGui:FindFirstChild("Frame")
    if not frame then return nil end

    return frame:FindFirstChild("TextLabel")
end

function GetCurrentResetWave()
    local label = GetResetWaveLabel()
    if not label then return nil end

    local ok, textValue = pcall(function()
        return tostring(label.Text or "")
    end)
    if not ok then return nil end

    local waveText = textValue:match("[Ww]ave%s*=?%s*(%d+)")
    if not waveText then
        waveText = textValue:match("(%d+)")
    end

    return tonumber(waveText)
end

function GetResetWaveTargetValue()
    local value = tonumber(ResetWaveValue) or 10
    value = math.floor(value)
    if value < 1 then value = 1 end
    return value
end

function GetResetWaveTriggerKey(currentWave, targetWave)
    return tostring(tonumber(currentWave) or "nil") .. ":" .. tostring(tonumber(targetWave) or "nil")
end

function ClearResetWaveTrigger(reason)
    ResetWaveLastTriggeredWave = nil
    ResetWaveLastTriggeredKey = nil
    CombatDebug("ResetWave", "触发器已清除: " .. tostring(reason or "重置"), 3, false)
end

function IsResetWaveCharacterReady()
    RefreshCombatCharacter()
    if not Character or not Character.Parent or not HumanoidRootPart or not HumanoidRootPart.Parent then
        return false
    end

    local humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health <= 0 then
        return false
    end

    return true
end

function BreakFarmLockForResetWave()
    ResetWaveTeleporting = true
    FarmForceRetarget = true
    FarmCollecting = false
    LockActive = false
    _interruptSignal = true
    WaitingRespawn = false
    _currentTargetPriority = 0

    pcall(function()
        RefreshCombatCharacter()
        if Character then
            local humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Sit = false
                humanoid.PlatformStand = false
                humanoid.AutoRotate = true
            end
        end
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)

    pcall(function() RunService.Heartbeat:Wait() end)
end

function HoldResetWavePosition(token)
    local holdUntil = tick() + (ResetWaveHoldTime or 2)

    while ResetWaveEnabled and ResetWaveTeleporting and token == ResetWaveToken and tick() < holdUntil do
        if not IsMiscFarmAllowed() then return false end
        if not IsResetWaveCharacterReady() then return false end

        pcall(function()
            local humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Sit = false
                humanoid.PlatformStand = false
                humanoid.AutoRotate = true
            end

            NeedNoClip = true
            Character:PivotTo(ResetWaveTargetCF)
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
            StabilizeFarmCamera()
        end)

        task.wait(0.1)
    end

    return ResetWaveEnabled and token == ResetWaveToken and IsResetWaveCharacterReady()
end

function FinishResetWaveTeleport(token, completed, currentWave, targetWave)
    if token ~= ResetWaveToken then return end

    ResetWaveTeleporting = false

    if completed then
        ResetWaveLastTriggeredWave = currentWave
        ResetWaveLastTriggeredKey = GetResetWaveTriggerKey(currentWave, targetWave)
        CombatDebug("ResetWave", "在波次 " .. tostring(currentWave) .. " 保持重置点 " .. tostring(ResetWaveHoldTime or 2) .. " 秒", 2, false)
    else
        ClearResetWaveTrigger("传送中断")
    end

    FarmForceRetarget = false
    _interruptSignal = false
    LockActive = false

    if completed and ResetWaveEnabled and AutoFarmEnabled and StartFarmLoop then
        task.defer(function()
            if ResetWaveEnabled and AutoFarmEnabled and not ResetWaveTeleporting then
                StartFarmLoop()
            end
        end)
    end
end

function TeleportResetWave(currentWave, targetWave, force, reason)
    if ResetWaveTeleporting then return false end

    local now = tick()
    if not force and now - (ResetWaveLastTeleportAt or 0) < 0.6 then return false end
    ResetWaveLastTeleportAt = now

    currentWave = tonumber(currentWave) or GetCurrentResetWave()
    targetWave = tonumber(targetWave) or GetResetWaveTargetValue()
    if not currentWave or currentWave < targetWave then return false end

    ResetWaveToken = (ResetWaveToken or 0) + 1
    local token = ResetWaveToken

    BreakFarmLockForResetWave()

    local ok, completed = pcall(function()
        if not IsResetWaveCharacterReady() then return false end

        pcall(function()
            NeedNoClip = true
            Character:PivotTo(ResetWaveTargetCF)
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end)

        return HoldResetWavePosition(token)
    end)

    FinishResetWaveTeleport(token, ok and completed == true, currentWave, targetWave)
    return ok and completed == true
end

function EvaluateResetWaveNow(reason, force)
    if not ResetWaveEnabled or not IsMiscFarmAllowed() or ResetWaveTeleporting then return false end

    local currentWave = GetCurrentResetWave()
    local targetWave = GetResetWaveTargetValue()

    if currentWave == nil then return false end

    if currentWave >= targetWave then
        local key = GetResetWaveTriggerKey(currentWave, targetWave)
        if force or ResetWaveLastTriggeredKey ~= key then
            return TeleportResetWave(currentWave, targetWave, force == true, reason)
        end
    else
        ClearResetWaveTrigger("波次低于目标")
    end

    return false
end

function StartResetWaveLoop()
    if ResetWaveLoopRunning then return end
    ResetWaveLoopRunning = true

    task.spawn(function()
        while ResetWaveEnabled do
            pcall(function()
                EvaluateResetWaveNow("循环", false)
            end)

            task.wait(ResetWaveTeleporting and 0.1 or 0.25)
        end

        ResetWaveLoopRunning = false
    end)
end
-- ====================== MISC OPTIONS HANDLER ======================
function HandleMiscOptions(selectedOptions)
    selectedOptions = selectedOptions or {}
    MiscOptions = selectedOptions

    local canRun = IsMiscFarmAllowed()

    local hasAutoAttack = table.find(selectedOptions, "Auto Attack") ~= nil
    if hasAutoAttack and canRun then
        AutoAttackEnabled = true
        StartAutoAttack()
    else
        AutoAttackEnabled = false
    end

    local hasAutoSkill = table.find(selectedOptions, "Auto Skill") ~= nil
    if hasAutoSkill and canRun then
        AutoSkillEnabled = true
        StartAutoSkill()
    else
        AutoSkillEnabled = false
    end

    local hasAutoSkipHeli = table.find(selectedOptions, "Auto Skip Helicopter")
    if hasAutoSkipHeli and canRun then
        if not AutoSkipHeliEnabled then AutoSkipHeliEnabled = true; TriggerAutoSkipHeli(true) end
    else
        if AutoSkipHeliEnabled then TriggerAutoSkipHeli(false) end
        AutoSkipHeliEnabled = false
    end

    local hasBoostFPS = table.find(selectedOptions, "Delete Map")
    if hasBoostFPS and canRun then
        if not BoostFPS_Active then SaveAndBoostFPS() end
    elseif BoostFPS_Active then
        RestoreBoostFPS()
    end

    SafeModeEnabled = table.find(selectedOptions, "Safe Mode") ~= nil and canRun
    GodModeEnabled  = table.find(selectedOptions, "God Mode") ~= nil and canRun

    local hasResetWave = table.find(selectedOptions, "Reset Wave")
    if hasResetWave and canRun then
        if not ResetWaveEnabled then
            ClearResetWaveTrigger("enabled")
        end
        ResetWaveEnabled = true
        StartResetWaveLoop()
        task.defer(function()
            EvaluateResetWaveNow("enabled", true)
        end)
    else
        ResetWaveEnabled = false
        ResetWaveTeleporting = false
        ResetWaveToken = (ResetWaveToken or 0) + 1
        ClearResetWaveTrigger("disabled")
    end

    local hasAutoStart = table.find(selectedOptions, "Auto Start")
    if hasAutoStart and canRun then
        if not AutoStartEnabled then StartAutoStart() end
    else
        if AutoStartEnabled then StopAutoStart() end
    end

    local hasAutoFillUp = table.find(selectedOptions, "Auto Fill Up")
    if hasAutoFillUp and canRun then
        if not AutoFillUpEnabled then AutoFillUpEnabled = true; StartAutoFillUpLoop() end
    else
        AutoFillUpEnabled = false
        FillUpRunning = false
    end

    Config:Set("MiscOptions", selectedOptions)
    Config:Set("AutoStartEnabled", hasAutoStart ~= nil)
    Config:Save()
end

-- ====================== CHARACTER RESPAWN HANDLER ======================
LocalPlayer.CharacterAdded:Connect(function(char)
    local keepFarmAstroBottomLock = ShouldKeepFarmAstroFinalLock and ShouldKeepFarmAstroFinalLock()

    Character        = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Client           = LocalPlayer
    FarmAstroTokenRespawnCounter = FarmAstroTokenRespawnCounter + 1

    -- Reset Wave 在死亡/重生时必须停止，如果波次仍达到目标则允许再次触发。
    ResetWaveToken = (ResetWaveToken or 0) + 1
    ResetWaveTeleporting = false
    ClearResetWaveTrigger("角色重生")

    if keepFarmAstroBottomLock then
        FarmAstroTokenTimerHold = true
        FarmAstroFinalLockActive = true
        FarmAstroTimerDropping = false
        FarmAstroReviveGodTriggered = false
        FarmAstroReviveTimerArmed = false
        FarmAstroLastReviveTimer = nil
        FarmAstroTokenTimerIgnoreUntil = 0
        if FarmAstroTokenEnabled then CancelFarmAstroTween() end
        task.defer(function()
            for _ = 1, 25 do
                if not FarmAstroTokenEnabled then break end
                if not (FarmAstroFinalLockActive or FarmAstroTokenTimerHold) then break end
                HoldFarmAstroBottomLockOnce()
                task.wait(0.05)
            end
        end)
    else
        FarmAstroTokenTimerHold = false
        FarmAstroFinalLockActive = false
        FarmAstroTimerDropping = false
        FarmAstroBottomGodTriggered = false
        FarmAstroReviveGodTriggered = false
        FarmAstroReviveTimerArmed = false
        FarmAstroLastReviveTimer = nil
        FarmAstroWaveTimerArmed = false
        FarmAstroLastWaveTimer = nil
        FarmAstroTokenTimerIgnoreUntil = tick() + 2
        ResumeFarmAstroGodModeAfterRespawn("角色重生")
        if FarmAstroTokenEnabled then CancelFarmAstroTween() end
    end

    JeffreyCacheAt = 0
    UpdateDYHUBWaitingPartCollision()
    MobHeightOverride   = {}
    MobConfirmedPadding = {}
    MobLastHealth       = {}
    IdlePositionReached = false
    LastIdleTeleportAt  = 0
    InvalidateMobCache("角色重生")
    ClearMobBoundsCache()
    FarmForceRetarget = true
    FarmCollecting = false
    task.delay(0.25, function()
        RestartCombatLoopsIfNeeded("角色重生")
        if AutoFarmEnabled and not ResetWaveTeleporting then StartFarmLoop(); StartJeffreyGuardLoop() end
        if ResetWaveEnabled then
            StartResetWaveLoop()
            EvaluateResetWaveNow("角色重生", true)
        end
        if BypassJeffreyEnabled then StartBypassJeffreyLoop(); ScanBypassJeffreys(true) end
    end)
    task.delay(0.8, function()
        if not ResetWaveTeleporting then
            FarmForceRetarget = false
        end
    end)
    task.wait(1)
    ApplyCameraMode(true)
end)

-- ====================== UI: MAIN ======================
Main:Section({ Title = T("auto_farm"), Icon = "package" })

AutoFarmToggle = Main:Toggle({
    Title = T("auto_farm"),
    Desc = T("auto_farm_desc"),
    Value = AutoFarmEnabled,
    Callback = function(state)
        if state and FarmAstroTokenEnabled then
            AutoFarmEnabled = false
            UpdateDYHUBWaitingPartCollision()
            Config:Set("AutoFarmEnabled", false)
            Config:Save()
            NotifyFarmAstroAutoFarm()
            return
        end
        AutoFarmEnabled = state
        UpdateDYHUBWaitingPartCollision()
        if state then
            StartFarmLoop()
            StartJeffreyGuardLoop()
            HandleMiscOptions(MiscOptions)
            WindUI:Notify({ Title = T("auto_farm"), Content = T("farm_enabled"), Duration = 2, Icon = "play" })
        else
            FarmLoopToken = (FarmLoopToken or 0) + 1
            WaitingRespawn = false
            LockActive = false
            RestoreFarmCameraAndMovement()
            UpdateDYHUBWaitingPartCollision()
            if SyncFarmOnly then
                StopMiscFarmRuntime("Auto Farm turned off while Sync Farm Only is ON")
                WindUI:Notify({ Title = T("auto_farm"), Content = "已关闭自动挂机（同步模式开启，辅助功能已停止）", Duration = 3, Icon = "square" })
            else
                HandleMiscOptions(MiscOptions)
                WindUI:Notify({ Title = T("auto_farm"), Content = "已关闭自动挂机（同步模式关闭，辅助功能保持运行）", Duration = 3, Icon = "unlink" })
            end
        end
        Config:Set("AutoFarmEnabled", state); Config:Save()
    end
})

-- 全部用户均可使用 Mode Farm（付费墙已移除）
FarmTargetModeDropdown = Main:Dropdown({
    Title = T("mode_farm"),
    Desc = "选择不同的农场模式。",
    Values = { "Normal Mode", "Astro Holdout Mode", "Dark Dimension Mode" },
    Multi = false,
    Value = FarmTargetMode,
    Callback = function(value)
        FarmTargetMode = NormalizeFarmTargetMode(value)
        Config:Set("FarmTargetMode", FarmTargetMode)
        Config:Save()
        InvalidateMobCache("farm target mode changed")
        FarmForceRetarget = true
        if AutoFarmEnabled then StartFarmLoop(); StartJeffreyGuardLoop() end
        task.delay(0.4, function() if not IsAntiJeffreyEscapePauseActive() then FarmForceRetarget = false end end)
        WindUI:Notify({ Title = T("mode_farm"), Content = "已选择: " .. tostring(FarmTargetMode), Duration = 2, Icon = "target" })
    end
})

Main:Section({ Title = T("farm_settings"), Icon = "settings" })

PositionDropdown = Main:Dropdown({
    Title = T("position_farm"),
    Desc = "选择角色相对目标的站位。",
    Values = { T("position_above"), T("position_under") },
    Multi = false,
    Value = FarmPosition,
    Callback = function(value) FarmPosition = value; Config:Set("FarmPosition", value); Config:Save() end
})

ModeDropdown = Main:Dropdown({
    Title = T("movement_farm"),
    Desc = "选择角色移动到每个目标的方式。",
    Values = { "Teleport", "Tween" },
    Multi = false,
    Value = FarmMode,
    Callback = function(value)
        FarmMode = NormalizeFarmMode(value)
        Config:Set("FarmMode", FarmMode)
        Config:Save()
        WindUI:Notify({ Title = T("movement_farm"), Content = "已选择: " .. tostring(FarmMode), Duration = 2, Icon = "mouse-pointer-click" })
    end
})

MiscDropdown = Main:Dropdown({
    Title = T("misc_farm"),
    Desc = "选择与自动挂机配合运行的额外系统。",
    Values = { "Auto Attack", "Auto Skill", "Auto Start", "Auto Skip Helicopter", "Auto Fill Up", "Safe Mode", "God Mode", "Reset Wave", "Delete Map" },
    Multi = true,
    Value = MiscOptions,
    Callback = function(values)
        MiscOptions = values
        -- 如果辅助功能开启但自动挂机关闭且同步模式开启，给出提示
        if not AutoFarmEnabled and SyncFarmOnly and #values > 0 then
            WindUI:Notify({
                Title = T("misc_farm"),
                Content = "请先开启自动挂机（同步模式已开启）",
                Duration = 3, Icon = "triangle-alert"
            })
        end
        HandleMiscOptions(values)
    end
})

Main:Toggle({
    Title = T("sync_mode"),
    Desc = T("sync_desc"),
    Value = SyncFarmOnly,
    Callback = function(state)
        SyncFarmOnly = state
        Config:Set("SyncFarmOnly", state)
        Config:Save()
        if state then
            WindUI:Notify({ Title = T("sync_mode"), Content = T("sync_on"), Duration = 3, Icon = "link" })
        else
            WindUI:Notify({ Title = T("sync_mode"), Content = T("sync_off"), Duration = 3, Icon = "unlink" })
        end
        -- 无论开关，重新应用门控
        ApplyMiscFarmGate("Sync Farm Only 已更改")
    end
})


Main:Section({ Title = T("farm_astro"), Icon = "flame" })

FarmAstroTokenToggle = Main:Toggle({
    Title = T("farm_astro"),
    Desc = T("farm_astro_desc"),
    Value = FarmAstroTokenEnabled,
    Callback = function(state)
        if state and AutoFarmEnabled then
            FarmAstroTokenEnabled = false
            Config:Set("FarmAstroTokenEnabled", false)
            Config:Save()
            NotifyFarmAstroAutoFarm()
            pcall(function()
                if FarmAstroTokenToggle and FarmAstroTokenToggle.Set then
                    FarmAstroTokenToggle:Set(false)
                end
            end)
            return
        end

        FarmAstroTokenEnabled = state
        Config:Set("FarmAstroTokenEnabled", state)
        Config:Save()

        if state then
            StartFarmAstroToken()
            WindUI:Notify({
                Title = T("farm_astro"),
                Content = "已启用。Astro 路线已开始。",
                Duration = 3,
                Icon = "sparkles"
            })
        else
            StopFarmAstroToken(false)
            WindUI:Notify({
                Title = T("farm_astro"),
                Content = "已禁用。Astro 路线已停止。",
                Duration = 3,
                Icon = "square"
            })
        end
    end
})

Main:Section({ Title = T("general_settings"), Icon = "zap" })

SkillDropdown = Main:Dropdown({
    Title = T("skill_keys"),
    Desc = "选择自动技能要按下的技能按键。",
    Values = skillDropdownValues,
    Multi = true,
    Value = SelectedSkills,
    Callback = function(values) SelectedSkills = values; Config:Set("SelectedSkills", values); Config:Save() end
})

SkillDelaySlider = Main:Slider({
    Title = T("skill_delay"),
    Desc = "设置每个技能按键之间的延迟（秒）。",
    Value = { Min = 1, Max = 60, Default = SkillDelay },
    Step = 1,
    Callback = function(value) SkillDelay = value; Config:Set("SkillDelay", value); Config:Save() end
})

FarmHeightSlider = Main:Slider({
    Title = T("height_offset"),
    Desc = "调整在怪物上方或下方挂机时的垂直偏移。",
    Value = { Min = -150, Max = 150, Default = HeightValue },
    Step = 1,
    Callback = function(value)
        HeightValue = value; Config:Set("HeightValue", value); Config:Save()
        for mob, _ in pairs(MobHeightOverride) do
            if MobConfirmedPadding[mob] == nil then MobHeightOverride[mob] = nil end
        end
    end
})

Main:Slider({
    Title = T("safe_hp"),
    Desc = "设置安全模式撤退前使用的生命值百分比。",
    Value = { Min = 1, Max = 99, Default = SafeValue },
    Step = 1,
    Callback = function(value) SafeValue = value; Config:Set("SafeValue", value); Config:Save() end
})

Main:Slider({
    Title = T("god_hp"),
    Desc = "设置普通上帝模式的生命值百分比阈值。农场 Astro Token 且同步模式关闭时被阻止；由复活系统接管。",
    Value = { Min = 1, Max = 99, Default = GodModeValue },
    Step = 1,
    Callback = function(value)
        GodModeValue = value
        Config:Set("GodModeValue", value)
        Config:Save()
    end
})

Main:Slider({
    Title = T("reset_wave_val"),
    Desc = "如果达到指定波次，将立即重置。",
    Value = { Min = 1, Max = 100, Default = ResetWaveValue },
    Step = 1,
    Callback = function(value)
        ResetWaveValue = tonumber(value) or 10
        ClearResetWaveTrigger("滑条更改")
        Config:Set("ResetWaveValue", ResetWaveValue)
        Config:Save()

        if ResetWaveEnabled and IsMiscFarmAllowed() then
            StartResetWaveLoop()
            task.defer(function()
                EvaluateResetWaveNow("滑条更改", true)
            end)
        end
    end
})

Main:Divider()

BypassJeffreyToggle = Main:Toggle({
    Title = T("bypass_jeffrey"),
    Desc = "使 Jeffrey 坐下并不再骚扰你。",
    Value = BypassJeffreyEnabled,
    Callback = function(state)
        BypassJeffreyEnabled = state
        Config:Set("BypassJeffreyEnabled", state)
        Config:Save()
        if state then
            StartBypassJeffreyLoop()
            ScanBypassJeffreys(true)
        end
    end
})

AntiJeffreyToggle = Main:Toggle({
    Title = T("anti_jeffrey"),
    Desc = "免费功能：创建一道软性隐形屏障。如果有 Jeffrey 进入范围，你会被慢慢推开。",
    Value = AntiJeffreyEnabled,
    Callback = function(state)
        AntiJeffreyEnabled = state
        Config:Set("AntiJeffreyEnabled", state)
        Config:Save()
        if state then StartAntiJeffreyLoop(); StartJeffreyGuardLoop() end
    end
})

Main:Slider({
    Title = T("anti_jeffrey_range"),
    Desc = "设置反 Jeffrey 使用的距离。默认 50 格。",
    Value = { Min = 10, Max = 200, Default = AntiJeffreyRange },
    Step = 1,
    Callback = function(value)
        AntiJeffreyRange = value
        Config:Set("AntiJeffreyRange", value)
        Config:Save()
    end
})

if AntiJeffreyEnabled then StartAntiJeffreyLoop(); StartJeffreyGuardLoop() end
if BypassJeffreyEnabled then StartBypassJeffreyLoop(); ScanBypassJeffreys(true) end

-- ====================== UI: PRIORITY SETTINGS ======================
Main:Section({ Title = T("priority_settings"), Icon = "list-ordered" })

Main:Paragraph({
    Title = "优先级顺序",
    Desc = "中断：如果正在攻击一个低最大生命值的怪物，而出现更高最大生命值的怪物，将立即切换",
    Image = "rbxassetid://104487529937663",
    ImageSize = 26,
})

Main:Slider({
    Title = T("high_hp_threshold"),
    Desc = "设置怪物成为高生命值优先级所需的最大生命值。",
    Value = { Min = 1, Max = 100000, Default = HighHPThreshold },
    Step = 100,
    Callback = function(value)
        HighHPThreshold = value
        Config:Set("HighHPThreshold", value)
        Config:Save()
        print("[DYHUB] 高生命值阈值已设置为 " .. value)
    end
})

-- ====================== UI: OVERRIDE SETTINGS ======================
Main:Section({ Title = T("override_settings"), Icon = "ruler" })

PaddingReduceInput = Main:Input({
    Title = T("padding_reduce"),
    Default = tostring(PADDING_REDUCE_STEP),
    Placeholder = "默认: 2",
    Callback = function(text)
        local num = tonumber(text)
        if num then PADDING_REDUCE_STEP = num; Config:Set("PaddingReduceStep", num); Config:Save()
        else warn("输入了无效数字！") end
    end
})

PaddingSafeInput = Main:Input({
    Title = T("padding_safe"),
    Default = tostring(PADDING_SAFE_MIN),
    Placeholder = "默认: -30",
    Callback = function(text)
        local num = tonumber(text)
        if num then PADDING_SAFE_MIN = num; Config:Set("PaddingSafeMin", num); Config:Save()
        else warn("输入了无效数字！") end
    end
})

Main:Slider({
    Title = T("anti_clip_margin"),
    Desc = "增加额外间距，减少在怪物身体附近挂机时的穿透。",
    Value = { Min = -10, Max = 10, Default = ANTI_CLIP_MARGIN },
    Step = 1,
    Callback = function(value)
        ANTI_CLIP_MARGIN = value; Config:Set("AntiClipMargin", value); Config:Save()
    end
})

Main:Slider({
    Title = T("dmg_threshold"),
    Desc = "设置多少伤害可确认当前挂机位置有效。",
    Value = { Min = 1, Max = 500, Default = DMG_THRESHOLD },
    Step = 1,
    Callback = function(value)
        DMG_THRESHOLD = value; Config:Set("DmgThreshold", value); Config:Save()
    end
})

Main:Button({
    Title = T("reset_positions"),
    Desc = "清除所有已保存的怪物高度位置，重置为默认值。",
    Callback = function()
        MobConfirmedPadding = {}
        MobHeightOverride   = {}
        WindUI:Notify({ Title = T("override_settings"), Content = "所有已确认的怪物位置已清除。", Duration = 2, Icon = "refresh-cw" })
    end
})

Main:Section({ Title = T("flush_settings"), Icon = "toilet" })

Flushaura      = Config:Get("flushaura", false)
FlushAuraValue = Config:Get("FlushAuraValue", 5)

Main:Slider({
    Title = T("flush_range"),
    Desc = "设置冲水光环激活附近提示的距离。",
    Value = { Min = 1, Max = 15, Default = FlushAuraValue },
    Step = 1,
    Callback = function(value) FlushAuraValue = value; Config:Set("FlushAuraValue", value); Config:Save() end
})

Main:Toggle({
    Title = T("flush_aura"),
    Desc = "自动冲刷设定半径内的冲水提示。",
    Value = Flushaura,
    Callback = function(enabled)
        Flushaura = enabled; Config:Set("flushaura", enabled); Config:Save()
        if enabled then
            task.spawn(function()
                while Flushaura do
                    pcall(function()
                        local char = game.Players.LocalPlayer.Character
                        if not char then return end
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if not root then return end
                        if FlushPromptCacheDirty or tick() - (FlushPromptCacheLastScan or 0) > (FlushPromptCacheTTL or 8) then
                            RebuildFlushPromptCache()
                        end
                        for prompt in pairs(FlushPromptCache) do
                            if prompt and prompt.Parent and IsFlushPrompt(prompt) then
                                local parent = prompt.Parent
                                local part = parent:IsA("BasePart") and parent or parent:FindFirstAncestorWhichIsA("BasePart")
                                if part and (root.Position - part.Position).Magnitude <= FlushAuraValue then
                                    ActivateProximityPrompt(prompt)
                                end
                            else
                                FlushPromptCache[prompt] = nil
                            end
                        end
                    end)
                    task.wait(0.25)
                end
            end)
        end
    end
})
-- ============================================================
-- ====================== ESP SYSTEM =========================
-- ============================================================

ESP = {
    Enabled       = Config:Get("EspEnabled", false),
    MobEnabled    = Config:Get("EspMobEnabled", true),
    PlayerEnabled = Config:Get("EspPlayerEnabled", true),
    ItemEnabled   = Config:Get("EspItemEnabled", true),
    Settings      = Config:Get("EspSettings", { "Highlight", "Distance", "Health", "Name" }),
    SelectedItems = Config:Get("EspSelectedItems", {}),
    MaxDistance   = 1500,
    _mobHighlights    = {},
    _playerHighlights = {},
    _itemHighlights   = {},
    ItemList = {
        "Clock Spider","X-18 Core","Green Energy Core","Weird Transmitter",
        "Presents","Weird Prism","Key Card","Zombie Core","Flash Drives","Astro Samples",
    },
}

function IsESPItemTarget(objectName, selectedList)
    for _, pattern in ipairs(selectedList) do
        if objectName:lower() == pattern:lower() then return true end
        if #objectName > #pattern then
            if objectName:lower():sub(1, #pattern) == pattern:lower() then
                local nc = objectName:lower():sub(#pattern + 1, #pattern + 1)
                if nc == " " or nc == "#" or nc == "_" or nc == "-" then return true end
            end
        end
        if CollectGroupMap[pattern] then
            for _, gName in ipairs(CollectGroupMap[pattern]) do
                if objectName:lower() == gName:lower() then return true end
            end
        end
    end
    return false
end

function CreateESPLabel(parent, labelText)
    local existing = parent:FindFirstChild("DYHUB_ESP_LABEL")
    if existing then existing:Destroy() end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "DYHUB_ESP_LABEL"; billboard.Size = UDim2.new(0, 120, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0); billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false; billboard.Adornee = parent; billboard.Parent = parent
    local frame = Instance.new("Frame"); frame.BackgroundTransparency = 1
    frame.Size = UDim2.fromScale(1, 1); frame.Parent = billboard
    local label = Instance.new("TextLabel"); label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1); label.Font = Enum.Font.GothamBold
    label.TextSize = 11; label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.4; label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Text = labelText; label.Parent = frame
    return billboard, label
end

function CreateHighlight(model, outlineColor, fillColor, fillTransparency)
    local existing = model:FindFirstChild("DYHUB_ESP_HIGHLIGHT")
    if existing then existing:Destroy() end
    local hl = Instance.new("Highlight")
    hl.Name = "DYHUB_ESP_HIGHLIGHT"; hl.OutlineColor = outlineColor
    hl.FillColor = fillColor; hl.FillTransparency = fillTransparency or 0.9
    hl.OutlineTransparency = 0; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = model; hl.Parent = model
    return hl
end

function RemoveESP(model)
    pcall(function()
        local hl = model:FindFirstChild("DYHUB_ESP_HIGHLIGHT"); if hl then hl:Destroy() end
        local hb = model:FindFirstChild("DYHUB_ESP_LABEL"); if hb then hb:Destroy() end
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if hrp then local lb = hrp:FindFirstChild("DYHUB_ESP_LABEL"); if lb then lb:Destroy() end end
    end)
end

function IsInRange(targetPart)
    if not targetPart or not HumanoidRootPart then return false end
    return (HumanoidRootPart.Position - targetPart.Position).Magnitude <= ESP.MaxDistance
end

function BuildLabelText(model, showName, showHealth, showDistance)
    local parts = {}
    if showName then table.insert(parts, model.Name) end
    if showHealth then
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid then table.insert(parts, "❤ " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)) end
    end
    if showDistance then
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if hrp and HumanoidRootPart then table.insert(parts, "📏 " .. math.floor((HumanoidRootPart.Position - hrp.Position).Magnitude) .. "m") end
    end
    return table.concat(parts, "\n")
end

function BuildItemLabelText(obj, showName, showDistance)
    local parts = {}
    if showName then table.insert(parts, obj.Name) end
    if showDistance then
        local root = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")) or (obj:IsA("BasePart") and obj or nil)
        if root and HumanoidRootPart then table.insert(parts, "📏 " .. math.floor((HumanoidRootPart.Position - root.Position).Magnitude) .. "m") end
    end
    return table.concat(parts, "\n")
end

function GetESPSettings()
    local s = ESP.Settings
    return {
        highlight = table.find(s, "Highlight") ~= nil,
        distance  = table.find(s, "Distance") ~= nil,
        health    = table.find(s, "Health") ~= nil,
        name      = table.find(s, "Name") ~= nil,
    }
end

function ApplyMobESP(mob)
    if not mob or not mob.Parent then return end
    local hrp = mob:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local settings = GetESPSettings()
    if settings.highlight then CreateHighlight(mob, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 255, 255), 0.9) end
    if settings.name or settings.health or settings.distance then
        local _, label = CreateESPLabel(hrp, "")
        task.spawn(function()
            while mob and mob.Parent and ESP.Enabled and ESP.MobEnabled do
                local humanoid = mob:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then break end
                if not IsInRange(hrp) then label.Visible = false; task.wait(0.5)
                else label.Visible = true; label.Text = BuildLabelText(mob, settings.name, settings.health, settings.distance); task.wait(0.35) end
            end
            RemoveESP(mob); ESP._mobHighlights[mob] = nil
        end)
    end
    ESP._mobHighlights[mob] = true
end

function ScanMobs()
    local livingFolder = workspace:FindFirstChild("Living"); if not livingFolder then return end
    for _, mob in ipairs(livingFolder:GetChildren()) do
        if IsValidMob(mob) and not ESP._mobHighlights[mob] then
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hrp and IsInRange(hrp) then ApplyMobESP(mob) end
        end
    end
end

function ApplyPlayerESP(playerChar)
    if not playerChar or not playerChar.Parent then return end
    local hrp = playerChar:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if playerChar == LocalPlayer.Character then return end
    local settings = GetESPSettings()
    if settings.highlight then CreateHighlight(playerChar, Color3.fromRGB(50, 255, 50), Color3.fromRGB(255, 255, 255), 0.9) end
    if settings.name or settings.health or settings.distance then
        local _, label = CreateESPLabel(hrp, "")
        task.spawn(function()
            while playerChar and playerChar.Parent and ESP.Enabled and ESP.PlayerEnabled do
                local humanoid = playerChar:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then break end
                if not IsInRange(hrp) then label.Visible = false; task.wait(0.5)
                else label.Visible = true; label.Text = BuildLabelText(playerChar, settings.name, settings.health, settings.distance); task.wait(0.35) end
            end
            RemoveESP(playerChar); ESP._playerHighlights[playerChar] = nil
        end)
    end
    ESP._playerHighlights[playerChar] = true
end

function ScanPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            if not ESP._playerHighlights[char] then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and IsInRange(hrp) then ApplyPlayerESP(char) end
            end
        end
    end
end

function GetItemRoot(obj)
    if obj:IsA("Model") then return obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
    elseif obj:IsA("BasePart") or obj:IsA("MeshPart") then return obj end
    return nil
end

function ApplyItemESP(obj)
    if not obj or not obj.Parent then return end
    local root = GetItemRoot(obj); if not root then return end
    local settings = GetESPSettings()
    if settings.highlight then CreateHighlight(obj, Color3.fromRGB(255, 215, 0), Color3.fromRGB(255, 255, 255), 0.9) end
    if settings.name or settings.distance then
        local _, label = CreateESPLabel(root, "")
        task.spawn(function()
            while obj and obj.Parent and ESP.Enabled and ESP.ItemEnabled do
                local currentRoot = GetItemRoot(obj); if not currentRoot then break end
                if not IsInRange(currentRoot) then label.Visible = false; task.wait(0.5)
                else label.Visible = true; label.Text = BuildItemLabelText(obj, settings.name, settings.distance); task.wait(0.5) end
            end
            RemoveESP(obj); ESP._itemHighlights[obj] = nil
        end)
    end
    ESP._itemHighlights[obj] = true
end

function ScanItems()
    if #ESP.SelectedItems == 0 then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if not ESP._itemHighlights[obj] and IsESPItemTarget(obj.Name, ESP.SelectedItems) then
            local root = GetItemRoot(obj)
            if root and IsInRange(root) then ApplyItemESP(obj) end
        end
    end
end

function ClearAllESP()
    for mob, _ in pairs(ESP._mobHighlights) do RemoveESP(mob) end
    ESP._mobHighlights = {}
    for char, _ in pairs(ESP._playerHighlights) do RemoveESP(char) end
    ESP._playerHighlights = {}
    for obj, _ in pairs(ESP._itemHighlights) do RemoveESP(obj) end
    ESP._itemHighlights = {}
end

ESPConnection = nil

function StartESPLoop()
    if ESPConnection then ESPConnection:Disconnect(); ESPConnection = nil end
    local lastMobScan, lastPlayerScan, lastItemScan = 0, 0, 0
    ESPConnection = RunService.Heartbeat:Connect(function()
        if not ESP.Enabled then return end
        local now = tick()
        if ESP.MobEnabled and now - lastMobScan >= 0.8 then
            lastMobScan = now
            pcall(ScanMobs)
        end
        if ESP.PlayerEnabled and now - lastPlayerScan >= 1.0 then
            lastPlayerScan = now
            pcall(ScanPlayers)
        end
        if ESP.ItemEnabled and now - lastItemScan >= 4.0 then
            lastItemScan = now
            pcall(ScanItems)
        end
    end)
end

function StopESPLoop()
    if ESPConnection then ESPConnection:Disconnect(); ESPConnection = nil end
    ClearAllESP()
end

workspace.DescendantAdded:Connect(function(obj)
    if not ESP.Enabled or not ESP.ItemEnabled or #ESP.SelectedItems == 0 then return end
    task.wait(0.1)
    if IsESPItemTarget(obj.Name, ESP.SelectedItems) and not ESP._itemHighlights[obj] then
        local root = GetItemRoot(obj)
        if root and IsInRange(root) then ApplyItemESP(obj) end
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if not ESP.Enabled or not ESP.PlayerEnabled then return end
        task.wait(1)
        if not ESP._playerHighlights[char] then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and IsInRange(hrp) then ApplyPlayerESP(char) end
        end
    end)
end)

function WatchLivingFolder()
    local living = workspace:FindFirstChild("Living")
    if living then
        living.ChildAdded:Connect(function(obj)
            if not ESP.Enabled or not ESP.MobEnabled then return end
            task.wait(0.2)
            if IsValidMob(obj) and not ESP._mobHighlights[obj] then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp and IsInRange(hrp) then ApplyMobESP(obj) end
            end
        end)
    end
end

task.spawn(function()
    if not workspace:FindFirstChild("Living") then
        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Living" then WatchLivingFolder() end
        end)
    else
        WatchLivingFolder()
    end
end)

-- ====================== UI: ESP TAB ======================
Main4:Section({ Title = T("esp_visual"), Icon = "eye" })

EspEnableToggle = Main4:Toggle({
    Title = T("esp_enable"), Value = ESP.Enabled,
    Desc = "启用所有透视视觉效果。",
    Callback = function(state)
        ESP.Enabled = state; Config:Set("EspEnabled", state); Config:Save()
        if state then StartESPLoop() else StopESPLoop() end
    end
})

EspMobToggle = Main4:Toggle({
    Title = T("esp_mob"), Value = ESP.MobEnabled,
    Desc = "在敌方怪物上方显示高亮和信息标签。",
    Callback = function(state)
        ESP.MobEnabled = state; Config:Set("EspMobEnabled", state); Config:Save()
        if not state then for mob, _ in pairs(ESP._mobHighlights) do RemoveESP(mob) end; ESP._mobHighlights = {} end
    end
})

EspPlayerToggle = Main4:Toggle({
    Title = T("esp_player"), Value = ESP.PlayerEnabled,
    Desc = "在其他玩家上方显示高亮和信息标签。",
    Callback = function(state)
        ESP.PlayerEnabled = state; Config:Set("EspPlayerEnabled", state); Config:Save()
        if not state then for char, _ in pairs(ESP._playerHighlights) do RemoveESP(char) end; ESP._playerHighlights = {} end
    end
})

EspItemToggle = Main4:Toggle({
    Title = T("esp_item"), Value = ESP.ItemEnabled,
    Desc = "在可收集物品上显示高亮和信息标签。",
    Callback = function(state)
        ESP.ItemEnabled = state; Config:Set("EspItemEnabled", state); Config:Save()
        if not state then for obj, _ in pairs(ESP._itemHighlights) do RemoveESP(obj) end; ESP._itemHighlights = {} end
    end
})

Main4:Section({ Title = T("esp_settings"), Icon = "settings" })

EspSettingsDropdown = Main4:Dropdown({
    Title = "透视选项",
    Desc = "选择显示哪些额外的透视标签和视觉效果。",
    Multi = true,
    Values = { "Highlight", "Distance", "Health", "Name" },
    Value = ESP.Settings,
    Callback = function(value)
        ESP.Settings = value or {}; Config:Set("EspSettings", value); Config:Save()
        if ESP.Enabled then ClearAllESP() end
    end,
})

EspItemDropdown = Main4:Dropdown({
    Title = "透视物品",
    Desc = "选择哪些可收集物品应获得物品透视。",
    Multi = true,
    Values = ESP.ItemList,
    Value = ESP.SelectedItems,
    Callback = function(value)
        ESP.SelectedItems = value or {}; Config:Set("EspSelectedItems", value); Config:Save()
        for obj, _ in pairs(ESP._itemHighlights) do RemoveESP(obj) end
        ESP._itemHighlights = {}
        if ESP.Enabled and ESP.ItemEnabled then pcall(ScanItems) end
    end,
})

-- ====================== UI: PLAYER TAB ======================
Main2:Section({ Title = T("local_player"), Icon = "user" })

WSValue = Config:Get("WSValue", 16)
JPValue = Config:Get("JPValue", 50)
NoClip  = Config:Get("NoClip", false)
LockMovementStats = Config:Get("LockMovementStats", true)
FlyEnabled = Config:Get("FlyEnabled", false)
FlySpeed = Config:Get("FlySpeed", 1)
InfiniteJumpEnabled = Config:Get("InfiniteJumpEnabled", false)
FullBrightEnabled = Config:Get("FullBrightEnabled", false)
NoFogEnabled = Config:Get("NoFogEnabled", false)

LastMovementStatApply = 0
MovementStatInterval  = 0.25
FlyBodyVelocity = nil
FlyBodyGyro = nil
FlyRenderConnection = nil
LastVisualApply = 0
FullBrightOriginal = nil
NoFogOriginal = nil

function GetLocalHumanoid()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

function GetLocalRootPart()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

function updatePlayerStats(force)
    local humanoid = GetLocalHumanoid()
    if not humanoid then return end

    pcall(function()
        if humanoid.UseJumpPower ~= nil then
            humanoid.UseJumpPower = true
        end
    end)

    if force or humanoid.WalkSpeed ~= WSValue then
        humanoid.WalkSpeed = WSValue
    end

    if force or humanoid.JumpPower ~= JPValue then
        humanoid.JumpPower = JPValue
    end
end

function ProtectMovementStats()
    if not LockMovementStats then return end

    local now = tick()
    if now - LastMovementStatApply < MovementStatInterval then return end
    LastMovementStatApply = now

    local humanoid = GetLocalHumanoid()
    if not humanoid then return end

    pcall(function()
        if humanoid.UseJumpPower ~= nil then
            humanoid.UseJumpPower = true
        end
    end)

    if humanoid.WalkSpeed < WSValue then
        humanoid.WalkSpeed = WSValue
    end

    if humanoid.JumpPower < JPValue then
        humanoid.JumpPower = JPValue
    end
end

function CleanupFlyForces()
    if FlyBodyVelocity then
        pcall(function() FlyBodyVelocity:Destroy() end)
        FlyBodyVelocity = nil
    end
    if FlyBodyGyro then
        pcall(function() FlyBodyGyro:Destroy() end)
        FlyBodyGyro = nil
    end
end

function StartFly()
    local humanoid = GetLocalHumanoid()
    local root = GetLocalRootPart()
    if not humanoid or not root then return end

    CleanupFlyForces()

    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.Name = "DYHUB_FlyVelocity"
    FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyVelocity.Velocity = Vector3.zero
    FlyBodyVelocity.Parent = root

    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.Name = "DYHUB_FlyGyro"
    FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyGyro.P = 10000
    FlyBodyGyro.CFrame = root.CFrame
    FlyBodyGyro.Parent = root

    humanoid.PlatformStand = true
end

function StopFly()
    CleanupFlyForces()
    local humanoid = GetLocalHumanoid()
    if humanoid then
        humanoid.PlatformStand = false
        pcall(function()
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end)
    end
end

function GetFlyVerticalInput()
    local vertical = 0
    pcall(function()
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E) then
            vertical = vertical + 1
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            vertical = vertical - 1
        end
    end)
    return vertical
end

function UpdateFly()
    if not FlyEnabled then return end

    local humanoid = GetLocalHumanoid()
    local root = GetLocalRootPart()
    local cam = workspace.CurrentCamera
    if not humanoid or not root or not cam then return end

    if not FlyBodyVelocity or FlyBodyVelocity.Parent ~= root or not FlyBodyGyro or FlyBodyGyro.Parent ~= root then
        StartFly()
        return
    end

    humanoid.PlatformStand = true

    local move = humanoid.MoveDirection
    local vertical = GetFlyVerticalInput()
    local velocity = move + Vector3.new(0, vertical, 0)

    if velocity.Magnitude > 0 then
        velocity = velocity.Unit
    end

    FlyBodyVelocity.Velocity = velocity * ((tonumber(FlySpeed) or 1) * 20)
    FlyBodyGyro.CFrame = cam.CFrame
end

function EnsureFlyRenderLoop()
    if FlyRenderConnection then return end
    FlyRenderConnection = RunService.RenderStepped:Connect(UpdateFly)
end

function CaptureFullBrightOriginal()
    if FullBrightOriginal then return end
    FullBrightOriginal = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ExposureCompensation = Lighting.ExposureCompensation,
    }
end

function ApplyFullBright()
    CaptureFullBrightOriginal()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.ExposureCompensation = 0
    end)
end

function RestoreFullBright()
    if not FullBrightOriginal then return end
    pcall(function()
        Lighting.Brightness = FullBrightOriginal.Brightness
        Lighting.ClockTime = FullBrightOriginal.ClockTime
        Lighting.GlobalShadows = FullBrightOriginal.GlobalShadows
        Lighting.Ambient = FullBrightOriginal.Ambient
        Lighting.OutdoorAmbient = FullBrightOriginal.OutdoorAmbient
        Lighting.ExposureCompensation = FullBrightOriginal.ExposureCompensation
    end)
    FullBrightOriginal = nil
end

function CaptureNoFogOriginal()
    if NoFogOriginal then return end
    NoFogOriginal = {
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
        Atmospheres = {},
    }
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") then
            table.insert(NoFogOriginal.Atmospheres, {
                Instance = obj,
                Density = obj.Density,
                Haze = obj.Haze,
                Glare = obj.Glare,
                Offset = obj.Offset,
            })
        end
    end
end

function ApplyNoFog()
    CaptureNoFogOriginal()
    pcall(function()
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
    end)
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") then
            pcall(function()
                obj.Density = 0
                obj.Haze = 0
                obj.Glare = 0
                obj.Offset = 0
            end)
        end
    end
end

function RestoreNoFog()
    if not NoFogOriginal then return end
    pcall(function()
        Lighting.FogStart = NoFogOriginal.FogStart
        Lighting.FogEnd = NoFogOriginal.FogEnd
        Lighting.FogColor = NoFogOriginal.FogColor
    end)
    for _, data in ipairs(NoFogOriginal.Atmospheres or {}) do
        local obj = data.Instance
        if obj and obj.Parent then
            pcall(function()
                obj.Density = data.Density
                obj.Haze = data.Haze
                obj.Glare = data.Glare
                obj.Offset = data.Offset
            end)
        end
    end
    NoFogOriginal = nil
end

RunService.Heartbeat:Connect(function()
    ProtectMovementStats()

    local now = tick()
    if now - LastVisualApply >= 1 then
        LastVisualApply = now
        if FullBrightEnabled then ApplyFullBright() end
        if NoFogEnabled then ApplyNoFog() end
    end
end)

EnsureFlyRenderLoop()

UserInputService.JumpRequest:Connect(function()
    if not InfiniteJumpEnabled then return end
    local humanoid = GetLocalHumanoid()
    if humanoid then
        pcall(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
end)

RunService.Stepped:Connect(function()
    if NoClip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    updatePlayerStats(true)
    if FlyEnabled then StartFly() end
end)

Main2:Slider({
    Title = T("walkspeed"),
    Desc = "设置你保存的移动速度值。",
    Value = { Min = 1, Max = 200, Default = WSValue },
    Step = 1,
    Callback = function(value)
        WSValue = value
        Config:Set("WSValue", value)
        Config:Save()
        updatePlayerStats(true)
    end
})

Main2:Slider({
    Title = T("jumppower"),
    Desc = "设置你保存的跳跃力度值。",
    Value = { Min = 1, Max = 500, Default = JPValue },
    Step = 1,
    Callback = function(value)
        JPValue = value
        Config:Set("JPValue", value)
        Config:Save()
        updatePlayerStats(true)
    end
})

Main2:Toggle({
    Title = T("lock_movement"),
    Desc = "当游戏降低移动速度和跳跃力度时恢复它们。",
    Value = LockMovementStats,
    Callback = function(state)
        LockMovementStats = state
        Config:Set("LockMovementStats", state)
        Config:Save()
        if state then updatePlayerStats(true) end
    end
})

nocliptoggle = Main2:Toggle({
    Title = T("no_clip"),
    Value = NoClip,
    Desc = "允许你的角色穿过墙壁和部件。",
    Callback = function(state) NoClip = state; Config:Set("NoClip", state); Config:Save() end
})

Main2:Section({ Title = "飞行移动", Icon = "plane" })

Main2:Slider({
    Title = T("fly_speed"),
    Desc = "飞行时调整飞行速度。",
    Value = { Min = 1, Max = 20, Default = FlySpeed },
    Step = 1,
    Callback = function(value)
        FlySpeed = value
        Config:Set("FlySpeed", value)
        Config:Save()
    end
})

Main2:Toggle({
    Title = T("fly"),
    Desc = "启用飞行移动。使用空格/E 上升，Ctrl/Q 下降。",
    Value = FlyEnabled,
    Callback = function(state)
        FlyEnabled = state
        Config:Set("FlyEnabled", state)
        Config:Save()
        if state then StartFly() else StopFly() end
    end
})

Main2:Section({ Title = "视觉与实用", Icon = "sun" })

Main2:Toggle({
    Title = T("infinite_jump"),
    Desc = "允许在空中连续跳跃。",
    Value = InfiniteJumpEnabled,
    Callback = function(state)
        InfiniteJumpEnabled = state
        Config:Set("InfiniteJumpEnabled", state)
        Config:Save()
    end
})

Main2:Toggle({
    Title = T("full_bright"),
    Desc = "提高地图亮度，禁用时恢复原光照。",
    Value = FullBrightEnabled,
    Callback = function(state)
        FullBrightEnabled = state
        Config:Set("FullBrightEnabled", state)
        Config:Save()
        if state then ApplyFullBright() else RestoreFullBright() end
    end
})

Main2:Toggle({
    Title = T("no_fog"),
    Desc = "移除远距离雾气，禁用时恢复原雾设置。",
    Value = NoFogEnabled,
    Callback = function(state)
        NoFogEnabled = state
        Config:Set("NoFogEnabled", state)
        Config:Save()
        if state then ApplyNoFog() else RestoreNoFog() end
    end
})

Main2:Section({ Title = T("redeem_codes"), Icon = "bird" })

SelectedCodes = Config:Get("SelectedCodes", {})

CodeDropdown = Main2:Dropdown({
    Title = "选择兑换码",
    Desc = "选择要兑换的代码。",
    Multi = true,
    Values = GlobalTables.redeemCodes, Value = SelectedCodes,
    Callback = function(value) SelectedCodes = value or {}; Config:Set("SelectedCodes", value); Config:Save() end,
})

Main2:Button({
    Title = T("redeem_selected"),
    Desc = "仅兑换下拉框中选中的代码。",
    Callback = function()
        for _, code in ipairs(SelectedCodes or {}) do
            pcall(function() local remote = GetRemote("RedeemCode"); if remote then remote:FireServer(code) end; task.wait(0.2) end)
        end
    end,
})

Main2:Button({
    Title = T("redeem_all"),
    Desc = "一次性兑换所有可用代码。",
    Callback = function()
        for _, code in ipairs(GlobalTables.redeemCodes or {}) do
            pcall(function() local remote = GetRemote("RedeemCode"); if remote then remote:FireServer(code) end; task.wait(0.5) end)
        end
    end,
})

-- ====================== UI: UNLOCK GAMEPASS ======================
Main2:Section({ Title = T("unlock_gamepass"), Icon = "badge-dollar-sign" })

SelectedGamepass = Config:Get("SelectedGamepass", {})
GlobalTables.Gamepassts = SelectedGamepass

GamepassDropdown = Main2:Dropdown({
    Title = "选择通行证",
    Desc = "选择要本地解锁的游戏通行证标志。",
    Multi = true,
    Values = GlobalTables.Gamepasst,
    Value = SelectedGamepass,
    Callback = function(value)
        GlobalTables.Gamepassts = value or {}
        SelectedGamepass = value or {}
        Config:Set("SelectedGamepass", value)
        Config:Save()
    end,
})

Main2:Button({
    Title = T("unlock_selected"),
    Desc = "免费本地解锁选中的游戏通行证。",
    Callback = function()
        local gachaData = LocalPlayer:FindFirstChild("GachaData")
        if not gachaData then
            gachaData = Instance.new("Folder")
            gachaData.Name = "GachaData"
            gachaData.Parent = LocalPlayer
        end
        local toUnlock = {}
        for _, v in ipairs(GlobalTables.Gamepassts) do
            if v == "All" then
                toUnlock = {"LuckyBoost", "RareLuckyBoost", "LegendaryLuckyBoost"}
                break
            else
                table.insert(toUnlock, v)
            end
        end
        if #toUnlock == 0 then
            WindUI:Notify({ Title = T("unlock_gamepass"), Content = "请先选择通行证！", Duration = 3, Icon = "alert-triangle" })
            return
        end
        local successCount = 0
        for _, gamepassName in ipairs(toUnlock) do
            pcall(function()
                local boolValue = gachaData:FindFirstChild(gamepassName)
                if not boolValue then
                    boolValue = Instance.new("BoolValue")
                    boolValue.Name = gamepassName
                    boolValue.Parent = gachaData
                end
                boolValue.Value = true
                successCount = successCount + 1
                task.wait(0.2)
            end)
        end
        WindUI:Notify({
            Title = T("unlock_gamepass"),
            Content = "已解锁 " .. successCount .. "/" .. #toUnlock .. " 个通行证！",
            Duration = 3,
            Icon = "badge-check"
        })
    end,
})
-- ====================== UI: GAMEMODE TAB ======================
GlobalTables2 = {
    Votes2 = {
        "Normal", "VeryHard", "Hard", "Insane", "Nightmare", "BossRush",
        "DarkDimension", "Hell", "ThunderStorm", "Christmas", "Zombie",
        "AstroV2", "Astro", "100MVisit"
    }
}

Main7:Section({ Title = T("vote_info"), TextXAlignment = "Center", TextSize = 17 })
Main7:Divider()
Main7:Paragraph({
    Title = T("auto_vote_ig"),
    Desc = "- [ 步骤 1 ] 点击恢复投票系统\n- [ 步骤 2 ] 留在大厅内（在游戏中）\n- [ 步骤 3 ] 设置自动投票并等待",
    Image = "rbxassetid://104487529937663",
    ImageSize = 30,
})
Main7:Divider()
Main7:Section({ Title = T("vote_mode"), Icon = "gamepad-2" })

Main7:Button({
    Title = T("restore_vote"),
    Desc = "⚠️ 在首次使用自动投票前请先点击此按钮。",
    Callback = function()
        pcall(function()
            ReplicatedStorage.GetReadyRemote:FireServer("1", true)
            task.wait(0.5)
            ReplicatedStorage.GetReadyRemote:FireServer("1", false)
            task.wait(0.5)
            ReplicatedStorage.GetReadyRemote:FireServer("2", false)
            task.wait(0.5)
            ReplicatedStorage.GetReadyRemote:FireServer("3", false)
            task.wait(0.5)
            ReplicatedStorage.GetReadyRemote:FireServer("1", true)
        end)
        WindUI:Notify({
            Title = "恢复中...",
            Content = "准备就绪，正在恢复投票系统...",
            Duration = 6,
            Icon = "loader-circle"
        })
        task.wait(6)
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(-220, -10, -600)
            end
        end)
        WindUI:Notify({
            Title = "恢复中...",
            Content = "正在恢复投票系统，请稍候...",
            Duration = 10,
            Icon = "loader-circle"
        })
        task.wait(10)
        WindUI:Notify({
            Title = "恢复完成",
            Content = "投票系统已恢复！你现在可以使用自动投票模式。",
            Duration = 5,
            Icon = "check"
        })
    end
})

GameModeDropdown2 = Main7:Dropdown({
    Title = T("set_vote_mode"),
    Desc = "选择自动投票要投的游戏模式。",
    Values = GlobalTables2.Votes2,
    Multi = false,
    Value = AutoVoteValue,
    Callback = function(value)
        AutoVoteValue = value
        Config:Set("AutoVoteValue", value)
        Config:Save()
        print("[DYHUB] 投票模式已选择:", tostring(value))
    end
})

AutoVoteIGToggle = Main7:Toggle({
    Title = T("auto_vote_ig"),
    Desc = "每回合自动为选定模式投票。",
    Value = AutoVoteinGameEnabled,
    Callback = function(enabled)
        AutoVoteinGameEnabled = enabled
        Config:Set("AutoVoteinGameEnabled", enabled)
        Config:Save()
        if enabled then
            if AutoStartEnabled and IsMiscFarmAllowed() then
                FireGetReady(0)
            else
                FireAutoVote(true)
            end
            StartAutoVoteLoop()
        else
            print("[DYHUB] 自动投票模式已禁用")
        end
    end
})

if AutoVoteinGameEnabled then
    StartAutoVoteLoop()
end

Main7:Divider()
Main7:Section({ Title = T("casual_info"), TextXAlignment = "Center", TextSize = 17 })
Main7:Divider()
Main7:Paragraph({
    Title = "休闲: 任务选择",
    Desc = "- [ 步骤 1 ] 留在大厅内（不在游戏中）\n- [ 步骤 2 ] 按 Play 并进入 Classic 游戏模式选择界面\n- [ 步骤 3 ] 选择休闲并完成传送\n- [ 步骤 4 ] 运行脚本",
    Image = "rbxassetid://104487529937663",
    ImageSize = 30,
})
Main7:Divider()
Main7:Section({ Title = T("game_mode"), Icon = "gamepad-2" })

GameModeDropdown = Main7:Dropdown({
    Title = T("set_game_mode"),
    Desc = "选择自动创建要创建的游戏模式。",
    Values = GlobalTables.Mode,
    Multi = false,
    Value = AutoGameValue,
    Callback = function(value)
        AutoGameValue = value; Config:Set("AutoGameValue", value); Config:Save()
        print("[DYHUB] 游戏模式已选择: " .. tostring(value))
    end
})

-- PLAY SYSTEM（加载时自动导航至 Classic/Casual）
DELAY = 1

function click_btn(btn)
    if btn and (btn:IsA("ImageButton") or btn:IsA("TextButton")) then
        pcall(function()
            if firesignal then
                firesignal(btn.MouseButton1Click)
                firesignal(btn.Activated)
            else
                btn:Activate()
            end
        end)
    end
end

function notify(title, content, icon)
    WindUI:Notify({
        Title = title,
        Content = content,
        Duration = 3,
        Icon = "check"
    })
end

--// PLAY SYSTEM
task.spawn(function()
    local playBtn =
        workspace:FindFirstChild("ForGui") and
        workspace.ForGui:FindFirstChild("SurfaceGui") and
        workspace.ForGui.SurfaceGui:FindFirstChild("Frame") and
        workspace.ForGui.SurfaceGui.Frame:FindFirstChild("Play")

    if playBtn then
        notify("自动 Play", "检测到 Play 按钮，自动开始...")
        task.wait(DELAY)

        local playGui = pg:FindFirstChild("Play")

        if not (playGui and playGui.Enabled) then
            click_btn(playBtn)
            notify("自动 Play", "已按下 Play 按钮")
        else
            notify("自动 Play", "Play GUI 已打开")
        end
    end

    task.wait(DELAY)

    local playGui = pg:FindFirstChild("Play")
    if not (playGui and playGui.Enabled) then
        return
    end

    local classicBtn = playGui:FindFirstChild("Classic")

    if classicBtn then
        notify("自动 Play", "正在选择 Classic 模式...")
        task.wait(DELAY)
        click_btn(classicBtn)
    end

    task.wait(DELAY)

    local modeGui = pg:FindFirstChild("mode select2")

    if modeGui and modeGui.Enabled then
        local diffBtn =
            modeGui:FindFirstChild("MainFrame") and
            modeGui.MainFrame:FindFirstChild("DiffMode")

        if diffBtn then
            notify("自动 Play", "正在选择难度...")
            task.wait(DELAY)
            click_btn(diffBtn)
        end
    end
end)

--// NEW LOBBY SYSTEM
task.spawn(function()
    while true do
        task.wait(0.5)

        local loadingGui = pg:FindFirstChild("LoadingScreen")

        if loadingGui then
            notify("大厅系统", "正在移除 LoadingScreen...")
            pcall(function()
                loadingGui:Destroy()
            end)
        end

        local lobby = pg:FindFirstChild("Lobby")

        if lobby and lobby.Enabled then
            notify("大厅系统", "检测到大厅，准备自动设置...")

            local btn =
                lobby:FindFirstChild("MainFrame") and
                lobby.MainFrame:FindFirstChild("Frame") and
                lobby.MainFrame.Frame:FindFirstChild("Create") and
                lobby.MainFrame.Frame.Create:FindFirstChild("TrackQuestButton")

            if btn and btn.Visible then
                notify("大厅系统", "正在按下 TrackQuestButton...")
                click_btn(btn)

                task.wait(0.5)

                if AutoVoteEnabled then
                    notify("大厅系统", "正在创建游戏模式...")

                    ReplicatedStorage.MainHandler:FireServer({
                        [1] = "StartSolo",
                        [2] = AutoGameValue
                    })

                    notify("大厅系统", "游戏模式创建成功！")
                else
                    notify("大厅系统", "请配合自动游戏模式使用！")
                end

                break
            end
        end
    end
end)

--// AUTO GAME MODE TOGGLE
AutoVoteToggle = Main7:Toggle({
    Title = T("auto_game_mode_lobby"),
    Desc = "在大厅时自动创建选定的游戏模式。",
    Value = AutoVoteEnabled,

    Callback = function(enabled)
        AutoVoteEnabled = enabled

        Config:Set("AutoVoteEnabled", enabled)
        Config:Save()

        if enabled then
            notify("自动游戏模式", "已启用")
        else
            notify("自动游戏模式", "已禁用", "x")
        end
    end
})


-- ====================== REQUEST / SKILL TREE HELPERS ======================
RequestWaveNotifyAt = 0
AutoSkillTreeNotifyAt = 0

function SafeWindNotify(title, content, duration, icon)
    if WindUI and WindUI.Notify then
        pcall(function()
            WindUI:Notify({
                Title = tostring(title or "DYHUB"),
                Content = tostring(content or ""),
                Duration = duration or 3,
                Icon = icon or "info"
            })
        end)
    end
end

function GetCurrentWaveText()
    local ok, result = pcall(function()
        local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return nil end

        local wavesGui = playerGui:FindFirstChild("WavesGui")
        if not wavesGui then return nil end

        local frame = wavesGui:FindFirstChild("Frame")
        if not frame then return nil end

        local label = frame:FindFirstChild("TextLabel")
        if not label then return nil end

        return tostring(label.Text or "")
    end)

    if ok then return result end
    return nil
end

function GetCurrentWaveNumber()
    local text = GetCurrentWaveText()
    if not text then return nil end

    local numberText = tostring(text):match("(%d+)")
    if not numberText then return nil end

    return tonumber(numberText)
end

function IsRequestWaveReady()
    local wave = GetCurrentWaveNumber()
    return wave ~= nil and wave >= 10
end

function NotifyRequestWaveNotReady()
    local now = tick()
    if now - RequestWaveNotifyAt < 4 then return end
    RequestWaveNotifyAt = now

    if GetCurrentWaveNumber() == nil then
        SafeWindNotify("自动请求", "暂时无法请求。波次 UI 未就绪。", 3, "triangle-alert")
    else
        SafeWindNotify("自动请求", "暂时无法请求。需要波次 10 或更高。", 3, "triangle-alert")
    end
end

function GetCurrentCharacterValue()
    local ok, result = pcall(function()
        local playerValues = LocalPlayer and LocalPlayer:FindFirstChild("PlayerValues")
        if not playerValues then return nil end

        local charValue = playerValues:FindFirstChild("Character")
        if not charValue then return nil end

        return tostring(charValue.Value or "")
    end)

    if ok then return result end
    return nil
end

function GetSkillTreeUIFolder()
    local characterName = GetCurrentCharacterValue()
    if not characterName or characterName == "" then return nil, characterName end

    local ok, result = pcall(function()
        local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return nil end

        local skillGui = playerGui:FindFirstChild("003-A")
        if not skillGui then return nil end

        local main = skillGui:FindFirstChild("Main")
        if not main then return nil end

        local scrolling = main:FindFirstChild("ScrollingFrame")
        if not scrolling then return nil end

        local direct = scrolling:FindFirstChild("Skills " .. characterName)
        if direct then return direct end

        local loweredName = characterName:lower()
        for _, child in ipairs(scrolling:GetChildren()) do
            local childName = tostring(child.Name or ""):lower()
            if childName:find("skills", 1, true) and childName:find(loweredName, 1, true) then
                return child
            end
        end

        return nil
    end)

    if ok then return result, characterName end
    return nil, characterName
end

function HasOwnedSkillTree(skillName)
    local folder = LocalPlayer and LocalPlayer:FindFirstChild("SkillTreesFolder")
    if not folder then return false end

    if folder:FindFirstChild(skillName) then return true end

    local loweredName = tostring(skillName or ""):lower()
    for _, child in ipairs(folder:GetChildren()) do
        if tostring(child.Name or ""):lower() == loweredName then
            return true
        end
    end

    return false
end

function IsSkillTreeBuyObject(obj)
    if not obj or not obj.Name then return false end

    local loweredName = tostring(obj.Name):lower()
    if loweredName == "" then return false end
    if loweredName:find("layout", 1, true) then return false end
    if loweredName:find("padding", 1, true) then return false end
    if loweredName:find("stroke", 1, true) then return false end
    if loweredName:find("corner", 1, true) then return false end

    if obj:IsA("GuiObject") or obj:IsA("Folder") or obj:IsA("Model") then
        return true
    end

    return false
end

function GetSkillTreesRemote()
    local remote = GetRemote("skilltrees")
    if remote then return remote end

    pcall(function()
        remote = ReplicatedStorage:FindFirstChild("SkillTrees") or ReplicatedStorage:FindFirstChild("SkillTree") or ReplicatedStorage:WaitForChild("skilltrees", 2)
    end)

    return remote
end

function NotifyAutoSkillTree(message)
    local now = tick()
    if now - AutoSkillTreeNotifyAt < 5 then return end
    AutoSkillTreeNotifyAt = now
    SafeWindNotify("自动技能树", tostring(message or "技能树未就绪。"), 3, "triangle-alert")
end

function FireAutoSkillTrees()
    local remote = GetSkillTreesRemote()
    if not remote then
        NotifyAutoSkillTree("未找到技能树远程事件。")
        return false
    end

    local folder, characterName = GetSkillTreeUIFolder()
    if not characterName or characterName == "" then
        NotifyAutoSkillTree("无法读取你当前的角色。")
        return false
    end

    if not folder then
        NotifyAutoSkillTree("未找到 " .. tostring(characterName) .. " 的技能树 UI。")
        return false
    end

    local fired = 0
    for _, skillObj in ipairs(folder:GetChildren()) do
        if IsSkillTreeBuyObject(skillObj) and not HasOwnedSkillTree(skillObj.Name) then
            local remoteArg = tostring(skillObj.Name):lower()
            local ok, err = pcall(function()
                remote:FireServer(remoteArg)
            end)

            if ok then
                fired = fired + 1
                print("[DYHUB] 自动技能树已触发:", remoteArg)
            else
                warn("[DYHUB] 自动技能树失败:", remoteArg, err)
            end

            task.wait(0.35)
        end
    end

    return true
end


-- ====================== UI: SHOP SYSTEMS ======================
Main5:Section({ Title = "自动抽卡", Icon = "sparkles" })

_G.__DYHUB_ShopSystems = function()
    local gachaArgs = { "1Spin", "10Spins", "100Spins", "1SpinLucky", "10SpinLucky" }

    local autoGachaCharacterEnabled = Config:Get("AutoGachaCharacterEnabled", false)
    local autoGachaSkinEnabled      = Config:Get("AutoGachaSkinEnabled", false)
    local selectedGachaCharacterArg = Config:Get("SelectedGachaCharacterArg", "1Spin")
    local selectedGachaSkinArg      = Config:Get("SelectedGachaSkinArg", "1Spin")
    local characterGachaRunning     = false
    local skinGachaRunning          = false

    local autoUseItemEnabled        = Config:Get("AutoUseItemEnabled", false)
    local selectedUseItem           = Config:Get("SelectedUseItem", "Presents")
    local useItemRunning            = false

    local selectedRequestItem       = Config:Get("SelectedRequestItem", "Titan-Request")
    local autoRequestEnabled        = Config:Get("AutoRequestEnabled", false)
    local autoSkillTreeEnabled      = Config:Get("AutoSkillTreeEnabled", false)

    local function EnsureList(value, fallback)
        if type(value) == "table" then
            return value
        end
        if value ~= nil then
            return { value }
        end
        return fallback or {}
    end

    local function WaitWhileEnabled(seconds, enabledFn)
        local elapsed = 0
        while elapsed < seconds do
            if enabledFn and not enabledFn() then
                return false
            end
            task.wait(0.5)
            elapsed = elapsed + 0.25
        end
        return true
    end

    local function FireShopRemote(remoteName, ...)
        local remote = GetRemote(remoteName)
        if not remote then return false end

        local args = { ... }
        local ok, err = pcall(function()
            remote:FireServer(unpack(args))
        end)

        if not ok then
            warn("[DYHUB] 商店远程事件失败:", tostring(remoteName), err)
        end

        return ok
    end

    local function ShouldShopSyncWithHeli()
        return AutoSkipHeliEnabled and IsMiscFarmAllowed()
    end

    local function StartAutoGachaCharacter()
        if characterGachaRunning then return end
        characterGachaRunning = true
        task.spawn(function()
            while autoGachaCharacterEnabled do
                FireShopRemote("GachaCharacter", selectedGachaCharacterArg)
                task.wait(1)
            end
            characterGachaRunning = false
        end)
    end

    local function StartAutoGachaSkin()
        if skinGachaRunning then return end
        skinGachaRunning = true
        task.spawn(function()
            while autoGachaSkinEnabled do
                FireShopRemote("GachaSkins", selectedGachaSkinArg)
                task.wait(1)
            end
            skinGachaRunning = false
        end)
    end

    local function StartAutoUseItem()
        if useItemRunning then return end
        useItemRunning = true
        task.spawn(function()
            while autoUseItemEnabled do
                if selectedUseItem == "Presents" then
                    FireShopRemote("GachaCapsule")
                end
                task.wait(1.5)
            end
            useItemRunning = false
        end)
    end
    Main5:Dropdown({
    Title = T("gacha_character"),
    Desc = "选择角色抽卡使用的旋转类型。",
    Values = gachaArgs,
    Multi = false,
    Value = selectedGachaCharacterArg,
    Callback = function(value)
        selectedGachaCharacterArg = value or "1Spin"
        Config:Set("SelectedGachaCharacterArg", selectedGachaCharacterArg)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("auto_gacha_character"),
    Value = autoGachaCharacterEnabled,
    Desc = "使用选定选项自动旋转角色抽卡。",
    Callback = function(enabled)
        autoGachaCharacterEnabled = enabled
        Config:Set("AutoGachaCharacterEnabled", enabled)
        Config:Save()
        if enabled then StartAutoGachaCharacter() end
    end
})

Main5:Dropdown({
    Title = T("gacha_skin"),
    Desc = "选择皮肤抽卡使用的旋转类型。",
    Values = gachaArgs,
    Multi = false,
    Value = selectedGachaSkinArg,
    Callback = function(value)
        selectedGachaSkinArg = value or "1Spin"
        Config:Set("SelectedGachaSkinArg", selectedGachaSkinArg)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("auto_gacha_skin"),
    Value = autoGachaSkinEnabled,
    Desc = "使用选定选项自动旋转皮肤抽卡。",
    Callback = function(enabled)
        autoGachaSkinEnabled = enabled
        Config:Set("AutoGachaSkinEnabled", enabled)
        Config:Save()
        if enabled then StartAutoGachaSkin() end
    end
})

Main5:Section({ Title = T("auto_use_item"), Icon = "package-open" })

Main5:Dropdown({
    Title = T("use_item"),
    Desc = "选择自动使用物品要激活的物品。",
    Values = { "Presents" },
    Multi = false,
    Value = selectedUseItem,
    Callback = function(value)
        selectedUseItem = value or "Presents"
        Config:Set("SelectedUseItem", selectedUseItem)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("auto_use_item"),
    Value = autoUseItemEnabled,
    Desc = "以安全延迟自动使用选定物品。",
    Callback = function(enabled)
        autoUseItemEnabled = enabled
        Config:Set("AutoUseItemEnabled", enabled)
        Config:Save()
        if enabled then StartAutoUseItem() end
    end
})

-- ====================== 同步商店购买/升级系统 ======================
Main5:Section({ Title = "商店升级", Icon = "arrow-big-up-dash" })

local titanSpeakerUpgradeValues = { "Jetpack", "OverCharge", "SoundBooster", "Core", "Upgrade" }
local utcmUpgradeValues         = { "Shield", "Blaster", "Lens", "Heat", "Armor" }
local tvUpgradeValues           = { "Absorb", "ShareOverCharge", "Shield", "AstroArm" }

local selectedTitanSpeakerUpgrades = EnsureList(Config:Get("SelectedTitanSpeakerUpgrades", { "Jetpack" }), { "Jetpack" })
local selectedUTCMUpgrades         = EnsureList(Config:Get("SelectedUTCMUpgrades", { "Shield" }), { "Shield" })
local selectedTVUpgrades           = EnsureList(Config:Get("SelectedTVUpgrades", { "Absorb" }), { "Absorb" })

local upgradeTitanSpeakerEnabled = Config:Get("UpgradeTitanSpeakerEnabled", false)
local upgradeUTCMEnabled         = Config:Get("UpgradeUTCMEnabled", false)
local upgradeTVEnabled           = Config:Get("UpgradeTVEnabled", false)

local StartAutoSyncedShopLoop = function() end

Main5:Dropdown({
    Title = T("select_upgrade_titan"),
    Desc = "选择要请求的 Titan Speaker 升级。",
    Values = titanSpeakerUpgradeValues,
    Multi = true,
    Value = selectedTitanSpeakerUpgrades,
    Callback = function(values)
        selectedTitanSpeakerUpgrades = values or {}
        Config:Set("SelectedTitanSpeakerUpgrades", selectedTitanSpeakerUpgrades)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("upgrade_titan"),
    Desc = "自动请求选定的 Titan Speaker 升级。",
    Value = upgradeTitanSpeakerEnabled,
    Callback = function(enabled)
        upgradeTitanSpeakerEnabled = enabled
        Config:Set("UpgradeTitanSpeakerEnabled", enabled)
        Config:Save()
        if enabled then StartAutoSyncedShopLoop() end
    end
})

Main5:Dropdown({
    Title = T("select_upgrade_utcm"),
    Desc = "选择要请求的 UTCM 升级。",
    Values = utcmUpgradeValues,
    Multi = true,
    Value = selectedUTCMUpgrades,
    Callback = function(values)
        selectedUTCMUpgrades = values or {}
        Config:Set("SelectedUTCMUpgrades", selectedUTCMUpgrades)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("upgrade_utcm"),
    Desc = "自动请求选定的 UTCM 升级。",
    Value = upgradeUTCMEnabled,
    Callback = function(enabled)
        upgradeUTCMEnabled = enabled
        Config:Set("UpgradeUTCMEnabled", enabled)
        Config:Save()
        if enabled then StartAutoSyncedShopLoop() end
    end
})

Main5:Dropdown({
    Title = T("select_upgrade_tv"),
    Desc = "选择要请求的 TV 升级。",
    Values = tvUpgradeValues,
    Multi = true,
    Value = selectedTVUpgrades,
    Callback = function(values)
        selectedTVUpgrades = values or {}
        Config:Set("SelectedTVUpgrades", selectedTVUpgrades)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("upgrade_tv"),
    Desc = "自动请求选定的 TV 升级。",
    Value = upgradeTVEnabled,
    Callback = function(enabled)
        upgradeTVEnabled = enabled
        Config:Set("UpgradeTVEnabled", enabled)
        Config:Save()
        if enabled then StartAutoSyncedShopLoop() end
    end
})

Main5:Section({ Title = T("shop_weapon"), Icon = "helicopter" })

local autoBuyWeaponValue   = Config:Get("AutoBuyWeaponValue", "Stungun")
local autoBuyWeaponEnabled = Config:Get("AutoBuyWeaponEnabled", false)

WeaponDropdown = Main5:Dropdown({
    Title = T("select_weapon"),
    Desc = "选择要自动购买的武器。",
    Values = GlobalTables.Weapon,
    Multi = false,
    Value = autoBuyWeaponValue,
    Callback = function(value)
        autoBuyWeaponValue = value
        Config:Set("AutoBuyWeaponValue", value)
        Config:Save()
    end
})

AutoBuyWeaponToggle = Main5:Toggle({
    Title = T("buy_weapon"),
    Desc = "在商店循环期间自动购买选定武器。",
    Value = autoBuyWeaponEnabled,
    Callback = function(enabled)
        autoBuyWeaponEnabled = enabled
        Config:Set("AutoBuyWeaponEnabled", enabled)
        Config:Save()
        if enabled then StartAutoSyncedShopLoop() end
    end
})

Main5:Button({
    Title = T("buy_weapon_once"),
    Desc = "一次性购买选定的武器。",
    Callback = function()
        if autoBuyWeaponValue then
            FireShopRemote("ShopSystem", "Buy", autoBuyWeaponValue)
        end
    end
})

Main5:Section({ Title = T("shop_misc"), Icon = "helicopter" })

local autoBuyMiscValue   = Config:Get("AutoBuyMiscValue", "HeadPhone")
local autoBuyMiscEnabled = Config:Get("AutoBuyMiscEnabled", false)

if table.find(GlobalTables.RequestTitanSpeaker, autoBuyMiscValue) or not table.find(GlobalTables.MiscShop, autoBuyMiscValue) then
    autoBuyMiscValue = "HeadPhone"
    Config:Set("AutoBuyMiscValue", autoBuyMiscValue)
    Config:Save()
end

if not table.find(GlobalTables.RequestTitanSpeaker, selectedRequestItem) then
    selectedRequestItem = "Titan-Request"
    Config:Set("SelectedRequestItem", selectedRequestItem)
    Config:Save()
end

MiscShopDropdown = Main5:Dropdown({
    Title = T("select_misc"),
    Desc = "选择要自动购买的杂项物品。",
    Values = GlobalTables.MiscShop,
    Multi = false,
    Value = autoBuyMiscValue,
    Callback = function(value)
        autoBuyMiscValue = value
        Config:Set("AutoBuyMiscValue", value)
        Config:Save()
    end
})

AutoBuyMiscToggle = Main5:Toggle({
    Title = T("buy_misc"),
    Value = autoBuyMiscEnabled,
    Desc = "在商店循环期间自动购买选定的杂项物品。",
    Callback = function(enabled)
        autoBuyMiscEnabled = enabled
        Config:Set("AutoBuyMiscEnabled", enabled)
        Config:Save()
        if enabled then StartAutoSyncedShopLoop() end
    end
})

Main5:Button({
    Title = T("buy_misc_once"),
    Desc = "一次性购买选定的杂项物品。",
    Callback = function()
        if autoBuyMiscValue then
            FireShopRemote("ShopSystem", "Buy", autoBuyMiscValue)
        end
    end
})

Main5:Section({ Title = "请求 Titan / Speaker", Icon = "send" })

RequestTitanSpeakerDropdown = Main5:Dropdown({
    Title = T("select_request"),
    Desc = "选择要自动购买的 Titan/Speaker 请求。",
    Values = GlobalTables.RequestTitanSpeaker,
    Multi = false,
    Value = selectedRequestItem,
    Callback = function(value)
        selectedRequestItem = value or "Titan-Request"
        Config:Set("SelectedRequestItem", selectedRequestItem)
        Config:Save()
    end
})

AutoRequestToggle = Main5:Toggle({
    Title = T("auto_request"),
    Desc = "当波次达到 10+ 时自动请求选定的 Titan/Speaker。",
    Value = autoRequestEnabled,
    Callback = function(enabled)
        autoRequestEnabled = enabled
        Config:Set("AutoRequestEnabled", enabled)
        Config:Save()

        if enabled then
            if not IsRequestWaveReady() then
                NotifyRequestWaveNotReady()
            end
            StartAutoSyncedShopLoop()
        end
    end
})

Main5:Section({ Title = T("skill_tree"), Icon = "git-branch-plus" })

AutoSkillTreeToggle = Main5:Toggle({
    Title = T("auto_skill_tree"),
    Desc = "自动解锁当前角色缺失的技能树。",
    Value = autoSkillTreeEnabled,
    Callback = function(enabled)
        autoSkillTreeEnabled = enabled
        Config:Set("AutoSkillTreeEnabled", enabled)
        Config:Save()

        if enabled then
            StartAutoSyncedShopLoop()
        end
    end
})

local autoSyncedShopRunning = false

local function IsHeavySyncedShopEnabled()
    return autoBuyWeaponEnabled
        or autoBuyMiscEnabled
        or upgradeTitanSpeakerEnabled
        or upgradeUTCMEnabled
        or upgradeTVEnabled
end

local function IsAnySyncedShopEnabled()
    return IsHeavySyncedShopEnabled()
        or autoRequestEnabled
        or autoSkillTreeEnabled
end

local function GetSyncedShopPreDelay()
    if not IsHeavySyncedShopEnabled() and (autoRequestEnabled or autoSkillTreeEnabled) then
        return 0
    end
    return 30
end

local function GetSyncedShopPostDelay()
    if not IsHeavySyncedShopEnabled() then
        if autoRequestEnabled then return 2 end
        if autoSkillTreeEnabled then return 5 end
    end
    return 10
end

local function FireSyncedShopBatch()
    if autoBuyWeaponEnabled and autoBuyWeaponValue then
        FireShopRemote("ShopSystem", "Buy", autoBuyWeaponValue)
        task.wait(0.35)
    end

    if autoBuyMiscEnabled and autoBuyMiscValue then
        FireShopRemote("ShopSystem", "Buy", autoBuyMiscValue)
        task.wait(0.35)
    end

    if autoRequestEnabled and selectedRequestItem then
        if IsRequestWaveReady() then
            FireShopRemote("ShopSystem", "Buy", selectedRequestItem)
        else
            NotifyRequestWaveNotReady()
        end
        task.wait(0.35)
    end

    if autoSkillTreeEnabled then
        FireAutoSkillTrees()
        task.wait(0.35)
    end

    if upgradeTitanSpeakerEnabled then
        for _, upgradeName in ipairs(selectedTitanSpeakerUpgrades or {}) do
            FireShopRemote("ChangeUpgradedTitanSpeaker", upgradeName)
            task.wait(0.35)
        end
    end

    if upgradeUTCMEnabled then
        for _, upgradeName in ipairs(selectedUTCMUpgrades or {}) do
            FireShopRemote("ForUpgradeUTCM", upgradeName)
            task.wait(0.35)
        end
    end

    if upgradeTVEnabled then
        for _, upgradeName in ipairs(selectedTVUpgrades or {}) do
            FireShopRemote("ForUpgradeTV", upgradeName)
            task.wait(0.35)
        end
    end
end

StartAutoSyncedShopLoop = function()
    if autoSyncedShopRunning then return end
    autoSyncedShopRunning = true

    task.spawn(function()
        local firstCycle = true

        while IsAnySyncedShopEnabled() do
            if not firstCycle then
                if not WaitWhileEnabled(GetSyncedShopPreDelay(), IsAnySyncedShopEnabled) then break end
            end
            firstCycle = false

            local shouldSyncHeli = ShouldShopSyncWithHeli()
            if shouldSyncHeli then
                TriggerAutoSkipHeli(false)
                task.wait(0.5)
            end

            FireSyncedShopBatch()

            if shouldSyncHeli then
                task.wait(0.5)
                TriggerAutoSkipHeli(true)
            end

            if not WaitWhileEnabled(GetSyncedShopPostDelay(), IsAnySyncedShopEnabled) then break end
        end

        autoSyncedShopRunning = false
    end)
end
    -- ====================== 商店每小时系统 ======================
    Main5:Section({ Title = T("shop_hourly"), Icon = "clock" })

    local ShopHourlyFixedItems = {
        "LuckPotionI",
        "LuckPotionII",
        "LuckPotionIII",
        "S-Ember",
        "BSX2:30",
        "BSX2:60",
        "BSX2:360",
        "FlashDrive#1",
        "FlashDrive#2",
        "FlashDrive#3",
        "FlashDrive#4",
        "FlashDrive#5",
        "FlashDrive#6",
        "MasterCard:Normal",
        "MasterCard:NormalTitan",
        "MasterCard:SpecialTitan",
    }

    local function GetShopHourlyItems()
        local results = {}
        for _, itemName in ipairs(ShopHourlyFixedItems) do
            table.insert(results, itemName)
        end
        return results
    end

    local ShopHourlyAllowed = {}
    for _, itemName in ipairs(ShopHourlyFixedItems) do
        ShopHourlyAllowed[itemName] = true
    end

    local function SanitizeShopHourlySelection(values, fallback)
        local clean = {}
        local seen = {}

        for _, itemName in ipairs(EnsureList(values, fallback or {})) do
            itemName = tostring(itemName or "")
            if ShopHourlyAllowed[itemName] and not seen[itemName] then
                seen[itemName] = true
                table.insert(clean, itemName)
            end
        end

        if #clean == 0 and type(fallback) == "table" then
            for _, itemName in ipairs(fallback) do
                itemName = tostring(itemName or "")
                if ShopHourlyAllowed[itemName] and not seen[itemName] then
                    seen[itemName] = true
                    table.insert(clean, itemName)
                    break
                end
            end
        end

        return clean
    end

    local shopHourlyValues          = GetShopHourlyItems()
    local selectedShopHourlyItems   = SanitizeShopHourlySelection(Config:Get("SelectedShopHourlyItems", { shopHourlyValues[1] }), { shopHourlyValues[1] })
    local shopHourlyItemAmount      = Config:Get("ShopHourlyItemAmount", 1)
    local buyItemHourlyEnabled      = Config:Get("BuyItemHourlyEnabled", false)
    local buyItemHourlyRunning      = false

    local function IsBuyItemHourlyEnabled()
        return buyItemHourlyEnabled
    end

    local function FireShopHourlyBatch()
        local amount = tonumber(shopHourlyItemAmount) or 1
        amount = math.max(1, math.floor(amount))

        for _, itemName in ipairs(selectedShopHourlyItems or {}) do
            if itemName and itemName ~= "" then
                FireShopRemote("BuyItemFromShopHourly", itemName, amount)
                task.wait(0.35)
            end
        end
    end

    local function StartBuyItemHourlyLoop()
        if buyItemHourlyRunning then return end
        buyItemHourlyRunning = true

        task.spawn(function()
            local firstCycle = true

            while buyItemHourlyEnabled do
                if not firstCycle then
                    if not WaitWhileEnabled(30, IsBuyItemHourlyEnabled) then break end
                end
                firstCycle = false

                FireShopHourlyBatch()

                if not WaitWhileEnabled(10, IsBuyItemHourlyEnabled) then break end
            end

            buyItemHourlyRunning = false
        end)
    end

    Main5:Dropdown({
        Title = T("select_shop_hourly"),
        Desc = "选择固定的每小时商店物品。",
        Values = shopHourlyValues,
        Multi = true,
        Value = selectedShopHourlyItems,
        Callback = function(values)
            selectedShopHourlyItems = SanitizeShopHourlySelection(values or {}, {})
            Config:Set("SelectedShopHourlyItems", selectedShopHourlyItems)
            Config:Save()
        end
    })

    Main5:Slider({
        Title = T("item_amount"),
        Desc = "设置每种选定每小时物品的购买数量。",
        Value = { Min = 1, Max = 100, Default = shopHourlyItemAmount },
        Step = 1,
        Callback = function(value)
            shopHourlyItemAmount = value
            Config:Set("ShopHourlyItemAmount", value)
            Config:Save()
        end
    })

    Main5:Toggle({
        Title = T("buy_item"),
        Desc = "定时自动购买选定的每小时商店物品。",
        Value = buyItemHourlyEnabled,
        Callback = function(enabled)
            buyItemHourlyEnabled = enabled
            Config:Set("BuyItemHourlyEnabled", enabled)
            Config:Save()
            if enabled then StartBuyItemHourlyLoop() end
        end
    })

    if autoGachaCharacterEnabled then StartAutoGachaCharacter() end
    if autoGachaSkinEnabled then StartAutoGachaSkin() end
    if autoUseItemEnabled then StartAutoUseItem() end
    if IsAnySyncedShopEnabled() then StartAutoSyncedShopLoop() end
    if buyItemHourlyEnabled then StartBuyItemHourlyLoop() end
end
_G.__DYHUB_ShopSystems()
_G.__DYHUB_ShopSystems = nil

-- ====================== UI: COLLECT TAB ======================
Main6:Section({ Title = T("collect_section"), Icon = "package" })

AutoCollectToggle = Main6:Toggle({
    Title = T("auto_collect"), Value = AutoCollectEnabled,
    Desc = "自动收集地图上出现的选定物品。",
    Callback = function(state)
        AutoCollectEnabled = state; Config:Set("AutoCollectEnabled", state); Config:Save()
        if state then
            KnownCollectItems = {}
            CollectCandidateCache = {}
            CollectCacheDirty = true
            CheckFarmAstroCollectMode()
            StartAutoCollectLoop()
        else
            CollectRunning = false
            FarmCollecting = false
        end
    end
})

Main6:Section({ Title = T("collect_settings"), Icon = "settings" })

CollectItemDropdown = Main6:Dropdown({
    Title = "收集物品",
    Desc = "选择自动收集要瞄准的可收集物品。",
    Values = CollectItems, Multi = true, Value = SelectedCollectItems,
    Callback = function(values)
        SelectedCollectItems = values or {}
        CollectCandidateCache = {}
        CollectCacheDirty = true
        KnownCollectItems = {}
        Config:Set("SelectedCollectItems", SelectedCollectItems)
        Config:Save()
    end
})

CollectModeDropdown = Main6:Dropdown({
    Title = T("collect_mode"),
    Desc = "选择自动收集应何时收集物品。",
    Values = { "Clean", "IDGF" }, Multi = false, Value = CollectMode,
    Callback = function(value)
        CollectMode = value
        Config:Set("CollectMode", value)
        Config:Save()
        CheckFarmAstroCollectMode()
    end
})

CollectMovementDropdown = Main6:Dropdown({
    Title = "收集移动模式",
    Desc = "选择角色移动到可收集物品的方式。",
    Values = { "Teleport", "Tween" },
    Multi = false,
    Value = CollectMovementMode,
    Callback = function(value)
        CollectMovementMode = NormalizeCollectMovement(value)
        Config:Set("CollectMovementMode", CollectMovementMode)
        Config:Save()
        WindUI:Notify({ Title = "收集移动模式", Content = "已选择: " .. tostring(CollectMovementMode), Duration = 2, Icon = "move" })
    end
})

-- ====================== UI: SETTING TAB ======================
Main3:Section({ Title = T("save_settings"), Icon = "save" })

Main3:Button({
    Title = T("save_config"),
    Desc = "立即将所有当前设置保存到配置文件。",
    Callback = function()
        Config:Save()
        WindUI:Notify({ Title = T("save_config"), Content = "配置已成功保存！", Duration = 2, Icon = "save" })
    end
})

AutoSaveEnabled = Config:Get("AutoSaveEnabled", true)
AutoSaveDelay   = Config:Get("AutoSaveDelay", 15)
AutoSaveThread  = nil

function RestartAutoSave()
    if AutoSaveThread then task.cancel(AutoSaveThread); AutoSaveThread = nil end
    if AutoSaveEnabled then
        AutoSaveThread = task.spawn(function()
            while AutoSaveEnabled do
                task.wait(AutoSaveDelay)
                Config:Save()
            end
        end)
    end
end

Main3:Toggle({
    Title = T("auto_save"), Value = AutoSaveEnabled,
    Desc = "按设定间隔自动保存配置。",
    Callback = function(state) AutoSaveEnabled = state; Config:Set("AutoSaveEnabled", state); Config:Save(); RestartAutoSave() end
})

Main3:Input({
    Title = T("delay_save"),
    Desc = "设置自动保存间隔（秒）。",
    Default = tostring(AutoSaveDelay), Placeholder = "默认: 15",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 1 then AutoSaveDelay = num; Config:Set("AutoSaveDelay", num); Config:Save(); RestartAutoSave()
        else warn("[DYHUB] 无效的延迟值！") end
    end
})

RestartAutoSave()

Main3:Section({ Title = T("server_status"), Icon = "server" })

Main3:Button({
    Title = T("serverhop"),
    Desc = "将你传送到此游戏的另一个随机服务器。",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local servers = {}
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
        end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    table.insert(servers, server.id)
                end
            end
        end
        if #servers > 0 then
            WindUI:Notify({ Title = T("serverhop"), Content = "正在传送到另一个服务器...", Duration = 2, Icon = "server" })
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        else
            WindUI:Notify({ Title = "切换服务器失败", Content = "未找到可用服务器。", Duration = 3, Icon = "alert-triangle" })
        end
    end
})

Main3:Button({
    Title = T("rejoin"),
    Desc = "重新加入当前游戏服务器。",
    Callback = function()
        WindUI:Notify({ Title = T("rejoin"), Content = "正在重新加入服务器...", Duration = 2, Icon = "refresh-cw" })
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

Main3:Section({ Title = T("others"), Icon = "settings" })

CameraDropdown = Main3:Dropdown({
    Title = T("camera_mode"),
    Desc = "选择相机应如何跟随你的角色。",
    Values = { "Classic", "Manual" },
    Multi = false,
    Value = NormalizeCameraMode(CameraMode),
    Callback = function(value)
        CameraMode = NormalizeCameraMode(value)
        Config:Set("CameraMode", CameraMode)
        Config:Save()
        ApplyCameraMode(true)
        WindUI:Notify({ Title = T("camera_mode"), Content = "已选择: " .. tostring(CameraMode), Duration = 2, Icon = "camera" })
    end
})

NoBarrierToggle = Main3:Toggle({
    Title = T("bypass_barrier"), Value = noBarrierActive,
    Desc = "尝试绕过隐形屏障（已失效）。",
    Callback = function(value)
        noBarrierActive = value; Config:Set("NoBarrier", value); Config:Save()
        if value then startNoBarrier() else stopNoBarrier() end
    end
})

CombatDebugToggle = Main3:Toggle({
    Title = T("combat_debug"),
    Value = CombatDebugEnabled,
    Desc = "输出基于冷却时间的自动攻击/技能和怪物缓存调试日志。",
    Callback = function(value)
        CombatDebugEnabled = value
        Config:Set("CombatDebugEnabled", value)
        Config:Save()
        if value then
            WindUI:Notify({ Title = T("combat_debug"), Content = "战斗调试日志已启用。", Duration = 2, Icon = "bug" })
        else
            WindUI:Notify({ Title = T("combat_debug"), Content = "战斗调试日志已禁用。", Duration = 2, Icon = "square" })
        end
    end
})

AntiAFKConnection = nil
AntiAFKThread = nil
AntiAFKDisabledConnections = false

function StartAntiAFK()
    AntiAFK = true

    if getconnections and not AntiAFKDisabledConnections then
        pcall(function()
            for _, connection in pairs(getconnections(LocalPlayer.Idled)) do
                if connection.Disable then
                    connection:Disable()
                elseif connection.Disconnect then
                    connection:Disconnect()
                end
            end
        end)
        AntiAFKDisabledConnections = true
    end

    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end

    AntiAFKConnection = LocalPlayer.Idled:Connect(function()
        if not AntiAFK then return end
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    if AntiAFKThread then
        pcall(function() task.cancel(AntiAFKThread) end)
        AntiAFKThread = nil
    end

    AntiAFKThread = task.spawn(function()
        while AntiAFK do
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            task.wait(60)
        end
        AntiAFKThread = nil
    end)
end

function StopAntiAFK()
    AntiAFK = false

    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end

    if AntiAFKThread then
        pcall(function() task.cancel(AntiAFKThread) end)
        AntiAFKThread = nil
    end
end

antiafk = Main3:Toggle({
    Title = T("anti_afk"), Value = AntiAFK,
    Desc = "防止 Roblox 因长时间不操作将你踢出。",
    Callback = function(enabled)
        AntiAFK = enabled
        Config:Set("AntiAfk", enabled)
        Config:Save()
        if enabled then
            StartAntiAFK()
            WindUI:Notify({ Title = T("anti_afk"), Content = "防挂机已启用。", Duration = 2, Icon = "shield-check" })
        else
            StopAntiAFK()
            WindUI:Notify({ Title = T("anti_afk"), Content = "防挂机已禁用。", Duration = 2, Icon = "square" })
        end
    end
})

if AntiAFK then StartAntiAFK() end

-- ====================== 应用保存的配置（启动时） ======================
function ApplySavedConfigOnStartup()
    task.wait(1)
    updatePlayerStats()
    ApplyCameraMode(true)
    UpdateDYHUBWaitingPartCollision()
    if FullBrightEnabled then ApplyFullBright() end
    if NoFogEnabled then ApplyNoFog() end
    if FlyEnabled then StartFly() end

    if FarmAstroTokenEnabled and AutoFarmEnabled then
        FarmAstroTokenEnabled = false
        Config:Set("FarmAstroTokenEnabled", false)
        Config:Save()
        NotifyFarmAstroAutoFarm()
    end

    if AutoFarmEnabled then
        StartFarmLoop()
        StartJeffreyGuardLoop()
    end

    if FarmAstroTokenEnabled then
        StartFarmAstroToken()
    end

    HandleMiscOptions(MiscOptions)

    if noBarrierActive then startNoBarrier() end

    if ESP.Enabled then
        StartESPLoop()
    end

    if AutoCollectEnabled then
        KnownCollectItems = {}
        CollectCandidateCache = {}
        CollectCacheDirty = true
        StartAutoCollectLoop()
    end

    if AutoStartEnabled and IsMiscFarmAllowed() then
        SetupAutoStartOnly(true)
    elseif AutoStartEnabled then
        StopAutoStart()
    end
end

ApplySavedConfigOnStartup()

print("[DYHUB] 版本: " .. version .. " | 更新日志: " .. ver .. " 加载成功！")
print("[DYHUB] 配置系统已激活 | 每 " .. tostring(AutoSaveDelay) .. " 秒自动保存")
