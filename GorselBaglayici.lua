--Bu kısımda görsel nesneleri oluşturdum--
local butonFrame 						=frameYaratici("Frame",UIParent,"butonPanel",300,325,"CENTER","BasicFrameTemplateWithInSet")				--Butonları tutan Frame
butonFrame.diziButon					={}																											--Butonları tutacak dizi
butonlariOlustur(butonFrame)																														--Butonları oluşturduk...
YaziOlusturma(butonFrame,YaziAyari)
butonFrame:Hide()
local GorevAnaPanel 					= frameYaratici("Frame",UIParent,"GorevAnaPanel",350,500,"CENTER","BasicFrameTemplateWithInSet")
GorevAnaPanel:Hide()
local GorevYaziAnaPanel 				= frameYaratici("ScrollFrame",GorevAnaPanel,"GorevYaziAnaPanel",325,450,"CENTER",nil)
local GorevSlider						= SliderOlustur(GorevYaziAnaPanel,"GorevPanelSlider",445,25,7,-6,100)
GorevYaziAnaPanel:SetScrollChild(GorevSlider)
GorevYaziAnaPanel:SetScript("OnMouseWheel",ScrollDondurme)
YaziAyari.Yazi							="AnaPanel"
local GorevAnaPanelYazi					= YaziOlusturma(GorevAnaPanel,YaziAyari)
YaziMetniniYerlestir(GorevYaziAnaPanel)
YaziAyari.Yazi							="NPCADI"
ModelOlustur(GorevAnaPanel,YaziAyari)
--Bu kısımda görsel nesneleri oluşturdum--




