IsRun = true;
local FileNameRead=getScriptPath().."\\poz.txt"
local FileNameWrite=getScriptPath().."\\data.txt"
local FileRead
local ID
local Read
local code
local Read
local ID_back
local Price_back
local direct
function OnInit()
FileRead=io.open(FileNameRead,"r")
code,ID=FileRead:read(4,"*n")
FileRead:close()
--message(FileNameRead)
ID_back=ID
end

function unit()

local TableSI=AllocTable()
	AddColumn(TableSI,1,"Äàòà",true,QTABLE_DATE_TYPE,10)
	AddColumn(TableSI,2,"Âðåìÿ",true,QTABLE_TIME_TYPE,10)
	AddColumn(TableSI,3,"Êîä",true,QTABLE_STRING_TYPE,10)
	AddColumn(TableSI,4,"Öåíà",true,QTABLE_INT_TYPE,10)
    AddColumn(TableSI,5,"Ïîçèöèÿ",true,QTABLE_INT_TYPE,10)


local ServerTime=tostring(getInfoParam("SERVERTIME"))
local TradeDate=tostring(getInfoParam("TRADEDATE"))
local SecCode=tostring(code)
--message(SecCode)
local LastPrice = getParamEx("SPBFUT", SecCode, "LAST").param_value
local Pos=getFuturesHolding("SPBFUT","SPBFUT00d8u",SecCode,0)
	if Pos~=nil then
	    Pos=Pos.totalnet
		else
		Pos=0
	end

FileRead=io.open(FileNameRead,"r")
code,ID,Read=FileRead:read(4,"*n","*n")
FileRead:close()
--message(code.." "..tostring(ID))
if(Read~=nil) then
if ID_back~=ID then
local Price
      if (Read>0) then
		Price=tonumber(LastPrice-LastPrice%1)*(-1)*Read	
--      direct=1
	  elseif (Read<0) then
	  Price=tonumber(LastPrice-LastPrice%1)*math.abs(Read)
--		direct=-1
	  end
local FileWrite=io.open(FileNameWrite,"a")
      if (Price~=nil and Price~=0) then
	  FileWrite:write(tostring(Price).." ")
 	  FileWrite:close()
	 end
	 end
	 ID_back=ID

   end
end

function main()
   while IsRun do
	unit()
--~ 	if(ID~=nil) then
--~ 	message(tostring(ID))
--~ 	end
   sleep(1000);
   -- ÎÁßÇÀÒÅËÜÍÎ !!!(ýòî ïàóçà â 1 ìèëëèñåêóíäó), ÈÍÀ×Å ÑÊÐÈÏÒ ÁÓÄÅÒ ÑÈËÜÍÎ ÍÀÃÐÓÆÀÒÜ ÏÐÎÖÅÑÑÎÐ
   -- È ÏÐÈ ÇÀÂÅÐØÅÍÈÈ ÒÀÊÎÃÎ ÑÊÐÈÏÒÀ QUIK ÌÎÆÅÒ ÀÂÀÐÈÉÍÎ ÇÀÂÅÐØÈÒÜ ÑÂÎÞ ÐÀÁÎÒÓ
   end;
end;

function OnStop()
   IsRun = false;
   message("Ñêðèïò îñòàíîâëåí")
end;







