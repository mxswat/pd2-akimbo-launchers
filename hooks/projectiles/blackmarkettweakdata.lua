-- Credits to DR NEWBIE
local mysplit = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "ClientProjectiles_BlackMarketTweakData_init_projectiles",    function(self, tweak_data)
	
    local _mod_path = Application:base_path()..'assets/mod_overrides/pd2-akimbo-launchers/'
    -- Clean the content of _mod_path..'/Assets/units'
    os.execute(string.format('RD /S /Q "%s"', Application:nice_path(_mod_path..'/Assets/units')))
    -- Get the current projectile to iterate
    local projectile_unit = self.projectiles.launcher_incendiary_arbiter.unit
    local unit_xml = DB:open("unit", projectile_unit):read()
    local _nus = mysplit(projectile_unit, "/") -- new unit string
    local _nu_last = _nus[#_nus] -- Get last from split
    _nus[#_nus] = nil -- Remove last item
    local _nu_path = string.join('/', _nus) -- Rejoin the string
    -- Use the NU_Unit path to create the appropriate folder
    os.execute('mkdir "'.. Application:nice_path(_mod_path..'/Assets/'.. _nu_path, true) ..'"')
    local _unit_file = io.open('assets/mod_overrides/pd2-akimbo-launchers/Assets/'.. projectile_unit ..'.unit', "w+")
    local newXMLContent = unit_xml:gsub('<network sync="spawn" />', '') -- Put the new xml content in the xml, but remove the sync
    _unit_file:write(newXMLContent)
    _unit_file:close()
end)

