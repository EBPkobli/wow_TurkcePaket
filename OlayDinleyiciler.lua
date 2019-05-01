--Görev olaylarý dinleyicisi

Gorev_Dinleyicisi = CreateFrame("Frame") 						--Görünmez boyutu olmayan arka planda çalýþan bir Panel
Gorev_Dinleyicisi:RegisterEvent("QUEST_DETAIL") 				--QUEST_DETAIL olayýný dinliyor
Gorev_Dinleyicisi:RegisterEvent("SUPER_TRACKED_QUEST_CHANGED")  --SUPER_TRACKED_QUEST_CHANGED olayýnýda dinliyor
Gorev_Dinleyicisi:RegisterEvent("QUEST_PROGRESS") 				--QUEST_PROGRESS olayýnýda dinliyor
Gorev_Dinleyicisi:RegisterEvent("QUEST_COMPLETE")				--Görev bittiðindeki gelecek olay...
Gorev_Dinleyicisi:SetScript("OnEvent",GorevVar)		   		    --GorevVar Fonksiyonuna yönlendiriyor...
Gorev_Dinleyicisi:SetScript("OnUpdate",GuncelTakip)				--Update fonksiyonu yani sürekli dönen fonksiyonda bir takip gerçekleþtiriyor.

--------------------------------