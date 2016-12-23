/area/vault/market
	name = "star market"
	flags = NO_PORTALS

/area/vault/market/shop
	name = "shopping area"
	var/list/items = list()
	var/list/enemies = list()

/area/vault/market/entrance
	name = "market entrance"

/obj/docking_port/destination/vault/market
	areaname = "market"

/obj/item/weapon/disk/shuttle_coords/vault/market/New()
	.=..()

	pixel_x = rand(-8, 8) * PIXEL_MULTIPLIER
	pixel_y = rand(-8, 8) * PIXEL_MULTIPLIER

//Docking port for the salvage shuttle
/obj/docking_port/destination/vault/market/aft_port
	areaname = "aft port market entrance"

/obj/item/weapon/disk/shuttle_coords/vault/market/aft_port
	name = "shuttle destination disk (large shuttle)"
	destination = /obj/docking_port/destination/vault/market/aft_port
	header = "star market (aft port)"
	allowed_shuttles = list(/datum/shuttle/salvage)

//Docking ports for other shuttles
////==
/obj/docking_port/destination/vault/market/port
	areaname = "port market entrance"

/obj/item/weapon/disk/shuttle_coords/vault/market/port
	name = "shuttle destination disk (small shuttle 1)"
	destination = /obj/docking_port/destination/vault/market/port
	header = "star market (port)"
	allowed_shuttles = list(/datum/shuttle/mining, /datum/shuttle/research, /datum/shuttle/voxresearch, /datum/shuttle/trade)

////==

/obj/docking_port/destination/vault/market/starboard
	areaname = "starboard market entrance"

/obj/item/weapon/disk/shuttle_coords/vault/market/starboard
	name = "shuttle destination disk (small shuttle 2)"
	destination = /obj/docking_port/destination/vault/market/starboard
	header = "star market (starboard)"
	allowed_shuttles = list(/datum/shuttle/mining, /datum/shuttle/research, /datum/shuttle/voxresearch, /datum/shuttle/trade)

////==

/obj/docking_port/destination/vault/market/aft_starboard
	areaname = "aft starboard market entrance"

/obj/item/weapon/disk/shuttle_coords/vault/market/aft_starboard
	name = "shuttle destination disk (small shuttle 3)"
	destination = /obj/docking_port/destination/vault/market/aft_starboard
	header = "star market (aft starboard)"
	allowed_shuttles = list(/datum/shuttle/mining, /datum/shuttle/research, /datum/shuttle/voxresearch, /datum/shuttle/trade)

/area/vault/market/shop/proc/initialize()
	for(var/C in circuitboard_prices)
		circuitboard_prices[C] = PRICE_CIRCUIT + rand(-PRICE_CIRCUIT_FLUCTUATION, PRICE_CIRCUIT_FLUCTUATION)
	for(var/C in clothing_prices)
		clothing_prices[C] = PRICE_CLOTHING + rand(-PRICE_CLOTHING_FLUCTUATION, PRICE_CLOTHING_FLUCTUATION)

	spawn()
		var/area/vault/market/entrance/E = locate(/area/vault/market/entrance)
		var/list/protected_objects = list(
			/obj/structure/window, //Destroying these objects triggers an alarm
			/turf/simulated/wall,
			/obj/structure,
			/mob/living/simple_animal,
			/obj/machinery,
			)

		for(var/atom/movable/AM in (src.contents + E.contents))

			if(!is_type_in_list(AM, protected_objects)) continue

			if(AM.on_destroyed)
				AM.on_destroyed.Add(src, "item_destroyed")

/obj/item/weapon/paper/market_coords
	name = "paper - market location"

/obj/item/weapon/paper/market_coord/New()
	.=..()
	var/datum/map_element/market = locate(/datum/map_element/vault/market) in existing_vaults
	if(!market)
		return

	var/turf/T = market.location
	info = {"<i>So long, and thanks for the fish.</i>

	We will be stationed in the following location for at least 20 sol days.
	SECTOR: AD1
	COORDINATES: [T.x]-[T.y]-[T.z]"}

/area/vault/market/shop/Exited(atom/movable/AM, atom/newloc)
	..()

	if(istype(AM, /mob/dead))
		return
	if(get_area(newloc) == src)
		return

	if(items.Find(AM))
		return on_theft()
	else
		var/list/AM_contents = get_contents_in_object(AM, /obj/item)

		for(var/obj/item/I in AM_contents)
			if(items.Find(I))
				return on_theft()
		for(var/mob/living/L in AM_contents + AM)
			if(isanimal(L))
				continue
			enemies.Add(L)


/area/vault/market/shop/proc/purchased(obj/item/I)
	items.Remove(I)
	I.name = initial(I.name)

/area/vault/market/shop/proc/item_destroyed()
	for(var/obj/item/I in items)
		if(isnull(I.loc) || I.gcDestroyed)
			items.Remove(I)

	on_theft()

/area/vault/market/shop/proc/on_theft()

///////SPAWNERS
/obj/map/spawner/supermarket
	name = "Costco spawner"
	amount = 4
	chance = 50
	jiggle = 10

/obj/map/spawner/supermarket/create_item(new_item_type)
	var/obj/item/I = ..()

	spawn()
		if(to_spawn[new_item_type])
			var/area/vault/market/shop/S = locate(/area/vault/market/shop)
			var/price = to_spawn[new_item_type]

			I.name = "[I.name] ($[price])"
			I.on_destroyed.Add(S, "item_destroyed") //Only trigger alarm when an item for sale is destroyed

			S.items[I] = price

	return I

/obj/map/spawner/supermarket/tools
	icon_state = "ass_tools"
	amount = 4
	chance = 50
	jiggle = 10

/obj/map/spawner/supermarket/tools/New()
	to_spawn = shop_prices
	return ..()

/obj/map/spawner/supermarket/circuits/New()
	to_spawn = circuitboard_prices
	return ..()

/obj/map/spawner/supermarket/clothing
	amount = 6

/obj/map/spawner/supermarket/clothing/New()
	to_spawn = clothing_prices
	return ..()



/mob/living/simple_animal/robot_cashier
	name = "cashier robot"
	desc = "Only accepts cash."

	icon = 'icons/mob/mob.dmi'
	icon_state = "s-ninjaf"

	anchored = 1
	canmove = 0
	intent = I_HURT

	faction = "costco"

	var/loaded_cash = 0
	var/help_cd = 0

/mob/living/simple_animal/robot_cashier/Die()
	var/area/vault/market/shop/A = get_area(src)
	if(istype(A))
		A.on_theft()

	return ..()

/mob/living/simple_animal/robot_cashier/attack_hand(mob/user)
	if(user.a_intent == I_HELP)
		if(world.time < help_cd + 0.5 SECONDS)
			return

		spawn(3)
			help_cd = world.time
			var/area/vault/market/shop/shop = get_area(src)
			if(!istype(shop))
				say("Unable to connect to NeoVatt server. I am useless.")
				return

			var/turf/input_loc = get_step(get_turf(src), dir)
			var/list/found_items = list()
			var/price = 0

			for(var/obj/item/I in input_loc)
				if(shop.items.Find(I))
					found_items.Add(I)
					price += shop.items[I]

			if(found_items.len > 0)
				if(price > 0)
					if(loaded_cash == 0)
						say("[found_items.len] items for $[price]. Current credit: $0. Please insert additional money into the cash slot.")
						visible_message("<span class='info'>\The [src]'s cash slot flashes.</span>")
					else if(loaded_cash < price)
						say("[found_items.len] items for $[price]. Current credit: [loaded_cash] credits. Insert [price-loaded_cash] more credits to continue.")
						visible_message("<span class='info'>\The [src]'s cash slot flashes.</span>")
					else
						say("[found_items.len] items for $[price]. Change: $[loaded_cash - price] space credits. Have a nice day.")
						for(var/obj/item/I in found_items)
							shop.purchased(I)

						loaded_cash -= price

						if(loaded_cash > 0)
							dispense_cash(loaded_cash - price, input_loc)
							loaded_cash = 0
				else
					say("[found_items.len] items, free of charge. Have a nice day.")
					for(var/obj/item/I in found_items)
						shop.purchased(I)
			else
				if(loaded_cash > 0)
					say("Current credit: $[loaded_cash]. Ejecting...")
					dispense_cash(loaded_cash, input_loc)
					loaded_cash = 0
				else
					say("Please place all items that you wish to purchase on the table in front of me, and activate me again.")

/mob/living/simple_animal/robot_cashier/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/S = I
		var/money_add = S.amount * S.worth

		if(user.drop_item(I))
			qdel(I)

			src.loaded_cash += money_add
			to_chat(user, "<span class='info'>You insert [money_add] space credits into \the [src]. \The [src] now holds [loaded_cash] space credits.</span>")
	else
		return ..()
