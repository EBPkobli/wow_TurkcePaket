
--Görev ID dinleyecisi--
function GorevVar(self,event,...)		 								--Buraya görünmez Gorev_Dinleyicisi panelinden geldim
	local gorevDetaylari={}
	MOBIDSAYACI=2
	if(event=="QUEST_DETAIL")then
		GorevNumarasi=GetQuestID() 										--Görev numarasını evrensel değişkene atadık bir çok yerde ayırt etmek amacıyla kullanacağız.
		GorevMenuAyiklaAc(GorevAlirkenCeviri)
	elseif(event=="SUPER_TRACKED_QUEST_CHANGED")then
		GorevNumarasi=select(1,...)		 				   			    --SUPER_TRACKED_QUEST_CHANGED olayının 2.argümenti(değişkeni 0,1 diye gidiyor) Görev numarasını taşıyor.
	elseif(event=="QUEST_PROGRESS")then
		GorevNumarasi=GetQuestID()
		GorevMenuAyiklaAc(GorevProgressCeviri)
		getglobal("3DPANELIM"):Hide()
	elseif(event=="QUEST_COMPLETE")then									--Görev bittiğinde çalışacak olay...
		--metinleriTemizle()
		GorevNumarasi=GetQuestID() 
		GorevMenuAyiklaAc(GorevBitisCeviri)
		getglobal("3DPANELIM"):Hide()
	else
		print("Bu olayı "..event.." tanımıyorum!")
	end
end
--Görev ID dinleyecisi--

--POPUP MENU TAKIBI--
local POPUPTakip=true
function GuncelTakip(self,elapsed)										--OnUpdate olayının girdiği fonksiyon dikkatli kodlanmalı sürekli olarak bu fonksiyon çağıralacak....
	
	--Orijinal görev frame takip--
	if((QuestFrame:IsShown()==false) and (QuestLogPopupDetailFrame:IsShown()==false))then							
		if((getglobal("GorevAnaPanel"):IsShown()) or (getglobal("butonPanel"):IsShown()))then
		getglobal("GorevAnaPanel"):Hide()
		getglobal("butonPanel"):Hide()
		metinleriTemizle()
		end
	end
	--Orijinal görev frame takip--
	
	--Orijinal Pop MENU Takip--
	if(QuestLogPopupDetailFrame:IsShown())then							--Sadece bir kere çalışsın diye Takip diye bir bool değişkene ihtiyaç duydum...(Yoksa sürekli olarak tekrar edip oyunu patlatacak)
		if(POPUPTakip==true)then
			POPUPTakip=false
			GorevMenuAyiklaAc(GorevAlirkenCeviri)						--POPUPTakip'i false ederek 1 kere çalıştın bir daha çalışma dedik....
		end
	else
		POPUPTakip=true
	
	end
	--Orijinal Pop MENU Takip--
end
--POPUP MENU TAKIBI--


--Farenin topuyla scrollu döndürme--
function ScrollDondurme(self, delta)
	local AnlikDeger = getglobal("GorevPanelSlider"):GetValue()						--Scroll kaydıracının anlık yerini aldık ve gerçekleşebilmesi için işlemlere tabii tuttum
	if(delta<0)and(AnlikDeger<ScrollMaksimumBoyut)then
		self:SetVerticalScroll(AnlikDeger+(ScrollMaksimumBoyut/10))
		getglobal("GorevPanelSlider"):SetValue(AnlikDeger+(ScrollMaksimumBoyut/10))
	elseif (delta>0)and(AnlikDeger>0)then
		self:SetVerticalScroll(AnlikDeger-(ScrollMaksimumBoyut/10))
		getglobal("GorevPanelSlider"):SetValue(AnlikDeger-(ScrollMaksimumBoyut/10))
	end
end
--Farenin topuyla scrollu döndürme--


--Farenin sol tikiyle sürükle bırak--
function ScrollSurukleBirak(self,value)
	self:GetParent():SetVerticalScroll(value)
end
--Farenin sol tikiyle sürükle bırak--

--Butonlar basıldığında buraya gelecekler--
function butonClick(self,event)
	local yaziDegerleri =diziAra(GorevAlirkenCeviri,self:GetText(),2)							--Butonun adından tüm değerlerini okuttuk 
	metinleriDoldur(yaziDegerleri,FontAyarlari.BaslikRenk,FontAyarlari.YaziRenk)
	getglobal("GorevAnaPanel"):Show()
	--ModelYukle()
	self:GetParent():Hide()
end
--Butonlar basıldığında buraya gelecekler--

--Oluşturulmuş yazı metinlerini doldurma fonksiyonu--
function metinleriDoldur(Degerler,BaslikRenk,YaziRenk)
	metinleriTemizle()
	local BoslukSayisi=0	--Enter boşluklarını yakalayıp onlar içinde pixel ayırmak için
	local BoslukGenislik=0	--Buda genişliği hesap edip pixel işlemlerine koyacağımız değer
	for i=0,(#Degerler[0]-3) do
		if((i%2)==1)then
			--print(Degerler[0][i+3])
			_, BoslukSayisi = string.gsub(Degerler[0][i+3],"<br/>","<br/>")
			BoslukGenislik=(BoslukSayisi/2)*FontAyarlari.YaziGenislik
			ToplamYaziPixel=ToplamYaziPixel+FontBoyutAyari(FontAyarlari.YaziGenislik,#Degerler[0][i+3],CumleBasinaDusenHarf)+20+BoslukGenislik
			getglobal("metin"..i):SetHeight(FontBoyutAyari(FontAyarlari.YaziGenislik,#Degerler[0][i+3],CumleBasinaDusenHarf)+20+BoslukGenislik)
			getglobal("metin"..i):SetFont(FontAyarlari.Yazi,FontAyarlari.YaziGenislik,"OUTLINE")
			getglobal("metin"..i):SetText("<html><body><p>"..YaziRenk..Degerler[0][i+3].."</p></body></html>")
		else
			ToplamYaziPixel=ToplamYaziPixel+FontAyarlari.BaslikGenislik+5
			getglobal("metin"..i):SetHeight(FontAyarlari.BaslikGenislik+5)
			getglobal("metin"..i):SetFont(FontAyarlari.Baslik,FontAyarlari.BaslikGenislik)
			getglobal("metin"..i):SetText("<html><body><p>"..BaslikRenk..Degerler[0][i+3].."</p></body></html>")
		end
	end
	ScrollFramePixelAyari(325)
end
--Oluşturulmuş yazı metinlerini doldurma fonksiyonu--

--Model için sonraki önceki butonlar--
local BilgiTasi={}
function SonrakiButonClickEvent(self,event)
	--#ModelBilgileri 5 adet var
	if(MOBIDSAYACI+1<#BilgiTasi[0])then
		MOBIDSAYACI=MOBIDSAYACI+2
		getglobal("3DPANELIMNPCADI"):SetText("|cFFFF0000"..BilgiTasi[0][MOBIDSAYACI+1])
		getglobal("3DNPCMODELIM"):SetCreature(BilgiTasi[0][MOBIDSAYACI])
		getglobal("btnOnceki"):Enable()
		if(MOBIDSAYACI+1==#BilgiTasi[0])then
			self:Disable()
		end
	end
end
function OncekiButonClickEvent(self,event)
	if(MOBIDSAYACI>2)then
		MOBIDSAYACI=MOBIDSAYACI-2
		getglobal("3DPANELIMNPCADI"):SetText("|cFFFF0000"..BilgiTasi[0][MOBIDSAYACI+1])
		getglobal("3DNPCMODELIM"):SetCreature(BilgiTasi[0][MOBIDSAYACI])
		getglobal("btnSonraki"):Enable()
		if(MOBIDSAYACI==2)then
			self:Disable()
		end
	end
end
--Model için sonraki önceki butonlar--
function ModelYukle(ModelBilgileri)
	BilgiTasi = ModelBilgileri
	if(ModelBilgileri~=0)then
		getglobal("3DPANELIMNPCADI"):SetText("|cFFFF0000"..ModelBilgileri[0][MOBIDSAYACI+1])
		getglobal("3DNPCMODELIM"):SetCreature(ModelBilgileri[0][MOBIDSAYACI])
		getglobal("3DPANELIM"):Show()
		if(#ModelBilgileri[0]>3)then
			getglobal("btnSonraki"):Show()
			getglobal("btnOnceki"):Show()
			getglobal("btnSonraki"):Enable()
			getglobal("btnOnceki"):Disable()
		else
			getglobal("btnSonraki"):Hide()
			getglobal("btnOnceki"):Hide()
		end
	else
		getglobal("3DPANELIM"):Hide()
	end
end