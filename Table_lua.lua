local stopped=false
local FileNameWrite="C:\\Users\\Stas\\Desktop\\data.txt"
local FileNameRead="C:\\Users\\Stas\\Desktop\\data.txt"
function OnStop()
	stopped=true
	return	5000
end

function main()
    local TableSI=AllocTable()
	AddColumn(TableSI,1,"Дата",true,QTABLE_DATE_TYPE,10)
	AddColumn(TableSI,2,"Время",true,QTABLE_TIME_TYPE,10)
	AddColumn(TableSI,3,"Код",true,QTABLE_STRING_TYPE,10)
	AddColumn(TableSI,4,"Цена",true,QTABLE_INT_TYPE,10)
    AddColumn(TableSI,5,"Позиция",true,QTABLE_INT_TYPE,10)

	CreateWindow(TableSI)
	SetWindowCaption(TableSI,"Таблица параметров SI")
	SetWindowPos(TableSI,0,10,600,70)
	InsertRow(TableSI,-1)
	while stopped==false do
	local ServerTime=tostring(getInfoParam("SERVERTIME"))
	local TradeDate=tostring(getInfoParam("TRADEDATE"))
	local SecCode="SiM9"
	--local LastTable={}
	--local LastPrice=LastTable.param_value
	local LastPrice = getParamEx("SPBFUT", SecCode, "LAST").param_value
	local Pos=getFuturesHolding("SPBFUT","SPBFUT00848",SecCode,0)
	--local Pos = getFuturesHolding("SPBFUT","SPBFUT00d8u,SecCode, 0).totalnet
	if Pos~=nil then
	    Pos=Pos.totalnet
		else
		Pos=0
	end

	SetCell(TableSI,1,1,tostring(TradeDate))
	SetCell(TableSI,1,2,tostring(ServerTime))
	SetCell(TableSI,1,3,tostring(SecCode))
	SetCell(TableSI,1,4,tostring(LastPrice-LastPrice%1))
	SetCell(TableSI,1,5,tostring(Pos))
--~ 	local price=tostring(LastPrice-LastPrice%1)
--~ 	local code=tostring(SecCode)
--~ 	local timer=tostring(SeverTime)
--~ 	local dater=tostring(TradeDate)
--~ 	local pozition=tostring(Pos)
--~ 	local FileWrite=io.open(FileNameWrite,"w")
--~ 	FileWrite:write(ServerTime.." ")
--~ 	FileWrite:close()
--~ 	sleep(1000)
	end

    message("Скрипт остановлен")
end

