IsRun = true;
local FileNameRead=getScriptPath().."\\poz.txt"
local FileNameWrite=getScriptPath().."\\data.txt"
local FileRead
local ID
local Read
local Price_Read
local code
local Read
local ID_back
local Price_back
local direct

function OnInit()
FileRead=io.open(FileNameRead,"r")
code,ID,Price_Read=FileRead:read(4,"*n","*n")
FileRead:close()

--message(FileNameRead)
if(ID_back~=nil) then
ID_back=ID
else
ID_back=0
end

if(Price_back~=nil) then
Price_back=Price_Read*(-1)
else
Price_back=0
end
end

function unit()

local TableSI=AllocTable()
	AddColumn(TableSI,1,"����",true,QTABLE_DATE_TYPE,10)
	AddColumn(TableSI,2,"�����",true,QTABLE_TIME_TYPE,10)
	AddColumn(TableSI,3,"���",true,QTABLE_STRING_TYPE,10)
	AddColumn(TableSI,4,"����",true,QTABLE_INT_TYPE,10)
    AddColumn(TableSI,5,"�������",true,QTABLE_INT_TYPE,10)


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

      if (Price~=nil and Price~=0 and Price_back==0 or Price~=nil and Price~=0 and Price_back*Price<0) then
	  FileWrite:write(tostring(Price).." ")
 	  FileWrite:close()
	  Price_back=Price
	 end
	 end
	 if(Price_back~=0) then
	 ID_back=ID
			end
		end
	end

function main()
   while IsRun do
	unit()

--~ 	if(ID~=nil) then
	---message(tostring(ID_back))

--~ 	end
   sleep(1000);
   -- ����������� !!!(��� ����� � 1 ������������), ����� ������ ����� ������ ��������� ���������
   -- � ��� ���������� ������ ������� QUIK ����� �������� ��������� ���� ������
   end;
end;

function OnStop()
   IsRun = false;
   message("������ ����������")
end;







