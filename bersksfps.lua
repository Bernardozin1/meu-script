-- ================= BERSKS DEVOURER =================
task.spawn(function()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- CONFIG
    local toolNames = {"Bat","Medusa's Head","Grapple Hook"}
    local cooldown = 0.08
    local ativo = false

    -- GUI principal
    local gui = Instance.new("ScreenGui")
    gui.Parent = playerGui
    gui.ResetOnSpawn = false

    local hud = Instance.new("Frame", gui)
    hud.Size = UDim2.new(0,160,0,60)
    hud.Position = UDim2.new(1,-170,0,10)
    hud.BackgroundColor3 = Color3.fromRGB(30,30,30)
    hud.Active = true
    Instance.new("UICorner", hud).CornerRadius = UDim.new(0,8)

    local title = Instance.new("TextLabel", hud)
    title.Size = UDim2.new(1,0,0,20)
    title.Position = UDim2.new(0,0,0,5)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "BERSKS DEVOURER"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextScaled = true

    local button = Instance.new("TextButton", hud)
    button.Size = UDim2.new(1,-16,0,24)
    button.Position = UDim2.new(0,8,0,30)
    button.BackgroundColor3 = Color3.fromRGB(50,50,50)
    button.Font = Enum.Font.GothamBold
    button.Text = "Bersks Devourer"
    button.TextColor3 = Color3.fromRGB(230,230,230)
    button.TextScaled = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0,6)

    -- Toggle
    button.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            print(">>> BERSKS DEVOURER ATIVADO <<<")
        else
            print(">>> BERSKS DEVOURER DESATIVADO <<<")
        end
    end)

    -- Loop spam
    task.spawn(function()
        local index = 1
        while true do
            if ativo then
                local c = player.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                local toolName = toolNames[index]
                local tool = (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild(toolName)) or (c and c:FindFirstChild(toolName))
                if h and tool then
                    pcall(function() h:EquipTool(tool) end)
                    task.wait(cooldown)
                    pcall(function() h:UnequipTools() end)
                end
                index = index % #toolNames + 1
            end
            task.wait(cooldown)
        end
    end)

    -- Arrastável (PC + Touch)
    local dragging, dragInput, dragStart, startPos
    hud.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = hud.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    hud.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            hud.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)
