//Object and area definitions go here
/area/vault //Please make all areas used in vaults a subtype of this!
	name = "mysterious structure"
	requires_power = 0
	icon_state = "firingrange"
	dynamic_lighting = 1

/area/vault/holomapAlwaysDraw()
	return 0

/area/vault/icetruck

/area/vault/asteroid

/area/vault/tommyboyasteroid
	requires_power = 1

/area/vault/satelite

/area/vault/factory

/area/vault/clownbase

/area/vault/gym

/area/vault/oldarmory

/area/vault/rust
	requires_power = 1

/area/vault/dancedance

/area/vault/dancedance/loot
	jammed = 2

/area/vault/spacepond

/area/vault/spacepond/wine_cellar

/area/vault/ioufort

/area/vault/hive_shuttle

//prison vault

/area/vault/prison_ship
	requires_power = 1

/area/vault/prison

/obj/item/weapon/disk/shuttle_coords/vault/prison
	destination = /obj/docking_port/destination/vault/prison

/obj/docking_port/destination/vault/prison
	areaname = "holding facility 10"

//listening outpost

/area/vault/listening
	requires_power = 1

/obj/item/weapon/disk/shuttle_coords/vault/listening
	destination = /obj/docking_port/destination/vault/listening

/obj/docking_port/destination/vault/listening
	areaname = "outpost V-24"
/area/vault/biodome
	requires_power = 1

//biodome

/obj/item/weapon/disk/shuttle_coords/vault/biodome
	destination = /obj/docking_port/destination/vault/biodome

/obj/docking_port/destination/vault/biodome
	areaname = "biodome"

/area/vault/brokeufo
	requires_power = 1

/area/vault/AIsat
	requires_power = 1

/area/vault/ejectedengine
	requires_power = 1

/area/vault/ejectedengine/SMES
	name = "\improper Engine SMES"
	icon_state = "engine_smes"

/area/vault/ejectedengine/generator
	name = "\improper Generator Room"
	icon_state = "thermo_engine"

/area/vault/ejectedengine/gasstorage
	name = "\improper Engine Gas Storage"
	icon_state = "engine_storage"

/area/vault/ejectedengine/monitering
	name = "Engine Monitering"
	icon_state = "engiaux"

/area/vault/ejectedengine/burnroom
	name = "\improper Engine Hallway"
	icon_state = "engine"

/area/vault/droneship
	name = "\improper Drone Ship"
	requires_power = 1
	jammed = 2
	var/pod_code = "00000"

/area/vault/droneship/New()
	..()
	pod_code = "[rand(10000, 99999.0)]"

/obj/machinery/door/poddoor/droneship
	name = "\improper OSIPR Pod-Door"
	id_tag = "denied"

/obj/machinery/door/poddoor/droneship/New()
	..()
	var/area/A = get_area(src)
	if(A && istype(A,/area/vault/droneship))
		var/area/vault/droneship/DS = A
		id_tag = DS.pod_code

/obj/item/weapon/p_folded/ball/droneship
	name = "crushed ball of paper"

/obj/item/weapon/p_folded/ball/droneship/New()
	..()
	qdel(unfolded)
	unfolded = new /obj/item/weapon/paper/crumpled/droneship(src)

/obj/item/weapon/paper/crumpled/droneship
	name = "paper- 'OSIPR Pod-Door ID'"
	info = "denied"

/obj/item/weapon/paper/crumpled/droneship/New()
	var/area/A = get_area(src)
	if(A && istype(A,/area/vault/droneship))
		var/area/vault/droneship/DS = A
		info = "[DS.pod_code]"

/mob/living/simple_animal/hostile/monster/cyber_horror/quiet
	speak_chance = 1 //shut the fuck up

/obj/item/weapon/bananapeel/traitorpeel/curse
	name = "cursed banana peel"
	desc = "A peel from a banana, surrounded by an evil aura of trickery and mischief. "

	anchored = 1
	cant_drop = 1

	slip_power = 10

/obj/item/weapon/melee/morningstar/catechizer
	name = "The Catechizer"
	desc = "An unholy weapon forged eons ago by a servant of Nar-Sie."

	force = 37
	throwforce = 30
	throw_speed = 3
	throw_range = 5

/obj/effect/landmark/catechizer_spawn //Multiple of these are put in a single area. One of these landmark will contain a true catachizer, others only mimics
	name = "catechizer spawn"

/obj/effect/landmark/catechizer_spawn/New()
	spawn()
		if(!isturf(loc))
			return

		var/list/all_spawns = list()
		for(var/obj/effect/landmark/catechizer_spawn/S in get_area(src))
			all_spawns.Add(S)

		var/obj/effect/true_spawn = pick(all_spawns)
		all_spawns.Remove(true_spawn)

		var/obj/item/weapon/melee/morningstar/catechizer/original = new(get_turf(true_spawn))

		for(var/obj/effect/S in all_spawns)
			new /mob/living/simple_animal/hostile/mimic/crate/item(get_turf(S), original) //Make copies
			qdel(S)

		qdel(src)

/obj/machinery/door/poddoor/vault_rust
	id_tag = "tokamak_yadro_ventilyatsionnyy" // Russian for "tokamak_core_vent"

/obj/machinery/door_control/vault_rust
	name   = "tokamak yadro ventilyatsionnyy"
	id_tag = "tokamak_yadro_ventilyatsionnyy"

/obj/item/weapon/fuel_assembly/trilithium
	name = "trilithium fuel rod assembly"

/obj/item/weapon/fuel_assembly/trilithium/New()
	. = ..()
	rod_quantities["Trilithium"] = 300

/obj/machinery/power/apc/frame/rust_vault
	make_alerts = FALSE

/obj/machinery/power/apc/frame/rust_vault/initialize()
	. = ..()
	name = "regulyator moshchnosti oblast'"

/obj/machinery/power/generator/rust_vault
	name = "termoelektricheskiy generator metki dva"

	thermal_efficiency = 0.90

/obj/machinery/power/battery_port/rust_vault
	name = "raz\"yem pitaniya"

/obj/machinery/power/rust_core/rust_vault
	name = "\improper Razmnozitel' Ustojcivogo Sostojanija Termojadernyj versija sem' tokamak yadro"

/obj/machinery/vending/engineering/rust_vault
	name = "\improper Robco instrumental'shchik"

/obj/item/device/rcd/rpd/rust_vault
	name = "\improper Bystroye Ustroystvo Truboprovodov (BUT)"

/obj/item/device/rcd/matter/engineering/rust_vault
	name = "\improper Bystroye Stroitel'stvo Ustroystv (BSU)"

/obj/item/weapon/paper/tommyboy
	name = "failed message transcript"
	info = {"This is Major Tom to Ground Control<br>
			I'm stepping through the door<br>
			And I'm floating in the most peculiar way<br>
			And the stars look very different today<br>
			For here am I sitting in my tin can<br>
			Far above the world<br>
			Planet Earth is blue<br>
			And there's nothing I can do.
			"}

/obj/machinery/atmospherics/binary/msgs/rust_vault
	name = "\improper Magnitno Priostanovleno Blok Khraneniya Gaza"

/obj/item/weapon/paper/iou
	name = "paper- 'IOU'"
	info = "I owe you a rod of destruction. Redeemable at Milliway's at the end of time."

/obj/item/weapon/paper/vault/vr_logs
	name = "paper - system logs"
	info = {"
	5.15.12.1113: loaded configuration: C_TRAVEL.a
	5.15.12.1114: virtual environment set up
	5.15.12.1114: starting a system check
	5.15.12.1114: system check performed successfully (0 warnings)
	5.15.12.1116: neural link established
	5.15.12.1116: neural link established
	5.15.12.1116: neural link established
	5.15.12.1116: neural link established
	5.15.12.1116: neural link established
	5.15.12.1117: neural link established
	5.15.12.1205: brain scan of 6 occupants finished successfully
	5.15.12.1220: simulation loaded (E1LA2001)
	5.15.12.1220: full transfer of 6 occupants to VLR mode completed (hybernation enabled, time dilation 1:1)
	5.16.2.7500: power to primary systems lost. diverting backup power to life support machinery
	5.16.2.7502: power to primary systems restored. resetting virtual environment and performing a check-up...
	5.16.2.7503: WARNING: configuration settings corrupted and no backup found. Loading default configuration...
	5.16.2.7503: loaded configuration: C_DEFAULT.a
	5.16.2.7504: virtual environment set up
	5.16.2.7504:  starting a system check
	5.16.2.7504: system check performed successfully (1 warning)
	5.16.2.7506: simulation loaded (EMPTY)
	5.16.2.7506: full transfer of 6 occupants to VLR mode completed (hybernation enabled, time dilation 1:1800000)
	9.1.1.1: system check performed successfully (0 warnings)
	13.1.1.1: system check performed successfully (0 warnings)
	13.11.5.12: occupants have been inactive for too long (5.666667e6 sol years). scheduling medical check-up...
	13.11.5.121: physical condition of occupants: 6 alive
	"}

/obj/machinery/computer/fluff/virtual_reality
	name = "VLR interface console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "ai-fixer"

	light_color = LIGHT_COLOR_PINK

	var/paper_left = 10
	var/turf/camera = null

/obj/machinery/computer/fluff/virtual_reality/attack_hand(mob/user)
	if(issilicon(user))
		to_chat(user, "<span class='notice'>You are unable to interact with this old-fashioned computer.</span>")
		return

	var/choice = alert(user, "There is only one unlocked button on this computer.", "[src]", "Print logs", "Cancel")
	switch(choice)
		if("Print logs")
			if(paper_left > 0)
				new /obj/item/weapon/paper/vault/vr_logs
				paper_left--
			else
				to_chat(user, "<span class='info'>Out of paper.</span>")
				return

/obj/machinery/computer/security/telescreen/entertainment/vr
	name = "virtual reality monitor"
	desc = "A small screen that shows the current state of the virtual world and its inhabitants."
	network = list("VR")

/obj/machinery/telecomms/relay/preset/vault_listening
	id = "syndicate relay"
	hide = 1
	toggled = 0
	autolinkers = list("hub")

/obj/machinery/power/apc/no_alerts/vault_listening/initialize()
	. = ..()
	name = "\improper Listening Outpost APC"

/obj/machinery/power/battery/smes/vault_listening
	chargelevel = 30000
	chargemode  = TRUE

/obj/machinery/power/solar/control/vault_listening
	track = 2 // Automatic

/obj/machinery/floodlight/on/New()
	..()
	on = 1
	set_light(brightness_on)
	update_icon()

/obj/machinery/floodlight/on/infinite
	cell = /obj/item/weapon/cell/infinite

/obj/machinery/bot/farmbot/duey
	name = "Duey"
	desc = "Looks like a maintenance droid, repurposed for botany management. Seems the years haven't been too kind."
	health = 150
	maxhealth = 150
	icon_state = "duey0"
	icon_initial = "duey"
	Max_Fertilizers = 50

/obj/structure/ladder/spacepond/ground
	name = "wine cellar"
	id = "spacepond"
	height = 1

/obj/structure/ladder/spacepond/winecellar
	name = "space cabin"
	id = "spacepond"
	height = 0

/mob/living/silicon/decoy/AIvault/New()
	name = pick(ai_names)
	icon_state = "ai-malf"
	..()

/obj/machinery/power/apc/no_alerts/vault_AIsat/initialize()
	. = ..()
	name = "\improper AI Satellite APC"

/obj/machinery/porta_turret/AIvault
	req_access = list(access_ai_upload)
	check_records = 1
	criminals = 1
	auth_weapons = 1
	stun_all = 1
	check_anomalies = 1
	ai = 1

/obj/machinery/porta_turret/AIvault/New()
	installed = new/obj/item/weapon/gun/energy/laser/retro/ancient(src)
	..()
	if(prob(25))
		dir = pick(alldirs)
		die()

/obj/item/weapon/gun/energy/laser/retro/ancient
	name = "ancient laser gun"
	desc = "Once a highly dangerous weapon, this laser has degraded over decades into a still somewhat dangerous weapon."
	projectile_type = /obj/item/projectile/beam/retro/weak

/obj/item/projectile/beam/retro/weak
	damage = 15
	linear_movement = 0

/turf/simulated/floor/engine/old
	icon_state = "engineold"

/obj/machinery/camera/noview/New()
	..()
	network = list()
	cameranet.removeCamera(src)

/obj/machinery/power/monitor/old
	icon_state = "powerold"
	light_color = LIGHT_COLOR_BLUE

/obj/effect/landmark/corpse/engineer/old
	generate_random_mob_name = 1
	mutantrace = "Skellington"
	corpseradio = /obj/item/device/radio/headset
	corpseback = /obj/item/weapon/storage/backpack
	corpsebelt = null

/obj/machinery/light/burnt/New()
	status = LIGHT_BURNED
	update(0)
	..()

/obj/structure/closet/welded/New()
	..()
	welded = 1
	update_icon()

/obj/machinery/portable_atmospherics/canister/old
	filled = 0.8
	volume = 50000

/obj/machinery/portable_atmospherics/canister/old/pressure_overlays(var/state)
	var/static/list/status_overlays_pressure = list(
		image(icon, "old-o0"),
		image(icon, "old-o1"),
		image(icon, "old-o2"),
		image(icon, "old-o3")
	)

	return status_overlays_pressure[state]

/obj/machinery/portable_atmospherics/canister/old/other_overlays(var/state)
	var/static/list/status_overlays_other = list(
		image(icon, "old-open"),
		image(icon, "old-connector")
	)

	return status_overlays_other[state]

/obj/machinery/portable_atmospherics/canister/old/process()
	..()
	can_label = 0

/obj/machinery/portable_atmospherics/canister/old/attack_ai()
	return

/obj/machinery/portable_atmospherics/canister/old/plasma
	name = "Canister: \[Toxins\]"
	icon_state = "orangeold"
	canister_color = "orangeold"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/old/plasma/New(loc)
	..(loc)
	air_contents.adjust(tx = (maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	update_icon()

/obj/machinery/portable_atmospherics/canister/old/oxygen
	name = "Canister: \[Oxygen\]"
	icon_state = "blueold"
	canister_color = "blueold"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/old/oxygen/New(loc)
	..(loc)
	air_contents.adjust((maximum_pressure * filled) * air_contents.volume / (R_IDEAL_GAS_EQUATION * air_contents.temperature))
	update_icon()

/mob/living/simple_animal/hostile/retaliate/malf_drone/vault
	environment_smash = 1
	speak_chance = 1

/obj/machinery/atmospherics/unary/vent/visible
	level = LEVEL_ABOVE_FLOOR

/obj/machinery/computer/ejectedengine/engine
	name = "Engine Ejection Console"
	desc = "Allows access to the engine ejection system."
	icon_state = "engine1"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/ejectedengine/engine/attack_hand(var/mob/user as mob)
	if(..())
		return

	var/dat = text("<B>Engine Ejection Module</B><HR>\nStatus: Ejected<BR>\n<BR>\nCountdown: N/60 \[Reset\]<BR>\n<BR>\nEngine Ejected!<BR>\n<BR>\n<A href='?src=\ref[];mach_close=computer'>Close</A>", user)
	user << browse(dat, "window=computer;size=400x500")

/obj/machinery/computer/ejectedengine/shield
	name = "Shield Control Console"
	desc = "Controls the station's external shielding."
	icon_state = "escape"
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/ejectedengine/shield/attack_hand(var/mob/user as mob)
	if(..())
		return

	var/dat = text("<B>Shield Generator Control</B><HR>\n<font color=red>Error:</font> Cannot locate projector array<BR>\n<font color=red>Error:</font> Cannot locate shield capacitors<BR>\n<font color=red>Error:</font> Cannot locate command signal<BR>\n<BR>\n<A href='?src=\ref[];mach_close=computer'>Close</A>", user)
	user << browse(dat, "window=computer;size=400x500")

/obj/machinery/door/firedoor/red
	name = "\improper Firelock"
	desc = "Emergency air-tight shutter, for keeping fires contained."
	icon = 'icons/obj/doors/Doorfire.dmi'
