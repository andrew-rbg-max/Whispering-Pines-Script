local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌲 Whispering Pines Script",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Whispering Pines Hub",
   LoadingSubtitle = "by Idwin.Matthew from discord",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Whispering Pines | Key",
      Subtitle = "Key System",
      Note = "Thank you for using my script! Key is Whisper", -- Use this to tell the user how to get a key
      FileName = "Whispering Pines Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Whisper"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Home", 4483362458) -- Title, Image
local MainSection = MainTab:CreateSection("ESP")

Rayfield:Notify({
   Title = "You have executed the script.",
   Content = "Thank you for using this script!",
   Duration = 5,
   Image = nil,
   Actions = { -- Notification Buttons
      Ignore = {
      Name = "Okay!",
      Callback = function()
      print("The user has tapped Okay!")
     end
   },
},
})

local Button = MainTab:CreateButton({
   Name = "Player ESP",
   Callback = function()
local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Player ESP Unloaded";
        Text = "Player ESP could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Typing = false

_G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.

_G.TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.

_G.ESPVisible = true   -- If set to true then the ESP will be visible and vice versa.
_G.TextColor = Color3.fromRGB(255, 80, 10)   -- The color that the boxes would appear as.
_G.TextSize = 14   -- The size of the text.
_G.Center = true   -- If set to true then the script would be located at the center of the label.
_G.Outline = true   -- If set to true then the text would have an outline.
_G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
_G.TextTransparency = 0.7   -- The transparency of the text.
_G.TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 

_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the ESP.

local function CreateESP()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local ESP = Drawing.new("Text")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

                    ESP.Size = _G.TextSize
                    ESP.Center = _G.Center
                    ESP.Outline = _G.Outline
                    ESP.OutlineColor = _G.OutlineColor
                    ESP.Color = _G.TextColor
                    ESP.Transparency = _G.TextTransparency
                    ESP.Font = _G.TextFont

                    if OnScreen == true then
                        local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                        local Dist = (Part1 - Part2).Magnitude
                        ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                        ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                ESP.Visible = _G.ESPVisible
                            else
                                ESP.Visible = false
                            end
                        else
                            ESP.Visible = _G.ESPVisible
                        end
                    else
                        ESP.Visible = false
                    end
                else
                    ESP.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                ESP.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then 
                local ESP = Drawing.new("Text")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
    
                        ESP.Size = _G.TextSize
                        ESP.Center = _G.Center
                        ESP.Outline = _G.Outline
                        ESP.OutlineColor = _G.OutlineColor
                        ESP.Color = _G.TextColor
                        ESP.Transparency = _G.TextTransparency
    
                        if OnScreen == true then
                            local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                            local Dist = (Part1 - Part2).Magnitude
                            ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                            ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    ESP.Visible = _G.ESPVisible
                                else
                                    ESP.Visible = false
                                end
                            else
                                ESP.Visible = _G.ESPVisible
                            end
                        else
                            ESP.Visible = false
                        end
                    else
                        ESP.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    ESP.Visible = false
                end)
            end
        end)
    end)
end

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.ESPVisible = true
    _G.TextColor = Color3.fromRGB(40, 90, 255)
    _G.TextSize = 14
    _G.Center = true
    _G.Outline = false
    _G.OutlineColor = Color3.fromRGB(0, 0, 0)
    _G.DisableKey = Enum.KeyCode.Q
    _G.TextTransparency = 0.75
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.ESPVisible = not _G.ESPVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Player ESP";
                Text = "The ESP's visibility is now set to "..tostring(_G.ESPVisible)..".";
                Duration = 5;
            })
        end
    end
end)

local Success, Errored = pcall(function()
    CreateESP()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Loaded Player ESP";
            Text = "Player ESP has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "ESP script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
    TestService:Message("The ESP script has errored, please notify Exunys with the following information :")
    warn(Errored)
    print("!! IF THE ERROR IS A FALSE POSITIVE (says that a player cannot be found) THEN DO NOT BOTHER !!")
end
   end,
})

local Button = MainTab:CreateButton({
   Name = "Rake ESP",
   Callback = function()
local modelName = "Rake"
local model = workspace:WaitForChild(modelName)
local rootPart = model:FindFirstChild("HumanoidRootPart")

if rootPart then
    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = rootPart

    -- Create label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = modelName
    label.TextColor3 = Color3.new(1, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard

    print("ESP added to Rake.")
else
    warn("Could not find HumanoidRootPart in Rake.")
end
   end,
})

local MainSection = MainTab:CreateSection("Sliders")

local Slider = MainTab:CreateSlider({
   Name = "Walkspeed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "example", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "FOV",
   Range = {0, 120},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 16,
   Flag = "example", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       local FovNumber = (Value) --Enter your FOV number here
       local Camera = workspace.CurrentCamera
       Camera.FieldOfView = FovNumber
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 100},
   Increment = 1,
   Suffix = "JumpPower",
   CurrentValue = 16,
   Flag = "example", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       local plr = game.Players.LocalPlayer
       local char = plr.Character
 
       char.Humanoid.JumpPower = (Value)
   end,
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458) -- Title, Image
local Section = TeleportTab:CreateSection("Players")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Input = TeleportTab:CreateInput({
   Name = "Tp To User",
   CurrentValue = "",
   PlaceholderText = "Username",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)

       if Text and Text ~= "" then
           local targetPlayer = Players:FindFirstChild(Text)
           if targetPlayer then

               LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame

               if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   LocalPlayer.Character.HumanoidRootPart.Anchored = false

                   task.delay(7.5, function()
                       if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                           LocalPlayer.Character.HumanoidRootPart.Anchored = false
                       end
                   end)
               end
           else
               print("Player not found!")
           end
       end
   end,
})

local button = TeleportTab:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
       local username = Input:GetValue() 
       if username and username ~= "" then
           local targetPlayer = Players:FindFirstChild(username)
           if targetPlayer then

               LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame

               if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   LocalPlayer.Character.HumanoidRootPart.Anchored = false

                   task.delay(7.5, function() 
                       if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                           LocalPlayer.Character.HumanoidRootPart.Anchored = false
                       end
                   end)
               end
           else
               print("Player not found!")
           end
       else
           print("Please enter a username.")
       end
   end,
})

local Section = TeleportTab:CreateSection("Places")

local Button = TeleportTab:CreateButton({
   Name = "Tower 1",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(-277.68, 4.7, -365.52)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Tower 2",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(188.37, 4.76, 191.47)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Staff Cabin",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(17.65, 4.21, -116.46)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Mini Cabin",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(83.76, 47.06, -494.27)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Merky Lake",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(183.27, 3.91, -131.39)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Shed",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(306.45, 4.74, -72.97)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "T2 Camp",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(-69.12, 4.58, 279.83)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Drowsy Mines",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(-358.04, 3.87, 208.24)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Button = TeleportTab:CreateButton({
   Name = "Rake Cave",
   Callback = function()
local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local targetPosition = Vector3.new(-517.46, 4.07, 183.53)

        local function teleportAndAnchorCharacter()

                character:PivotTo(CFrame.new(targetPosition))

                local primaryPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")

                if primaryPart then
                    primaryPart.Anchored = false
                
            end
        end

        teleportAndAnchorCharacter()
   end,
})

local Tab = Window:CreateTab("Misc", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Noclip")

local Toggle = Tab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "Toggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
              local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local function toggleNoclip()
            noclipEnabled = not noclipEnabled 

            if noclipEnabled then

                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else

                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end

        toggleNoclip()
   end,
})
