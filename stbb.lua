-- v085 汉化无后门完整版 | 至尊版整合
-- 主框架：v085 基线 | 扩展：多语言、调度器、熟练度、碰撞箱、任务、额外、圣诞、视觉
local version = "Rework"
local ver = "v023.4-至尊版"

-- ====================== LOAD UI ======================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ====================== GameLoad ======================
repeat task.wait() until game:IsLoaded()

-- ====================== LoadingGui ======================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local pg = LocalPlayer:WaitForChild("PlayerGui")

local function waitLoadingGone()
    local gui = pg:FindFirstChild("LoadingGui")
    if gui then
        WindUI:Notify({ Title = "初始化", Content = "游戏加载中，请稍候...", Duration = 3, Icon = "download" })
        gui.AncestryChanged:Wait()
    end
end

waitLoadingGone()

WindUI:Notify({ Title = "初始化", Content = "加载完成，3秒后启动", Duration = 3, Icon = "shield-check" })
task.wait(3)

-- ====================== FPS UNLOCK ======================
local part = Instance.new("Part")
part.Size = Vector3.new(10, 1, 10)
part.Position = Vector3.new(-23.3435822, 61, 0.341766357)
part.Transparency = 1
part.Anchored = true
part.CanCollide = true
part.Material = Enum.Material.Neon
part.BrickColor = BrickColor.new("Bright blue")
part.Name = "DYHUB_WAITING_PART"
part.Parent = workspace

if setfpscap then
    setfpscap(1000000)
    WindUI:Notify({ Title = "服务", Content = "FPS 已解锁 | " .. ver, Duration = 3, Icon = "cpu" })
    warn("FPS Unlocked!")
else
    WindUI:Notify({ Title = "不支持", Content = "您的执行器不支持 setfpscap.", Duration = 3, Icon = "ban" })
end

-- ====================== CUSTOM CONFIG SYSTEM ======================
local HttpService = game:GetService("HttpService")
local ConfigFolder = "DYHUB_STBB_V0234"

local CustomConfig = {}
CustomConfig.__index = CustomConfig

function CustomConfig.new()
    local self = setmetatable({}, CustomConfig)
    self.ConfigData = {}
    self.ConfigPath = ConfigFolder .. "/config.json"
    if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
    self:Load()
    return self
end

function CustomConfig:Set(key, value) self.ConfigData[key] = value end

function CustomConfig:Get(key, default)
    if self.ConfigData[key] ~= nil then return self.ConfigData[key] end
    return default
end

function CustomConfig:Save()
    local success, err = pcall(function()
        writefile(self.ConfigPath, HttpService:JSONEncode(self.ConfigData))
    end)
    if success then warn("[DYHUB] Config saved!") else warn("[DYHUB] Save failed:", err) end
end

function CustomConfig:Load()
    if isfile(self.ConfigPath) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(self.ConfigPath))
        end)
        if success and type(result) == "table" then
            self.ConfigData = result
            print("[DYHUB] Config loaded!")
        else
            warn("[DYHUB] Failed to load config, using defaults")
            self.ConfigData = {}
        end
    else
        print("[DYHUB] No config found, creating new one")
        self.ConfigData = {}
    end
end

function CustomConfig:AutoSave(interval)
    task.spawn(function()
        while true do
            task.wait(interval or 15)
            self:Save()
        end
    end)
end

local Config = CustomConfig.new()
Config:AutoSave(15)

-- ====================== 多语言系统 ======================
local translations = {
    Chinese = {
        loading = "游戏加载中...", loaded = "加载完成，3秒后启动",
        auto_farm = "自动挂机", auto_farm_desc = "根据优先级自动刷怪",
        farm_enabled = "已开启", farm_disabled = "已关闭",
        sync_mode = "同步挂机模式", sync_desc = "辅助功能需自动挂机开启",
        sync_on = "需自动挂机", sync_off = "辅助功能独立",
        position_above = "上方", position_under = "下方",
        auto_attack = "自动攻击", auto_skill = "自动技能",
        auto_ready = "自动开局", auto_skip_heli = "自动跳过直升机",
        auto_heal = "自动补血", safe_mode = "安全模式",
        god_mode = "上帝模式", delete_map = "删除地图",
        flush_aura = "冲水光环", flush_range = "冲水范围",
        attack_speed = "攻击速度", skill_delay = "技能延迟",
        height_offset = "挂机高度偏移", safe_hp = "安全模式血量",
        god_hp = "上帝模式血量", high_hp_threshold = "高血量阈值",
        esp_enable = "启用透视", esp_mob = "怪物透视",
        esp_player = "玩家透视", esp_item = "物品透视",
        esp_highlight = "高亮", esp_distance = "距离",
        esp_health = "血量", esp_name = "名称",
        farm_settings = "挂机设置", general_settings = "通用设置",
        priority_settings = "优先级设置", override_settings = "覆写设置",
        flush_settings = "冲水设置", risky_features = "高风险功能（无检测）",
        esp_visual = "透视视觉", esp_settings = "透视设置",
        local_player = "本地玩家", redeem_codes = "兑换码",
        unlock_gamepass = "解锁游戏通行证", shop_weapon = "商店武器",
        shop_misc = "商店道具", batch_section = "无延迟批量购买",
        batch_gacha_section = "无延迟批量抽卡", collect_section = "物品收集",
        collect_settings = "收集设置", vote_system = "投票系统",
        mode_switch = "模式切换", astro_params = "天文币刷取参数",
        auto_game_mode = "自动游戏模式（大厅）", extra_auto = "自动化额外",
        visual_section = "视觉效果", server_status = "服务器状态",
        others = "其他", save_settings = "保存配置",
        mastery_title = "熟练度自动刷", mastery_no_flush = "无冲水",
        mastery_flush = "冲水模式", hitbox_title = "碰撞箱",
        hitbox_scan = "扫描", hitbox_size = "大小",
        hitbox_enable = "启用", hitbox_show = "显示",
        quest_title = "任务辅助", quest_open_clock = "打开时钟人菜单",
        quest_open_quest = "打开任务菜单", quest_auto_collect = "自动收集任务物品",
        quest_auto_skip = "自动跳过任务", auto_rebirth = "自动重生",
        auto_daily = "自动每日奖励", auto_chest = "自动开宝箱",
        motion_prediction = "运动预测", motion_prediction_desc = "预判怪物位置（高危）",
        follow_mode = "跟随模式", follow_mode_desc = "每帧黏住怪物（极高危）",
        auto_god_mode = "自动无敌重生", auto_god_mode_desc = "血量低于阈值自动重生",
        god_respawn_threshold = "重生触发血量", xmas_title = "Xmas极速系统",
        xmas_open = "自动开礼物（极速）", xmas_collect = "自动收集The Present（极速）",
        xmas_open_now = "立即开100个礼物", batch_buy = "无延迟批量购买",
        batch_buy_desc = "超快速度购买商店物品", batch_gacha_char = "批量抽角色",
        batch_gacha_skin = "批量抽皮肤", rotate_90 = "旋转90°模式",
        rotate_90_desc = "站立时旋转90度", fullbright = "全亮",
        nofog = "去雾", vibrant = "鲜艳色彩",
        show_fps = "显示FPS", show_ping = "显示Ping",
        fly = "飞行", infinity_jump = "无限跳跃",
        no_clip = "穿墙", server_hop = "更换服务器",
        rejoin = "重新加入", save_config = "保存配置",
        anti_afk = "防挂机检测", bypass_barrier = "绕过边界",
        fps_boost = "FPS极限优化", theme = "主题",
        language = "语言", auto_collect = "自动收集",
        collect_clean = "清理模式", collect_idgf = "即时模式",
        move_mode = "移动模式", stand_pos = "站位位置",
        aux_func = "辅助功能", skill_keys = "自动技能按键",
        weapon_select = "选择武器", auto_buy_weapon = "自动购买武器",
        buy_weapon_once = "购买武器（一次）", misc_select = "选择道具",
        auto_buy_misc = "自动购买道具", buy_misc_once = "购买道具（一次）",
        redeem_selected = "兑换选中码", redeem_all = "兑换所有码",
        unlock_selected = "解锁选中通行证", restore_vote = "恢复投票系统",
        set_vote_mode = "设置投票模式", auto_vote_ig = "自动投票（局内）",
        switch_farm = "▶ 自动挂机模式", switch_astro = "✈ 天文币刷取模式",
        astro_duration = "游戏持续时间（秒）", astro_radius = "飞行半径",
        astro_speed = "飞行速度", select_game_mode = "选择游戏模式",
        auto_game_mode_toggle = "自动游戏模式（大厅）", show_cpu_ping = "显示CPU/Ping",
        auto_reconnect = "断线自动重连", save_now = "立即保存配置",
        auto_save_config = "自动保存配置", save_interval = "保存间隔（秒）",
        reset_override = "重置所有已确认位置", padding_reduce = "设置覆写递减步长",
        padding_safe = "设置最小安全高度", anti_clip_margin = "防卡墙边距",
        dmg_threshold = "伤害阈值", mastery_move_mode = "移动模式",
        mastery_char_type = "角色类型", mastery_distance = "与NPC距离",
        batch_items = "批量购买物品", batch_amount = "批量购买数量",
        batch_char_spins = "选择抽卡类型（角色）", batch_skin_spins = "选择抽卡类型（皮肤）",
        item_notify = "物品通知", collect_mode = "收集模式",
        walk_speed = "移动速度", jump_power = "跳跃高度",
        fly_speed_label = "飞行速度", priority_order = "优先级顺序",
        priority_desc = "GiantST → 直升机 → 高血量精英 → 最近怪物",
        info_update = "更新: 全功能整合", info_desc = "- 无后门 | 多语言 | 所有功能已补全",
        info_clean = "纯净版", info_clean_desc = "无后门 | 中文界面 | 全功能整合",
    },
    English = {
        loading = "Loading game...", loaded = "Loaded, starting in 3s",
        auto_farm = "Auto Farm", auto_farm_desc = "Priority-based auto farm",
        farm_enabled = "Enabled", farm_disabled = "Disabled",
        sync_mode = "Sync Farm Mode", sync_desc = "Aux functions need auto farm",
        sync_on = "Need auto farm", sync_off = "Aux functions independent",
        position_above = "Above", position_under = "Under",
        auto_attack = "Auto Attack", auto_skill = "Auto Skill",
        auto_ready = "Auto Start", auto_skip_heli = "Auto Skip Heli",
        auto_heal = "Auto Heal", safe_mode = "Safe Mode",
        god_mode = "God Mode", delete_map = "Delete Map",
        flush_aura = "Flush Aura", flush_range = "Flush Range",
        attack_speed = "Attack Speed", skill_delay = "Skill Delay",
        height_offset = "Height Offset", safe_hp = "Safe HP",
        god_hp = "God HP", high_hp_threshold = "High HP Threshold",
        esp_enable = "Enable ESP", esp_mob = "Mob ESP",
        esp_player = "Player ESP", esp_item = "Item ESP",
        esp_highlight = "Highlight", esp_distance = "Distance",
        esp_health = "Health", esp_name = "Name",
        farm_settings = "Farm Settings", general_settings = "General Settings",
        priority_settings = "Priority Settings", override_settings = "Override Settings",
        flush_settings = "Flush Settings", risky_features = "Risky Features (No Detection)",
        esp_visual = "ESP Visual", esp_settings = "ESP Settings",
        local_player = "Local Player", redeem_codes = "Redeem Codes",
        unlock_gamepass = "Unlock Gamepass", shop_weapon = "Shop Weapon",
        shop_misc = "Shop Misc", batch_section = "Batch Buy (No Delay)",
        batch_gacha_section = "Batch Gacha (No Delay)", collect_section = "Collect Item",
        collect_settings = "Collect Settings", vote_system = "Vote System",
        mode_switch = "Mode Switch", astro_params = "Astro Coin Farm Parameters",
        auto_game_mode = "Auto Game Mode (Lobby)", extra_auto = "Extra Automation",
        visual_section = "Visual Effects", server_status = "Server Status",
        others = "Others", save_settings = "Save Config",
        mastery_title = "Auto Mastery", mastery_no_flush = "No Flush",
        mastery_flush = "Flush Mode", hitbox_title = "Hitbox",
        hitbox_scan = "Scan", hitbox_size = "Size",
        hitbox_enable = "Enable", hitbox_show = "Show",
        quest_title = "Quest Helper", quest_open_clock = "Clock-Man Menu",
        quest_open_quest = "Quest Menu", quest_auto_collect = "Auto Collect",
        quest_auto_skip = "Auto Skip", auto_rebirth = "Auto Rebirth",
        auto_daily = "Auto Daily", auto_chest = "Auto Chest",
        motion_prediction = "Motion Prediction", motion_prediction_desc = "Predict NPC position (high risk)",
        follow_mode = "Follow Mode", follow_mode_desc = "Stick to NPC every frame",
        auto_god_mode = "Auto God Mode", auto_god_mode_desc = "Auto respawn when HP low",
        god_respawn_threshold = "Respawn HP threshold", xmas_title = "Xmas Ultra Fast",
        xmas_open = "Auto Open Gifts (Ultra Fast)", xmas_collect = "Auto Collect The Present (Ultra Fast)",
        xmas_open_now = "Open 100 Gifts Now", batch_buy = "Batch Buy (No Delay)",
        batch_buy_desc = "Ultra fast shop buying", batch_gacha_char = "Batch Pull Characters",
        batch_gacha_skin = "Batch Pull Skins", rotate_90 = "Rotate 90° Mode",
        rotate_90_desc = "Rotate character 90 degrees", fullbright = "Full Bright",
        nofog = "No Fog", vibrant = "Vibrant Colors",
        show_fps = "Show FPS", show_ping = "Show Ping",
        fly = "Fly", infinity_jump = "Infinity Jump",
        no_clip = "No Clip", server_hop = "Server Hop",
        rejoin = "Rejoin", save_config = "Save Config",
        anti_afk = "Anti AFK", bypass_barrier = "Bypass Barrier",
        fps_boost = "FPS Boost", theme = "Theme",
        language = "Language", auto_collect = "Auto Collect",
        collect_clean = "Clean", collect_idgf = "IDGF",
        move_mode = "Move Mode", stand_pos = "Farm Position",
        aux_func = "Aux Functions", skill_keys = "Auto Skill Keys",
        weapon_select = "Select Weapon", auto_buy_weapon = "Auto Buy Weapon",
        buy_weapon_once = "Buy Weapon (Once)", misc_select = "Select Misc",
        auto_buy_misc = "Auto Buy Misc", buy_misc_once = "Buy Misc (Once)",
        redeem_selected = "Redeem Selected", redeem_all = "Redeem All",
        unlock_selected = "Unlock Selected", restore_vote = "Restore Vote System",
        set_vote_mode = "Set Vote Mode", auto_vote_ig = "Auto Vote (In-Game)",
        switch_farm = "▶ Auto Farm Mode", switch_astro = "✈ Astro Coin Farm",
        astro_duration = "Game Duration (s)", astro_radius = "Fly Radius",
        astro_speed = "Fly Speed", select_game_mode = "Select Game Mode",
        auto_game_mode_toggle = "Auto Game Mode (Lobby)", show_cpu_ping = "Show CPU/Ping",
        auto_reconnect = "Auto Reconnect", save_now = "Save Config Now",
        auto_save_config = "Auto Save Config", save_interval = "Save Interval (s)",
        reset_override = "Reset All Confirmed Positions", padding_reduce = "Set Padding Reduce",
        padding_safe = "Set Padding Safe Min", anti_clip_margin = "Anti-Clip Margin",
        dmg_threshold = "Damage Threshold", mastery_move_mode = "Move Mode",
        mastery_char_type = "Character Type", mastery_distance = "Distance to NPC",
        batch_items = "Batch Items", batch_amount = "Batch Amount",
        batch_char_spins = "Select Char Spins", batch_skin_spins = "Select Skin Spins",
        item_notify = "Item Notify", collect_mode = "Collect Mode",
        walk_speed = "Walk Speed", jump_power = "Jump Power",
        fly_speed_label = "Fly Speed", priority_order = "Priority Order",
        priority_desc = "GiantST → Helicopter → High HP → Nearest",
        info_update = "Update: Full Integration", info_desc = "- No backdoor | Multi-language | All features completed",
        info_clean = "Clean Version", info_clean_desc = "No backdoor | Chinese UI | Full features",
    },
    Russian = {
        loading = "Загрузка...", loaded = "Загружено, старт через 3с",
        auto_farm = "Авто ферма", auto_farm_desc = "Приоритетная ферма",
        farm_enabled = "Вкл", farm_disabled = "Выкл",
        sync_mode = "Синхронный режим", sync_desc = "Вспом. функции требуют ферму",
        sync_on = "Нужна ферма", sync_off = "Независимы",
        position_above = "Сверху", position_under = "Снизу",
        auto_attack = "Авто атака", auto_skill = "Авто умение",
        auto_ready = "Авто старт", auto_skip_heli = "Пропустить вертолёт",
        auto_heal = "Авто лечение", safe_mode = "Безопасный режим",
        god_mode = "Режим бога", delete_map = "Удалить карту",
        flush_aura = "Аура слива", flush_range = "Радиус слива",
        attack_speed = "Скорость атаки", skill_delay = "Задержка умений",
        height_offset = "Смещение высоты", safe_hp = "Порог ХП",
        god_hp = "Порог бога", high_hp_threshold = "Порог высокого ХП",
        esp_enable = "Включить ESP", esp_mob = "ESP мобов",
        esp_player = "ESP игроков", esp_item = "ESP предметов",
        esp_highlight = "Подсветка", esp_distance = "Дистанция",
        esp_health = "Здоровье", esp_name = "Имя",
        farm_settings = "Настройки фермы", general_settings = "Общие настройки",
        priority_settings = "Настройки приоритета", override_settings = "Настройки переопределения",
        flush_settings = "Настройки слива", risky_features = "Рискованные функции",
        esp_visual = "ESP визуал", esp_settings = "Настройки ESP",
        local_player = "Локальный игрок", redeem_codes = "Коды",
        unlock_gamepass = "Разблокировать Gamepass", shop_weapon = "Магазин оружия",
        shop_misc = "Магазин прочего", batch_section = "Пакетная покупка",
        batch_gacha_section = "Пакетная гача", collect_section = "Сбор предметов",
        collect_settings = "Настройки сбора", vote_system = "Система голосования",
        mode_switch = "Переключение режима", astro_params = "Параметры астро фарма",
        auto_game_mode = "Авто режим игры", extra_auto = "Доп. автоматизация",
        visual_section = "Визуальные эффекты", server_status = "Статус сервера",
        others = "Прочее", save_settings = "Сохранить конфиг",
        mastery_title = "Авто мастерство", mastery_no_flush = "Без слива",
        mastery_flush = "Режим слива",
        hitbox_title = "Хитбокс", hitbox_scan = "Сканировать",
        hitbox_size = "Размер", hitbox_enable = "Включить", hitbox_show = "Показать",
        quest_title = "Помощник заданий", quest_open_clock = "Меню часового",
        quest_open_quest = "Меню заданий",
        quest_auto_collect = "Авто сбор", quest_auto_skip = "Авто пропуск",
        auto_rebirth = "Авто возрождение", auto_daily = "Ежедневные", auto_chest = "Сундуки",
        motion_prediction = "Предсказание движения", motion_prediction_desc = "Предугадать позицию НПС (опасно)",
        follow_mode = "Режим следования", follow_mode_desc = "Прилипать к НПС каждый кадр",
        auto_god_mode = "Авто режим бога", auto_god_mode_desc = "Авто возрождение при низком ХП",
        god_respawn_threshold = "Порог возрождения",
        xmas_title = "Xmas супер быстрый", xmas_open = "Авто открытие подарков",
        xmas_collect = "Авто сбор The Present", xmas_open_now = "Открыть 100 подарков",
        batch_buy = "Пакетная покупка", batch_buy_desc = "Очень быстрая покупка",
        batch_gacha_char = "Пакетный抽 персонажей", batch_gacha_skin = "Пакетный抽 скинов",
        rotate_90 = "Поворот на 90°", rotate_90_desc = "Повернуть персонажа на 90 градусов",
        fullbright = "Полная яркость", nofog = "Без тумана", vibrant = "Яркие цвета",
        show_fps = "Показать FPS", show_ping = "Показать пинг",
        fly = "Полёт", infinity_jump = "Бесконечный прыжок", no_clip = "Нет столкновений",
        server_hop = "Смена сервера", rejoin = "Перезайти",
        save_config = "Сохранить конфиг", anti_afk = "Анти-AFK",
        bypass_barrier = "Обход границ", fps_boost = "FPS буст",
        theme = "Тема", language = "Язык",
        auto_collect = "Авто сбор", collect_clean = "После волны", collect_idgf = "Мгновенно",
        move_mode = "Режим движения", stand_pos = "Позиция фарма",
        aux_func = "Вспом. функции", skill_keys = "Клавиши умений",
        weapon_select = "Выбрать оружие", auto_buy_weapon = "Авто покупка оружия",
        buy_weapon_once = "Купить оружие", misc_select = "Выбрать предмет",
        auto_buy_misc = "Авто покупка предмета", buy_misc_once = "Купить предмет",
        redeem_selected = "Активировать выбранные", redeem_all = "Активировать все",
        unlock_selected = "Разблокировать выбранные",
        restore_vote = "Восстановить голосование", set_vote_mode = "Выбрать режим голосования",
        auto_vote_ig = "Авто голосование", switch_farm = "▶ Режим авто фарма",
        switch_astro = "✈ Режим астро фарма",
        astro_duration = "Длительность игры", astro_radius = "Радиус полёта",
        astro_speed = "Скорость полёта", select_game_mode = "Выбрать режим игры",
        auto_game_mode_toggle = "Авто режим игры",
        show_cpu_ping = "Показать CPU/Ping", auto_reconnect = "Авто переподключение",
        save_now = "Сохранить сейчас", auto_save_config = "Авто сохранение",
        save_interval = "Интервал сохранения",
        reset_override = "Сбросить подтверждённые позиции",
        padding_reduce = "Шаг уменьшения отступа", padding_safe = "Мин. безопасный отступ",
        anti_clip_margin = "Защита от клиппинга", dmg_threshold = "Порог урона",
        mastery_move_mode = "Режим движения", mastery_char_type = "Тип персонажа",
        mastery_distance = "Расстояние до NPC",
        batch_items = "Предметы для покупки", batch_amount = "Количество",
        batch_char_spins = "Выбрать крутки персонажей", batch_skin_spins = "Выбрать крутки скинов",
        item_notify = "Уведомление о предметах", collect_mode = "Режим сбора",
        walk_speed = "Скорость ходьбы", jump_power = "Сила прыжка",
        fly_speed_label = "Скорость полёта",
        priority_order = "Порядок приоритета",
        priority_desc = "GiantST → Вертолёт → Высокий HP → Ближайший",
        info_update = "Обновление: Полная интеграция",
        info_desc = "- Без бэкдоров | Многоязычный | Все функции",
        info_clean = "Чистая версия",
        info_clean_desc = "Без бэкдоров | Китайский UI | Все функции",
    },
    Portuguese = {
        loading = "Carregando...", loaded = "Carregado, iniciando em 3s",
        auto_farm = "Auto Farm", auto_farm_desc = "Farm por prioridade",
        farm_enabled = "Ativado", farm_disabled = "Desativado",
        sync_mode = "Modo Sincronizado", sync_desc = "Funções auxiliares precisam do auto farm",
        sync_on = "Precisa auto farm", sync_off = "Independentes",
        position_above = "Acima", position_under = "Abaixo",
        auto_attack = "Auto Ataque", auto_skill = "Auto Habilidade",
        auto_ready = "Auto Início", auto_skip_heli = "Auto Pular Heli",
        auto_heal = "Auto Cura", safe_mode = "Modo Seguro",
        god_mode = "Modo Deus", delete_map = "Deletar Mapa",
        flush_aura = "Aura Descarga", flush_range = "Alcance",
        attack_speed = "Velocidade Ataque", skill_delay = "Atraso Habilidade",
        height_offset = "Deslocamento Altura", safe_hp = "Limite HP Seguro",
        god_hp = "Limite HP Deus", high_hp_threshold = "Limite HP Alto",
        esp_enable = "Ativar ESP", esp_mob = "ESP Monstros",
        esp_player = "ESP Jogadores", esp_item = "ESP Itens",
        esp_highlight = "Destaque", esp_distance = "Distância",
        esp_health = "Vida", esp_name = "Nome",
        farm_settings = "Config. Farm", general_settings = "Config. Gerais",
        priority_settings = "Config. Prioridade", override_settings = "Config. Substituição",
        flush_settings = "Config. Descarga", risky_features = "Recursos Arriscados",
        esp_visual = "Visual ESP", esp_settings = "Config. ESP",
        local_player = "Jogador Local", redeem_codes = "Códigos",
        unlock_gamepass = "Desbloquear Gamepass", shop_weapon = "Loja de Armas",
        shop_misc = "Loja Misc", batch_section = "Compra em Lote",
        batch_gacha_section = "Gacha em Lote", collect_section = "Coletar Item",
        collect_settings = "Config. Coleta", vote_system = "Sistema de Voto",
        mode_switch = "Trocar Modo", astro_params = "Parâmetros Astro Farm",
        auto_game_mode = "Modo de Jogo Automático", extra_auto = "Automação Extra",
        visual_section = "Efeitos Visuais", server_status = "Status do Servidor",
        others = "Outros", save_settings = "Salvar Config",
        mastery_title = "Auto Maestria", mastery_no_flush = "Sem Descarga",
        mastery_flush = "Modo Descarga",
        hitbox_title = "Hitbox", hitbox_scan = "Escanear",
        hitbox_size = "Tamanho", hitbox_enable = "Ativar", hitbox_show = "Mostrar",
        quest_title = "Ajudante de Missões", quest_open_clock = "Menu Relógio",
        quest_open_quest = "Menu Missões",
        quest_auto_collect = "Auto Coletar", quest_auto_skip = "Auto Pular",
        auto_rebirth = "Auto Renascimento", auto_daily = "Recompensas Diárias", auto_chest = "Baús",
        motion_prediction = "Predição de Movimento", motion_prediction_desc = "Prever posição do NPC (risco)",
        follow_mode = "Modo Seguir", follow_mode_desc = "Grudar no NPC a cada quadro",
        auto_god_mode = "Auto Modo Deus", auto_god_mode_desc = "Auto renascer quando HP baixo",
        god_respawn_threshold = "Limite de renascimento",
        xmas_title = "Xmas Ultra Rápido", xmas_open = "Auto Abrir Presentes",
        xmas_collect = "Auto Coletar The Present", xmas_open_now = "Abrir 100 Presentes",
        batch_buy = "Compra em Lote", batch_buy_desc = "Compra super rápida",
        batch_gacha_char = "Puxar Personagens", batch_gacha_skin = "Puxar Skins",
        rotate_90 = "Rotação 90°", rotate_90_desc = "Rotacionar personagem 90 graus",
        fullbright = "Brilho Total", nofog = "Sem Névoa", vibrant = "Cores Vibrantes",
        show_fps = "Mostrar FPS", show_ping = "Mostrar Ping",
        fly = "Voar", infinity_jump = "Pulo Infinito", no_clip = "Sem Colisão",
        server_hop = "Trocar Servidor", rejoin = "Reentrar",
        save_config = "Salvar Config", anti_afk = "Anti AFK",
        bypass_barrier = "Ignorar Barreira", fps_boost = "Otimizar FPS",
        theme = "Tema", language = "Idioma",
        auto_collect = "Auto Coleta", collect_clean = "Limpo", collect_idgf = "IDGF",
        move_mode = "Modo de Movimento", stand_pos = "Posição de Farm",
        aux_func = "Funções Auxiliares", skill_keys = "Teclas de Habilidade",
        weapon_select = "Selecionar Arma", auto_buy_weapon = "Auto Comprar Arma",
        buy_weapon_once = "Comprar Arma", misc_select = "Selecionar Misc",
        auto_buy_misc = "Auto Comprar Misc", buy_misc_once = "Comprar Misc",
        redeem_selected = "Resgatar Selecionados", redeem_all = "Resgatar Todos",
        unlock_selected = "Desbloquear Selecionados",
        restore_vote = "Restaurar Sistema de Voto", set_vote_mode = "Definir Modo de Voto",
        auto_vote_ig = "Auto Voto", switch_farm = "▶ Modo Auto Farm",
        switch_astro = "✈ Modo Astro Farm",
        astro_duration = "Duração do Jogo", astro_radius = "Raio de Voo",
        astro_speed = "Velocidade de Voo", select_game_mode = "Selecionar Modo de Jogo",
        auto_game_mode_toggle = "Modo de Jogo Automático",
        show_cpu_ping = "Mostrar CPU/Ping", auto_reconnect = "Auto Reconectar",
        save_now = "Salvar Agora", auto_save_config = "Auto Salvar Config",
        save_interval = "Intervalo de Salvamento",
        reset_override = "Redefinir Posições Confirmadas",
        padding_reduce = "Definir Redução de Padding", padding_safe = "Definir Padding Mínimo",
        anti_clip_margin = "Margem Anti-Clip", dmg_threshold = "Limite de Dano",
        mastery_move_mode = "Modo de Movimento", mastery_char_type = "Tipo de Personagem",
        mastery_distance = "Distância ao NPC",
        batch_items = "Itens para Lote", batch_amount = "Quantidade",
        batch_char_spins = "Selecionar Giros de Personagem", batch_skin_spins = "Selecionar Giros de Skin",
        item_notify = "Notificar Item", collect_mode = "Modo de Coleta",
        walk_speed = "Velocidade de Caminhada", jump_power = "Força do Pulp",
        fly_speed_label = "Velocidade de Voo",
        priority_order = "Ordem de Prioridade",
        priority_desc = "GiantST → Helicóptero → HP Alto → Mais Próximo",
        info_update = "Atualização: Integração Completa",
        info_desc = "- Sem backdoor | Multi-idioma | Todas funções",
        info_clean = "Versão Limpa",
        info_clean_desc = "Sem backdoor | UI Chinês | Todas funções",
    },
}
getgenv().DYHUB_T = function(key)
    return (translations[currentLanguage] and translations[currentLanguage][key]) or key
end
local function T(key)
    return getgenv().DYHUB_T(key)
end

-- ====================== UI主题 ======================
WindUI:AddTheme({ Name = "Dark", Accent = "#18181b", Dialog = "#18181b", Outline = "#FFFFFF", Text = "#FFFFFF", Placeholder = "#999999", Background = "#0e0e10", Button = "#52525b", Icon = "#a1a1aa" })
WindUI:AddTheme({ Name = "Light", Accent = "#f4f4f5", Dialog = "#f4f4f5", Outline = "#000000", Text = "#000000", Placeholder = "#666666", Background = "#ffffff", Button = "#e4e4e7", Icon = "#52525b" })
WindUI:AddTheme({ Name = "Gray", Accent = "#374151", Dialog = "#374151", Outline = "#d1d5db", Text = "#f9fafb", Placeholder = "#9ca3af", Background = "#1f2937", Button = "#4b5563", Icon = "#d1d5db" })
WindUI:AddTheme({ Name = "Blue", Accent = "#1e40af", Dialog = "#1e3a8a", Outline = "#93c5fd", Text = "#f0f9ff", Placeholder = "#60a5fa", Background = "#1e293b", Button = "#3b82f6", Icon = "#93c5fd" })
WindUI:AddTheme({ Name = "Green", Accent = "#059669", Dialog = "#047857", Outline = "#6ee7b7", Text = "#ecfdf5", Placeholder = "#34d399", Background = "#064e3b", Button = "#10b981", Icon = "#6ee7b7" })
WindUI:AddTheme({ Name = "Purple", Accent = "#7c3aed", Dialog = "#6d28d9", Outline = "#c4b5fd", Text = "#faf5ff", Placeholder = "#a78bfa", Background = "#581c87", Button = "#8b5cf6", Icon = "#c4b5fd" })

local themesList = { "Dark", "Light", "Gray", "Blue", "Green", "Purple" }
local currentThemeIndex = 1

-- ====================== WINDOW ======================
local Window = WindUI:CreateWindow({
    Title = "DYHUB",
    IconThemed = true,
    Icon = "rbxassetid://93661445926652/",
    Author = "STBB | " .. "至尊版",
    Folder = "DYHUB",
    Size = UDim2.fromOffset(650, 550),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.8,
    HasOutline = false,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            currentThemeIndex = currentThemeIndex % #themesList + 1
            WindUI:SetTheme(themesList[currentThemeIndex])
            WindUI:Notify({ Title = T("theme"), Content = T("theme") .. " " .. themesList[currentThemeIndex], Duration = 2 })
        end
    },
})

Window:Tag({ Title = "至尊版", Color = Color3.fromHex("#db7093") })
Window:EditOpenButton({
    Title = "DYHUB - 打开",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255)),
    Draggable = true
})

-- ====================== TABS ======================
local Info       = Window:Tab({ Title = "信息",   Icon = "info" })
MainDivider      = Window:Divider()
local Main       = Window:Tab({ Title = T("auto_farm"),      Icon = "rocket" })
local Main4      = Window:Tab({ Title = T("esp_enable"),      Icon = "eye" })
local Main2      = Window:Tab({ Title = "玩家",               Icon = "user" })
local MasteryTab = Window:Tab({ Title = T("mastery_title"),   Icon = "award" })
local HitboxTab  = Window:Tab({ Title = T("hitbox_title"),    Icon = "package" })
local QuestTab   = Window:Tab({ Title = T("quest_title"),     Icon = "sword" })
MainDivider1     = Window:Divider()
local Main5      = Window:Tab({ Title = "商店",               Icon = "shopping-cart" })
local Main6      = Window:Tab({ Title = T("auto_collect"),    Icon = "hand" })
local Main7      = Window:Tab({ Title = "模式",               Icon = "gamepad-2" })
local ExtraTab   = Window:Tab({ Title = "额外",               Icon = "zap" })
local XmasTab    = Window:Tab({ Title = T("xmas_title"),      Icon = "gift" })
local MiscTab    = Window:Tab({ Title = "视觉效果",           Icon = "palette" })
MainDivider2     = Window:Divider()
local Main3      = Window:Tab({ Title = "设置",               Icon = "settings" })
Window:SelectTab(1)

-- ====================== INFO ======================
Info:Section({ Title = "最近更新", TextXAlignment = "Center", TextSize = 17 })
Info:Divider()
Info:Paragraph({
    Title = T("info_update"),
    Desc = T("info_desc"),
    Image = "rbxassetid://104487529937663",
    ImageSize = 30,
})
Info:Divider()
Info:Section({ Title = "DYHUB 信息", TextXAlignment = "Center", TextSize = 17 })
Info:Divider()
Info:Paragraph({ Title = "至尊版", Desc = "无后门 | 全功能整合 | 多语言界面", Image = "rbxassetid://104487529937663", ImageSize = 30 })

-- ====================== SERVICES ======================
local TweenService       = game:GetService("TweenService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService         = game:GetService("RunService")
local VirtualUser        = game:GetService("VirtualUser")
local UserInputService   = game:GetService("UserInputService")
local Lighting           = game:GetService("Lighting")
local TeleportService    = game:GetService("TeleportService")
local Stats              = game:GetService("Stats")
local Camera             = workspace.CurrentCamera

-- ====================== PLAYER ======================
local Character      = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Client         = LocalPlayer

-- ====================== GLOBAL TABLES ======================
local redeemCodes = {
    "100MVisit2", "100MVisit1", "CamArmada", "CCTVBase",
    "ADelayedGameIsEventuallyGoodButRushedGameIsForeverBad",
    "Verified", "BackOnBusiness", "UTSM", "18k loss",
    "50KGroup", "WaveStuckIssue", "flying toilet",
    "AstroInvasionBegin", "DarkDriveIssue", "Digi",
}
GlobalTables = {
    redeemCodes = redeemCodes,
    ModeDisplay = {
        "普通模式", "模糊记忆", "极限模式", "困难模式",
        "疯狂模式", "噩梦模式", "首领连战", "暗黑维度",
        "地狱", "迷雾", "圣诞行动1", "僵尸行动1",
        "坚守模式", "入侵"
    },
    ModeInternal = {
        ["普通模式"] = "Normal", ["模糊记忆"] = "Vague Memory", ["极限模式"] = "Extreme Mode",
        ["困难模式"] = "Hard", ["疯狂模式"] = "Insane", ["噩梦模式"] = "Nightmare",
        ["首领连战"] = "BossRush", ["暗黑维度"] = "DarkDimension",
        ["地狱"] = "Hell", ["迷雾"] = "ThunderStorm",
        ["圣诞行动1"] = "Christmas", ["僵尸行动1"] = "Zombie",
        ["坚守模式"] = "Holdout", ["入侵"] = "Invasion",
    },
    Votes = {
        "Normal", "Hard", "VeryHard", "Insane",
        "Nightmare", "BossRush", "DarkDimension", "Hell",
        "ThunderStorm", "Christmas", "Zombie", "Astro", "AstroV2",
    },
    WeaponDisplay = { "电击枪", "火焰喷射器", "鱼叉枪", "霰弹枪", "脉冲步枪", "鱼叉霰弹枪", "EPD", "小型激光枪" },
    WeaponInternal = {
        ["电击枪"] = "Stungun", ["火焰喷射器"] = "Flamethrower", ["鱼叉枪"] = "Harpoon Gun",
        ["霰弹枪"] = "Shot Gun", ["脉冲步枪"] = "Pulse Rifle", ["鱼叉霰弹枪"] = "Shot Harpoon Gun",
        ["EPD"] = "EPD", ["小型激光枪"] = "Small Laser Gun",
    },
    MiscDisplay = { "耳机", "泰坦呼叫", "特种泰坦呼叫", "扬声器呼叫", "手雷", "喷气背包", "透镜" },
    MiscInternal = {
        ["耳机"] = "HeadPhone", ["泰坦呼叫"] = "Titan-Request", ["特种泰坦呼叫"] = "SpecialTitan-Request",
        ["扬声器呼叫"] = "Speaker-Request", ["手雷"] = "Grenade", ["喷气背包"] = "Jetpack", ["透镜"] = "Lens",
    },
    Gamepasst = { "全部", "幸运加成", "稀有幸运加成", "传说幸运加成" },
}
local skillList          = { "Q", "E", "R", "T", "Y", "G", "H", "Z", "X", "C", "V", "B", "U" }
local skillDropdownValues = { "全部", "Q", "E", "R", "T", "Y", "G", "H", "Z", "X", "C", "V", "B", "U" }

-- ====================== STATE VARIABLES ======================
local AutoFarmEnabled        = Config:Get("AutoFarmEnabled", false)
local FarmPosition           = Config:Get("FarmPosition", "Above")
local FarmMode               = Config:Get("FarmMode", "Tween")
local MiscOptions            = Config:Get("MiscOptions", {})
local AutoAttackEnabled      = false
local AutoSkillEnabled       = false
local AutoSkipHeliEnabled    = false
local BoostFPS_Active_dummy  = false
local AutoStartEnabled       = false
local AutoFillUpEnabled      = false
local SelectedSkills         = Config:Get("SelectedSkills", { "全部" })
local SafeModeEnabled        = false
local SafeValue              = Config:Get("SafeValue", 30)
local GodModeEnabled         = false
local GodModeValue           = Config:Get("GodModeValue", 30)
local GodModeTriggered       = false
local WaitingRespawn         = false
local IdlePosition           = CFrame.new(-23.3435822, 67, 0.341766357) * CFrame.Angles(math.rad(0), 0, 0)
local SkillDelay             = Config:Get("SkillDelay", 1)
local LoopDelay              = 0.5
local TweenSpeed             = 1
local HeightValue            = Config:Get("HeightValue", 3)
local NeedNoClip             = false
local LockActive             = false
local AutoStartConnection    = nil
local noBarrierConnection    = nil
local noBarrierActive        = Config:Get("NoBarrier", false)

-- ====================== NEW PRIORITY SYSTEM CONFIG ======================
local HighHPThreshold        = Config:Get("HighHPThreshold", 200)
local _currentTargetPriority = 0
local _interruptSignal       = false

local VirtualUser = game:GetService("VirtualUser")
local AntiAFK = Config:Get("AntiAfk", true)

-- 自动购买配置
local AutoBuyWeaponEnabled   = Config:Get("AutoBuyWeaponEnabled", false)
local AutoBuyMiscEnabled     = Config:Get("AutoBuyMiscEnabled", false)
local rawWeapon = Config:Get("SelectedWeapon", "Stungun")
local rawMisc = Config:Get("SelectedMiscItem", "HeadPhone")
-- 确保存储英文
local SelectedWeapon = GlobalTables.WeaponInternal[rawWeapon] or rawWeapon
local SelectedMiscItem = GlobalTables.MiscInternal[rawMisc] or rawMisc
Config:Set("SelectedWeapon", SelectedWeapon)
Config:Set("SelectedMiscItem", SelectedMiscItem)

-- 自动模式配置
local rawMode = Config:Get("AutoGameValue", "Normal")
local AutoGameValue = GlobalTables.ModeInternal[rawMode] or rawMode
Config:Set("AutoGameValue", AutoGameValue)

-- 额外功能状态
local AutoRebirthEnabled     = Config:Get("AutoRebirthEnabled", false)
local AutoDailyEnabled       = Config:Get("AutoDailyEnabled", false)
local AutoChestEnabled       = Config:Get("AutoChestEnabled", false)
local MotionPredictionEnabled = Config:Get("MotionPredictionEnabled", false)
local FollowModeEnabled      = Config:Get("FollowModeEnabled", false)
local AutoGodModeEnabled     = Config:Get("AutoGodModeEnabled", false)
local GodRespawnThreshold    = Config:Get("GodRespawnThreshold", 10)
local XmasOpenEnabled        = Config:Get("XmasOpenEnabled", false)
local XmasCollectEnabled     = Config:Get("XmasCollectEnabled", false)
local BatchBuyEnabled        = Config:Get("BatchBuyEnabled", false)
local BatchGachaCharEnabled  = Config:Get("BatchGachaCharEnabled", false)
local BatchGachaSkinEnabled  = Config:Get("BatchGachaSkinEnabled", false)
local Rotate90Enabled        = Config:Get("Rotate90Enabled", false)
local AstroGameDuration      = Config:Get("AstroGameDuration", 960)
local AstroFlyRadius         = Config:Get("AstroFlyRadius", 300)
local AstroFlySpeed          = Config:Get("AstroFlySpeed", 2)
local MasteryAutoFarmActive  = false
local MasteryAutoFarmActiveTest = false
local ActionMode             = Config:Get("ActionMode", "Default")
local CharacterMode          = Config:Get("CharacterMode", "Used")
local MasteryMovementMode    = Config:Get("MasteryMovementMode", "CFrame")
local autoQuestCollectActive = false
local autoQuestSkipActive    = false
local ShowCPU                = Config:Get("ShowCPU", false)
local ReconnectOnDisconnect  = Config:Get("ReconnectOnDisconnect", true)

-- 视觉效果
local fullBrightEnabled      = false
local noFogEnabled           = false
local vibrantEnabled         = false
local showFPS                = true
local showPing               = true
local flying                 = false
local flySpeed               = 50
local flyConnection          = nil
local flyBodyVelocity        = nil
local infJumpConnection      = nil
local fullBrightConnection   = nil
local noFogConnection        = nil
local vibrantEffect          = nil
local fpsText                = nil
local msText                 = nil
local fpsCounter             = 0
local fpsLastUpdate          = tick()

-- 收集
local CollectItems = {
    "Clock Spider", "X-18 Core", "Green Energy Core", "Weird Transmitter",
    "Astro Samples", "Weird Prism", "Key Card", "Zombie Core",
    "Flash Drives", "Presents",
}
local CollectGroupMap = {
    ["Astro Samples"] = {
        "Trooper Blast", "Trooper Spinner", "Specialist Blaster",
        "Specialist Spinner", "Specialist Sword Arm", "Strider Leg",
        "Interceptor Wing", "Interceptor Goggles", "Interceptor Spinner",
        "Impactor Cannon", "Impactor Laser", "High Impactor Cannon",
        "High Impactor Laser", "Destructor Laser", "Destructor Blaster",
        "Destructor Core", "Obliterator Blaster", "Obliterator Spinner",
    },
    ["Presents"] = {
        "Gacha Capsule",
    },
}
local SelectedCollectItems   = Config:Get("SelectedCollectItems", {})
local AutoCollectEnabled     = Config:Get("AutoCollectEnabled", false)
local CollectMode            = Config:Get("CollectMode", "Clean")
local itemNotifyEnabled      = Config:Get("ItemNotifyEnabled", false)
local flushAuraEnabled       = Config:Get("flushaura", false)
local flushAuraRange         = Config:Get("FlushAuraValue", 5)
local SyncFarmOnly           = Config:Get("SyncFarmOnly", true)

-- 覆写参数
local PADDING_REDUCE_STEP    = Config:Get("PaddingReduceStep", 2)
local PADDING_SAFE_MIN       = Config:Get("PaddingSafeMin", -30)
local DMG_THRESHOLD          = Config:Get("DmgThreshold", 40)
local ANTI_CLIP_MARGIN       = Config:Get("AntiClipMargin", 3)
local PLAYER_HALF_HEIGHT     = 3

-- 玩家属性
local WSValue                = Config:Get("WSValue", 16)
local JPValue                = Config:Get("JPValue", 50)
local NoClip                 = Config:Get("NoClip", false)

-- 配置保存
local AutoSaveEnabled        = Config:Get("AutoSaveEnabled", true)
local AutoSaveDelay          = Config:Get("AutoSaveDelay", 15)
local autoSaveThread         = nil

-- 全局设置
getgenv().HitboxEnabled      = Config:Get("HitboxEnabled", false)
getgenv().HitboxSize         = Config:Get("HitboxSize", 20)
getgenv().HitboxShow         = Config:Get("HitboxShow", false)
getgenv().ACTIVE_MODE        = Config:Get("ActiveMode", "farm")
getgenv().DistanceValue      = Config:Get("DistanceValue", 1)
-- ====================== ALLY SYSTEM ======================
local AllyNames = {
    ["Heavy Soldier Toilet V2"]  = true,
    ["Quad Laser Toilet"]        = true,
    ["Strider Rocket Laser"]     = true,
    ["Helicopter Camera"]        = true,
    ["Heavy Soldier Toilet V1"]  = true,
    ["Rocket Heli v2"]           = true,
    ["Gunner Camera man"]        = true,
    ["Attack Helicopter"]        = true,
    ["Swat Mutant"]              = true,
    ["Huge DJ Toilet"]           = true,
}

local function IsAlly(mob)
    return AllyNames[mob.Name] ~= nil
end

-- ====================== TP SYSTEM ======================
function tp(pu79)
    pcall(function()
        local v80 = Client
        if v80 then v80 = Client.Character end
        if v80:FindFirstChild("Humanoid") and v80.Humanoid.Sit == true then v80.Humanoid.Sit = false end
        NeedNoClip = true
        local v81 = { Target = pu79.Target or print("目标错误"), Mod = pu79.Mod or CFrame.new(0, 0, 0) }
        v80:FindFirstChild("HumanoidRootPart").CFrame = v81.Target * v81.Mod
    end)
end

function Tp(p82)
    if Client.Character.Humanoid.Sit == true then Client.Character.Humanoid.Sit = false end
    local v83, v84, v85 = pairs(Client.Character:GetDescendants())
    while true do
        local v86
        v85, v86 = v83(v84, v85)
        if v85 == nil then break end
        if v86:IsA("BasePart") then v86.CanCollide = false end
    end
    if not Client.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
        local v87 = Instance.new("BodyVelocity")
        v87.Parent = Client.Character.HumanoidRootPart
        v87.Name = "BodyClip"
        v87.Velocity = Vector3.new(0, 0, 0)
        v87.MaxForce = Vector3.new(5, math.huge, 5)
    end
    Client.Character.HumanoidRootPart.CFrame = p82
end

function tp1(p89)
    local v90 = game.Players.LocalPlayer
    if v90 and v90.Character and v90.Character:FindFirstChild("HumanoidRootPart") then
        v90.Character:FindFirstChild("HumanoidRootPart").CFrame = p89
    else
        warn("玩家角色或 HumanoidRootPart 未找到")
    end
end

-- ====================== UTILITY FUNCTIONS ======================
local function IsValidMob(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        if Players:GetPlayerFromCharacter(obj) then return false end
        if IsAlly(obj) then return false end
        local humanoid = obj:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then return true end
    end
    return false
end

local function IsMobDead(mob)
    if not mob or not mob.Parent then return true end
    local humanoid = mob:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return true end
    return false
end

local function GetMobMaxHP(mob)
    local humanoid = mob and mob:FindFirstChild("Humanoid")
    if not humanoid then return 0 end
    return humanoid.MaxHealth or 0
end

-- ====================== MOB SELECTION ======================
local function GetNearestMob()
    local nearestMob, nearestDist = nil, math.huge
    local livingFolder = workspace:FindFirstChild("Living")
    if not livingFolder then return nil end
    for _, mob in ipairs(livingFolder:GetChildren()) do
        if IsValidMob(mob) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
            if mobRoot then
                local d = (HumanoidRootPart.Position - mobRoot.Position).Magnitude
                if d < nearestDist then nearestDist = d; nearestMob = mob end
            end
        end
    end
    return nearestMob
end

local function GetHighestMob()
    local highestMob, highestY = nil, -math.huge
    local livingFolder = workspace:FindFirstChild("Living")
    if not livingFolder then return nil end
    local myY = HumanoidRootPart and HumanoidRootPart.Position.Y or 0
    for _, mob in ipairs(livingFolder:GetChildren()) do
        if IsValidMob(mob) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
            if mobRoot then
                local mobY = mobRoot.Position.Y
                if mobY > myY and mobY > highestY then highestY = mobY; highestMob = mob end
            end
        end
    end
    return highestMob
end

-- ============================================================
-- ====================== NEW PRIORITY SYSTEM =================
-- ============================================================

local function GetHelicopter()
    local livingFolder = workspace:FindFirstChild("Living")
    if not livingFolder then return nil end
    for _, mob in ipairs(livingFolder:GetChildren()) do
        if mob.Name:lower():find("helicopter") and IsValidMob(mob) then
            return mob
        end
    end
    return nil
end

local function GetGiantSTToilet()
    local livingFolder = workspace:FindFirstChild("Living")
    if not livingFolder then return nil end
    local giant = livingFolder:FindFirstChild("Giant ST toilet")
    if giant and IsValidMob(giant) then
        local lever = giant:FindFirstChild("lever")
        if lever then
            local prompt = lever:FindFirstChildOfClass("ProximityPrompt")
            if prompt then return giant, prompt end
        end
    end
    return nil, nil
end

local function GetHighHPMob()
    local livingFolder = workspace:FindFirstChild("Living")
    if not livingFolder then return nil end
    local bestMob, bestHP = nil, HighHPThreshold
    for _, mob in ipairs(livingFolder:GetChildren()) do
        if IsValidMob(mob) then
            local hp = GetMobMaxHP(mob)
            if hp > bestHP then
                bestHP = hp
                bestMob = mob
            end
        end
    end
    return bestMob
end

local function GetPriorityMob()
    local giant, prompt = GetGiantSTToilet()
    if giant and prompt then return giant, "GiantST", prompt, 4 end
    local heli = GetHelicopter()
    if heli then return heli, "Helicopter", nil, 3 end
    local highHPMob = GetHighHPMob()
    if highHPMob then return highHPMob, "HighHP", nil, 2 end
    local nearMob = GetNearestMob()
    if nearMob then return nearMob, "NearestMob", nil, 1 end
    return nil, nil, nil, 0
end

local function CheckInterrupt(currentPriority)
    if currentPriority < 4 then
        local g, pr = GetGiantSTToilet()
        if g and pr then return true, 4 end
    end
    if currentPriority < 3 then
        if GetHelicopter() then return true, 3 end
    end
    if currentPriority < 2 then
        if GetHighHPMob() then return true, 2 end
    end
    return false, currentPriority
end

-- ============================================================
-- ====================== MOB VISUAL BOUNDS ===================
-- ============================================================

local function GetMobVisualBounds(mob)
    local minY, maxY = math.huge, -math.huge
    local centerX, centerZ, count = 0, 0, 0
    for _, part in ipairs(mob:GetDescendants()) do
        if part:IsA("BasePart") and part.Transparency < 0.9 and part.Size.Y > 0.1 then
            local pos = part.Position
            local hy  = part.Size.Y * 0.5
            if pos.Y - hy < minY then minY = pos.Y - hy end
            if pos.Y + hy > maxY then maxY = pos.Y + hy end
            centerX = centerX + pos.X
            centerZ = centerZ + pos.Z
            count   = count + 1
        end
    end
    if count == 0 then
        local hrp = mob:FindFirstChild("HumanoidRootPart")
        if hrp then
            return hrp.Position, hrp.Position.Y - 2, hrp.Position.Y + 2
        end
        return Vector3.new(0, 0, 0), 0, 4
    end
    local cx = centerX / count
    local cz = centerZ / count
    local cy = (minY + maxY) * 0.5
    return Vector3.new(cx, cy, cz), minY, maxY
end

-- ============================================================
-- ====================== MOB HEIGHT OVERRIDE =================
-- ============================================================

local PADDING_REDUCE_STEP    = Config:Get("PaddingReduceStep", 2)
local PADDING_SAFE_MIN       = Config:Get("PaddingSafeMin", -30)
local DMG_THRESHOLD          = Config:Get("DmgThreshold", 40)
local ANTI_CLIP_MARGIN       = Config:Get("AntiClipMargin", 3)
local PLAYER_HALF_HEIGHT     = 3

local MobHeightOverride   = {}
local MobConfirmedPadding = {}
local MobLastHealth       = {}
local MobCheckerCancelled = {}

local function GetAntiClipFloor(mob, position)
    local _, minY, maxY = GetMobVisualBounds(mob)
    local visualHeight = maxY - minY
    return -(visualHeight) + PLAYER_HALF_HEIGHT + ANTI_CLIP_MARGIN
end

local function GetEffectivePadding(mob)
    if MobConfirmedPadding[mob] ~= nil then return MobConfirmedPadding[mob] end
    if MobHeightOverride[mob] ~= nil then return MobHeightOverride[mob] end
    return HeightValue
end

local function ClampPaddingToAntiClip(mob, padding)
    local antiFloor = GetAntiClipFloor(mob, FarmPosition)
    local clamped = math.max(padding, antiFloor)
    clamped = math.max(clamped, PADDING_SAFE_MIN)
    return clamped
end

local function StartDamageChecker(mob)
    MobCheckerCancelled[mob] = false
    task.spawn(function()
        local humanoid = mob and mob:FindFirstChild("Humanoid")
        if not humanoid then return end
        if MobConfirmedPadding[mob] ~= nil then return end

        MobLastHealth[mob]     = humanoid.Health
        MobHeightOverride[mob] = ClampPaddingToAntiClip(mob, MobHeightOverride[mob] or HeightValue)

        local lastDamageTime = tick()
        local noDamageTimer  = 0
        local hitStreak      = 0
        local lastWasHit     = false
        local reducedOnce    = false

        while mob and mob.Parent and not IsMobDead(mob) and AutoFarmEnabled do
            task.wait(0.3)
            if MobCheckerCancelled[mob] then break end
            if not mob or not mob.Parent or IsMobDead(mob) then break end
            humanoid = mob:FindFirstChild("Humanoid")
            if not humanoid then break end

            local currentHP = humanoid.Health
            local lastHP    = MobLastHealth[mob] or currentHP
            local dmgDealt  = lastHP - currentHP
            local gotHit    = dmgDealt > 0

            if gotHit then
                lastDamageTime = tick()
                noDamageTimer  = 0
                reducedOnce    = false
                if lastWasHit then hitStreak = hitStreak + 1 else hitStreak = 1 end
                lastWasHit = true
                local curPad = GetEffectivePadding(mob)
                if dmgDealt >= DMG_THRESHOLD and MobConfirmedPadding[mob] == nil then
                    if not MobCheckerCancelled[mob] then
                        MobConfirmedPadding[mob] = curPad
                        MobHeightOverride[mob]   = curPad
                    end
                    break
                end
                if hitStreak >= 2 and MobConfirmedPadding[mob] == nil then
                    if not MobCheckerCancelled[mob] then
                        MobConfirmedPadding[mob] = curPad
                        MobHeightOverride[mob]   = curPad
                    end
                    break
                end
            else
                lastWasHit    = false
                hitStreak     = 0
                noDamageTimer = tick() - lastDamageTime
            end

            if noDamageTimer >= 3 and not reducedOnce then
                reducedOnce = true
                local curPad = GetEffectivePadding(mob)
                local newPad = ClampPaddingToAntiClip(mob, curPad - PADDING_REDUCE_STEP)
                if newPad ~= curPad then MobHeightOverride[mob] = newPad end
            end

            if noDamageTimer >= 6 then
                lastDamageTime = tick()
                reducedOnce    = false
                local curPad   = GetEffectivePadding(mob)
                local newPad   = ClampPaddingToAntiClip(mob, curPad - PADDING_REDUCE_STEP)
                if newPad ~= curPad then MobHeightOverride[mob] = newPad end
            end

            MobLastHealth[mob] = currentHP
        end

        if not MobCheckerCancelled[mob] then
            MobHeightOverride[mob] = nil
            MobLastHealth[mob]     = nil
        end
    end)
end

local function ResetMobOverride(mob)
    MobCheckerCancelled[mob] = true
    MobHeightOverride[mob]   = nil
    MobConfirmedPadding[mob] = nil
    MobLastHealth[mob]       = nil
    task.delay(0.5, function()
        MobCheckerCancelled[mob] = nil
    end)
end

-- ============================================================
-- ====================== TARGET CFRAME =======================
-- ============================================================
local function PredictNPCMovement(npc, timeAhead)
    if not npc or not npc:FindFirstChild("HumanoidRootPart") then
        return Vector3.new()
    end
    local hrp = npc.HumanoidRootPart
    local hum = npc:FindFirstChildOfClass("Humanoid")
    if hum and hum.MoveDirection and hum.MoveDirection.Magnitude > 0.1 then
        return hrp.Position + (hum.MoveDirection * hum.WalkSpeed * timeAhead)
    end
    return hrp.Position
end

local function GetTargetCFrame(mob, position)
    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
    if not mobRoot then return nil end

    local padding = GetEffectivePadding(mob)
    local center, minY, maxY = GetMobVisualBounds(mob)
    if MotionPredictionEnabled then
        center = PredictNPCMovement(mob, 0.3)
    end

    if position == "Above" then
        local safeTargetY = math.max(maxY + padding, maxY + 0.5)
        local targetPos   = Vector3.new(center.X, safeTargetY, center.Z)
        local lookAtPos   = Vector3.new(center.X, maxY, center.Z)
        local lookCF      = CFrame.new(targetPos, lookAtPos)
        return lookCF * CFrame.Angles(math.rad(-10), 0, 0)

    elseif position == "Under" then
        local safeTargetY = math.min(minY - padding, minY - 0.5)
        local targetPos   = Vector3.new(center.X, safeTargetY, center.Z)
        local lookAtPos   = Vector3.new(center.X, minY, center.Z)
        local lookCF      = CFrame.new(targetPos, lookAtPos)
        return lookCF * CFrame.Angles(math.rad(10), 0, 0)
    end
end
-- ============================================================
-- ====================== MAIN FARM LOOP ======================
-- ============================================================
local function StartFarmLoop()
    task.spawn(function()
        task.spawn(function()
            while AutoFarmEnabled do
                if WaitingRespawn and not LockActive then
                    pcall(function()
                        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = IdlePosition })
                        tween:Play(); tween.Completed:Wait()
                        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                    end)
                end
                task.wait(0.1)
            end
        end)

        while AutoFarmEnabled do
            if not Character or not Character.Parent then
                Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                Client = LocalPlayer
            end

            local mob, mobType, extraData, priority = GetPriorityMob()

            if mob then
                WaitingRespawn = false
                _currentTargetPriority = priority

                if mobType == "GiantST" and extraData then
                    local cf = GetTargetCFrame(mob, FarmPosition)
                    if cf then
                        if FarmMode == "Tween" then
                            local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = cf })
                            tween:Play(); tween.Completed:Wait()
                        else tp1(cf) end
                    end
                    local giantLockConn
                    giantLockConn = RunService.RenderStepped:Connect(function()
                        if IsMobDead(mob) or not mob.Parent or not AutoFarmEnabled then
                            giantLockConn:Disconnect(); return
                        end
                        local lockCF = GetTargetCFrame(mob, FarmPosition)
                        if lockCF and Character and HumanoidRootPart then
                            Character:PivotTo(lockCF)
                            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                            HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                        end
                    end)
                    repeat
                        task.wait(0.2)
                        ActivateProximityPrompt(extraData)
                        ActivateAllFlushPrompts()
                    until IsMobDead(mob) or not mob.Parent or not AutoFarmEnabled
                    giantLockConn:Disconnect()

                else
                    if SafeModeEnabled and GetPlayerHealthPercent() < SafeValue then
                        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
                        if mobRoot then
                            local safePos = mobRoot.Position + Vector3.new(0, 111, 0)
                            pcall(function()
                                Character:PivotTo(CFrame.new(safePos))
                                HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                                HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                            end)
                        end
                        task.wait(0.5)
                    else
                        StartDamageChecker(mob)
                        local cf = GetTargetCFrame(mob, FarmPosition)
                        if cf then
                            if FarmMode == "Tween" then
                                local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = cf })
                                tween:Play(); tween.Completed:Wait()
                            else
                                tp1(cf)
                            end
                        end

                        LockActive = true
                        local lockConn
                        lockConn = RunService.RenderStepped:Connect(function()
                            if not AutoFarmEnabled or IsMobDead(mob) or not LockActive then
                                lockConn:Disconnect(); LockActive = false; return
                            end
                            if not Character or not HumanoidRootPart then return end
                            local cf = GetTargetCFrame(mob, FarmPosition)
                            if cf then
                                Character:PivotTo(cf)
                                HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                                HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                            end
                        end)

                        repeat
                            task.wait(0.1)
                            local shouldInterrupt, newPriority = CheckInterrupt(priority)
                            if shouldInterrupt then
                                _interruptSignal = true
                                break
                            end
                        until IsMobDead(mob) or not AutoFarmEnabled

                        lockConn:Disconnect()
                        LockActive = false
                        _interruptSignal = false
                        ResetMobOverride(mob)
                    end
                end

            else
                _currentTargetPriority = 0
                TeleportToIdle()
                repeat task.wait(0.5) until GetPriorityMob() ~= nil or not AutoFarmEnabled
                WaitingRespawn = false
            end

            task.wait(0.1)
        end

        WaitingRespawn = false
        _currentTargetPriority = 0
    end)
end

-- ====================== AUTO LOOPS ======================
local function StartAutoAttack()
    task.spawn(function()
        while AutoAttackEnabled and AutoFarmEnabled do
            if not WaitingRespawn then
                pcall(function() ReplicatedStorage.LMB:FireServer() end)
            end
            task.wait(0.05)
        end
    end)
end

local function StartAutoSkill()
    task.spawn(function()
        while AutoSkillEnabled and AutoFarmEnabled do
            if not WaitingRespawn then
                local keysToPress = {}
                if table.find(SelectedSkills, "全部") then
                    keysToPress = skillList
                else
                    keysToPress = SelectedSkills
                end
                for _, key in ipairs(keysToPress) do
                    if not AutoSkillEnabled or not AutoFarmEnabled then break end
                    local keyCode = Enum.KeyCode[key]
                    if keyCode then
                        pcall(function()
                            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                            task.wait(0.05)
                            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
                        end)
                        task.wait(SkillDelay)
                    end
                end
            end
            task.wait(LoopDelay)
        end
    end)
end

local function TriggerAutoSkipHeli(state)
    pcall(function() ReplicatedStorage.SetSettingAutoSkipWave:FireServer(state) end)
end

-- ====================== DELETE MAP ======================
local BoostFPS_OriginalData = {}
local BoostFPS_Active = false
local BoostFPS_RestoreConnection = nil
local BoostFPS_LightingData = {}

local function SaveAndBoostFPS()
    if BoostFPS_Active then return end
    BoostFPS_Active = true
    BoostFPS_OriginalData = {}
    BoostFPS_LightingData = {}

    local Lighting = game:GetService("Lighting")
    BoostFPS_LightingData = {
        Brightness        = Lighting.Brightness,
        GlobalShadows     = Lighting.GlobalShadows,
        FogEnd            = Lighting.FogEnd,
        FogStart          = Lighting.FogStart,
    }
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness    = 1
        Lighting.FogEnd        = 100000
        Lighting.FogStart      = 100000
    end)
    for _, effect in ipairs(Lighting:GetChildren()) do
        pcall(function()
            if effect:IsA("Atmosphere") or effect:IsA("BloomEffect") or
               effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") or
               effect:IsA("SunRaysEffect") or effect:IsA("Sky") then
                BoostFPS_LightingData["effect_" .. effect.Name] = { class = effect.ClassName, inst = effect }
                effect.Parent = nil
            end
        end)
    end

    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if IsLivingDescendant(obj) then continue end
            if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") or obj:IsA("SpecialMesh") then
                if not IsLivingDescendant(obj) then
                    if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                        BoostFPS_OriginalData[obj] = {
                            Transparency = obj.Transparency,
                            CastShadow   = obj.CastShadow,
                            Material     = obj.Material,
                        }
                        obj.Transparency = 1
                        obj.CastShadow   = false
                        pcall(function() obj.Material = Enum.Material.SmoothPlastic end)
                    end
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                BoostFPS_OriginalData[obj] = { Transparency = obj.Transparency }
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
                   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("SelectionBox") then
                BoostFPS_OriginalData[obj] = { Enabled = obj.Enabled }
                pcall(function() obj.Enabled = false end)
            elseif obj:IsA("SpecialMesh") then
                BoostFPS_OriginalData[obj] = { TextureId = obj.TextureId }
                obj.TextureId = ""
            end
        end
    end)

    BoostFPS_RestoreConnection = workspace.DescendantAdded:Connect(function(obj)
        if not BoostFPS_Active then return end
        if IsLivingDescendant(obj) then return end
        task.wait(0.05)
        pcall(function()
            if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                if not IsLivingDescendant(obj) then
                    obj.Transparency = 1
                    obj.CastShadow   = false
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
                   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                pcall(function() obj.Enabled = false end)
            end
        end)
    end)

    print("[DYHUB] 删除地图: 开启")
end

local function RestoreBoostFPS()
    if not BoostFPS_Active then return end
    BoostFPS_Active = false

    if BoostFPS_RestoreConnection then
        BoostFPS_RestoreConnection:Disconnect()
        BoostFPS_RestoreConnection = nil
    end

    local Lighting = game:GetService("Lighting")
    pcall(function()
        if BoostFPS_LightingData.Brightness        ~= nil then Lighting.Brightness        = BoostFPS_LightingData.Brightness end
        if BoostFPS_LightingData.GlobalShadows     ~= nil then Lighting.GlobalShadows     = BoostFPS_LightingData.GlobalShadows end
        if BoostFPS_LightingData.FogEnd            ~= nil then Lighting.FogEnd            = BoostFPS_LightingData.FogEnd end
        if BoostFPS_LightingData.FogStart          ~= nil then Lighting.FogStart          = BoostFPS_LightingData.FogStart end
    end)
    for key, data in pairs(BoostFPS_LightingData) do
        if type(key) == "string" and key:sub(1, 7) == "effect_" then
            pcall(function()
                if data.inst then data.inst.Parent = Lighting end
            end)
        end
    end

    for obj, data in pairs(BoostFPS_OriginalData) do
        pcall(function()
            if not obj or not obj.Parent then return end
            if data.Transparency ~= nil and (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") or obj:IsA("Decal") or obj:IsA("Texture")) then
                obj.Transparency = data.Transparency
            end
            if data.CastShadow ~= nil then obj.CastShadow = data.CastShadow end
            if data.Material   ~= nil then pcall(function() obj.Material = data.Material end) end
            if data.Enabled    ~= nil then pcall(function() obj.Enabled  = data.Enabled  end) end
            if data.TextureId  ~= nil then obj.TextureId = data.TextureId end
        end)
    end

    BoostFPS_OriginalData = {}
    BoostFPS_LightingData = {}
    print("[DYHUB] 删除地图: 关闭")
end

-- ====================== GOD MODE LOOP ======================
task.spawn(function()
    while true do
        task.wait(0.1)
        if GodModeEnabled then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local humanoid = char:FindFirstChild("Humanoid")
                if not humanoid then return end
                if humanoid.MaxHealth <= 0 then return end
                local hpPercent = (humanoid.Health / humanoid.MaxHealth) * 100
                if hpPercent < GodModeValue then
                    local head = char:FindFirstChild("Head")
                    if head then
                        head:Destroy()
                    else
                        humanoid.Health = 0
                    end
                end
            end)
        end
    end
end)

-- ====================== AUTO FILL UP ======================
local function DoFillUp()
    for i = 1, 2 do
        pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "FillHP") end)
        if i < 2 then task.wait(0.3) end
    end
end

local FillUpRunning = false

local function StartAutoFillUpLoop()
    if FillUpRunning then return end
    FillUpRunning = true
    task.spawn(function()
        while AutoFillUpEnabled and AutoFarmEnabled do
            if not IsPlayerHPFull() then
                if AutoSkipHeliEnabled then TriggerAutoSkipHeli(false) end
                local waited = 0
                while not IsFillUpPartReady() and AutoFillUpEnabled do
                    waited = waited + 0.2
                    if waited >= 30 then break end
                    task.wait(0.2)
                end
                if IsFillUpPartReady() and AutoFillUpEnabled then DoFillUp(); task.wait(1) end
                if AutoSkipHeliEnabled then TriggerAutoSkipHeli(true) end
            end
            task.wait(1)
        end
        FillUpRunning = false
    end)
end

-- ====================== MISC OPTIONS HANDLER ======================
local SyncFarmOnly = Config:Get("SyncFarmOnly", true)

local function HandleMiscOptions(selectedOptions)
    MiscOptions = selectedOptions
    local canRun = AutoFarmEnabled or not SyncFarmOnly

    local hasAutoAttack = table.find(selectedOptions, T("auto_attack"))
    if hasAutoAttack and not AutoAttackEnabled and canRun then
        AutoAttackEnabled = true; StartAutoAttack()
    elseif not hasAutoAttack then
        AutoAttackEnabled = false
    end

    local hasAutoSkill = table.find(selectedOptions, T("auto_skill"))
    if hasAutoSkill and not AutoSkillEnabled and canRun then
        AutoSkillEnabled = true; StartAutoSkill()
    elseif not hasAutoSkill then
        AutoSkillEnabled = false
    end

    local hasAutoSkipHeli = table.find(selectedOptions, T("auto_skip_heli"))
    if hasAutoSkipHeli and not AutoSkipHeliEnabled and canRun then
        AutoSkipHeliEnabled = true; TriggerAutoSkipHeli(true)
    elseif not hasAutoSkipHeli and AutoSkipHeliEnabled then
        AutoSkipHeliEnabled = false; TriggerAutoSkipHeli(false)
    end

    local hasBoostFPS = table.find(selectedOptions, T("delete_map"))
    if hasBoostFPS and not BoostFPS_Active then
        SaveAndBoostFPS()
    elseif not hasBoostFPS and BoostFPS_Active then
        RestoreBoostFPS()
    end

    SafeModeEnabled = table.find(selectedOptions, T("safe_mode")) ~= nil
    GodModeEnabled  = table.find(selectedOptions, T("god_mode")) ~= nil

    local hasAutoStart = table.find(selectedOptions, T("auto_ready"))
    if hasAutoStart and not AutoStartEnabled and canRun then
        StartAutoStart()
    elseif not hasAutoStart and AutoStartEnabled then
        StopAutoStart()
    end

    local hasAutoFillUp = table.find(selectedOptions, T("auto_heal"))
    if hasAutoFillUp and not AutoFillUpEnabled then
        if canRun then AutoFillUpEnabled = true; StartAutoFillUpLoop() end
    elseif not hasAutoFillUp then
        AutoFillUpEnabled = false; FillUpRunning = false
    end

    Config:Set("MiscOptions", selectedOptions)
    Config:Save()
end

-- ====================== SCHEDULER ======================
local Scheduler = {
    tasks = {},
    heartbeat = nil,
}

function Scheduler:register(name, step, interval)
    self.tasks[name] = {
        step = step,
        interval = interval or 0,
        last = 0,
    }
end

function Scheduler:unregister(name)
    self.tasks[name] = nil
end

function Scheduler:start()
    if self.heartbeat then return end
    self.heartbeat = RunService.Heartbeat:Connect(function(dt)
        local now = tick()
        for _, t in pairs(self.tasks) do
            if t.interval == 0 then
                t.step(dt)
            elseif now - t.last >= t.interval then
                t.last = now
                t.step(dt)
            end
        end
    end)
end

-- ====================== SCANNER ======================
local Scanner = {
    Cache = {
        mobs = {},
        items = {},
        flushPrompts = {},
    },
    LastScan = 0,
    ScanInterval = 2,
}

local function IsCollectTarget(name)
    for _, p in ipairs(SelectedCollectItems) do
        if name:lower() == p:lower() then return true end
        if CollectGroupMap[p] then
            for _, g in ipairs(CollectGroupMap[p]) do
                if name:lower() == g:lower() then return true end
            end
        end
    end
    return false
end

local function ScanWorld()
    local now = tick()
    if now - Scanner.LastScan < Scanner.ScanInterval then return end
    Scanner.LastScan = now
    task.spawn(function()
        pcall(function()
            local mobs = {}
            local items = {}
            local flushPrompts = {}
            local living = workspace:FindFirstChild("Living")
            if living then
                for _, m in ipairs(living:GetChildren()) do
                    if IsValidMob(m) then
                        table.insert(mobs, m)
                        for _, prompt in ipairs(m:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") and (prompt.ActionText == "Flush" or prompt.ActionText == "Dragon Flash") then
                                table.insert(flushPrompts, { mob = m, prompt = prompt })
                            end
                        end
                    end
                end
            end
            if AutoCollectEnabled and #SelectedCollectItems > 0 then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj and obj.Parent and (obj:IsA("Model") or obj:IsA("Part")) and IsCollectTarget(obj.Name) then
                        table.insert(items, obj)
                    end
                end
            end
            Scanner.Cache.mobs = mobs
            Scanner.Cache.items = items
            Scanner.Cache.flushPrompts = flushPrompts
        end)
    end)
end

-- ====================== ESP SYSTEM (with Scheduler integration) ======================
local ESP = {
    Enabled       = Config:Get("EspEnabled", false),
    MobEnabled    = Config:Get("EspMobEnabled", true),
    PlayerEnabled = Config:Get("EspPlayerEnabled", true),
    ItemEnabled   = Config:Get("EspItemEnabled", true),
    Settings      = Config:Get("EspSettings", { T("esp_highlight"), T("esp_distance"), T("esp_health"), T("esp_name") }),
    SelectedItems = Config:Get("EspSelectedItems", {}),
    ESPMode       = Config:Get("EspMode", "Highlight"),
    _mobHighlights    = {},
    _playerHighlights = {},
    _itemHighlights   = {},
    ItemList = {
        "Clock Spider","X-18 Core","Green Energy Core","Weird Transmitter",
        "Presents","Weird Prism","Key Card","Zombie Core","Flash Drives","Astro Samples",
    },
}

local function GetESPSettings()
    local s = ESP.Settings
    return {
        highlight = table.find(s, T("esp_highlight")) ~= nil,
        distance  = table.find(s, T("esp_distance")) ~= nil,
        health    = table.find(s, T("esp_health")) ~= nil,
        name      = table.find(s, T("esp_name")) ~= nil,
    }
end

local function EnsureHighlight(model, color)
    if ESP.ESPMode == "BoxHandle" then
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if hrp then
            local box = hrp:FindFirstChild("DYHUB_ESP_BOX")
            if not box then
                box = Instance.new("BoxHandleAdornment")
                box.Name = "DYHUB_ESP_BOX"
                box.Adornee = hrp
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = Vector3.new(4, 6, 2)
                box.Color3 = color or Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.5
                box.Parent = hrp
            else
                box.Color3 = color or Color3.fromRGB(255, 0, 0)
                box.Visible = true
            end
            return box
        end
        return nil
    else
        local hl = model:FindFirstChild("DYHUB_ESP_HIGHLIGHT")
        if not hl then
            hl = Instance.new("Highlight")
            hl.Name = "DYHUB_ESP_HIGHLIGHT"
            hl.Adornee = model
            hl.Parent = model
        end
        hl.FillColor = color or Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.9
        hl.Enabled = true
        return hl
    end
end

local function EnsureBillboard(hrp)
    local bill = hrp:FindFirstChild("DYHUB_ESP_LABEL")
    if not bill then
        bill = Instance.new("BillboardGui")
        bill.Name = "DYHUB_ESP_LABEL"
        bill.Size = UDim2.new(0, 150, 0, 40)
        bill.StudsOffset = Vector3.new(0, 2.5, 0)
        bill.AlwaysOnTop = true
        bill.Adornee = hrp
        bill.Parent = hrp
        local frame = Instance.new("Frame", bill)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 12
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeTransparency = 0.3
        label.Name = "Label"
    end
    return bill
end

local function UpdateESPForMob(mob)
    if not ESP.MobEnabled then return end
    local hrp = mob:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local settings = GetESPSettings()
    if settings.highlight then EnsureHighlight(mob) end
    if settings.name or settings.health or settings.distance then
        local bill = EnsureBillboard(hrp)
        local label = bill:FindFirstChild("Frame").Label
        local parts = {}
        if settings.name then table.insert(parts, mob.Name) end
        if settings.health then
            local hum = mob:FindFirstChild("Humanoid")
            if hum then table.insert(parts, string.format("❤ %.0f/%.0f", hum.Health, hum.MaxHealth)) end
        end
        if settings.distance and HumanoidRootPart then
            local dist = (HumanoidRootPart.Position - hrp.Position).Magnitude
            table.insert(parts, string.format("📏 %.0fm", dist))
        end
        label.Text = table.concat(parts, "\n")
        bill.Visible = true
    else
        local bill = hrp:FindFirstChild("DYHUB_ESP_LABEL")
        if bill then bill.Visible = false end
    end
end

local function UpdateESPForPlayer(playerChar)
    if not ESP.PlayerEnabled then return end
    local hrp = playerChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if playerChar == LocalPlayer.Character then return end
    local settings = GetESPSettings()
    if settings.highlight then EnsureHighlight(playerChar, Color3.fromRGB(50, 255, 50)) end
    if settings.name or settings.health or settings.distance then
        local bill = EnsureBillboard(hrp)
        local label = bill:FindFirstChild("Frame").Label
        local parts = {}
        if settings.name then
            local plr = Players:GetPlayerFromCharacter(playerChar)
            table.insert(parts, plr and plr.Name or playerChar.Name)
        end
        if settings.health then
            local hum = playerChar:FindFirstChild("Humanoid")
            if hum then table.insert(parts, string.format("❤ %.0f/%.0f", hum.Health, hum.MaxHealth)) end
        end
        if settings.distance and HumanoidRootPart then
            local dist = (HumanoidRootPart.Position - hrp.Position).Magnitude
            table.insert(parts, string.format("📏 %.0fm", dist))
        end
        label.Text = table.concat(parts, "\n")
        bill.Visible = true
    else
        local bill = hrp:FindFirstChild("DYHUB_ESP_LABEL")
        if bill then bill.Visible = false end
    end
end

local function UpdateESPForItem(obj)
    if not ESP.ItemEnabled then return end
    local root = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")) or (obj:IsA("BasePart") and obj) or nil
    if not root then return end
    local settings = GetESPSettings()
    if settings.highlight then EnsureHighlight(obj, Color3.fromRGB(255, 215, 0)) end
    if settings.name or settings.distance then
        local bill = EnsureBillboard(root)
        local label = bill:FindFirstChild("Frame").Label
        local parts = {}
        if settings.name then table.insert(parts, obj.Name) end
        if settings.distance and HumanoidRootPart then
            local dist = (HumanoidRootPart.Position - root.Position).Magnitude
            table.insert(parts, string.format("📏 %.0fm", dist))
        end
        label.Text = table.concat(parts, "\n")
        bill.Visible = true
    else
        local bill = root:FindFirstChild("DYHUB_ESP_LABEL")
        if bill then bill.Visible = false end
    end
end

local function ClearAllESP()
    for mob, _ in pairs(ESP._mobHighlights) do
        pcall(function()
            local hl = mob:FindFirstChild("DYHUB_ESP_HIGHLIGHT") if hl then hl:Destroy() end
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hrp then
                local lb = hrp:FindFirstChild("DYHUB_ESP_LABEL") if lb then lb:Destroy() end
                local bx = hrp:FindFirstChild("DYHUB_ESP_BOX") if bx then bx:Destroy() end
            end
        end)
    end
    ESP._mobHighlights = {}
    for char, _ in pairs(ESP._playerHighlights) do
        pcall(function()
            local hl = char:FindFirstChild("DYHUB_ESP_HIGHLIGHT") if hl then hl:Destroy() end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local lb = hrp:FindFirstChild("DYHUB_ESP_LABEL") if lb then lb:Destroy() end
                local bx = hrp:FindFirstChild("DYHUB_ESP_BOX") if bx then bx:Destroy() end
            end
        end)
    end
    ESP._playerHighlights = {}
    for obj, _ in pairs(ESP._itemHighlights) do
        pcall(function()
            local hl = obj:FindFirstChild("DYHUB_ESP_HIGHLIGHT") if hl then hl:Destroy() end
            local root = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")) or obj
            if root then
                local lb = root:FindFirstChild("DYHUB_ESP_LABEL") if lb then lb:Destroy() end
                local bx = root:FindFirstChild("DYHUB_ESP_BOX") if bx then bx:Destroy() end
            end
        end)
    end
    ESP._itemHighlights = {}
end

local ESPConnection = nil

local function StartESPLoop()
    if ESPConnection then ESPConnection:Disconnect(); ESPConnection = nil end
    local tickCounter = 0
    ESPConnection = RunService.Heartbeat:Connect(function()
        tickCounter = tickCounter + 1
        if tickCounter % 30 == 0 and ESP.Enabled and ESP.MobEnabled then
            for _, mob in ipairs(Scanner.Cache.mobs or {}) do
                UpdateESPForMob(mob)
            end
        end
        if tickCounter % 47 == 0 and ESP.Enabled and ESP.PlayerEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    UpdateESPForPlayer(player.Character)
                end
            end
        end
        if tickCounter % 61 == 0 and ESP.Enabled and ESP.ItemEnabled then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if IsCollectTarget(obj.Name) then
                    UpdateESPForItem(obj)
                end
            end
        end
        if tickCounter >= 3660 then tickCounter = 0 end
    end)
end

local function StopESPLoop()
    if ESPConnection then ESPConnection:Disconnect(); ESPConnection = nil end
    ClearAllESP()
end

-- ====================== COLLECT SYSTEM (step) ======================
local KnownCollectItems = {}

local function stepAutoCollect()
    if not AutoCollectEnabled or #SelectedCollectItems == 0 then return end
    if not Scanner.Cache.items or #Scanner.Cache.items == 0 then return end
    local hrp = HumanoidRootPart
    if not hrp then return end
    for _, obj in ipairs(Scanner.Cache.items) do
        if obj and obj.Parent and not KnownCollectItems[obj] then
            local root = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")) or obj
            if root then
                if itemNotifyEnabled then
                    local dist = (hrp.Position - root.Position).Magnitude
                    WindUI:Notify({ Title = T("item_notify"), Content = string.format("%s\n%.0fm", obj.Name, dist), Duration = 2 })
                end
                local targetPos = root.Position + Vector3.new(0, 3, 0)
                hrp.CFrame = CFrame.new(targetPos)
                task.wait(0.05)
                pcall(function()
                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        prompt.HoldDuration = 0
                        fireproximityprompt(prompt)
                    end
                end)
                KnownCollectItems[obj] = true
            end
        end
    end
end

-- ====================== FLUSH AURA ======================
local function stepFlushAura()
    if not flushAuraEnabled then return end
    local hrp = HumanoidRootPart
    if not hrp then return end
    for _, entry in ipairs(Scanner.Cache.flushPrompts or {}) do
        local prompt = entry.prompt
        local part = prompt.Parent
        if part and part:IsA("BasePart") then
            if (hrp.Position - part.Position).Magnitude <= flushAuraRange then
                pcall(function()
                    prompt.HoldDuration = 0
                    fireproximityprompt(prompt)
                end)
            end
        end
    end
end

-- ====================== VISUAL EFFECTS ======================
local function updateFullBright()
    if fullBrightEnabled then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 5
        Lighting.ClockTime = 14
        if not fullBrightConnection then
            fullBrightConnection = RunService.RenderStepped:Connect(function()
                if fullBrightEnabled then
                    Lighting.ClockTime = 14
                    Lighting.Brightness = 10
                    Lighting.Ambient = Color3.new(1, 1, 1)
                end
            end)
        end
    else
        if fullBrightConnection then
            fullBrightConnection:Disconnect()
            fullBrightConnection = nil
        end
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    end
end

local function updateNoFog()
    if noFogEnabled then
        Lighting.FogStart = 0
        Lighting.FogEnd = 1e10
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        if not noFogConnection then
            noFogConnection = RunService.RenderStepped:Connect(function()
                if noFogEnabled then
                    Lighting.FogStart = 0
                    Lighting.FogEnd = 1e10
                    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
                end
            end)
        end
    else
        if noFogConnection then
            noFogConnection:Disconnect()
            noFogConnection = nil
        end
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    end
end

local function updateVibrant()
    if not vibrantEffect then
        vibrantEffect = Lighting:FindFirstChild("VibrantEffect") or Instance.new("ColorCorrectionEffect")
        vibrantEffect.Name = "VibrantEffect"
        vibrantEffect.Parent = Lighting
    end
    if vibrantEnabled then
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
        Lighting.ColorShift_Top = Color3.fromRGB(255, 230, 200)
        Lighting.ColorShift_Bottom = Color3.fromRGB(200, 240, 255)
        vibrantEffect.Saturation = 1
        vibrantEffect.Contrast = 0.4
        vibrantEffect.Brightness = 0.05
        vibrantEffect.Enabled = true
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        vibrantEffect.Enabled = false
    end
end

-- ====================== FLY ======================
local function startFly()
    if flyConnection then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBodyVelocity.Parent = hrp
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying or not LocalPlayer.Character then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            flyConnection:Disconnect()
            flyConnection = nil
            return
        end
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * flySpeed end
        flyBodyVelocity.Velocity = moveDir
    end)
end

-- ====================== FPS DISPLAY ======================
local function initFPSDisplay()
    if not fpsText then
        fpsText = Drawing.new("Text")
        fpsText.Size = 16
        fpsText.Color = Color3.fromRGB(0, 255, 0)
        fpsText.Center = false
        fpsText.Outline = true
        fpsText.Visible = showFPS
        msText = Drawing.new("Text")
        msText.Size = 16
        msText.Color = Color3.fromRGB(0, 255, 0)
        msText.Center = false
        msText.Outline = true
        msText.Visible = showPing
    end
    local cam = workspace.CurrentCamera
    if cam and cam.ViewportSize then
        fpsText.Position = Vector2.new(cam.ViewportSize.X - 100, 10)
        msText.Position = Vector2.new(cam.ViewportSize.X - 100, 30)
    end
end

local function updateFPSDisplay()
    if not showFPS and not showPing then return end
    initFPSDisplay()
    fpsCounter = fpsCounter + 1
    if tick() - fpsLastUpdate >= 1 then
        if showFPS then
            fpsText.Text = "FPS: " .. tostring(fpsCounter)
            fpsText.Visible = true
        else
            fpsText.Visible = false
        end
        if showPing then
            local pingStat = Stats.Network.ServerStatsItem["Data Ping"]
            local ping = pingStat and math.floor(pingStat:GetValue()) or 0
            msText.Text = "Ping: " .. ping .. " ms"
            if ping <= 60 then
                msText.Color = Color3.fromRGB(0, 255, 0)
            elseif ping <= 120 then
                msText.Color = Color3.fromRGB(255, 165, 0)
            else
                msText.Color = Color3.fromRGB(255, 0, 0)
            end
            msText.Visible = true
        else
            msText.Visible = false
        end
        fpsCounter = 0
        fpsLastUpdate = tick()
    end
end

-- ====================== MEMORY MONITOR ======================
task.spawn(function()
    while true do
        task.wait(30)
        local mem = collectgarbage("count")
        if mem > 800000 then
            collectgarbage()
            if mem > 1200000 then
                Scanner.Cache = { mobs = {}, items = {}, flushPrompts = {} }
                for k in pairs(KnownCollectItems) do KnownCollectItems[k] = nil end
                for k in pairs(MobHeightOverride) do MobHeightOverride[k] = nil end
                for k in pairs(MobConfirmedPadding) do MobConfirmedPadding[k] = nil end
                print("[DYHUB] 内存超限，已清理缓存")
            end
        end
    end
end)

-- ====================== STEP FUNCTIONS FOR NEW MODULES ======================
local function stepAutoRebirth()
    if not AutoRebirthEnabled then return end
    pcall(function()
        local r = ReplicatedStorage:FindFirstChild("Rebirth")
        if r then r:FireServer() end
    end)
end

local function stepAutoDaily()
    if not AutoDailyEnabled then return end
    pcall(function()
        local d = ReplicatedStorage:FindFirstChild("DailyReward")
        if d then d:FireServer() end
    end)
end

local function stepAutoChest()
    if not AutoChestEnabled then return end
    local hrp = HumanoidRootPart
    if not hrp then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("chest") or obj.Name:lower():find("crate")) then
            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
            if prompt and (hrp.Position - obj:GetPivot().Position).Magnitude <= 50 then
                pcall(function()
                    prompt.HoldDuration = 0
                    fireproximityprompt(prompt)
                end)
            end
        end
    end
end

local function stepAutoGodMode()
    if not AutoGodModeEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return end
    local percent = (hum.Health / hum.MaxHealth) * 100
    if percent <= GodRespawnThreshold then
        pcall(function()
            local rr = ReplicatedStorage:FindFirstChild("ResetCharacter")
            if rr then rr:InvokeServer() end
        end)
        pcall(function() LocalPlayer:Kick("Auto God Mode: Respawning") end)
    end
end

local function stepXmasOpen()
    if not XmasOpenEnabled then return end
    pcall(function() ReplicatedStorage:WaitForChild("GachaCapsule"):FireServer() end)
end

local function stepXmasCollect()
    if not XmasCollectEnabled then return end
    local hrp = HumanoidRootPart
    if not hrp then return end
    local nearest, nearestDist = nil, math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "The Present" then
            local pos = obj:IsA("Model") and obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position
            local d = (hrp.Position - pos).Magnitude
            if d < nearestDist then
                nearestDist = d
                nearest = obj
            end
        end
    end
    if nearest then
        local prompt = nearest:FindFirstChildOfClass("ProximityPrompt")
        if prompt then
            prompt.HoldDuration = 0
            local target = nearest:IsA("Model") and nearest.PrimaryPart and nearest.PrimaryPart.Position + Vector3.new(0, 3, 0) or nearest.Position + Vector3.new(0, 3, 0)
            hrp.CFrame = CFrame.new(target)
            task.wait(0.1)
            fireproximityprompt(prompt)
        end
    end
end

local function stepBatchBuy()
    if not BatchBuyEnabled then return end
    local items = Config:Get("BatchBuyItems", {})
    local amounts = Config:Get("BatchBuyAmounts", {})
    for _, item in ipairs(items) do
        for _, amt in ipairs(amounts) do
            pcall(function()
                ReplicatedStorage:WaitForChild("BuyItemFromShopHourly"):FireServer(item, amt)
            end)
        end
    end
end

local function stepBatchGachaChar()
    if not BatchGachaCharEnabled then return end
    local spins = Config:Get("BatchGachaCharSpins", { "1SpinLucky", "10Spins", "1Spin" })
    for _, spin in ipairs(spins) do
        pcall(function()
            ReplicatedStorage:WaitForChild("GachaCharacter"):FireServer(spin)
        end)
    end
end

local function stepBatchGachaSkin()
    if not BatchGachaSkinEnabled then return end
    local spins = Config:Get("BatchGachaSkinSpins", { "1SpinLucky", "1Spin", "10Spins" })
    for _, spin in ipairs(spins) do
        pcall(function()
            ReplicatedStorage:WaitForChild("GachaSkins"):FireServer(spin)
        end)
    end
end

local function stepAutoBuyWeapon()
    if not AutoBuyWeaponEnabled or not SelectedWeapon then return end
    pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", SelectedWeapon) end)
end

local function stepAutoBuyMisc()
    if not AutoBuyMiscEnabled or not SelectedMiscItem then return end
    pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", SelectedMiscItem) end)
end

-- ====================== MASTERY FUNCTIONS ======================
local function getMasteryAttackSpeed()
    if ActionMode == "Slow" then return 0.25
    elseif ActionMode == "Faster" then return 0.05
    elseif ActionMode == "Flash (Lag)" then return 0.01
    else return 0.1 end
end

local function getMasteryTarget()
    if CharacterMode == "Large" then
        for _, m in ipairs(Scanner.Cache.mobs or {}) do
            if m.Name:lower():find("giant") or m.Name:lower():find("titan") or m.Name:lower():find("boss") then return m end
        end
    elseif CharacterMode == "Support (Not Good)" then
        local lowest, lowestHP = nil, math.huge
        for _, m in ipairs(Scanner.Cache.mobs or {}) do
            local hp = GetMobMaxHP(m)
            if hp > 0 and hp < lowestHP then lowestHP = hp; lowest = m end
        end
        if lowest then return lowest end
    elseif CharacterMode == "Titan" then
        local highest, highestHP = nil, 0
        for _, m in ipairs(Scanner.Cache.mobs or {}) do
            local hp = GetMobMaxHP(m)
            if hp > highestHP then highestHP = hp; highest = m end
        end
        if highest then return highest end
    end
    return GetNearestMob()
end

local function stepMasteryNoFlush()
    if not MasteryAutoFarmActive then return end
    local mob = getMasteryTarget()
    if mob and not WaitingRespawn then
        local hum = mob:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            local cf = GetTargetCFrame(mob, FarmPosition)
            if cf then
                if MasteryMovementMode == "Teleport" then tp1(cf)
                else
                    local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = cf })
                    tween:Play(); tween.Completed:Wait()
                end
            end
            pcall(function() ReplicatedStorage.LMB:FireServer() end)
            task.wait(getMasteryAttackSpeed())
        end
    end
end

local function stepMasteryFlush()
    if not MasteryAutoFarmActiveTest then return end
    local mob = getMasteryTarget()
    if mob and not WaitingRespawn then
        for _, prompt in pairs(mob:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and (prompt.ActionText == "Flush" or prompt.ActionText == "Dragon Flash") then
                pcall(function()
                    prompt.HoldDuration = 0
                    fireproximityprompt(prompt)
                end)
            end
        end
        local hum = mob:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            local cf = GetTargetCFrame(mob, FarmPosition)
            if cf then
                if MasteryMovementMode == "Teleport" then tp1(cf)
                else
                    local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear), { CFrame = cf })
                    tween:Play(); tween.Completed:Wait()
                end
            end
            pcall(function() ReplicatedStorage.LMB:FireServer() end)
        end
        task.wait(getMasteryAttackSpeed())
    end
end

-- ====================== HITBOX STEP ======================
local function stepHitboxUpdate()
    if not getgenv().HitboxEnabled then return end
    for _, mob in ipairs(Scanner.Cache.mobs or {}) do
        local hum = mob:FindFirstChildOfClass("Humanoid")
        local hrp = mob:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local existing = hrp:FindFirstChild("DYHUB_Hitbox")
            if getgenv().HitboxEnabled then
                if not existing then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "DYHUB_Hitbox"
                    box.Adornee = hrp
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                    box.Transparency = getgenv().HitboxShow and 0.5 or 1
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Parent = hrp
                else
                    existing.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                    existing.Transparency = getgenv().HitboxShow and 0.5 or 1
                end
            else
                if existing then existing:Destroy() end
            end
        end
    end
end

-- ====================== QUEST STEP FUNCTIONS ======================
local function stepAutoQuestCollect()
    if not autoQuestCollectActive then return end
    local hrp = HumanoidRootPart
    if not hrp then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
            if prompt and (prompt.ActionText:lower():find("collect") or prompt.ActionText:lower():find("take") or prompt.ActionText:lower():find("pick")) then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                if (hrp.Position - pos).Magnitude <= 50 then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    task.wait(0.05)
                    pcall(function()
                        prompt.HoldDuration = 0
                        fireproximityprompt(prompt)
                    end)
                end
            end
        end
    end
end

local function stepAutoQuestSkip()
    if not autoQuestSkipActive then return end
    pcall(function()
        local skipBtn = LocalPlayer.PlayerGui:FindFirstChild("QuestUI") and LocalPlayer.PlayerGui.QuestUI:FindFirstChild("SkipButton")
        if skipBtn and skipBtn.Visible then
            if skipBtn:IsA("TextButton") or skipBtn:IsA("ImageButton") then
                skipBtn:Activate()
            end
        end
    end)
end

-- ====================== ASTRO MODE ======================
local astroState = "IDLE"
local astroTimer = 0
local astroAngle = 0
local astroOrbitConn = nil
local astroStrikeRunning = false

local function AstroIsInLobby()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    return pg and pg:FindFirstChild("Lobby") and pg.Lobby.Enabled == true
end

local function AstroVoteAndPrepare()
    local vote = ReplicatedStorage:FindFirstChild("Vote")
    local getReady = ReplicatedStorage:FindFirstChild("GetReadyRemote")
    if vote then pcall(function() vote:FireServer("AstroV2") end) end
    task.wait(0.3)
    if getReady then pcall(function() getReady:FireServer("3", true) end) end
    task.wait(0.3)
    if getReady then pcall(function() getReady:FireServer("1", true) end) end
end

local function stepAstroMode()
    if getgenv().ACTIVE_MODE ~= "astro" then
        if astroOrbitConn then astroOrbitConn:Disconnect(); astroOrbitConn = nil end
        if astroStrikeRunning then astroStrikeRunning = false end
        astroState = "IDLE"
        return
    end
    if astroState == "IDLE" then
        if AstroIsInLobby() then AstroVoteAndPrepare(); astroState = "VOTING" end
    elseif astroState == "VOTING" then
        if not AstroIsInLobby() and LocalPlayer.Character and HumanoidRootPart then
            task.wait(2)
            local char = LocalPlayer.Character
            if char and HumanoidRootPart then
                char.Humanoid.PlatformStand = true
                astroAngle = 0
                if astroOrbitConn then astroOrbitConn:Disconnect() end
                astroOrbitConn = RunService.Heartbeat:Connect(function(dt)
                    if getgenv().ACTIVE_MODE ~= "astro" then return end
                    astroAngle = (astroAngle + AstroFlySpeed * dt) % (math.pi * 2)
                    local pos = Vector3.new(0, 250, 0) + Vector3.new(math.cos(astroAngle) * AstroFlyRadius, 0, math.sin(astroAngle) * AstroFlyRadius)
                    if HumanoidRootPart then HumanoidRootPart.CFrame = CFrame.new(pos, Vector3.new(0, 250, 0)) end
                end)
                astroStrikeRunning = true
                task.spawn(function()
                    while astroStrikeRunning and getgenv().ACTIVE_MODE == "astro" do
                        pcall(function()
                            ReplicatedStorage:FindFirstChild("VillanArcAirStrike"):FireServer(Vector3.new(-23.34, -0.19, 0.34))
                        end)
                        task.wait(1)
                    end
                end)
                astroTimer = 0
                astroState = "FLYING"
            end
        end
    elseif astroState == "FLYING" then
        astroTimer = astroTimer + 0.5
        if astroTimer >= AstroGameDuration or AstroIsInLobby() then
            if astroOrbitConn then astroOrbitConn:Disconnect(); astroOrbitConn = nil end
            astroStrikeRunning = false
            local char = LocalPlayer.Character
            if char and HumanoidRootPart then HumanoidRootPart.CFrame = CFrame.new(-23.34, -0.19, 0.34) end
            astroState = "RETURNING"
        end
    elseif astroState == "RETURNING" then
        task.wait(1)
        astroState = "IDLE"
    end
end

-- ====================== REGISTER SCHEDULER TASKS ======================
Scheduler:register("Scanner", function() ScanWorld() end, 2)
Scheduler:register("ESP", function()
    if ESP.Enabled then
        for _, m in ipairs(Scanner.Cache.mobs or {}) do UpdateESPForMob(m) end
    end
end, 3)
Scheduler:register("FlushAura", function() stepFlushAura() end, 1.5)
Scheduler:register("AutoCollect", function() stepAutoCollect() end, 0.2)
Scheduler:register("AstroMode", function() stepAstroMode() end, 0.5)
Scheduler:register("FPS", function() updateFPSDisplay() end, 0.1)
Scheduler:register("Visual", function()
    updateFullBright()
    updateNoFog()
    updateVibrant()
end, 1)
-- ====================== UI: MAIN (核心) ======================
Main:Section({ Title = T("auto_farm"), Icon = "package" })

AutoFarmToggle = Main:Toggle({
    Title = T("auto_farm"),
    Desc = T("auto_farm_desc"),
    Value = AutoFarmEnabled,
    Callback = function(state)
        AutoFarmEnabled = state
        if state then
            StartFarmLoop()
            HandleMiscOptions(MiscOptions)
            WindUI:Notify({ Title = T("auto_farm"), Content = T("farm_enabled"), Duration = 2, Icon = "play" })
        else
            AutoAttackEnabled = false
            AutoSkillEnabled = false
            AutoSkipHeliEnabled = false
            AutoFillUpEnabled = false
            FillUpRunning = false
            LockActive = false
            if AutoStartEnabled then
                StopAutoStart()
            end
            if SyncFarmOnly then
                TriggerAutoSkipHeli(false)
                WindUI:Notify({ Title = T("auto_farm"), Content = T("farm_disabled") .. " (同步模式生效)", Duration = 3, Icon = "square" })
            else
                WindUI:Notify({ Title = T("auto_farm"), Content = T("farm_disabled"), Duration = 2, Icon = "square" })
            end
        end
        Config:Set("AutoFarmEnabled", state); Config:Save()
    end
})

Main:Section({ Title = T("farm_settings"), Icon = "settings" })

PositionDropdown = Main:Dropdown({
    Title = T("stand_pos"),
    Values = { T("position_above"), T("position_under") },
    Multi = false,
    Value = FarmPosition,
    Callback = function(value) FarmPosition = value; Config:Set("FarmPosition", value); Config:Save() end
})

ModeDropdown = Main:Dropdown({
    Title = T("move_mode"),
    Values = { "Tween", "tp", "Tp", "tp1" },
    Multi = false,
    Value = FarmMode,
    Callback = function(value) FarmMode = value; Config:Set("FarmMode", value); Config:Save() end
})

MiscDropdown = Main:Dropdown({
    Title = T("aux_func"),
    Values = {
        T("auto_attack"),
        T("auto_skill"),
        T("auto_ready"),
        T("auto_skip_heli"),
        T("auto_heal"),
        T("safe_mode"),
        T("god_mode"),
        T("delete_map"),
    },
    Multi = true,
    Value = MiscOptions,
    Callback = function(values)
        MiscOptions = values
        if not AutoFarmEnabled and SyncFarmOnly then
            local hasFeatures = #values > 0
            local onlyGodOrBoost = true
            for _, v in ipairs(values) do
                if v ~= T("god_mode") and v ~= T("delete_map") then
                    onlyGodOrBoost = false
                    break
                end
            end
            if hasFeatures and not onlyGodOrBoost then
                WindUI:Notify({
                    Title = T("aux_func"),
                    Content = "请先开启自动挂机（同步模式已开启）",
                    Duration = 3, Icon = "triangle-alert"
                })
            end
        end
        HandleMiscOptions(values)
    end
})

Main:Toggle({
    Title = T("sync_mode"),
    Desc = T("sync_desc"),
    Value = SyncFarmOnly,
    Callback = function(state)
        SyncFarmOnly = state
        Config:Set("SyncFarmOnly", state)
        Config:Save()
        if state then
            WindUI:Notify({ Title = T("sync_mode"), Content = T("sync_on"), Duration = 3, Icon = "link" })
        else
            WindUI:Notify({ Title = T("sync_mode"), Content = T("sync_off"), Duration = 3, Icon = "unlink" })
            HandleMiscOptions(MiscOptions)
        end
    end
})

Main:Section({ Title = T("general_settings"), Icon = "zap" })

SkillDropdown = Main:Dropdown({
    Title = T("skill_keys"),
    Values = skillDropdownValues,
    Multi = true,
    Value = SelectedSkills,
    Callback = function(values) SelectedSkills = values; Config:Set("SelectedSkills", values); Config:Save() end
})

SkillDelaySlider = Main:Slider({
    Title = T("skill_delay"),
    Value = { Min = 1, Max = 30, Default = SkillDelay },
    Step = 1,
    Callback = function(value) SkillDelay = value; Config:Set("SkillDelay", value); Config:Save() end
})

FarmHeightSlider = Main:Slider({
    Title = T("height_offset"),
    Value = { Min = -30, Max = 30, Default = HeightValue },
    Step = 1,
    Callback = function(value)
        HeightValue = value; Config:Set("HeightValue", value); Config:Save()
        for mob, _ in pairs(MobHeightOverride) do
            if MobConfirmedPadding[mob] == nil then MobHeightOverride[mob] = nil end
        end
    end
})

Main:Slider({
    Title = T("safe_hp"),
    Value = { Min = 1, Max = 100, Default = SafeValue },
    Step = 1,
    Callback = function(value) SafeValue = value; Config:Set("SafeValue", value); Config:Save() end
})

Main:Slider({
    Title = T("god_hp"),
    Value = { Min = 1, Max = 99, Default = GodModeValue },
    Step = 1,
    Callback = function(value)
        GodModeValue = value
        Config:Set("GodModeValue", value)
        Config:Save()
    end
})

-- ====================== UI: PRIORITY SETTINGS ======================
Main:Section({ Title = T("priority_settings"), Icon = "list-ordered" })

Main:Paragraph({
    Title = T("priority_order"),
    Desc = T("priority_desc"),
    Image = "rbxassetid://104487529937663",
    ImageSize = 26,
})

Main:Slider({
    Title = T("high_hp_threshold"),
    Value = { Min = 1, Max = 100000, Default = HighHPThreshold },
    Step = 100,
    Callback = function(value)
        HighHPThreshold = value
        Config:Set("HighHPThreshold", value)
        Config:Save()
        print("[DYHUB] 高血量阈值已设置为 " .. value)
    end
})

-- ====================== UI: OVERRIDE SETTINGS ======================
Main:Section({ Title = T("override_settings"), Icon = "ruler" })

PaddingReduceInput = Main:Input({
    Title = T("padding_reduce"),
    Default = tostring(PADDING_REDUCE_STEP),
    Placeholder = "默认: 2",
    Callback = function(text)
        local num = tonumber(text)
        if num then PADDING_REDUCE_STEP = num; Config:Set("PaddingReduceStep", num); Config:Save()
        else warn("输入的数字无效") end
    end
})

PaddingSafeInput = Main:Input({
    Title = T("padding_safe"),
    Default = tostring(PADDING_SAFE_MIN),
    Placeholder = "默认: -30",
    Callback = function(text)
        local num = tonumber(text)
        if num then PADDING_SAFE_MIN = num; Config:Set("PaddingSafeMin", num); Config:Save()
        else warn("输入的数字无效") end
    end
})

Main:Slider({
    Title = T("anti_clip_margin"),
    Value = { Min = 0, Max = 10, Default = ANTI_CLIP_MARGIN },
    Step = 1,
    Callback = function(value)
        ANTI_CLIP_MARGIN = value; Config:Set("AntiClipMargin", value); Config:Save()
    end
})

Main:Slider({
    Title = T("dmg_threshold"),
    Value = { Min = 1, Max = 500, Default = DMG_THRESHOLD },
    Step = 1,
    Callback = function(value)
        DMG_THRESHOLD = value; Config:Set("DmgThreshold", value); Config:Save()
    end
})

Main:Button({
    Title = T("reset_override"),
    Desc = "清除所有已保存的怪物高度位置",
    Callback = function()
        MobConfirmedPadding = {}
        MobHeightOverride = {}
        WindUI:Notify({ Title = T("override_settings"), Content = "所有已确认位置已清除", Duration = 2, Icon = "refresh-cw" })
    end
})

-- ====================== UI: FLUSH SETTINGS ======================
Main:Section({ Title = T("flush_settings"), Icon = "toilet" })

Main:Slider({
    Title = T("flush_range"),
    Value = { Min = 1, Max = 15, Default = flushAuraRange },
    Step = 1,
    Callback = function(value) flushAuraRange = value; Config:Set("FlushAuraValue", value); Config:Save() end
})

Main:Toggle({
    Title = T("flush_aura"),
    Desc = "自动触发范围内的冲水提示",
    Value = flushAuraEnabled,
    Callback = function(enabled)
        flushAuraEnabled = enabled; Config:Set("flushaura", enabled); Config:Save()
    end
})

-- ====================== UI: RISKY FEATURES ======================
Main:Section({ Title = T("risky_features"), Icon = "flame" })

Main:Toggle({
    Title = T("motion_prediction"),
    Desc = T("motion_prediction_desc"),
    Value = MotionPredictionEnabled,
    Callback = function(value)
        MotionPredictionEnabled = value
        Config:Set("MotionPredictionEnabled", value)
        Config:Save()
    end
})

Main:Toggle({
    Title = T("follow_mode"),
    Desc = T("follow_mode_desc"),
    Value = FollowModeEnabled,
    Callback = function(value)
        FollowModeEnabled = value
        Config:Set("FollowModeEnabled", value)
        Config:Save()
    end
})

Main:Toggle({
    Title = T("rotate_90"),
    Desc = T("rotate_90_desc"),
    Value = Rotate90Enabled,
    Callback = function(value)
        Rotate90Enabled = value
        Config:Set("Rotate90Enabled", value)
        Config:Save()
    end
})

Main:Toggle({
    Title = T("auto_god_mode"),
    Desc = T("auto_god_mode_desc"),
    Value = AutoGodModeEnabled,
    Callback = function(value)
        AutoGodModeEnabled = value
        Config:Set("AutoGodModeEnabled", value)
        Config:Save()
        if value then
            Scheduler:register("AutoGodMode", stepAutoGodMode, 2)
        else
            Scheduler:unregister("AutoGodMode")
        end
    end
})

Main:Slider({
    Title = T("god_respawn_threshold"),
    Value = { Min = 1, Max = 100, Default = GodRespawnThreshold },
    Step = 1,
    Callback = function(value)
        GodRespawnThreshold = value
        Config:Set("GodRespawnThreshold", value)
        Config:Save()
    end
})

-- ====================== UI: ESP TAB ======================
Main4:Section({ Title = T("esp_visual"), Icon = "eye" })

EspEnableToggle = Main4:Toggle({
    Title = T("esp_enable"),
    Value = ESP.Enabled,
    Desc = "启用所有透视效果",
    Callback = function(state)
        ESP.Enabled = state; Config:Set("EspEnabled", state); Config:Save()
        if state then StartESPLoop() else StopESPLoop() end
    end
})

EspMobToggle = Main4:Toggle({
    Title = T("esp_mob"),
    Value = ESP.MobEnabled,
    Desc = "在怪物上方显示高亮和标签",
    Callback = function(state)
        ESP.MobEnabled = state; Config:Set("EspMobEnabled", state); Config:Save()
        if not state then
            for mob, _ in pairs(ESP._mobHighlights) do
                pcall(function()
                    local hl = mob:FindFirstChild("DYHUB_ESP_HIGHLIGHT"); if hl then hl:Destroy() end
                end)
            end
            ESP._mobHighlights = {}
        end
    end
})

EspPlayerToggle = Main4:Toggle({
    Title = T("esp_player"),
    Value = ESP.PlayerEnabled,
    Desc = "在其他玩家上方显示高亮和标签",
    Callback = function(state)
        ESP.PlayerEnabled = state; Config:Set("EspPlayerEnabled", state); Config:Save()
        if not state then
            for char, _ in pairs(ESP._playerHighlights) do
                pcall(function()
                    local hl = char:FindFirstChild("DYHUB_ESP_HIGHLIGHT"); if hl then hl:Destroy() end
                end)
            end
            ESP._playerHighlights = {}
        end
    end
})

EspItemToggle = Main4:Toggle({
    Title = T("esp_item"),
    Value = ESP.ItemEnabled,
    Desc = "在可收集物品上显示高亮和标签",
    Callback = function(state)
        ESP.ItemEnabled = state; Config:Set("EspItemEnabled", state); Config:Save()
        if not state then
            for obj, _ in pairs(ESP._itemHighlights) do
                pcall(function()
                    local hl = obj:FindFirstChild("DYHUB_ESP_HIGHLIGHT"); if hl then hl:Destroy() end
                end)
            end
            ESP._itemHighlights = {}
        end
    end
})

Main4:Dropdown({
    Title = "ESP 模式",
    Values = { "Highlight", "BoxHandle" },
    Multi = false,
    Value = ESP.ESPMode,
    Callback = function(value)
        ESP.ESPMode = value; Config:Set("EspMode", value); Config:Save()
    end
})

Main4:Section({ Title = T("esp_settings"), Icon = "settings" })

EspSettingsDropdown = Main4:Dropdown({
    Title = "透视选项",
    Multi = true,
    Values = {
        T("esp_highlight"),
        T("esp_distance"),
        T("esp_health"),
        T("esp_name"),
    },
    Value = ESP.Settings,
    Callback = function(value)
        ESP.Settings = value or {}; Config:Set("EspSettings", value); Config:Save()
        if ESP.Enabled then ClearAllESP() end
    end,
})

EspItemDropdown = Main4:Dropdown({
    Title = "透视物品",
    Multi = true,
    Values = ESP.ItemList,
    Value = ESP.SelectedItems,
    Callback = function(value)
        ESP.SelectedItems = value or {}; Config:Set("EspSelectedItems", value); Config:Save()
        for obj, _ in pairs(ESP._itemHighlights) do
            pcall(function()
                local hl = obj:FindFirstChild("DYHUB_ESP_HIGHLIGHT"); if hl then hl:Destroy() end
            end)
        end
        ESP._itemHighlights = {}
    end,
})

-- ====================== UI: PLAYER TAB ======================
Main2:Section({ Title = T("local_player"), Icon = "user" })

Main2:Slider({
    Title = T("walk_speed"),
    Value = { Min = 1, Max = 200, Default = WSValue },
    Step = 1,
    Callback = function(value) WSValue = value; Config:Set("WSValue", value); Config:Save(); updatePlayerStats() end
})

Main2:Slider({
    Title = T("jump_power"),
    Value = { Min = 1, Max = 500, Default = JPValue },
    Step = 1,
    Callback = function(value) JPValue = value; Config:Set("JPValue", value); Config:Save(); updatePlayerStats() end
})

Main2:Toggle({
    Title = T("no_clip"),
    Value = NoClip,
    Desc = "允许角色穿过墙壁和部件",
    Callback = function(state) NoClip = state; Config:Set("NoClip", state); Config:Save() end
})

local infJumpEnabled = false
Main2:Toggle({
    Title = T("infinity_jump"),
    Value = infJumpEnabled,
    Callback = function(v)
        infJumpEnabled = v
        if v then
            if infJumpConnection then infJumpConnection:Disconnect() end
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

Main2:Toggle({
    Title = T("fly"),
    Value = flying,
    Callback = function(v)
        flying = v
        if v then startFly()
        else
            if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
            if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
        end
    end
})

Main2:Slider({
    Title = T("fly_speed_label"),
    Value = { Min = 10, Max = 200, Default = flySpeed },
    Step = 5,
    Callback = function(v) flySpeed = v end
})

Main2:Section({ Title = T("redeem_codes"), Icon = "bird" })

local SelectedCodes = Config:Get("SelectedCodes", {})

CodeDropdown = Main2:Dropdown({
    Title = "选择兑换码",
    Multi = true,
    Values = GlobalTables.redeemCodes,
    Value = SelectedCodes,
    Callback = function(value) SelectedCodes = value or {}; Config:Set("SelectedCodes", value); Config:Save() end,
})

Main2:Button({
    Title = T("redeem_selected"),
    Desc = "只兑换下拉框中选中的代码",
    Callback = function()
        for _, code in ipairs(SelectedCodes or {}) do
            pcall(function() ReplicatedStorage:WaitForChild("RedeemCode"):FireServer(code); task.wait(0.2) end)
        end
    end,
})

Main2:Button({
    Title = T("redeem_all"),
    Desc = "一次性兑换所有可用代码",
    Callback = function()
        for _, code in ipairs(GlobalTables.redeemCodes or {}) do
            pcall(function() ReplicatedStorage:WaitForChild("RedeemCode"):FireServer(code); task.wait(0.5) end)
        end
    end,
})

-- ====================== UI: UNLOCK GAMEPASS ======================
Main2:Section({ Title = T("unlock_gamepass"), Icon = "badge-dollar-sign" })

local SelectedGamepass = Config:Get("SelectedGamepass", {})
GlobalTables.Gamepassts = SelectedGamepass

GamepassDropdown = Main2:Dropdown({
    Title = "选择通行证",
    Multi = true,
    Values = GlobalTables.Gamepasst,
    Value = SelectedGamepass,
    Callback = function(value)
        GlobalTables.Gamepassts = value or {}
        SelectedGamepass = value or {}
        Config:Set("SelectedGamepass", value)
        Config:Save()
    end,
})

Main2:Button({
    Title = T("unlock_selected"),
    Desc = "本地解锁选中的游戏通行证",
    Callback = function()
        local gachaData = LocalPlayer:FindFirstChild("GachaData")
        if not gachaData then
            gachaData = Instance.new("Folder")
            gachaData.Name = "GachaData"
            gachaData.Parent = LocalPlayer
        end
        local toUnlock = {}
        for _, v in ipairs(GlobalTables.Gamepassts) do
            if v == "全部" then
                toUnlock = {"LuckyBoost", "RareLuckyBoost", "LegendaryLuckyBoost"}
                break
            else
                table.insert(toUnlock, v)
            end
        end
        if #toUnlock == 0 then
            WindUI:Notify({ Title = T("unlock_gamepass"), Content = "请先选择通行证", Duration = 3, Icon = "alert-triangle" })
            return
        end
        local successCount = 0
        for _, gamepassName in ipairs(toUnlock) do
            pcall(function()
                local boolValue = gachaData:FindFirstChild(gamepassName)
                if not boolValue then
                    boolValue = Instance.new("BoolValue")
                    boolValue.Name = gamepassName
                    boolValue.Parent = gachaData
                end
                boolValue.Value = true
                successCount = successCount + 1
                task.wait(0.2)
            end)
        end
        WindUI:Notify({
            Title = T("unlock_gamepass"),
            Content = "已解锁 " .. successCount .. "/" .. #toUnlock .. " 个通行证",
            Duration = 3,
            Icon = "badge-check"
        })
    end,
})

-- ====================== UI: MASTERY TAB ======================
MasteryTab:Section({ Title = T("mastery_title"), Icon = "book-open" })

MasteryTab:Dropdown({
    Title = T("mastery_move_mode"),
    Values = { "Teleport", "CFrame" },
    Default = MasteryMovementMode,
    Multi = false,
    Callback = function(v)
        MasteryMovementMode = v
        Config:Set("MasteryMovementMode", v)
        Config:Save()
    end
})

MasteryTab:Dropdown({
    Title = T("attack_speed"),
    Values = { "Default", "Slow", "Faster", "Flash (Lag)" },
    Default = ActionMode,
    Callback = function(v)
        ActionMode = v
        Config:Set("ActionMode", v)
        Config:Save()
    end
})

MasteryTab:Dropdown({
    Title = T("mastery_char_type"),
    Values = { "Small", "Large", "Support (Not Good)", "Titan" },
    Default = CharacterMode,
    Callback = function(v)
        CharacterMode = v
        Config:Set("CharacterMode", v)
        Config:Save()
    end
})

MasteryTab:Dropdown({
    Title = T("stand_pos"),
    Values = { "Spin", "Above", "Back", "Under", "Front" },
    Default = FarmPosition,
    Callback = function(v)
        FarmPosition = v
        Config:Set("FarmPosition", v)
        Config:Save()
    end
})

MasteryTab:Slider({
    Title = T("mastery_distance"),
    Value = { Min = 0, Max = 50, Default = getgenv().DistanceValue or 1 },
    Step = 1,
    Callback = function(val)
        getgenv().DistanceValue = val
        Config:Set("DistanceValue", val)
        Config:Save()
    end
})

MasteryTab:Toggle({
    Title = T("mastery_no_flush"),
    Default = MasteryAutoFarmActive,
    Callback = function(v)
        MasteryAutoFarmActive = v
        if v then
            Scheduler:register("MasteryNoFlush", stepMasteryNoFlush, 0.3)
        else
            Scheduler:unregister("MasteryNoFlush")
        end
    end
})

MasteryTab:Toggle({
    Title = T("mastery_flush"),
    Default = MasteryAutoFarmActiveTest,
    Callback = function(v)
        MasteryAutoFarmActiveTest = v
        if v then
            Scheduler:register("MasteryFlush", stepMasteryFlush, 0.3)
        else
            Scheduler:unregister("MasteryFlush")
        end
    end
})

-- ====================== UI: HITBOX TAB ======================
HitboxTab:Section({ Title = T("hitbox_title"), Icon = "crosshair" })

HitboxTab:Button({
    Title = T("hitbox_scan"),
    Callback = function()
        for _, mob in ipairs(Scanner.Cache.mobs or {}) do
            if mob:IsA("Model") and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                if not Players:GetPlayerFromCharacter(mob) then
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Name = "DYHUB_Hitbox"
                        box.Adornee = hrp
                        box.AlwaysOnTop = true
                        box.ZIndex = 10
                        box.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                        box.Transparency = getgenv().HitboxShow and 0.5 or 1
                        box.Color3 = Color3.fromRGB(255, 0, 0)
                        box.Parent = hrp
                    end
                end
            end
        end
        WindUI:Notify({ Title = T("hitbox_title"), Content = "扫描完成", Duration = 2 })
    end
})

HitboxTab:Slider({
    Title = T("hitbox_size"),
    Value = { Min = 16, Max = 100, Default = getgenv().HitboxSize },
    Step = 1,
    Callback = function(val)
        getgenv().HitboxSize = val
        Config:Set("HitboxSize", val)
        Config:Save()
    end
})

HitboxTab:Toggle({
    Title = T("hitbox_enable"),
    Default = getgenv().HitboxEnabled,
    Callback = function(v)
        getgenv().HitboxEnabled = v
        Config:Set("HitboxEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("Hitbox", stepHitboxUpdate, 3)
        else
            Scheduler:unregister("Hitbox")
        end
    end
})

HitboxTab:Toggle({
    Title = T("hitbox_show"),
    Default = getgenv().HitboxShow,
    Callback = function(v)
        getgenv().HitboxShow = v
        Config:Set("HitboxShow", v)
        Config:Save()
    end
})

-- ====================== UI: QUEST TAB ======================
QuestTab:Section({ Title = T("quest_title"), Icon = "album" })

QuestTab:Button({
    Title = T("quest_open_clock"),
    Callback = function()
        local gui = LocalPlayer.PlayerGui:FindFirstChild("QuestClockManUI")
        if gui then gui.Enabled = not gui.Enabled end
    end
})

QuestTab:Button({
    Title = T("quest_open_quest"),
    Callback = function()
        local gui = LocalPlayer.PlayerGui:FindFirstChild("QuestUI")
        if gui then gui.Enabled = not gui.Enabled end
    end
})

QuestTab:Section({ Title = "任务自动设置", Icon = "star-half" })

QuestTab:Toggle({
    Title = T("quest_auto_collect"),
    Default = autoQuestCollectActive,
    Callback = function(v)
        autoQuestCollectActive = v
        if v then
            Scheduler:register("AutoQuestCollect", stepAutoQuestCollect, 4)
        else
            Scheduler:unregister("AutoQuestCollect")
        end
    end
})

QuestTab:Toggle({
    Title = T("quest_auto_skip"),
    Default = autoQuestSkipActive,
    Callback = function(v)
        autoQuestSkipActive = v
        if v then
            Scheduler:register("AutoQuestSkip", stepAutoQuestSkip, 4)
        else
            Scheduler:unregister("AutoQuestSkip")
        end
    end
})

-- ====================== UI: SHOP TAB ======================
Main5:Section({ Title = T("shop_weapon"), Icon = "helicopter" })

local currentWeaponEn = Config:Get("SelectedWeapon", "Stungun")
local weaponDisplayMap = {}
for ch, en in pairs(GlobalTables.WeaponInternal) do weaponDisplayMap[en] = ch end

WeaponDropdown = Main5:Dropdown({
    Title = T("weapon_select"),
    Values = GlobalTables.WeaponDisplay,
    Multi = false,
    Value = weaponDisplayMap[currentWeaponEn] or "电击枪",
    Callback = function(chineseValue)
        local englishValue = GlobalTables.WeaponInternal[chineseValue]
        if englishValue then
            SelectedWeapon = englishValue
            Config:Set("SelectedWeapon", englishValue)
            Config:Save()
        end
    end
})

AutoBuyWeaponToggle = Main5:Toggle({
    Title = T("auto_buy_weapon"),
    Value = AutoBuyWeaponEnabled,
    Callback = function(enabled)
        AutoBuyWeaponEnabled = enabled
        Config:Set("AutoBuyWeaponEnabled", enabled)
        Config:Save()
        if enabled then
            Scheduler:register("AutoBuyWeapon", stepAutoBuyWeapon, 10)
        else
            Scheduler:unregister("AutoBuyWeapon")
        end
    end
})

Main5:Button({
    Title = T("buy_weapon_once"),
    Callback = function()
        if SelectedWeapon then
            pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", SelectedWeapon) end)
        end
    end
})

Main5:Section({ Title = T("shop_misc"), Icon = "shopping-cart" })

local currentMiscEn = Config:Get("SelectedMiscItem", "HeadPhone")
local miscDisplayMap = {}
for ch, en in pairs(GlobalTables.MiscInternal) do miscDisplayMap[en] = ch end

MiscShopDropdown = Main5:Dropdown({
    Title = T("misc_select"),
    Values = GlobalTables.MiscDisplay,
    Multi = false,
    Value = miscDisplayMap[currentMiscEn] or "耳机",
    Callback = function(chineseValue)
        local englishValue = GlobalTables.MiscInternal[chineseValue]
        if englishValue then
            SelectedMiscItem = englishValue
            Config:Set("SelectedMiscItem", englishValue)
            Config:Save()
        end
    end
})

AutoBuyMiscToggle = Main5:Toggle({
    Title = T("auto_buy_misc"),
    Value = AutoBuyMiscEnabled,
    Callback = function(enabled)
        AutoBuyMiscEnabled = enabled
        Config:Set("AutoBuyMiscEnabled", enabled)
        Config:Save()
        if enabled then
            Scheduler:register("AutoBuyMisc", stepAutoBuyMisc, 10)
        else
            Scheduler:unregister("AutoBuyMisc")
        end
    end
})

Main5:Button({
    Title = T("buy_misc_once"),
    Callback = function()
        if SelectedMiscItem then
            pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", SelectedMiscItem) end)
        end
    end
})

Main5:Section({ Title = T("batch_section"), Icon = "rocket" })

Main5:Toggle({
    Title = T("batch_buy"),
    Desc = T("batch_buy_desc"),
    Value = BatchBuyEnabled,
    Callback = function(v)
        BatchBuyEnabled = v
        Config:Set("BatchBuyEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("BatchBuy", stepBatchBuy, 0.2)
        else
            Scheduler:unregister("BatchBuy")
        end
    end
})

Main5:Dropdown({
    Title = T("batch_items"),
    Multi = true,
    Values = (function()
        local list = {}
        pcall(function()
            for _, gear in ipairs(game:GetService("ReplicatedFirst"):WaitForChild("Gears"):GetChildren()) do
                table.insert(list, gear.Name)
            end
        end)
        return list
    end)(),
    Callback = function(v)
        Config:Set("BatchBuyItems", v)
        Config:Save()
    end
})

Main5:Dropdown({
    Title = T("batch_amount"),
    Multi = true,
    Values = { "1", "2", "3", "4", "5", "10", "20" },
    Callback = function(v)
        Config:Set("BatchBuyAmounts", v)
        Config:Save()
    end
})

Main5:Section({ Title = T("batch_gacha_section"), Icon = "gem" })

Main5:Toggle({
    Title = T("batch_gacha_char"),
    Value = BatchGachaCharEnabled,
    Callback = function(v)
        BatchGachaCharEnabled = v
        Config:Set("BatchGachaCharEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("BatchGachaChar", stepBatchGachaChar, 0.2)
        else
            Scheduler:unregister("BatchGachaChar")
        end
    end
})

Main5:Dropdown({
    Title = T("batch_char_spins"),
    Multi = true,
    Values = { "1SpinLucky", "10Spins", "1Spin" },
    Callback = function(v)
        Config:Set("BatchGachaCharSpins", v)
        Config:Save()
    end
})

Main5:Toggle({
    Title = T("batch_gacha_skin"),
    Value = BatchGachaSkinEnabled,
    Callback = function(v)
        BatchGachaSkinEnabled = v
        Config:Set("BatchGachaSkinEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("BatchGachaSkin", stepBatchGachaSkin, 0.2)
        else
            Scheduler:unregister("BatchGachaSkin")
        end
    end
})

Main5:Dropdown({
    Title = T("batch_skin_spins"),
    Multi = true,
    Values = { "1SpinLucky", "1Spin", "10Spins" },
    Callback = function(v)
        Config:Set("BatchGachaSkinSpins", v)
        Config:Save()
    end
})

-- ====================== UI: COLLECT TAB ======================
Main6:Section({ Title = T("collect_section"), Icon = "package" })

AutoCollectToggle = Main6:Toggle({
    Title = T("auto_collect"),
    Value = AutoCollectEnabled,
    Desc = "自动收集地图上出现的选定物品",
    Callback = function(state)
        AutoCollectEnabled = state; Config:Set("AutoCollectEnabled", state); Config:Save()
        if state then KnownCollectItems = {} end
    end
})

Main6:Toggle({
    Title = T("item_notify"),
    Value = itemNotifyEnabled,
    Callback = function(v)
        itemNotifyEnabled = v
        Config:Set("ItemNotifyEnabled", v)
        Config:Save()
    end
})

Main6:Section({ Title = T("collect_settings"), Icon = "settings" })

CollectItemDropdown = Main6:Dropdown({
    Title = "收集物品",
    Values = CollectItems,
    Multi = true,
    Value = SelectedCollectItems,
    Callback = function(values) SelectedCollectItems = values or {}; Config:Set("SelectedCollectItems", values); Config:Save() end
})

CollectModeDropdown = Main6:Dropdown({
    Title = T("collect_mode"),
    Values = { T("collect_clean"), T("collect_idgf") },
    Multi = false,
    Value = CollectMode,
    Callback = function(value) CollectMode = value; Config:Set("CollectMode", value); Config:Save() end
})

-- ====================== UI: GAMEMODE TAB ======================
Main7:Section({ Title = T("vote_system"), Icon = "gamepad-2" })

Main7:Button({
    Title = T("restore_vote"),
    Callback = function()
        pcall(function()
            ReplicatedStorage.GetReadyRemote:FireServer("3", true)
            task.wait(1.25)
            ReplicatedStorage.GetReadyRemote:FireServer("3", false)
            task.wait(0.67)
            ReplicatedStorage.GetReadyRemote:FireServer("2", true)
            task.wait(1.25)
            ReplicatedStorage.GetReadyRemote:FireServer("2", false)
            task.wait(0.67)
            ReplicatedStorage.GetReadyRemote:FireServer("1", true)
        end)
        task.wait(6)
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(-220, 3, -600)
            end
        end)
        task.wait(10)
        pcall(function()
            ReplicatedStorage.GetReadyRemote:FireServer("3", true)
            task.wait(1.25)
            ReplicatedStorage.GetReadyRemote:FireServer("3", false)
            task.wait(0.67)
            ReplicatedStorage.GetReadyRemote:FireServer("2", true)
            task.wait(1.25)
            ReplicatedStorage.GetReadyRemote:FireServer("2", false)
        end)
        WindUI:Notify({ Title = T("restore_vote"), Content = "投票系统已恢复", Duration = 3, Icon = "check-circle" })
    end
})

GameModeDropdown2 = Main7:Dropdown({
    Title = T("set_vote_mode"),
    Values = GlobalTables.Votes,
    Multi = false,
    Value = AutoVoteValue,
    Callback = function(value) AutoVoteValue = value; Config:Set("AutoVoteValue", value); Config:Save() end
})

AutoVoteIGToggle = Main7:Toggle({
    Title = T("auto_vote_ig"),
    Desc = "每回合自动为选定模式投票",
    Value = AutoVoteinGameEnabled,
    Callback = function(enabled)
        AutoVoteinGameEnabled = enabled; Config:Set("AutoVoteinGameEnabled", enabled); Config:Save()
        SetupAutoVote_InGame(enabled)
    end
})

Main7:Divider()

Main7:Section({ Title = T("mode_switch") })

Main7:Button({
    Title = T("switch_farm"),
    Callback = function()
        getgenv().ACTIVE_MODE = "farm"
        Config:Set("ActiveMode", "farm")
        Config:Save()
        WindUI:Notify({ Title = T("mode_switch"), Content = "已切换到自动挂机模式", Duration = 2 })
    end
})

Main7:Button({
    Title = T("switch_astro"),
    Callback = function()
        getgenv().ACTIVE_MODE = "astro"
        Config:Set("ActiveMode", "astro")
        Config:Save()
        WindUI:Notify({ Title = T("mode_switch"), Content = "已切换到天文币刷取模式", Duration = 2 })
    end
})

Main7:Section({ Title = T("astro_params"), Icon = "settings" })

Main7:Slider({
    Title = T("astro_duration"),
    Value = { Min = 60, Max = 3600, Default = AstroGameDuration },
    Step = 30,
    Callback = function(v) AstroGameDuration = v; Config:Set("AstroGameDuration", v); Config:Save() end
})

Main7:Slider({
    Title = T("astro_radius"),
    Value = { Min = 50, Max = 1000, Default = AstroFlyRadius },
    Step = 50,
    Callback = function(v) AstroFlyRadius = v; Config:Set("AstroFlyRadius", v); Config:Save() end
})

Main7:Slider({
    Title = T("astro_speed"),
    Value = { Min = 0.5, Max = 10, Default = AstroFlySpeed },
    Step = 0.5,
    Callback = function(v) AstroFlySpeed = v; Config:Set("AstroFlySpeed", v); Config:Save() end
})

Main7:Section({ Title = T("auto_game_mode"), Icon = "gamepad-2" })

GameModeDropdown = Main7:Dropdown({
    Title = T("select_game_mode"),
    Values = GlobalTables.ModeDisplay,
    Multi = false,
    Value = (function()
        for ch, en in pairs(GlobalTables.ModeInternal) do
            if en == AutoGameValue then return ch end
        end
        return "普通模式"
    end)(),
    Callback = function(chineseValue)
        local englishValue = GlobalTables.ModeInternal[chineseValue]
        if englishValue then
            AutoGameValue = englishValue
            Config:Set("AutoGameValue", englishValue)
            Config:Save()
        end
    end
})

AutoVoteToggle = Main7:Toggle({
    Title = T("auto_game_mode_toggle"),
    Desc = "在大厅时自动创建选定的游戏模式",
    Value = AutoVoteEnabled,
    Callback = function(enabled)
        AutoVoteEnabled = enabled
        Config:Set("AutoVoteEnabled", enabled)
        Config:Save()
    end
})

-- ====================== UI: EXTRA TAB ======================
ExtraTab:Section({ Title = T("extra_auto"), Icon = "zap" })

ExtraTab:Toggle({
    Title = T("auto_rebirth"),
    Desc = "死亡后自动重生",
    Value = AutoRebirthEnabled,
    Callback = function(v)
        AutoRebirthEnabled = v
        Config:Set("AutoRebirthEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("AutoRebirth", stepAutoRebirth, 4)
        else
            Scheduler:unregister("AutoRebirth")
        end
    end
})

ExtraTab:Toggle({
    Title = T("auto_daily"),
    Value = AutoDailyEnabled,
    Callback = function(v)
        AutoDailyEnabled = v
        Config:Set("AutoDailyEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("AutoDaily", stepAutoDaily, 300)
        else
            Scheduler:unregister("AutoDaily")
        end
    end
})

ExtraTab:Toggle({
    Title = T("auto_chest"),
    Value = AutoChestEnabled,
    Callback = function(v)
        AutoChestEnabled = v
        Config:Set("AutoChestEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("AutoChest", stepAutoChest, 4)
        else
            Scheduler:unregister("AutoChest")
        end
    end
})

ExtraTab:Toggle({
    Title = T("show_cpu_ping"),
    Value = ShowCPU,
    Callback = function(v)
        ShowCPU = v
        Config:Set("ShowCPU", v)
        Config:Save()
    end
})

ExtraTab:Toggle({
    Title = T("auto_reconnect"),
    Value = ReconnectOnDisconnect,
    Callback = function(v)
        ReconnectOnDisconnect = v
        Config:Set("ReconnectOnDisconnect", v)
        Config:Save()
    end
})

-- ====================== UI: XMAS TAB ======================
XmasTab:Section({ Title = T("xmas_title"), Icon = "gift" })

XmasTab:Toggle({
    Title = T("xmas_open"),
    Value = XmasOpenEnabled,
    Callback = function(v)
        XmasOpenEnabled = v
        Config:Set("XmasOpenEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("XmasOpen", stepXmasOpen, 0.05)
        else
            Scheduler:unregister("XmasOpen")
        end
    end
})

XmasTab:Toggle({
    Title = T("xmas_collect"),
    Value = XmasCollectEnabled,
    Callback = function(v)
        XmasCollectEnabled = v
        Config:Set("XmasCollectEnabled", v)
        Config:Save()
        if v then
            Scheduler:register("XmasCollect", stepXmasCollect, 1)
        else
            Scheduler:unregister("XmasCollect")
        end
    end
})

XmasTab:Button({
    Title = T("xmas_open_now"),
    Callback = function()
        for i = 1, 100 do
            pcall(function()
                ReplicatedStorage:WaitForChild("GachaCapsule"):FireServer()
            end)
            task.wait(0.01)
        end
        WindUI:Notify({ Title = T("xmas_title"), Content = "已打开100个礼物", Duration = 2 })
    end
})

-- ====================== UI: MISC VISUAL TAB ======================
MiscTab:Section({ Title = T("visual_section"), Icon = "eye" })

MiscTab:Toggle({
    Title = T("fullbright"),
    Value = fullBrightEnabled,
    Callback = function(v)
        fullBrightEnabled = v
        updateFullBright()
    end
})

MiscTab:Toggle({
    Title = T("nofog"),
    Value = noFogEnabled,
    Callback = function(v)
        noFogEnabled = v
        updateNoFog()
    end
})

MiscTab:Toggle({
    Title = T("vibrant"),
    Value = vibrantEnabled,
    Callback = function(v)
        vibrantEnabled = v
        updateVibrant()
    end
})

MiscTab:Toggle({
    Title = T("show_fps"),
    Value = showFPS,
    Callback = function(v)
        showFPS = v
        if fpsText then fpsText.Visible = v end
    end
})

MiscTab:Toggle({
    Title = T("show_ping"),
    Value = showPing,
    Callback = function(v)
        showPing = v
        if msText then msText.Visible = v end
    end
})

MiscTab:Button({
    Title = T("fps_boost"),
    Callback = function()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.Brightness = 2
            Lighting.FogEnd = 100
            Lighting.GlobalShadows = false
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            Lighting.ClockTime = 14
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 1
            end
            for _, obj in ipairs(Lighting:GetDescendants()) do
                if obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") or obj:IsA("BlurEffect") then
                    obj.Enabled = false
                end
            end
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then part.CastShadow = false end
            end
        end)
        WindUI:Notify({ Title = T("fps_boost"), Content = "已应用", Duration = 2 })
    end
})

-- ====================== UI: SETTINGS TAB ======================
Main3:Section({ Title = T("language"), Icon = "globe" })

Main3:Dropdown({
    Title = T("language"),
    Values = { "Chinese", "English", "Russian", "Portuguese" },
    Default = currentLanguage,
    Multi = false,
    Callback = function(v)
        currentLanguage = v
        Config:Set("Language", v)
        Config:Save()
        WindUI:Notify({ Title = T("language"), Content = "已切换到 " .. v, Duration = 2 })
    end
})

Main3:Section({ Title = T("save_settings"), Icon = "save" })

Main3:Button({
    Title = T("save_now"),
    Desc = "将所有当前设置保存到配置文件",
    Callback = function()
        Config:Save()
        WindUI:Notify({ Title = T("save_config"), Content = "保存成功", Duration = 2, Icon = "save" })
    end
})

local function RestartAutoSave()
    if autoSaveThread then task.cancel(autoSaveThread); autoSaveThread = nil end
    if AutoSaveEnabled then
        autoSaveThread = task.spawn(function()
            while AutoSaveEnabled do
                task.wait(AutoSaveDelay)
                Config:Save()
            end
        end)
    end
end

Main3:Toggle({
    Title = T("auto_save_config"),
    Value = AutoSaveEnabled,
    Desc = "按设定间隔自动保存配置",
    Callback = function(state)
        AutoSaveEnabled = state
        Config:Set("AutoSaveEnabled", state)
        Config:Save()
        RestartAutoSave()
    end
})

Main3:Input({
    Title = T("save_interval"),
    Default = tostring(AutoSaveDelay),
    Placeholder = "15",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 1 then
            AutoSaveDelay = num
            Config:Set("AutoSaveDelay", num)
            Config:Save()
            RestartAutoSave()
        end
    end
})

Main3:Section({ Title = T("server_status"), Icon = "server" })

Main3:Button({
    Title = T("server_hop"),
    Desc = "传送到此游戏的其他随机服务器",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local servers = {}
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
        end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    table.insert(servers, server.id)
                end
            end
        end
        if #servers > 0 then
            WindUI:Notify({ Title = T("server_hop"), Content = "正在传送...", Duration = 2, Icon = "server" })
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        else
            WindUI:Notify({ Title = T("server_hop"), Content = "未找到可用服务器", Duration = 3, Icon = "alert-triangle" })
        end
    end
})

Main3:Button({
    Title = T("rejoin"),
    Desc = "重新加入当前游戏服务器",
    Callback = function()
        WindUI:Notify({ Title = T("rejoin"), Content = "正在重连...", Duration = 2, Icon = "refresh-cw" })
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

Main3:Section({ Title = T("others"), Icon = "settings" })

NoBarrierToggle = Main3:Toggle({
    Title = T("bypass_barrier"),
    Value = noBarrierActive,
    Desc = "尝试绕过隐形边界",
    Callback = function(value)
        noBarrierActive = value; Config:Set("NoBarrier", value); Config:Save()
        if value then startNoBarrier() else stopNoBarrier() end
    end
})

local antiafk = Main3:Toggle({
    Title = T("anti_afk"),
    Value = AntiAFK,
    Desc = "防止因长时间不动被踢出游戏",
    Callback = function(enabled)
        AntiAFK = enabled; Config:Set("AntiAfk", enabled); Config:Save()
        if enabled then
            task.spawn(function()
                game.Players.LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                while AntiAFK do
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    task.wait(60)
                end
            end)
        end
    end
})
-- ====================== 辅助函数（保证完整性）======================
-- 这些函数已在之前定义，此处作为确认
local function HasHumanoid(obj)
    if obj:IsA("Model") then
        return obj:FindFirstChildOfClass("Humanoid") ~= nil
    end
    return false
end

local function IsLivingDescendant(obj)
    local current = obj
    while current and current ~= workspace do
        if current:IsA("Model") and current:FindFirstChildOfClass("Humanoid") then
            return true
        end
        current = current.Parent
    end
    return false
end

local function TeleportToIdle()
    LockActive = false
    task.wait(0.1)
    WaitingRespawn = true
    pcall(function()
        Character:PivotTo(IdlePosition)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    end)
end

-- ProximityPrompt 激活辅助
local function ActivateProximityPrompt(prompt)
    pcall(function()
        prompt.HoldDuration = 0
        prompt.MaxActivationDistance = 50
        if fireproximityprompt then fireproximityprompt(prompt) end
        prompt:InputHoldBegin()
        task.wait(0.05)
        prompt:InputHoldEnd()
    end)
end

local function ActivateAllFlushPrompts()
    pcall(function()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Model") then
                local prompt = part:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    local actionText = prompt.ActionText:lower()
                    if actionText:find("flush") or actionText:find("flash") or actionText:find("dragon") then
                        ActivateProximityPrompt(prompt)
                    end
                end
            end
        end
    end)
end

-- 玩家血量辅助
local function GetPlayerHPInfo()
    local humanoid = Character and Character:FindFirstChild("Humanoid")
    if not humanoid then return 100, 100 end
    return humanoid.Health, humanoid.MaxHealth
end

local function IsPlayerHPFull()
    local hp, maxHp = GetPlayerHPInfo()
    if maxHp <= 0 then return true end
    return hp >= maxHp
end

local function GetPlayerHealthPercent()
    local humanoid = Character and Character:FindFirstChild("Humanoid")
    if not humanoid then return 100 end
    if humanoid.MaxHealth <= 0 then return 100 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

-- 自动开局函数
local function StartAutoStart()
    AutoStartEnabled = true
    RefreshVoteAndStartSetup()
end

local function StopAutoStart()
    AutoStartEnabled = false
    RefreshVoteAndStartSetup()
end

-- 自动投票与开局刷新（来自基线）
local _voteRespawnConn = nil
local _syncRespawnConn = nil
local _voteIGRespawnConn = nil

local function FireVote_Solo()
    if not AutoGameValue then return end
    pcall(function()
        ReplicatedStorage.MainHandler:FireServer({ [1] = "StartSolo", [2] = AutoGameValue })
    end)
end

local function FireGetReady()
    task.wait(2.5)
    pcall(function() ReplicatedStorage.GetReadyRemote:FireServer("1", true) end)
end

local function FireVote_InGame()
    if not AutoVoteValue then return end
    pcall(function() ReplicatedStorage.Vote:FireServer(AutoVoteValue) end)
end

local function SetupSyncVoteAndStart()
    if _voteRespawnConn then _voteRespawnConn:Disconnect(); _voteRespawnConn = nil end
    if _syncRespawnConn then _syncRespawnConn:Disconnect(); _syncRespawnConn = nil end
    FireVote_Solo()
    task.spawn(function()
        task.wait(2.5)
        if AutoVoteEnabled and AutoStartEnabled then FireGetReady() end
    end)
    _syncRespawnConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.5)
        if AutoVoteEnabled and AutoStartEnabled then
            FireVote_Solo()
            task.spawn(function()
                task.wait(2.5)
                if AutoVoteEnabled and AutoStartEnabled then FireGetReady() end
            end)
        end
    end)
end

local function SetupAutoVote_SoloOnly(enabled)
    if _voteRespawnConn then _voteRespawnConn:Disconnect(); _voteRespawnConn = nil end
    if not enabled then return end
    FireVote_Solo()
    _voteRespawnConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.5)
        if AutoVoteEnabled and not AutoStartEnabled then FireVote_Solo() end
    end)
end

local function SetupAutoStartOnly(enabled)
    if AutoStartConnection then AutoStartConnection:Disconnect(); AutoStartConnection = nil end
    if not enabled then return end
    FireGetReady()
    AutoStartConnection = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if AutoStartEnabled and not AutoVoteEnabled then task.spawn(FireGetReady) end
    end)
end

local function RefreshVoteAndStartSetup()
    if _voteRespawnConn   then _voteRespawnConn:Disconnect();   _voteRespawnConn   = nil end
    if _syncRespawnConn   then _syncRespawnConn:Disconnect();   _syncRespawnConn   = nil end
    if AutoStartConnection then AutoStartConnection:Disconnect(); AutoStartConnection = nil end

    if AutoVoteEnabled and AutoStartEnabled then
        SetupSyncVoteAndStart()
    elseif AutoVoteEnabled and not AutoStartEnabled then
        SetupAutoVote_SoloOnly(true)
    elseif not AutoVoteEnabled and AutoStartEnabled then
        SetupAutoStartOnly(true)
    end
end

local function SetupAutoVote_InGame(enabled)
    if _voteIGRespawnConn then _voteIGRespawnConn:Disconnect(); _voteIGRespawnConn = nil end
    if not enabled then return end
    FireVote_InGame()
    _voteIGRespawnConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.5)
        if AutoVoteinGameEnabled then FireVote_InGame() end
    end)
end

-- 边界绕过函数
local function startNoBarrier()
    if noBarrierConnection then return end
    noBarrierConnection = RunService.Heartbeat:Connect(function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local pos = hrp.Position
            if math.abs(pos.X) > 1000 or math.abs(pos.Y) > 1000 or math.abs(pos.Z) > 1000 then
                hrp.CFrame = CFrame.new(Vector3.new(0, 50, 0))
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Health = humanoid.MaxHealth end
            end
        end)
    end)
end

local function stopNoBarrier()
    if noBarrierConnection then
        noBarrierConnection:Disconnect()
        noBarrierConnection = nil
    end
end

-- 玩家属性更新函数
local function updatePlayerStats()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WSValue
        LocalPlayer.Character.Humanoid.JumpPower = JPValue
    end
end

-- 角色重生回调
LocalPlayer.CharacterAdded:Connect(function(char)
    Character        = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Client           = LocalPlayer
    MobHeightOverride   = {}
    MobConfirmedPadding = {}
    MobLastHealth       = {}
    task.wait(1)
    local cam = workspace.CurrentCamera
    cam.CameraSubject = HumanoidRootPart
    cam.CameraType    = Enum.CameraType.Custom
    updatePlayerStats()
    if NoClip then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- NoClip 持续检查
RunService.Stepped:Connect(function()
    if NoClip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ====================== 自动大厅逻辑 ======================
task.spawn(function()
    local playBtn = workspace:FindFirstChild("ForGui") and workspace.ForGui:FindFirstChild("SurfaceGui") and workspace.ForGui.SurfaceGui:FindFirstChild("Frame") and workspace.ForGui.SurfaceGui.Frame:FindFirstChild("Play")
    if playBtn then
        WindUI:Notify({ Title = "自动开始", Content = "检测到开始按钮，自动启动...", Duration = 2 })
        task.wait(1)
        local playGui = pg:FindFirstChild("Play")
        if not (playGui and playGui.Enabled) then
            pcall(function() playBtn:Activate() end)
            WindUI:Notify({ Title = "自动开始", Content = "已按下开始按钮", Duration = 2 })
        end
    end
    task.wait(1)
    local playGui = pg:FindFirstChild("Play")
    if playGui and playGui.Enabled then
        local classicBtn = playGui:FindFirstChild("Classic")
        if classicBtn then
            task.wait(1)
            pcall(function() classicBtn:Activate() end)
        end
        task.wait(1)
        local modeGui = pg:FindFirstChild("mode select2")
        if modeGui and modeGui.Enabled then
            local diffBtn = modeGui:FindFirstChild("MainFrame") and modeGui.MainFrame:FindFirstChild("DiffMode")
            if diffBtn then pcall(function() diffBtn:Activate() end) end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        local loadingGui = pg:FindFirstChild("LoadingScreen")
        if loadingGui then pcall(function() loadingGui:Destroy() end) end
        local lobby = pg:FindFirstChild("Lobby")
        if lobby and lobby.Enabled then
            local btn = lobby:FindFirstChild("MainFrame") and lobby.MainFrame:FindFirstChild("Frame") and lobby.MainFrame.Frame:FindFirstChild("Create") and lobby.MainFrame.Frame.Create:FindFirstChild("TrackQuestButton")
            if btn and btn.Visible then
                pcall(function() btn:Activate() end)
                task.wait(0.5)
                if AutoVoteEnabled then
                    ReplicatedStorage.MainHandler:FireServer({ [1] = "StartSolo", [2] = AutoGameValue })
                    WindUI:Notify({ Title = "大厅系统", Content = "游戏模式已创建", Duration = 2 })
                end
                break
            end
        end
    end
end)

-- ====================== 防挂机启动 ======================
if AntiAFK then
    task.spawn(function()
        game.Players.LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        while AntiAFK do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            task.wait(60)
        end
    end)
end

-- 边界绕过初始状态
if noBarrierActive then
    startNoBarrier()
end

-- ====================== 自动功能恢复 ======================
if AutoFarmEnabled then
    task.wait(2)
    StartFarmLoop()
    HandleMiscOptions(MiscOptions)
end

if ESP.Enabled then
    task.wait(2)
    StartESPLoop()
end

if AutoBuyWeaponEnabled then
    Scheduler:register("AutoBuyWeapon", stepAutoBuyWeapon, 10)
end

if AutoBuyMiscEnabled then
    Scheduler:register("AutoBuyMisc", stepAutoBuyMisc, 10)
end

if AutoCollectEnabled then
    task.wait(2)
end

if AutoVoteEnabled or AutoStartEnabled then
    RefreshVoteAndStartSetup()
end

if AutoVoteinGameEnabled then
    SetupAutoVote_InGame(true)
end

if AutoRebirthEnabled then
    Scheduler:register("AutoRebirth", stepAutoRebirth, 4)
end

if AutoDailyEnabled then
    Scheduler:register("AutoDaily", stepAutoDaily, 300)
end

if AutoChestEnabled then
    Scheduler:register("AutoChest", stepAutoChest, 4)
end

if AutoGodModeEnabled then
    Scheduler:register("AutoGodMode", stepAutoGodMode, 2)
end

if XmasOpenEnabled then
    Scheduler:register("XmasOpen", stepXmasOpen, 0.05)
end

if XmasCollectEnabled then
    Scheduler:register("XmasCollect", stepXmasCollect, 1)
end

if BatchBuyEnabled then
    Scheduler:register("BatchBuy", stepBatchBuy, 0.2)
end

if BatchGachaCharEnabled then
    Scheduler:register("BatchGachaChar", stepBatchGachaChar, 0.2)
end

if BatchGachaSkinEnabled then
    Scheduler:register("BatchGachaSkin", stepBatchGachaSkin, 0.2)
end

if MasteryAutoFarmActive then
    Scheduler:register("MasteryNoFlush", stepMasteryNoFlush, 0.3)
end

if MasteryAutoFarmActiveTest then
    Scheduler:register("MasteryFlush", stepMasteryFlush, 0.3)
end

if getgenv().HitboxEnabled then
    Scheduler:register("Hitbox", stepHitboxUpdate, 3)
end

if autoQuestCollectActive then
    Scheduler:register("AutoQuestCollect", stepAutoQuestCollect, 4)
end

if autoQuestSkipActive then
    Scheduler:register("AutoQuestSkip", stepAutoQuestSkip, 4)
end

-- 自动保存重启
RestartAutoSave()

-- ====================== 启动调度器 ======================
Scheduler:start()

-- FPS/Ping 显示初始化
initFPSDisplay()

-- ====================== 最终输出 ======================
print("[DYHUB] 至尊版加载成功！")
print("[DYHUB] 版本 " .. version .. " " .. ver .. " | 无后门 | 全功能整合")
print("[DYHUB] 调度器已启动 | ESP已优化 | 多语言就绪")

-- 暴露全局变量
getgenv().DYHUB = {
    Window = Window,
    Config = Config,
    Scheduler = Scheduler,
    Ready = true,
}
