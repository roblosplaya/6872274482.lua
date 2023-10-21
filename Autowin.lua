getgenv().AutowinSettings = {
    XPGrind = {
        Enabled = false; 
--[[
In programming, including Roblox Lua scripting, "true" and "false" are special values called booleans. Booleans are a data type that can only have one of two possible values: true or false.

The value "true" represents something that is considered to be true or valid.
In many programming contexts, "true" is used to indicate that a condition is met or that a statement is valid.

The value "false" represents something that is considered to be false or invalid.
In programming, "false" is often used to indicate that a condition is not met or that a statement is not valid.
]]
        WaitTime = 0.1 -- hoW long it Waits before starting (for bw XP counter). Recommended 10-15 seconds
    };
    Game = {
        LowFPS = {
            Enabled = false;
            fpsamt = 35 -- no lower than 35 or not as efficient
        };
        LowGFX = false;
    };
}
-- made by boat_lol

repeat task.wait() until game:IsLoaded() 
task.wait(2)
if not shared.GuiLibrary then
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"))()
end;


repeat task.wait() until shared.GuiLibrary and shared.vapewhitelist and shared.VapeFullyLoaded
task.wait(2)

local LibLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/boatDeckRoblox/Libraries/main/LibLoader'))()

LibLoader:LoadLib('lPlayer')

if Connections then
    for i,v in pairs(Connections) do
        if typeof(v) == 'RBXScriptSignal' then
            v:Disconnect()
        end
    end
end



getgenv().Connections = {}

getgenv = getgenv or function()
    return _G
end

local TP = game:GetService("TeleportService")


TP.TeleportInitFailed:Connect(function()
	task.wait()
	TP:Teleport(6872265039)
end)



getgenv().TweenSpeed = .96

function HasPick()
    for i,v in pairs(game:GetService("ReplicatedStorage").Inventories:GetChildren()) do
        if v.Name == game.Players.LocalPlayer.Name then
            for x,child in pairs(v:GetChildren()) do
                if child.Name:find("pickaxe") or child.Name == "wood_pickaxe" then
                    return true
                end
            end
        end
    end
    return false
end


getBed = function()
    local _2 = ''
        for i,v in pairs(workspace:GetChildren()) do
            if v.Name == 'bed' and v:FindFirstChild("Covers") and v.Covers.BrickColor == game.Players.LocalPlayer.TeamColor then
                _2 = v;
                break
            end
        end
        return _2
    end
print("Running!")



repeat task.wait(.1) until lPlayer


if AutowinSettings.Game.LowFPS.Enabled then
    lPlayer:fpslim(tonumber(AutowinSettings.Game.LowFPS.fpsamt) or math.random(35,45))
end
if AutowinSettings.Game.LowGFX then
lPlayer:SetRender(false) 
end


function KillSelf()

    if lPlayer:isAlive() then
        lPlayer:kill()
        task.wait(.1)
        GetService("vim"):SendKeyEvent(true, "W", false, game)
        task.wait(.2)
        GetService("vim"):SendKeyEvent(false, "W", false, game)
    end
end

if not workspace:FindFirstChild("Map") then return end


function GetMagnitude(block1, block2)
    if block1 and block2 then
        local pos1 = block1.Position
        local pos2 = block2.Position
        return (pos2 - pos1).Magnitude
    end
end

local function isPlayerNearby(radius)
    radius = radius or 18
    -- Get the position of the local player
    local localPlayerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    -- Initialize variables to track the closest player and its distance
    local closestPlayer = nil
    local closestDistance = math.huge -- Start with a very large value

    -- Loop through all the players in the game
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Team ~= lPlayer.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerPosition = player.Character.HumanoidRootPart.Position
            local distance = (playerPosition - localPlayerPosition).magnitude

            if distance <= radius and distance < closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end

    return closestPlayer
end

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function CountBeds()
    local amt = 0;
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == 'bed' and v:FindFirstChild("Covers") then
            amt += 1
        end
    end
    return amt
end

local numBeds = 2;

spawn(function()
repeat task.wait(0.2)
numBeds = CountBeds()
until nil
end)

function GetClosestBed()
    local nearestBed = nil
    local minDistance = math.huge

    for _,v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower() == "bed" and v:FindFirstChild("Covers") and v:FindFirstChild("Covers").BrickColor ~= lPlayer.TeamColor then
            local distance = (v.Position - lPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < minDistance then
                nearestBed = v
                minDistance = distance
            end
        end
    end

    return nearestBed
end


local function TargBed()
    local blacklistbedBeds = getBed()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == 'bed' and v:FindFirstChild("Covers") and v ~= blacklistbedBeds then
            return v
        end
    end
end

function bedHasSheild()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == 'BedShield' then
            return true
        end
    end
    return false
end
getgenv().killed = {}
function DoTween(where2, mode)
	task.wait(0.1)
    local tweenComp = false
    local tween
    if mode == 'bed' then
    tween = TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {-- Enum.EasingStyle.Linear, Enum.EasingDirection.Out
        CFrame = where2.CFrame * CFrame.new(0,5,0)
    });
else
    tween = TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = where2.CFrame * CFrame.new(0,0,-1)
    });
    --- -, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
    end
    tween:Play();
    local normal = Enum.CameraType.Custom;
    local scriptable = Enum.CameraType.Scriptable
    local camera = workspace.CurrentCamera
    camera.CameraType = scriptable
    local leftRotation = CFrame.Angles(0, math.rad(-90), 0)
    local rotatedLeftCFrame = camera.CFrame * leftRotation

    -- Set the camera to the left rotated CFrame
    camera.CFrame = rotatedLeftCFrame

    local rightRotation = CFrame.Angles(0, math.rad(90), 0)
    local rotatedRightCFrame = rightRotation
    print("sad")
    camera.CameraType = normal
    tween.Completed:Wait(.1)
    tweenComp = true
    if mode == 'bed' then

        local oldPos = TargBed():FindFirstChild("Covers").CFrame
        
        if lPlayer:isAlive() and GetMagnitude(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TargBed()) > 10 and tweenComp then -- if the tween lags u back or fails then we kill the player and retry
            KillSelf()
        end
        repeat
        task.wait()
        if lPlayer:isAlive() and lPlayer.Character and lPlayer.Character:FindFirstChild("HumanoidRootPart") and GetMagnitude(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TargBed()) > 10 and tweenComp then -- if the tween lags u back or fails then we kill the player and retry
            KillSelf()
        end
        until where2 == nil or where2.Parent ~= game:GetService("Workspace") or where2.Parent == nil or not where2:FindFirstChild("Covers") or where2.Covers.CFrame ~= oldPos or not lPlayer:isAlive()

        if isPlayerNearby(20) then
            local plr = isPlayerNearby(20)
            print(plr.Name)
            local oldTeam = plr.Team
            local oldTeamColor = plr.TeamColor;
            local lol = TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(.16, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
            })
            lol:Play();
            lol.Completed:Wait()
            repeat task.wait()
            local thisTween
            thisTween = TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
            })
            thisTween:Play()
            thisTween.Completed:Wait()
            if GetMagnitude(lPlayer.Character:FindFirstChild("HumanoidRootPart"), plr.Character.HumanoidRootPart) > 30 then -- if the tween lags u back or fails then we kill the player and retry
                KillSelf()
            end
            thisTween = nil
            
            task.wait(.1)
            until plr.Team ~= oldTeam or plr.TeamColor ~= oldTeamColor or not lPlayer:isAlive(plr)
            table.insert(killed, plr.Name)
        end
        KillSelf()
    end
    tween = nil
end
local mode = ''
if bedHasSheild() then
    mode = 'ranked' 
end


repeat task.wait(0.2) until not bedHasSheild() and HasPick()
if AutowinSettings.XPGrind.Enabled and mode == '' then
    task.wait((AutowinSettings.XPGrind.WaitTime))
end
--[[
function HasBeenTime(amt)
    amt = tonumber(amt)
    local lagbacked = false
    for i=1,7 do
        if not lagbacked then
            task.wait(1)
            lagbacked = isnetworkowner(lPlayer.Character.HumanoidRootPart)
        end
    end
    return lagbacked
end
]]

local function PlayerOnTeam(team)
    local players = game:GetService("Players"):GetPlayers()
    
    for _, player in ipairs(players) do
        if player.TeamColor == team then
            return true
        end
    end
    
    return false
end
task.wait(.1)
KillSelf()
print("Starting")




Connections.bedBreakFunc = lPlayer.CharacterAdded:Connect(function()

    DoTween(TargBed(), 'bed')
end)

repeat task.wait(0.2) until numBeds == 0 or numBeds == 1
Connections.bedBreakFunc:Disconnect();

print("Disconnected!")


Connections.Kill = lPlayer.CharacterAdded:Connect(function()
	task.wait()
	repeat task.wait() until lPlayer:isAlive()
    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        local times
        if not table.find(killed, v.Name) and v.Team ~= lPlayer.Team and lPlayer:isAlive() and lPlayer:isAlive(v) and v.Character and v.Character:FindFirstChild('HumanoidRootPart') then
            if (not v.Character or not v.Character:FindFirstChild("HumanoidRootPart")) then repeat task.wait() times += 1 until (v and v.Character and v.Character.HumanoidRootPart) or times == 10 end
            if times == 10 then
                lPlayer:kill()
                break
            end
            DoTween(v.Character.HumanoidRootPart, "kill")
            local oldTeam = v.Team
            local oldTeamColor = v.TeamColor;
            repeat task.wait()
                local thisTween = nil;
                thisTween =  TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(.2,Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { -- Enum.EasingStyle.Linear, Enum.EasingDirection.Out
                    CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
                })
                thisTween:Play()
                thisTween.Completed:Wait()
                task.wait(.1)
                thisTween =  TweenService:Create(lPlayer.Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(.4,Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { -- Enum.EasingStyle.Linear, Enum.EasingDirection.Out
                    CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
                })
                thisTween:Play()
                thisTween.Completed:Wait()
                task.wait(.1)
                if GetMagnitude(lPlayer.Character:FindFirstChild("HumanoidRootPart"), v.Character.HumanoidRootPart) > 30 then -- if the tween lags u back or fails then we kill the player and retry
                    KillSelf()
                end
            until v == nil or v.Team ~= oldTeam or v.TeamColor ~= oldTeamColor or not lPlayer:isAlive(v) or not lPlayer:isAlive()
	        if lPlayer:isAlive() then
                    table.insert(killed, v.Name);
                    print(lPlayer:isAlive())
                KillSelf()
            end
            return
        end
    end
end)

KillSelf()
print("YESSSSS")
