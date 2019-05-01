
--Herhangi bir panele yazı oluşturma--
function YaziOlusturma(self,yaziYeri)
	local UIYazi=self:CreateFontString(self:GetName()..yaziYeri.Yazi,"OVERLAY")
	UIYazi:SetFontObject("GameFontHighlight")
	UIYazi:SetPoint(yaziYeri.Point,self,yaziYeri.relativePoint,yaziYeri.x,yaziYeri.y)
	UIYazi:SetText(yaziYeri.Renk..yaziYeri.Yazi)--"|cFFFF0000NPC ADI")
end
--Herhangi bir panele yazı oluşturma--

--Buton oluşturma fonksiyonu--
function ButonOlusturma(self,butonBilgileri,relativeNesne,butonSirasi)
	local ButonFormu=CreateFrame("Button",butonBilgileri.Adi,self,butonBilgileri.Sinif)
	ButonFormu:SetSize(butonBilgileri.BoyutX,butonBilgileri.BoyutY)
	ButonFormu:SetPoint(butonBilgileri.Yeri,relativeNesne,butonBilgileri.relativePoint,butonBilgileri.OffsetX,butonBilgileri.OffsetY)
	ButonFormu:SetText(butonBilgileri.Yazi)
	ButonFormu:SetNormalFontObject("GameFontNormalLarge")
	ButonFormu:SetHighlightFontObject("GameFontHighlightLarge")
	ButonFormu:SetScript("OnClick",butonClick)
	self.diziButon[butonSirasi]=ButonFormu
	ButonFormu:Show()
end
--Buton oluşturma fonksiyonu--

--İlk butonları oluştururken bağımsızlıkları vardır herhangi bir butona bağımlı değillerdir...--
function BagimsizButon(self,butonBilgileri)
	local ButonFormu=CreateFrame("Button",butonBilgileri.Adi,self,butonBilgileri.Sinif)
	ButonFormu:SetSize(butonBilgileri.BoyutX,butonBilgileri.BoyutY)
	ButonFormu:SetPoint(butonBilgileri.Yeri,butonBilgileri.OffsetX,butonBilgileri.OffsetY) --Fark burda önemli bir fark
	ButonFormu:SetText(butonBilgileri.Yazi)
	ButonFormu:SetNormalFontObject("GameFontNormalLarge")
	ButonFormu:SetHighlightFontObject("GameFontHighlightLarge")
	ButonFormu:SetScript("OnClick",butonClick)
	self.diziButon[0]=ButonFormu
	ButonFormu:Show()
end
--İlk butonları oluştururken bağımsızlıkları vardır herhangi bir butona bağımlı değillerdir...--

--Panelleri oluşturan fonksiyon--
function frameYaratici(nesneTuru,parentNesne,nesneAdi,boyutX,boyutY,nesneYeri,nesneSinif)
	local UIPanel = CreateFrame(nesneTuru,nesneAdi,parentNesne,nesneSinif)
	UIPanel:SetSize(boyutX,boyutY)
	UIPanel:SetPoint(nesneYeri)
	UIPanel:SetMovable(true)
	UIPanel:EnableMouse(true)
	if(nesneTuru=="Frame")then
		UIPanel:RegisterForDrag("LeftButton")
		UIPanel:SetScript("OnDragStart", UIPanel.StartMoving)								--Frame'i hareket ettirebilmek için kullandığım fonksiyon(içinde gömülü)
		UIPanel:SetScript("OnDragStop", UIPanel.StopMovingOrSizing)
	end
	--UIPanel:Hide()
	return UIPanel
end
--Panelleri oluşturan fonksiyon--

--Butonlar silinmediği için bu yolu seçtim butonları önceden yaratıp sadece isimlerini yazdırıp gizliyeceğim--
function butonlariOlustur(anaNesne)
	butonGrubu.Adi="btn0"
	butonGrubu.Yeri="TOPLEFT"
	butonGrubu.OffsetX=10
	butonGrubu.OffsetY=-30
	butonGrubu.Yazi="0"
	BagimsizButon(anaNesne,butonGrubu)--ilk buton oluştu
	for i=1,6 do
		butonGrubu.Adi="btn"..i
		butonGrubu.Yeri="TOPLEFT"
		butonGrubu.OffsetX=0
		butonGrubu.OffsetY=0
		butonGrubu.relativePoint="BOTTOMLEFT"
		butonGrubu.Yazi=i
		ButonOlusturma(anaNesne,butonGrubu,"btn"..(i-1),i)		
	end
end
--Butonlar silinmediği için bu yolu seçtim butonları önceden yaratıp sadece isimlerini yazdırıp gizliyeceğim--

--Panellerin kayıcılarını oluşturdum burada--
function SliderOlustur(anaNesne,sliderAdi,sliderUzunluk,sliderGenislik,sliderOffsetX,sliderOffsetY,sliderMax)
	local SliderFrameDeneme = CreateFrame("Slider", sliderAdi,anaNesne, "UIPanelScrollBarTemplate") 
	SliderFrameDeneme:ClearAllPoints()
	SliderFrameDeneme:SetPoint("LEFT",anaNesne,"RIGHT", sliderOffsetX, sliderOffsetY)
	SliderFrameDeneme:SetHeight(sliderUzunluk)
	SliderFrameDeneme:SetWidth(sliderGenislik)
	SliderFrameDeneme:SetScript("OnValueChanged", ScrollSurukleBirak)
	SliderFrameDeneme:SetMinMaxValues(0, sliderMax)
	SliderFrameDeneme:SetValue(0)
end
--Panellerin kayıcılarını oluşturdum burada--

--Yazi metni oluşturuyor--
function YaziMetniOlustur(anaNesne,nesneAdi,IlkMetin,BagliMetin,MetinYazisi,MetinFont,MetinGenislik)				--Bağlı metin yani bir önceki metin neden kullandım çünkü bir birine bağlı olarak konumlanacaklar

	if(IlkMetin)then
		MetinFrame = CreateFrame("SimpleHTML",nesneAdi,anaNesne);
		MetinFrame:SetWidth(StandartMetinUzunlugu)
		MetinFrame:SetHeight(15)
		MetinFrame:SetPoint("TOPLEFT",0,-5)
		--MetinFrame:SetFont('Fonts\\FRIZQT__.ttf',12);
		--MetinFrame:SetText("<html><body><p>"..MetinYazisi.."</p></body></html>")
	else
		if(MetinYazisi~=nil)then													--Neden hiç bilmiyorum for döngüsünden 9.geliyor ve programı bozuyor(boş gleiyor)
			MetinFrame = CreateFrame("SimpleHTML",nesneAdi,anaNesne);
			MetinFrame:SetWidth(StandartMetinUzunlugu)
			MetinFrame:SetHeight(45)
			MetinFrame:SetPoint("TOPLEFT",BagliMetin,"BOTTOMLEFT",0,-5)
			--MetinFrame:SetFont('Fonts\\FRIZQT__.ttf',12);
			--MetinFrame:SetText("<html><body><p><br/><br/><br/><br/>"..MetinYazisi.."<br/><br/></p></body></html>")
		end
	end


--ScrollFrameTest_VSlider:SetMinMaxValues(0,((#DegerDenemesi/45)*13.5)*4 )
end
--Yazi metni oluşturuyor--

--8 Adet YaziMetni oluşturucam Başlık,Özet,Hikaye,HikayeninYazısı,İpucu,İpucununKendisi,Çevirmen,ÇevirmeninKendisi--
function YaziMetniniYerlestir(anaNesne)
	yaziNesnesiniTutanFrame = frameYaratici("frame",anaNesne,"YAZIPANEL",325,450,"CENTER",nil)
	for i=0,7 do
		if(i==0)then
			YaziMetniOlustur(yaziNesnesiniTutanFrame,"metin"..i,true,"","","",15)
		else
			YaziMetniOlustur(yaziNesnesiniTutanFrame,"metin"..i,false,"metin"..(i-1),"","",15)
		end
	end
	getglobal("GorevYaziAnaPanel"):SetScrollChild(yaziNesnesiniTutanFrame)
end
--8 Adet YaziMetni oluşturucam Başlık,Özet,Hikaye,HikayeninYazısı,İpucu,İpucununKendisi,Çevirmen,ÇevirmeninKendisi--

--Model oluşturan fonksiyon--

function ModelOlustur(anaNesne,yaziYerim)

	local Nesne3DPanel = CreateFrame("Frame", "3DPANELIM", anaNesne)
	Nesne3DPanel:SetPoint("BOTTOMLEFT",anaNesne,-255,0)
	Nesne3DPanel:SetSize(250, 300)
	Nesne3DPanel:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", insets = {left = 0, top = 0, right = 0, bottom = 0}, tile = true,})
	Nesne3DPanel:SetBackdropColor(0, 0, 0, 1)
	Nesne3DPanel:SetMovable(false)
	
	YaziOlusturma(Nesne3DPanel,yaziYerim)
	
	local butonSonrakiMOB=CreateFrame("Button","btnSonraki",Nesne3DPanel,"ButonSonraki")
	butonSonrakiMOB:SetSize(32,32)
	butonSonrakiMOB:SetPoint("BOTTOMRIGHT",-7,7)
	butonSonrakiMOB:SetScript("OnClick",SonrakiButonClickEvent)
	butonSonrakiMOB:Disable()

	local butonOncekiMOB=CreateFrame("Button","btnOnceki",Nesne3DPanel,"ButonOnceki")
	butonOncekiMOB:SetSize(32,32)
	butonOncekiMOB:SetPoint("BOTTOMLEFT",7,7)
	butonOncekiMOB:SetScript("OnClick",OncekiButonClickEvent)
	butonOncekiMOB:Disable()
	
	local model = CreateFrame("PlayerModel", "3DNPCMODELIM", Nesne3DPanel)
	model:SetCreature(15296)
	model:SetPoint("CENTER",0,0)
	model:SetSize(250, 250)
	model:SetMovable(false)
	
end

--Model oluşturan fonksiyon--