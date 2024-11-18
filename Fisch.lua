--Load library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "[🍄] Fisch | Version 0.0.54.3",
   LoadingTitle = "[🍄] Fisch",
   LoadingSubtitle = "by Kirymeww",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Fisch",
      FileName = "FischCfg"
   },
      
   KeySystem = false,
   KeySettings = {
      Title = "[🍄] Fisch",
      Subtitle = "🔑 Key System",
      Note = "Password: Depths",
      Key = {"Depths"}
   }
})

--Services
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--Values
_G.acast = false
_G.ashake = false
_G.areel = false
_G.freezep = false
_G.asell = false
_G.asellinhand = false
_G.afixmap = false
_G.afindchest = false

_G.areelmode = false
_G.ashakemode = true
_G.smerchant = nil

_G.plspeed = 16
_G.pljump = 50

_G.espisonade = false

--Functions
local function AutoCast()
   while _G.acast do
      local args = {
         [1] = 100,
         [2] = 1
      }

      local player = game.Players.LocalPlayer
      local rod = nil

      if player.Character and player.Character:FindFirstChildOfClass("Tool") then
         rod = player.Character:FindFirstChildOfClass("Tool")
      else
         for _, item in ipairs(player.Backpack:GetChildren()) do
            if item.Name:find("Rod") then
               rod = item
               break
            end
         end
      end

      if rod then
         if rod.Parent ~= player.Character then
            rod.Parent = player.Character
         end

         if rod:FindFirstChild("events") and rod.events:FindFirstChild("cast") then
            rod.events.cast:FireServer(unpack(args))
         end
      end
      wait(0.5)
   end
end

local function navigateAndClick()
    local player = Players.LocalPlayer
    local button = player.PlayerGui:FindFirstChild("shakeui") and player.PlayerGui.shakeui:FindFirstChild("safezone") and player.PlayerGui.shakeui.safezone:FindFirstChild("button")
    
    if button then
        GuiService.SelectedObject = button
        if GuiService.SelectedObject == button then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, nil)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, nil)
        end
    end
end

local function clickWithCursor()
    local player = Players.LocalPlayer
    local button = player.PlayerGui:FindFirstChild("shakeui") and player.PlayerGui.shakeui:FindFirstChild("safezone") and player.PlayerGui.shakeui.safezone:FindFirstChild("button")

    if button then
        local buttonPosition = button.AbsolutePosition
        local buttonSize = button.AbsoluteSize
        local centerX = buttonPosition.X + (buttonSize.X / 2.5)
        local centerY = buttonPosition.Y + (buttonSize.Y / 2.5)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, nil, 0)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, nil, 0)
    end
end

local function AutoShake()
    while _G.ashake do
        if _G.ashakemode then
            navigateAndClick()
            wait(0.01)
        else
            clickWithCursor()
            wait(0.01)
        end
    end
end

local function NormalReelGui()
    local player = Players.LocalPlayer
    local playerbar = player.PlayerGui:FindFirstChild("reel") and player.PlayerGui.reel:FindFirstChild("bar") and player.PlayerGui.reel.bar:FindFirstChild("playerbar")
    
    if playerbar then
        playerbar.Position = UDim2.new(0.5, 0, 0.5, 0)
        playerbar.Size = UDim2.new(1, 0, 1.3, 0)
    end
end

local function AutoReel()
    local args = {}

    while _G.areel do
        if _G.areelmode then
            NormalReelGui()
            args = {}
        else
            args = {
                [1] = 100,
                [2] = true
            }
        end

        if #args > 0 then
            game:GetService("ReplicatedStorage").events.reelfinished:FireServer(unpack(args))
        end
        wait(0.2)
    end
end

local function AutoSell()
   while _G.asell do
      if _G.smerchant then
         local merchant = workspace.world.npcs:FindFirstChild(_G.smerchant)
         if merchant then
            merchant.merchant.sellall:InvokeServer()
         end
      end
      wait(0.1)
   end
end

local function AutoSellInHand()
   while _G.asellinhand do
      if _G.smerchant then
         local merchant = workspace.world.npcs:FindFirstChild(_G.smerchant)
         if merchant then
            merchant.merchant.sell:InvokeServer()
         end
      end
      wait(0.2)
   end
end

local function FreezePlayer()
   local player = game.Players.LocalPlayer
   local initialCFrame = nil
   local humanoid = nil

   while _G.freezep do
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         if not initialCFrame then
            initialCFrame = player.Character.HumanoidRootPart.CFrame
            humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               humanoid.WalkSpeed = 0
               humanoid.JumpPower = 0
            end
         end
         player.Character.HumanoidRootPart.CFrame = initialCFrame
      end
      wait(0.01)
   end

   if humanoid then
      humanoid.WalkSpeed = _G.plspeed
      humanoid.JumpPower = _G.pljump
   end
end

local function Espisonade()
   local player = game.Players.LocalPlayer
   local notifiedIsonades = {}
   local isonades = workspace:FindFirstChild("zones")

   while _G.espisonade do
      if isonades and isonades:FindFirstChild("fishing") then
         for _, isonade in pairs(isonades.fishing:GetChildren()) do
            if isonade.Name == "Isonade" and not isonade:FindFirstChild("BillboardGui") then
               local billboardGui = Instance.new("BillboardGui")
               local textLabel = Instance.new("TextLabel")

               billboardGui.Adornee = isonade
               billboardGui.Size = UDim2.new(0, 150, 0, 40)
               billboardGui.StudsOffset = Vector3.new(0, 110, 0)
               billboardGui.AlwaysOnTop = true
               textLabel.Parent = billboardGui
               textLabel.Size = UDim2.new(1, 0, 1, 0)
               textLabel.BackgroundTransparency = 1
               textLabel.TextColor3 = Color3.fromRGB(200, 100, 150)
               textLabel.TextScaled = false
               textLabel.TextSize = 14
               textLabel.Font = Enum.Font.FredokaOne
               textLabel.Text = "Isonade"
               billboardGui.Parent = isonade

               if not notifiedIsonades[isonade] then
                  Rayfield:Notify({
                     Title = "🚩 Event",
                     Content = "Isonade zone has spawned!",
                     Duration = 3,
                     Image = 4483362458,
                  })
                  notifiedIsonades[isonade] = true
               end
            end
         end
      end
      wait(1)
   end
end

local function DelEspisonade()
   for _, isonade in pairs(workspace:FindFirstChild("zones").fishing:GetChildren()) do
      if isonade:FindFirstChild("BillboardGui") then
         isonade.BillboardGui:Destroy()
      end
   end
end

function teleportPlayer(x, y, z)
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local character = player.Character
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end

--Tabs
local ma = Window:CreateTab("Main", "fish")
local tp = Window:CreateTab("Teleport", "earth")
local misc = Window:CreateTab("Misc", "hammer")
local setting = Window:CreateTab("Settings", "bolt")

--Main
local Section = ma:CreateSection("🎣 Auto Cast")
local acast = ma:CreateToggle({
   Name = "🎣 Auto Cast",
   CurrentValue = false,
   Flag = "acast",
   Callback = function(AcastV)
         _G.acast = AcastV
         AutoCast()
   end,
})

local Section = ma:CreateSection("🔀 Auto Shake")
local ashakemode = ma:CreateDropdown({
   Name = "🔀 Select Shake Mode",
   Options = {"⌨ KeyCode", "🖱 Mouse"},
   CurrentOption = {"⌨ KeyCode"},
   MultipleOptions = false,
   Flag = "ashakemode",
   Callback = function(Options)
      if Options[1] == "⌨ KeyCode" then
         _G.ashakemode = true
      else
         _G.ashakemode = false
      end
   end,
})

local ashake = ma:CreateToggle({
   Name = "🔀 Auto Shake",
   CurrentValue = false,
   Flag = "ashake",
   Callback = function(AshakeV)
         _G.ashake = AshakeV
         AutoShake()
   end,
})

local Section = ma:CreateSection("🔃 Auto Reel")
local areelmode = ma:CreateDropdown({
   Name = "🎣 Select Reel Mode",
   Options = {"🟩 Normal", "🟨 Instant"},
   CurrentOption = {"🟨 Instant"},
   MultipleOptions = false,
   Flag = "areelmode",
   Callback = function(Options)
      if Options[1] == "🟩 Normal" then
         _G.areelmode = true
      else
         _G.areelmode = false
      end
   end,
})

local areel = ma:CreateToggle({
   Name = "🔃 Auto Reel",
   CurrentValue = false,
   Flag = "areel",
   Callback = function(AreelV)
         _G.areel = AreelV
         AutoReel()
   end,
})

local Section = ma:CreateSection("🛒 Merchant")
local smerchant = ma:CreateDropdown({
   Name = "👨‍🦰 Select Merchant",
   Options = {
      "🌲 Marc", "🏖 Matt", "🌞 Max", "❄️ Mike", 
      "⚛ Cort", "🌊 Maverick", "🌌 Mel", "⛏ Marc (The Depths)"
   },
   CurrentOption = "",  
   MultipleOptions = false,
   Flag = "smerchant",
   Callback = function(Options)
      local selectedMerchant = Options[1]
      if selectedMerchant == "🌲 Marc" then
         _G.smerchant = "Marc Merchant"
      elseif selectedMerchant == "🏖 Matt" then
         _G.smerchant = "Matt Merchant"
      elseif selectedMerchant == "🌞 Max" then
         _G.smerchant = "Max Merchant"
      elseif selectedMerchant == "❄️ Mike" then
         _G.smerchant = "Mike Merchant"
      elseif selectedMerchant == "⚛ Cort" then
         _G.smerchant = "Cort Merchant"
      elseif selectedMerchant == "🌊 Maverick" then
         _G.smerchant = "Maverick Merchant"
      elseif selectedMerchant == "🌌 Mel" then
         _G.smerchant = "Mel Merchant"
      elseif selectedMerchant == "⛏ Marc (The Depths)" then
         _G.smerchant = "The Depth Merchant"
      end
   end,
})

local asell = ma:CreateToggle({
   Name = "💰 Auto Sell All",
   CurrentValue = false,
   Flag = "asell",
   Callback = function(AsellV)
         _G.asell = AsellV
         AutoSell()
   end,
})

local asellinhand = ma:CreateToggle({
   Name = "💰 Auto Sell In Hand",
   CurrentValue = false,
   Flag = "asellinhand",
   Callback = function(AsellihV)
         _G.asellinhand = AsellihV
         AutoSellInHand()
   end,
})

--Teleport
local Section = tp:CreateSection("🌎 Locations")
local tlocation = tp:CreateDropdown({
   Name = "🗺 Select Location",
   Options = {
      "🌲 Moosewood", "🏖 Roslit Bay", "🌋 Roslit Volcano",
      "🍄 Mushgrove Swamp", "🏝 Terrapin Island", "❄️ Snowcap Island",
      "🌞 Sunstone Island", "🏴‍☠️ Forsaken Shores", "🗿 Statue Of Sovereignty",
      "⛪ Keepers Altar", "🌪 Vertigo", "🌊 Desolate Deep", "🌌 Desolate Pocket", 
      "⛏ The Depths", "🌊 Brine Pool", "🌴 Earmark Isle", "🎸 Haddock Rock",
      "🌉 The Arch", "🌳 Birch Cay", "⚒ Harvesters Spike"
   },
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "tlocation",
   Callback = function(Options)
         local selectedLocation = Options[1]
         if selectedLocation == "🌲 Moosewood" then
            teleportPlayer(380, 135, 223)
         elseif selectedLocation == "🏖 Roslit Bay" then
            teleportPlayer(-1485, 133, 720)
         elseif selectedLocation == "🌋 Roslit Volcano" then
            teleportPlayer(-1910, 165, 317)
         elseif selectedLocation == "🍄 Mushgrove Swamp" then
            teleportPlayer(2500, 131, -720)
         elseif selectedLocation == "🏝 Terrapin Island" then
            teleportPlayer(-18, 156, 1975)
         elseif selectedLocation == "❄️ Snowcap Island" then
            teleportPlayer(2624, 142, 2471)
         elseif selectedLocation == "🌞 Sunstone Island" then
            teleportPlayer(-933, 132, -1118)
         elseif selectedLocation == "🏴‍☠️ Forsaken Shores" then
            teleportPlayer(-2500, 134, 1540)
         elseif selectedLocation == "🗿 Statue Of Sovereignty" then
            teleportPlayer(50, 132, -1009)
         elseif selectedLocation == "⛪ Keepers Altar" then
            teleportPlayer(1307, -805, -96)
         elseif selectedLocation == "🌪 Vertigo" then
            teleportPlayer(-108, -515, 1065)
         elseif selectedLocation == "🌊 Desolate Deep" then
            teleportPlayer(-1000, -245, -2725)
         elseif selectedLocation == "🌌 Desolate Pocket" then
            teleportPlayer(-1500, -235, -2856)
         elseif selectedLocation == "⛏ The Depths" then
            teleportPlayer(502, -707, 1234)
         elseif selectedLocation == "🌊 Brine Pool" then
            teleportPlayer(-1800, -143, -3404)
         elseif selectedLocation == "🌴 Earmark Isle" then
            teleportPlayer(1230, 125, 575)
         elseif selectedLocation == "🎸 Haddock Rock" then
            teleportPlayer(-570, 182, -413)
         elseif selectedLocation == "🌉 The Arch" then
            teleportPlayer(1000, 125, -1250)
         elseif selectedLocation == "🌳 Birch Cay" then
            teleportPlayer(1700, 125, -2500)
         elseif selectedLocation == "⚒ Harvesters Spike" then
            teleportPlayer(-1257, 139, 1550)
         end
   end,
})

local Section = tp:CreateSection("🛠 Items")
local ttotem = tp:CreateDropdown({
   Name = "🗿 Select Totem",
   Options = {
      "🕰️ Sundial", 
      "🌌 Aurora", 
      "🌬️ Windset", 
      "💨 Smokescreen", 
      "🌪️ Tempest"
   },
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "ttotem",
   Callback = function(Options)
         local selectedTotem = Options[1]

         if selectedTotem == "🕰️ Sundial" then
            teleportPlayer(-1148, 135, -1075)
         elseif selectedTotem == "🌌 Aurora" then
            teleportPlayer(-1811, -137, -3282)
         elseif selectedTotem == "🌬️ Windset" then
            teleportPlayer(2849, 179, 2702)
         elseif selectedTotem == "💨 Smokescreen" then
            teleportPlayer(2789, 140, -625)
         elseif selectedTotem == "🌪️ Tempest" then
            teleportPlayer(35, 132.5, 1943)
         end
   end,
})

local tfishingRods = tp:CreateDropdown({
   Name = "🎣 Select Fishing Rod",
   Options = {
      "🍣 Basic Rods",
      "🎯 Long Rod",
      "⚡ Rapid & ⏳ Steady Rods",
      "🍀 Fortune Rod",
      "🧲 Magnet Rod", 
      "🔱 Trident Rod",
      "🌌 Aurora Rod", 
      "🌙 Nocturnal Rod",
      "🔍 Kings Rod",
      "🛠️ Reinforced Rod",
      "🏴‍☠️ Scurvy Rod",
      "🏮 Rod Of The Depths"
   },
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "tfishingRods",
   Callback = function(Options)
         local selectedRod = Options[1]

         if selectedRod == "🍣 Basic Rods" then
            teleportPlayer(454, 151, 239)
         elseif selectedRod == "🎯 Long Rod" then
            teleportPlayer(486, 175, 151)
         elseif selectedRod == "⚡ Rapid & ⏳ Steady Rods" then
            teleportPlayer(-1510, 142, 761)
         elseif selectedRod == "🍀 Fortune Rod" then
            teleportPlayer(-1523, 142, 770)
         elseif selectedRod == "🧲 Magnet Rod" then
            teleportPlayer(-200, 133, 1930)
         elseif selectedRod == "🔱 Trident Rod" then
            teleportPlayer(-1484, -226, -2201)
         elseif selectedRod == "🌌 Aurora Rod" then
            teleportPlayer(-141, -512, 1145)
         elseif selectedRod == "🌙 Nocturnal Rod" then
            teleportPlayer(-141, -512, 1145)
         elseif selectedRod == "🔍 Kings Rod" then
            teleportPlayer(1381, -808, -302)
         elseif selectedRod == "🛠️ Reinforced Rod" then
            teleportPlayer(-989, -243, -2693)
         elseif selectedRod == "🏴‍☠️ Scurvy Rod" then
            teleportPlayer(-2825, 215, 1512)
         elseif selectedRod == "🏮 Rod Of The Depths" then
            teleportPlayer(1703, -903, 1443)
         end
   end,
})

local titems = tp:CreateDropdown({
   Name = "📦 Select Item",
   Options = {
      "📍 GPS", 
      "🔘 Fish Radar", 
      "🤿 Diving Gear", 
      "🐟 Bait Crate",
      "🦈 Quality Bait Crate", 
      "🦀 Crab Cage",
      "🈳 Tidebreaker",
      "⚓ Coral Geode",
      "👣 Flippers",
      "🪂 Glider",
      "🎺 Conception Conch",
   },
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "titems",
   Callback = function(Options)
         local selectedItem = Options[1]

         if selectedItem == "📍 GPS" then
            teleportPlayer(515, 151, 285)
         elseif selectedItem == "🔘 Fish Radar" then
            teleportPlayer(365, 136, 275)
         elseif selectedItem == "🤿 Diving Gear" then
            teleportPlayer(370, 136, 250)
         elseif selectedItem == "🐟 Bait Crate" then
            teleportPlayer(384, 137, 334)
         elseif selectedItem == "🦈 Quality Bait Crate" then
            teleportPlayer(-174, 144, 1932)
         elseif selectedItem == "🦀 Crab Cage" then
            teleportPlayer(476, 151, 231)
         elseif selectedItem == "🈳 Tidebreaker" then
            teleportPlayer(-1640, -214, -2851.11)
         elseif selectedItem == "⚓ Coral Geode" then
            teleportPlayer(-1640, -214, -2851.12)
         elseif selectedItem == "👣 Flippers" then
            teleportPlayer(-1640, -214, -2851.13)
         elseif selectedItem == "🪂 Glider" then
            teleportPlayer(-1640, -214, -2851.14)
         elseif selectedItem == "🎺 Conception Conch" then
            teleportPlayer(-1632, -214, -2862.15)
         end
   end,
})

local Section = tp:CreateSection("📌 Position")

local savedPosition = nil
local savep = tp:CreateButton({
   Name = "🟩 Save Position",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         savedPosition = player.Character.HumanoidRootPart.Position
         Rayfield:Notify({
         Title = "🟩 Success!",
         Content = "Position saved!",
         Duration = 3,
         Image = 4483362458,
      })
      else
         Rayfield:Notify({
         Title = "🟥 Failed!",
         Content = "Position not saved!",
         Duration = 3,
         Image = 4483362458,
      })
      end
   end,
})

local teleportp = tp:CreateButton({
   Name = "🟨 Teleport To Saved Position",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and savedPosition then
         player.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
         Rayfield:Notify({
         Title = "🟩 Success!",
         Content = "Teleported to saved position!",
         Duration = 3,
         Image = 4483362458,
      })
      else
         Rayfield:Notify({
         Title = "🟥 Failed!",
         Content = "No saved positions found!",
         Duration = 3,
         Image = 4483362458,
      })
      end
   end,
})

--Misc
local Section = misc:CreateSection("👁 Visual")
local espisonadet = misc:CreateToggle({
   Name = "👁 Esp Isonade",
   CurrentValue = false,
   Flag = "espisonadet",
   Callback = function(espisonadeV)
         _G.espisonade = espisonadeV
         if _G.espisonade then
            Espisonade()
         else
            DelEspisonade()
         end
   end,
})

local Section = misc:CreateSection("🙍‍♂️ Player")
local freezep = misc:CreateToggle({
   Name = "❄ Freeze Player",
   CurrentValue = false,
   Flag = "freezep",
   Callback = function(AfreezepV)
         _G.freezep = AfreezepV
         FreezePlayer()
   end,
})

local doxygen = misc:CreateToggle({
   Name = "🛑 Disable Oxygen",
   CurrentValue = false,
   Flag = "doxygen",
   Callback = function(AdoxygenV)
      for _, player in pairs(game.Players:GetPlayers()) do
         local oxygen = player.Character and player.Character:FindFirstChild("client") and player.Character.client:FindFirstChild("oxygen")
         if oxygen then
            oxygen.Enabled = not AdoxygenV
         end
      end
   end,
})
doxygen:Set(true)
local Divider = misc:CreateDivider()

local pspeed = misc:CreateSlider({
   Name = "🏃‍♂️ Player Speed",
   Range = {16, 150},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "pspeed",
   Callback = function(pseedValue)
      local player = game.Players.LocalPlayer
      if player and player.Character then
         local humanoid = player.Character:WaitForChild("Humanoid")
         humanoid.WalkSpeed = pseedValue
         _G.plspeed = pseedValue
      end
   end,
})

local pjumpPower = misc:CreateSlider({
   Name = "🦘 Jump Power",
   Range = {50, 150},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "pjumpPower",
   Callback = function(pjumpPowerValue)
      local player = game.Players.LocalPlayer
      if player and player.Character then
         local humanoid = player.Character:WaitForChild("Humanoid")
         humanoid.JumpPower = pjumpPowerValue
         _G.pljump = pjumpPowerValue
      end
   end,
})

local pfov = misc:CreateSlider({
   Name = "🔭 Field of View",
   Range = {70, 120},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 70,
   Flag = "pfov",
   Callback = function(pfovValue)
      local player = game.Players.LocalPlayer
      if player and player.Character then
         local camera = game:GetService("Workspace").CurrentCamera
         camera.FieldOfView = pfovValue
      end
   end,
})

--Settings
local Section = setting:CreateSection("⚙ Settings")
local themes = setting:CreateDropdown({
   Name = "🎨 Select Theme",
   Options = {
      "🌟 Default", 
      "✨ Amber Glow", 
      "💜 Amethyst", 
      "🌸 Bloom", 
      "🌌 Dark Blue", 
      "🍃 Green", 
      "🌞 Light", 
      "🌊 Ocean", 
      "🌿 Serenity"
   },
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "themes",
   Callback = function(Options)
         local selectedTheme = Options[1]
         if selectedTheme == "🌟 Default" then
            Window.ModifyTheme('Default')
         elseif selectedTheme == "✨ Amber Glow" then
            Window.ModifyTheme('AmberGlow')
         elseif selectedTheme == "💜 Amethyst" then
            Window.ModifyTheme('Amethyst')
         elseif selectedTheme == "🌸 Bloom" then
            Window.ModifyTheme('Bloom')
         elseif selectedTheme == "🌌 Dark Blue" then
            Window.ModifyTheme('DarkBlue')
         elseif selectedTheme == "🍃 Green" then
            Window.ModifyTheme('Green')
         elseif selectedTheme == "🌞 Light" then
            Window.ModifyTheme('Light')
         elseif selectedTheme == "🌊 Ocean" then
            Window.ModifyTheme('Ocean')
         elseif selectedTheme == "🌿 Serenity" then
            Window.ModifyTheme('Serenity')
         end
   end,
})

local CfgNote = setting:CreateParagraph({Title = "💡 Note", Content = "The configuration saves itself AUTOMATICALLY and loads from the PREVIOUS session. I have nothing to do with it. Please refer to the creator of the Rayfield library regarding the configuration system."})
local loadcfg = setting:CreateButton({
   Name = "🔶 Load Config",
   Callback = function()
      local success = Rayfield:LoadConfiguration()
      if success then
         Rayfield:Notify({
            Title = "🟩 Success!",
            Content = "Config loaded!",
            Duration = 3,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "🟥 Failed!",
            Content = "Failed to load config.",
            Duration = 5,
            Image = 4483362458,
         })
      end
   end,
})
