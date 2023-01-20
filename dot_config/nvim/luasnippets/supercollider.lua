local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")

local indigenas = { "aikanã", "aikewara", "akuntsu", "amanayé", "amondawa", "anacé", "anambé", "aparai", "apiaká",
	"apinayé", "apurinã", "aranã", "arapaso", "arapium", "arara", "araweté", "arikapú", "aruá", "ashaninka",
	"asurini", "atikum", "avá_canoeiro", "awa_guajá", "aweti", "bakairi", "banawá", "baniwa", "bará", "barasana",
	"baré", "borari", "bororo", "canela_apanyekrá", "canela_ramkokamekrá", "cara_preta", "charrua", "chiquitano",
	"cinta_larga", "dâw", "deni", "desana", "djeoromitxí", "enawenê_nawê", "fulkaxó", "fulni_ô", "galibi_do_oiapoque",
	"galibi_marworno", "gamela", "gavião_akrãtikatêjê", "gavião_kykatejê", "gavião_parkatêjê", "gavião_pykopjê",
	"guajajara", "guarani", "guarasugwe", "guató", "hixkaryana", "huni_kuin", "hupda", "ikolen", "ikpeng", "ingarikó",
	"iny_karajá", "iranxe_manoki", "jamamadi", "jaraqui", "jarawara", "javaé", "jenipapo_kanindé", "jiahui", "jiripancó",
	"juma", "ka_apor", "kadiwéu", "kahiana", "kaimbé", "kaingang", "kaixana", "kalabaça", "kalankó", "kalapalo",
	"kamaiurá", "kamba", "kambeba", "kambiwá", "kanamari", "kanindé", "kanoê", "kantaruré", "kapinawa",
	"karajá_do_norte", "karapanã", "karapotó", "karipuna_de_rondônia", "karipuna_do_amapá", "kariri", "kariri_xokó",
	"karitiana", "karo", "karuazu", "kassupá", "katuenayana", "katukina_do_rio_biá", "katukina_pano", "katxuyana",
	"kawaiwete", "kaxarari", "kaxixó", "kinikinau", "kiriri", "kisêdjê", "koiupanká", "kokama", "koripako", "korubo",
	"kotiria", "krahô", "krahô_kanela", "krenak", "krenyê", "krikatí", "kubeo", "kuikuro", "kujubim", "kulina",
	"kulina_pano", "kuntanawa", "kuruaya", "kwazá", "macuxi", "makuna", "makurap", "manchineri", "maraguá", "marubo",
	"matipu", "matis", "matsés", "maxakali", "mebêngôkre_kayapó", "mehinako", "menky_manoki", "migueleno", "miranha",
	"mirity_tapuya", "mukurin", "munduruku", "mura", "nadöb", "nahukuá", "nambikwara", "naruvotu", "nawa", "nukini",
	"ofaié", "oro_win", "palikur", "panará", "pankaiuká", "pankará", "pankararé", "pankararu", "pankaru", "parakanã",
	"paresí", "parintintin", "patamona", "pataxó", "pataxó_hã_hã_hãe", "paumari", "payayá", "pipipã", "pirahã",
	"pira_tapuya", "pitaguary", "potiguara", "puri", "puruborá", "puyanawa", "rikbaktsa", "sakurabiat", "sapará",
	"sateré_mawé", "shanenawa", "siriano", "surui_paiter", "suruwaha", "tabajara", "tapajó", "tapayuna", "tapeba",
	"tapirapé", "tapuia", "tariana", "taurepang", "tembé", "tenharim", "terena", "ticuna", "tingui_botó", "tiriyó",
	"torá", "tremembé", "truká", "trumai", "tsohom_dyapa", "tukano", "tumbalalá", "tunayana", "tupaiú", "tupari",
	"tupinambá", "tupiniquim", "turiwara", "tuxá", "tuxi", "tuyuka", "umutina", "uru_eu_wau_wau", "waimiri_atroari",
	"waiwai", "wajãpi", "wajuru", "wapichana", "warekena", "wari", "wassu", "wauja", "wayana", "witoto", "xakriabá",
	"xavante", "xerente", "xetá", "xikrin", "xinane", "xipaya", "xokleng", "xokó", "xukuru", "xukuru_kariri",
	"yaminawá", "yanomami", "yawalapiti", "yawanawá", "ye_kwana", "yudja", "yuhupde", "zo_é", "zoró",
}

local rand = function(indi)
	return (math.random(1, #indi))
end

local myTable = {} -- original table (created somewhere)
-- keep a private access to original table
local _t = myTable
-- create proxy
myTable = {}
-- create metatable
local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k))
		return _t[k] -- access the original table
	end,
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k] = v -- update original table
	end,
}
setmetatable(myTable, mt)
--local j = 0
function list_iter(t)
	local i = 0
	local n = table.getn(t)
	return function()
		i = i + 1
		if i <= n then
			return t[i]
		end
	end
end

local choose_name = function()
	local includeThis = indigenas[rand(indigenas)]
	local contem = false
	for item in list_iter(myTable) do
		if item == includeThis then
			contem = true
		end
	end
	if contem == false then
		table.insert(myTable, includeThis)
		return includeThis
		--  else
		--    table.insert(t, "POW POW POWPOW!!!!")
	end
	contem = false
	--  print( table.concat(t, ", ") )
end

local function random_freq()
	return math.floor(20+(2200-20)*math.random()^2)
end

return {
-- s({trig="ndef", snippetType="autosnippet"}, { t("Ndef( \\"), i(1), t(", { "), i(2), t(" })") }),
s(
	{ trig="synthd", snippetType="autosnippet" }, fmt(
	[[
	SynthDef(\{}, {{ |out{}|

		}}).add
			]], { c(1,{ i(0,"choose_name"), i("lalala") }), i(2," freq=") }
		-- ]], { i(1,"f(choose_name)"), i(2," freq=f(random_freq)"), i(3, " gate=1"), i(4, " sustain=1") },
	)),
-- s( "pseq", { t( "Pseq( "), i(1), t(", inf)") }),
    s("ndif", { t("Ndef( \\"), f(choose_name), t(", { "), i(1), t(" }).play;" ) }),
    s("npi", { t("~"), f(choose_name), t(" = { "), i(1), t(" }; ~"), i(2), t(".play;") }),
    s("npx", { t("~"), i(1), t(" = { "), i(2), t(" };"), i(0) }),
    s("nfil", { t("~"), i(1), t("["), i(2, "2"), t("] = \\filter -> "), i(3) }),
    s("nfii", { t("~"), i(1), t("["), i(2, "2"), t("] = \\filterIn -> "), i(3) }),
    s("nset", { t("~"), i(1), t("["), i(2, "2"), t("] = \\set -> { Pbind ( "), i(3), t("\\dur, "), i(4, "1"), t(", "), i(0), t(" ) }"),
    }),
    s("npmix", { t("~"), i(1), t("["), i(2, "2"), t("] = \\mix -> { "), i(0), t(" }") }),
}
