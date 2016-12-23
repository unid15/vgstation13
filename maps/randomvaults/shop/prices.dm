var/list/shop_prices = list( //Cost in space credits
//Misc objects
/obj/item/weapon/soap = 20,
/obj/item/weapon/phone = 30,
/obj/item/weapon/mop = 20,
/obj/item/weapon/lipstick/random = 30,
/obj/item/weapon/lazarus_injector = 500,
/obj/item/weapon/kitchen/rollingpin = 20,
/obj/item/weapon/hand_labeler = 10,
/obj/item/weapon/extinguisher = 20,
/obj/item/weapon/crowbar/red = 5,
/obj/item/weapon/bikehorn/rubberducky = 5,
/obj/item/weapon/bikehorn = 5,
/obj/item/weapon/lighter/zippo = 20,
/obj/item/weapon/screwdriver = 3,
/obj/item/weapon/wrench = 3,
/obj/item/queen_bee = 5,
/obj/item/toy/gooncode = 400, //honk
/obj/item/mounted/poster = 20,
/obj/item/candle = 5,


//tools
/obj/item/weapon/surgicaldrill = 100,
/obj/item/weapon/circular_saw = 100,
/obj/item/weapon/scalpel/laser/tier2 = 120,
/obj/item/weapon/scalpel = 70,
/obj/item/weapon/retractor = 30,
/obj/item/weapon/cautery = 30,
/obj/item/weapon/bonegel = 30,
/obj/item/weapon/FixOVein = 30,

/obj/item/weapon/switchtool/surgery = 250,
/obj/item/weapon/switchtool/swiss_army_knife = 500,
/obj/item/weapon/rcl = 100,
/obj/item/weapon/glue = 500,
/obj/item/weapon/chisel = 20,
/obj/item/weapon/scythe = 50,
/obj/item/bluespace_crystal/flawless = 10000,
/obj/item/bluespace_crystal/artificial = 1000,
/obj/item/bluespace_crystal = 750,
/obj/item/device/assembly_frame = 50,
/obj/item/device/camera = 30,
/obj/item/device/flash = 20,
/obj/item/device/robotanalyzer = 5,
/obj/item/device/soundsynth = 20,
/obj/item/device/transfer_valve = 500, //What could go wrong
/obj/item/device/maracas = 5,
/obj/item/device/aicard = 50,
/obj/item/device/soulstone = 400, //What could go wrong
/obj/item/device/taperecorder = 30,
/obj/item/device/rcd/tile_painter = 30,
/obj/item/device/rcd/matter/engineering = 30,
/obj/item/device/paicard = 10,
/obj/item/device/megaphone = 25,
/obj/item/device/hailer = 10,
/obj/item/broken_device = 1,
/obj/item/toy/balloon = 1,
/obj/item/toy/syndicateballoon = 700,
/obj/item/weapon/am_containment = 60,
/obj/item/weapon/cane = 5,
/obj/item/weapon/legcuffs/beartrap = 100,
/obj/item/weapon/rcd_ammo = 20,
/obj/item/weapon/storage/pneumatic = 40,
/obj/item/weapon/resonator = 100,
/obj/item/weapon/gun/energy/kinetic_accelerator = 80,
/obj/item/device/modkit/aeg_parts = 99,
/obj/item/device/modkit/gold_rig = 50,
/obj/item/device/modkit/storm_rig = 50,
/obj/item/clothing/accessory/medal/gold/captain = 1500,
/obj/item/device/radio/headset/headset_earmuffs = 125,
/obj/item/device/detective_scanner = 200,
/obj/item/device/mass_spectrometer/adv = 150,
/obj/item/device/mass_spectrometer = 100,
/obj/item/device/mining_scanner = 15,
/obj/item/device/mobcapsule = 200,
/obj/item/weapon/solder = 10,


//weapons
/obj/item/weapon/melee/classic_baton = 100,
/obj/item/weapon/melee/lance = 200,
/obj/item/weapon/melee/telebaton = 500,
/obj/item/weapon/claymore = 600,
/obj/item/weapon/fireaxe  = 200,
/obj/item/weapon/spear/wooden = 200,
/obj/item/weapon/spear = 30,
/obj/item/weapon/crossbow = 100,
/obj/item/weapon/hatchet = 20,
/obj/item/weapon/harpoon = 125,
/obj/item/weapon/boomerang/toy = 5,
/obj/item/weapon/boomerang = 30,
/obj/item/weapon/batteringram = 1000,
/obj/item/weapon/shield/riot = 250,

//No guns sorry
)

#define PRICE_CIRCUIT 100
#define PRICE_CIRCUIT_FLUCTUATION 50
#define forbidden_circuits (typesof(/obj/item/weapon/circuitboard/card/centcom))
var/list/circuitboard_prices = existing_typesof(/obj/item/weapon/circuitboard) - forbidden_circuits //All circuit boards can be bought in Costco
#undef forbidden_circuits

#define PRICE_CLOTHING 250
#define PRICE_CLOTHING_FLUCTUATION 200
#define forbidden_clothing (typesof(/obj/item/clothing/suit/space/ert) + typesof(/obj/item/clothing/head/helmet/space/ert) + list(/obj/item/clothing/suit/space/rig/elite, /obj/item/clothing/suit/space/rig/deathsquad, /obj/item/clothing/suit/space/rig/wizard, /obj/item/clothing/head/helmet/space/bomberman, /obj/item/clothing/suit/space/bomberman))
var/list/clothing_prices = existing_typesof(/obj/item/clothing) - forbidden_clothing //What in the world could go wrong
#undef forbidden_clothing
