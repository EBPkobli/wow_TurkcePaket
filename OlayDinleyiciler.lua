--G�rev olaylar� dinleyicisi

Gorev_Dinleyicisi = CreateFrame("Frame") 						--G�r�nmez boyutu olmayan arka planda �al��an bir Panel
Gorev_Dinleyicisi:RegisterEvent("QUEST_DETAIL") 				--QUEST_DETAIL olay�n� dinliyor
Gorev_Dinleyicisi:RegisterEvent("SUPER_TRACKED_QUEST_CHANGED")  --SUPER_TRACKED_QUEST_CHANGED olay�n�da dinliyor
Gorev_Dinleyicisi:RegisterEvent("QUEST_PROGRESS") 				--QUEST_PROGRESS olay�n�da dinliyor
Gorev_Dinleyicisi:RegisterEvent("QUEST_COMPLETE")				--G�rev bitti�indeki gelecek olay...
Gorev_Dinleyicisi:SetScript("OnEvent",GorevVar)		   		    --GorevVar Fonksiyonuna y�nlendiriyor...
Gorev_Dinleyicisi:SetScript("OnUpdate",GuncelTakip)				--Update fonksiyonu yani s�rekli d�nen fonksiyonda bir takip ger�ekle�tiriyor.

--------------------------------