print("|cFFFF0000Türkçe Addon Aktif|r")
print("Yapımcı : Furkan KUBILAY")
print("|cFFFF0000Saygılarımla :)")


--Yazıları Panele Sığdırmak İçin Gereken Fonksiyon--
function FontBoyutAyari(FontBoyutu,ToplamHarfSayisi,CumleHarfSayisi)
	return (ToplamHarfSayisi/CumleHarfSayisi)*FontBoyutu
end
--Yazıları Panele Sığdırmak İçin Gereken Fonksiyon--

--Dizi içinde arama fonksiyonu(Çevirilerin için Görev Numarasına göre arayacak fonksiyon...)--
function diziAra(aranacakDizi,aranacakSey,aranacakSeyYeri)
	local diziSayaci=0
	local donusDizisi={}
	for i=0,#aranacakDizi do
		if(tostring(aranacakDizi[i][aranacakSeyYeri])==tostring(aranacakSey))then
			donusDizisi[diziSayaci]=aranacakDizi[i]
			diziSayaci=diziSayaci+1
		end
	end
	if(diziSayaci==0)then
		
		return 0
	else
		
		return donusDizisi
	end
end
--Dizi içinde arama fonksiyonu(Çevirilerin için Görev Numarasına göre arayacak fonksiyon...)--

--Dizi içindeki belli yerlerdeki kelimeleri dönecek(çeviri isimlerini alabilmek için kullanacağım)--
function diziKelimeAyikla(dizi,Yer)
	local donusDizisi={}
	for i=0,#dizi do
		donusDizisi[i]=dizi[i][Yer]
	end
	return donusDizisi
end
--Dizi içindeki belli yerlerdeki kelimeleri dönecek(çeviri isimlerini alabilmek için kullanacağım)--

--Herhangi bir frame,nesne değerini bir değişkene atıyor
function frameDegerleri(self)
	if(self.name=="SkrollFrame")then
		SkrollFrameSelf=self
	end	
end
--Herhangi bir frame,nesne değerini bir değişkene atıyor

function ScrollFramePixelAyari(FrameBoyut)
	ScrollMaksimumBoyut=ToplamYaziPixel-FrameBoyut+HataPayi
	if(ScrollMaksimumBoyut<=0)then
		getglobal("GorevPanelSlider"):Hide()
		ScrollMaksimumBoyut=0
	end
	getglobal("GorevPanelSlider"):SetMinMaxValues(0,ScrollMaksimumBoyut)
	ToplamYaziPixel=0
end

function GorevMenuAyiklaAc(hangiCeviri)
	local cevirmenDizisi={}
	local ModelBilgileri={}
	MOBIDSAYACI=2
	gorevDetaylari=diziAra(hangiCeviri,GorevNumarasi,1)		--Diziden gorev numarası tutan gorevleri çektik(var ise)
	if(gorevDetaylari~=0)then
		ModelBilgileri=diziAra(ModelNumaralari,GorevNumarasi,1)			--Diziden model ile gerekli bilgileri çektik (model 3 boyutlu canavarlar)
		if(#gorevDetaylari>0)then										--Eğer numarası tutan bir den fazla çeviri var ise çevirmenlerin adlarını almalıyım
			cevirmenDizisi=diziKelimeAyikla(gorevDetaylari,2)			--Burda da tüm çevirmenleri aldım					
			for i=0,#cevirmenDizisi do									--Tek tek ayıklıyorum
				butonPanel.diziButon[i]:SetText(cevirmenDizisi[i])
				butonPanel.diziButon[i]:Show()
				for j=(i+1),6 do
					butonPanel.diziButon[j]:Hide()						--8 Adet buton var sadece isimleri değişiyor geri kalanı saklanıyor neden belli başlı var der iseniz wow widget(butonlar paneller görünen her şey)leri silmeye izin vermiyor eğer sürekli oluşturup silmez iseniz programın performansı baya baya düşer oyunu kastırır...
				end
			end
			butonPanel:Show()
			ModelYukle(ModelBilgileri)									--Modeli yükleyen fonksiyon
		else
			--Sadece 1 çevirmen var direk görev panelini çıkarmalıyım...
			gorevDetaylari=diziAra(hangiCeviri,GorevNumarasi,1)	
			metinleriDoldur(gorevDetaylari,FontAyarlari.BaslikRenk,FontAyarlari.YaziRenk)
			ModelYukle(ModelBilgileri)
			getglobal("GorevAnaPanel"):Show()
		end
	else
		print("|cFFFF0000Çeviri bulunamadı :( |cFFFFFFFF Görev Numarası : |r"..GorevNumarasi)
	end
end

function metinleriTemizle()
	for i=0,7 do
		getglobal("metin"..i):SetText("")
	end
end
