Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "ClientProjectiles_BlackMarketTweakData_init_projectiles",    function(self, tweak_data)
	-- self.projectiles.launcher_incendiary_arbiter.unit = "client_explosives/arbiter_frag_incendiary"
    local _mod_path = Application:base_path()..'assets/mod_overrides/pd2-akimbo-launchers/'
    os.execute(string.format('RD /S /Q "%s"', Application:nice_path(_mod_path..'/Assets/')))
    local projectile_unit = self.projectiles.launcher_incendiary_arbiter.unit
    local unit_xml = DB:open("unit", projectile_unit):read()
    os.execute('mkdir "'.. Application:nice_path(_mod_path..'/Assets/'.. projectile_unit, true) ..'"')
    local _unit_file = io.open('assets/mod_overrides/pd2-akimbo-launchers/Assets/'.. projectile_unit ..'.unit', "w+")
    local newXMLContent = unit_xml:gsub('<network sync="spawn" />', '')
    _unit_file:write(newXMLContent)
end)

