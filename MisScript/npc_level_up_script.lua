--[[ Script para NPC de Aumento de Nível em Tales of Pirates ]]

-- Este script permite que um jogador abaixo do Nível 100 escolha entre ir para o Nível 55 ou Nível 100.
-- É necessário adaptar os valores de EXP_TO_LEVEL_55 e EXP_TO_LEVEL_100 de acordo com a sua versão do servidor.

-- Defina os valores de experiência necessários para atingir os níveis desejados.
-- Estes são valores PLACEHOLDER. Você DEVE substituí-los pelos valores corretos do seu servidor.
local EXP_TO_LEVEL_55 = 19674240  -- Exemplo: Experiência total necessária para o Nível 55
local EXP_TO_LEVEL_100 = 4176709541 -- Exemplo: Experiência total necessária para o Nível 100

-- Função principal do NPC
function NpcLevelUpFunction()
    -- Verifica o nível atual do jogador
    InitTrigger()
    TriggerCondition(1, LvCheck, ">=", 100) -- Condição: Jogador já é Nível 100 ou superior
    TriggerAction(1, JumpPage, 4)           -- Ação: Vai para a página de diálogo de 


nível máximo

    TriggerCondition(2, LvCheck, "<", 100)  -- Condição: Jogador está abaixo do Nível 100
    TriggerAction(2, JumpPage, 1)           -- Ação: Vai para a página de diálogo principal

    -- Página 1: Diálogo principal e opções de escolha
    MISSCRIPT_NPC_LEVELUP_MAIN_TALK = GetResString("MISSCRIPT_NPC_LEVELUP_MAIN_TALK")
    Talk(1, MISSCRIPT_NPC_LEVELUP_MAIN_TALK)
    
    MISSCRIPT_NPC_LEVELUP_OPTION_55 = GetResString("MISSCRIPT_NPC_LEVELUP_OPTION_55")
    Text(1, MISSCRIPT_NPC_LEVELUP_OPTION_55, JumpPage, 2) -- Opção: Ir para Nível 55
    
    MISSCRIPT_NPC_LEVELUP_OPTION_100 = GetResString("MISSCRIPT_NPC_LEVELUP_OPTION_100")
    Text(1, MISSCRIPT_NPC_LEVELUP_OPTION_100, JumpPage, 3) -- Opção: Ir para Nível 100
    
    MISSCRIPT_NPC_LEVELUP_OPTION_CANCEL = GetResString("MISSCRIPT_NPC_LEVELUP_OPTION_CANCEL")
    Text(1, MISSCRIPT_NPC_LEVELUP_OPTION_CANCEL, CloseTalk) -- Opção: Cancelar

    -- Página 2: Confirmar Nível 55
    MISSCRIPT_NPC_LEVELUP_CONFIRM_55 = GetResString("MISSCRIPT_NPC_LEVELUP_CONFIRM_55")
    Talk(2, MISSCRIPT_NPC_LEVELUP_CONFIRM_55)
    
    InitTrigger()
    TriggerAction(1, AddExp, EXP_TO_LEVEL_55, 1) -- Ação: Adiciona EXP para Nível 55
    TriggerAction(1, JumpPage, 5)                -- Ação: Vai para a página de sucesso
    Text(2, "Confirmar", MultiTrigger, GetMultiTrigger(), 1)
    Text(2, "Cancelar", CloseTalk)

    -- Página 3: Confirmar Nível 100
    MISSCRIPT_NPC_LEVELUP_CONFIRM_100 = GetResString("MISSCRIPT_NPC_LEVELUP_CONFIRM_100")
    Talk(3, MISSCRIPT_NPC_LEVELUP_CONFIRM_100)
    
    InitTrigger()
    TriggerAction(1, AddExp, EXP_TO_LEVEL_100, 1) -- Ação: Adiciona EXP para Nível 100
    TriggerAction(1, JumpPage, 5)                 -- Ação: Vai para a página de sucesso
    Text(3, "Confirmar", MultiTrigger, GetMultiTrigger(), 1)
    Text(3, "Cancelar", CloseTalk)

    -- Página 4: Jogador já é Nível 100 ou superior
    MISSCRIPT_NPC_LEVELUP_ALREADY_MAX = GetResString("MISSCRIPT_NPC_LEVELUP_ALREADY_MAX")
    Talk(4, MISSCRIPT_NPC_LEVELUP_ALREADY_MAX)
    Text(4, "Ok.", CloseTalk)

    -- Página 5: Sucesso na mudança de nível
    MISSCRIPT_NPC_LEVELUP_SUCCESS = GetResString("MISSCRIPT_NPC_LEVELUP_SUCCESS")
    Talk(5, MISSCRIPT_NPC_LEVELUP_SUCCESS)
    Text(5, "Obrigado!", CloseTalk)
end


