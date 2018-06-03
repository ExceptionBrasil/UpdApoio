#Include 'Protheus.ch'
#Include 'topconn.ch'

/*
	Data : 30/06/2015 
	Autor: Daniel P Silveira
	Descr: Luke! Use the Force, use the Force!

*/

User Function UPDAPOIO()
	

	
// -----------------------------------------------------------------------------------------
// -- D E C L A R A C A O   D E   V A R I Á V E I S 
// -----------------------------------------------------------------------------------------
	Local ceol:=chr(13)+chr(10)
	Local cTable:=SPACE(3)
	Local lTdTBL:=.F.
	Local lTdEmp:=.F.
	local aEmpresas:=LoadEmps() //empresa de processamento
	Local nBoxCpos:=0
	
	
	
	//index
	Local cTable2:=Space(3)
	Local lNoExists:=.F.
	Local lRebuild:=.F.
	Local lReindex:=.F.
	Local lAllTab	:=.F.
	
	Local nBoxCpos2:=0
	Local lAllEmp:=.F.
	
	//Registra no top
	Local cTable3:=Space(3)
	
	Local nBoxCpos3:=0
	
	
	Local cTable4:=Space(10) //ZAP das Tabelas
	Local cTable5:=Space(10) //PACK NA TABELA
	Local cTable6:=Space(10)	//DROP TABLE
	
	
	Private cAviso:=""
	private nBoxexec:=0
/*
	*** CÓDIGO DA CRIAÇÃO DE CAMPOS ***
	***         variáveis           *** 
*/
	Private lReal	:=.f.
	Private lEdita:=.f.
	Private lUsado  :=.f.
	Private lBrowse :=.f.
	Private lObrig	:=.f.
	Private nBox	:= ""

	Private CpNome	:= Space (10)	//X3_CAMPO
	Private Cplabel := Space (12)	//X3_TITULO
	Private CpDescr	:= Space (25)	//X3_DESCRIC
	Private CpTam	:= 14			//X3_TAMANHO
	Private CpDeci	:= 2			//X3_DECIMAL
	Private CpMask  := Space(45)	//X3_PICTURE
	Private CpValid := Space(128)	//X3_VLDUSER
	Private CpOpcao := Space(128)	//X3_CBOXENG
	Private CpCons  := Space(03)	//X3_F3
	Private CpInic	:= Space(128)	//X3_RELACAO	
	Private CpTab	:= Space(03)	//X3_ARQUIVO
	Private aTipos	:={"C","N","D","M","L"}
	Private ntipo:="";
	

	
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	//Parte do SX3
	oDlg1      := MSDialog():New( 503,294,795,1625,"Ferramentinha TOP! v.2.3 - PRO+BR+CRACK+KeyGen+Serial+Ativado!",,,.F.,,,,,,.T.,,,.T. )
	oGrp1      := TGroup():New( 004,004,072,128,"Olha o SX3 e cria os campos a mais na base",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 016,008,{||"Tabela:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oSay2      := TSay():New( 032,008,{||"Empresa:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet1      := TGet():New( 016,032,{|u| if( Pcount()>0, cTable:= u,cTable ) },oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable",,)
	oCBox1     := TCheckBox():New( 016,084,"Todas",{|u| if( Pcount()>0, lTdTBL:= u,lTdTBL ) },oGrp1,028,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox2     := TComboBox():New( 040,008,{|u| If(PCount()>0,nBoxCpos:=u,nBoxCpos)},aEmpresas,072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
	oCBox3     := TCheckBox():New( 040,084,"Todas",{|u| if( Pcount()>0, lTdEmp:= u,lTdEmp ) },oGrp1,032,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oBtn1      := TButton():New( 056,008,"EXECUTA",oGrp1,{|| Processa({|| SX3VsSQL(cTable,lTdTBL,lTdEmp,nBoxCpos) } ) },50,012,,,,.T.,,"",,,,.F. )

	//Parte dos índices
	oGrp2      := TGroup():New( 004,132,072,264,"Cria Indices",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay3      := TSay():New( 016,136,{||"Tabela"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      := TSay():New( 008,200,{||"Empresa"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet2      := TGet():New( 016,164,{|u| if( Pcount()>0, cTable2:= u,cTable2 ) },oGrp2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable2",,)
	oCBox5     := TCheckBox():New( 036,136,"Inexistentes",{|u| if( Pcount()>0, lNoExists:=u,lNoExists ) },oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox6     := TCheckBox():New( 028,200,"Recriar tudo",{|u| if( Pcount()>0, lRebuild:=u,lRebuild ) },oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox7     := TCheckBox():New( 044,136,"Reindexar",{|u| if( Pcount()>0, lReindex:=u,lReindex ) },oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox4     := TComboBox():New( 016,200,{|u| If(PCount()>0,nBoxCpos2:=u,nBoxCpos2)},aEmpresas,060,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
	oCBox8     := TCheckBox():New( 028,136,"Todas Tabelas",{|u| if( Pcount()>0, lAllTab:=u,lAllTab ) },oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox9     := TCheckBox():New( 036,200,"Todas as Empresas",{|u| if( Pcount()>0, lAllEmp:=u,lAllEmp ) },oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oBtn2      := TButton():New( 056,136,"EXECUTA",oGrp2,{|| Processa({||  INDEX(cTable2,lNoExists,lRebuild,lReindex,nBoxCpos2,lAllTab,lAllEmp)  } ) },50,012,,,,.T.,,"",,,,.F. )


	//Refresh das Tabelas 
	oGrp3      := TGroup():New( 076,132,120,264,"Regitra tabela no TOP C/ Dbselectarea ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay5      := TSay():New( 088,136,{||"Tabela"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay6      := TSay():New( 080,196,{||"Empresa"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet5      := TGet():New( 088,160,{|u| if( Pcount()>0, cTable3:= u,cTable3 ) },oGrp3,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable3",,)
	oCBox9     := TComboBox():New( 088,196,{|u| If(PCount()>0,nBoxCpos3:=u,nBoxCpos3)},aEmpresas,064,010,oGrp3,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
	oBtn5      := TButton():New( 104,136,"TcRefresh",oGrp3,{|| RefreshTbl(cTable3,nBoxCpos3) },108,012,,,,.T.,,"",,,,.F. )


	
	oBtn4      := TButton():New( 092,040,"ZAP SQL",oDlg1,{|| ZAPTBL(cTable4) },037,012,,,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 076,040,"Pack SQL",oDlg1,{|| PackTbl(cTable5) },037,012,,,,.T.,,"",,,,.F. )
	oBtn6      := TButton():New( 108,040,"Drop SQL",oDlg1,{|| DropTbl(cTable6) },037,012,,,,.T.,,"",,,,.F. )
	oBtn14     := TButton():New( 076,100,"TESTE MAIL",oDlg1,{|| TESTEMAIL() },028,044,,,,.T.,,"",,,,.F. )
	
	//Criação de Campo
	oGrp1sx      := TGroup():New( 004,272,136,532,"Criação de Campos",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1sx      := TSay():New( 016,276,{||"Nome"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2sx      := TSay():New( 028,276,{||"Label"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay3sx      := TSay():New( 040,276,{||"Descrição"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4sx      := TSay():New( 052,276,{||"Tipo"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay5sx      := TSay():New( 064,276,{||"Tamanho"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay6sx      := TSay():New( 076,276,{||"Decimal"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay7sx      := TSay():New( 088,276,{||"Máscara"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay8sx      := TSay():New( 016,376,{||"Validação"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay9sx      := TSay():New( 028,376,{||"Opções"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay10sx     := TSay():New( 100,276,{||"Consulta Pad"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay11sx     := TSay():New( 052,376,{||"Inicializa"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay12sx     := TSay():New( 064,376,{||"Empresa?"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay13sx     := TSay():New( 076,376,{||"Tabela"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	
	oGet1sx      := TGet():New( 016,312,{|u| if( Pcount()>0, CpNome:= u,CpNome ) },oGrp1,060,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet2sx      := TGet():New( 028,312,{|u| if( Pcount()>0, CpLabel:= u,CpLabel ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet3sx      := TGet():New( 040,312,{|u| if( Pcount()>0, CpDescr:= u,CpDescr ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oCBox1       := TComboBox():New( 052,312,{|u| If(PCount()>0,ntipo:=u,nTipo)},aTipos,060,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
	oGet4sx      := TGet():New( 064,312,{|u| if( Pcount()>0, CpTam:= u,CpTam ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet5sx      := TGet():New( 076,312,{|u| if( Pcount()>0, CpDeci:= u,CpDeci ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet6sx      := TGet():New( 088,312,{|u| if( Pcount()>0, CpMask:= u,CpMask ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet7sx      := TGet():New( 016,404,{|u| if( Pcount()>0, CpValid:= u,CpValid ) },oGrp1,124,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet8sx      := TGet():New( 028,404,{|u| if( Pcount()>0, CpOpcao:= u,CpOpcao ) },oGrp1,124,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet9sx      := TGet():New( 100,312,{|u| if( Pcount()>0, CpCons:= u,CpCons ) },oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet10sx     := TGet():New( 052,404,{|u| if( Pcount()>0, CpInic:= u,CpInic ) },oGrp1,124,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet11sx     := TGet():New( 076,404,{|u| if( Pcount()>0, CpTab:= u,CpTab ) },oGrp1,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	
	oCBox2sx     := TCheckBox():New( 120,276,"Usado?",{|| lUsado},oGrp1,032,008,,{|| lUsado:=.T.},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox3sx     := TCheckBox():New( 120,312,"Browse",{|| lBrowse},oGrp1,032,008,,{|| lBrowse:=.t.},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox4sx     := TCheckBox():New( 120,344,"Obrigatório",{|| lObrig},oGrp1,036,008,,{|| lObrig:=.T.},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox5sx     := TCheckBox():New( 040,404,"Real ?",{|| lReal},oGrp1,048,008,,{|| lReal:=.t., lVirtual:=.F. ,CpRefresh()},,{|| },CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox6sx     := TCheckBox():New( 040,480,"Edita ?",{|| lEdita},oGrp1,048,008,,{|| lEdita:=.f., lEdita:=.t.,CpRefresh()},,{|| },CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oBtn1sx      := TButton():New( 120,480,"Vai !",oGrp1,{|| CriaCampo()},049,012,,,,.T.,,"",,,,.F. )	
	oCBox7sx     := TComboBox():New( 064,404,{|u| If(PCount()>0,nBox:=u,nBox)},aEmpresas,060,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )

	oGet3      := TGet():New( 076,004,{|u| if( Pcount()>0, cTable5:= u,cTable5 ) },oDlg1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable4",,)
	oGet4      := TGet():New( 092,004,{|u| if( Pcount()>0, cTable4:= u,cTable4 ) },oDlg1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable5",,)
	oGet6      := TGet():New( 108,004,{|u| if( Pcount()>0, cTable6:= u,cTable6 ) },oDlg1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTable6",,)

	oBtn7      := TButton():New( 056,060,"DOC",oGrp1,{|| HELPSX3(cTable,lTdTBL,lTdEmp,nBoxCpos)},050,012,,,,.T.,,"",,,,.F. )
	oBtn8      := TButton():New( 056,200,"Remove Chr",oGrp2,{|| REMOVECHAR()},050,012,,,,.T.,,"",,,,.F. )

	oBtnexec      := TButton():New( 08,550,"Executa Isso!",oGrp1,{|| Executar()},049,012,,,,.T.,,"",,,,.F. )
	oSayexec      := TSay():New( 20,550,{||"Empresa:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oCBoexec      := TComboBox():New( 030,550,{|u| If(PCount()>0,nBoxexec:=u,nBoxexec)},aEmpresas,072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
	
	oAviso      := TSay():New( 124,004,{|| cAviso},oDlg1,,,.F.,.F.,.F.,.T.,CLR_HRED,CLR_WHITE,260,008)

	oDlg1:Activate(,,,.T.)
	
	
Return



/*
	*** CÓDIGO DA CRIAÇÃO DE CAMPOS *** 
	          Implementações 
*/
Static function CriaCampo()
	PRIVATE cArqEmp 		:= "SigaMat.Emp"
	PRIVATE aSM0			:={}
	PRIVATE aStruSX3		:={}
	PRIVATE aStruSQL		:={}
	Private nTopErr			:=0
	Private cQuery			:=""
	Private cInjection		:=""
		
		

		//+--------------------------------------------------+
		//|Preparando ambiente para execucao da Rotina       |
		//+--------------------------------------------------+
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	
	If (nBox =="")
		Alert("Na boa. Escolha uma empresa antes de continuar.")
		Return
	EndIf
	
	If (Empty(CpNome))
		Alert("Se ta achando que sou adivinho! Você não informou o nome do campo...")
		Return
	endif
	
	If(empty(CpTab))
		Alert("Se ta achando que sou adivinho! Você não informou o nome da tabela")
		Return
	endIf
	
	
	If (empty(CpLabel) .or. empty(CpDescr))
		Alert("Tá, e qual é a descrição dessa bagaça!")
		return
	EndIf
	
	
	If (CpTam<=0)
		Alert("To enchergando direito, ou você tá querendo criar um campo de tamanho zero! Sem chance! Volta lá e arruma isso!")
		return
	EndIf
	
	If (Empty(CpMask))
		Alert("É.. É.. É... Garoto, tá sem máscara o campo...")
		return
	EndiF		
	
	If !ApMsgYesNo("Pode ser que isso de uma Zerda! Continua?")
		Alert("Ufa...! Essa foi por pouco!")
		Return
	EndIF
			//+--------------------------------------------------+
			//|Monta array com o SM0                             |
			//+--------------------------------------------------+
	
		While !Eof()
			If nBox==SM0->M0_CODIGO
				If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
					Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
				EndIf
			EndIf
			dbSkip()
		EndDo

	ProcRegua(Len(aSM0))
	
			//+--------------------------------------------------+
			//|Processa a rotina para todas as empresas e filiais|
			//+--------------------------------------------------+
	For nI := 1 To Len(aSM0)	
	
			//+------------------------------------------------+
			//|Set o Proximo SM0                               |
			//+------------------------------------------------+
		SM0->(dbGoto(aSM0[nI][1]))
  				
			
			//+------------------------------------------------+
			//|Configura para nao utilizar Licencas do Protheus|
			//+------------------------------------------------+
		//RpcSetType(3)
	
	
			//+------------------------------------------------+
			//|Seta o Ambiente                                 |
			//+------------------------------------------------+
		RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, {"SIX","SX2","SX3"})
		IncProc("Empresa/Filial: "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
		
	
			//+-----------------------------------------------------------------------+
			//|PROCESSANDO A ROTINA                                                   |
			//+-----------------------------------------------------------------------+
				DbSelectArea("SX3")
				DBSETORDER(1)				
				
				cOrdem:=SetaOrdem() 
				
				RecLock("SX3",.T.)
				SX3->X3_ARQUIVO	:=  UPPER(CpTab)
				SX3->X3_ORDEM   :=  cOrdem
				SX3->X3_TIPO	:=  UPPER(ntipo)
				SX3->X3_CAMPO	:=	UPPER(CpNome)
				SX3->X3_TITULO	:=	UPPER(Cplabel)
				SX3->X3_DESCRIC	:=	UPPER(CpDescr)
				SX3->X3_TAMANHO	:=	CpTam
				SX3->X3_DECIMAL	:=	CpDeci
				SX3->X3_PICTURE	:=	UPPER(CpMask)
				SX3->X3_VLDUSER	:=	UPPER(CpValid)
				SX3->X3_CBOXENG	:=	UPPER(CpOpcao)
				SX3->X3_F3		:=	UPPER(CpCons)
				SX3->X3_RELACAO	:=	UPPER(CpInic)
				SX3->X3_USADO	:= X3TreatUso("x       x       x       x       x       x       x       x       x       x       x       x       x       x       x x     ")
				SX3->X3_RESERV	:= str2bin("xxxxxxx xx      ") 
				SX3->X3_BROWSE  := IF(lBrowse,"S","N")
				SX3->X3_VISUAL	:= IF(lEdita,"A","V")
				SX3->X3_CONTEXT := IF(lReal,"R","V")
				SX3->X3_OBRIGAT := IF(lObrig,"S","N")
				SX3->X3_PROPRI  := "U"
				MsUnlock()
				
			
				
				AlterTbl(CpTab)
				
		
			//+------------------------------------------------+
			//|Fecha o ambiente atual                          |
			//+------------------------------------------------+
		RpcClearEnv()
	
			//+------------------------------------------------+
			//|Abre o Ambiente novamente para proxima execucao |
			//+------------------------------------------------+
		OpenSm0()
	Next nI
	
	RpcClearEnv()	
	
	
		cAviso:="Campo criado na Empresa: "+nBox
		oAviso:SetText(cAviso)
		oAviso:CtrlRefresh()	
return



Static Function SetaOrdem()
	DbSelectArea("SX3")
	DBSETORDER(1)
	
	private cRet:=""
	
	DbSeek(SX3->X3_ARQUIVO)
	
	while !Eof()
		cRet:=SX3->X3_ORDEM		
		DbSkip()
	end	
	
	cRet:=Soma1(cRet)	
	
Return cRet

Static Function CpRefresh()
	oCBox5sx:CtrlRefresh()
	oCBox6sx:CtrlRefresh()
Return

/*
	*** FIM DAS IMPLEMENTAÇÕES DA CRIAÇÃO DE CAMPOS 
*/

/*
	-->25/04/2015 <--
	rotina executada para remover caracteres malucos da base de dados 


*/

Static function REMOVECHAR()
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
	//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv("01", "01",,,,, {"SX1","SX2","SX3"})
	
	U_REMOVECHAR()
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return





/*


			Executa o Zap da Tabela 
			

*/

Static Function ZapTbl(cTable4)

	If !ApMsgYesNo("Vou apagar os registros data tabela, Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If !ApMsgYesNo("Última chance de abortar! Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If Empty(cTable4)
		Alert("Você esqueceu de informar uma tabela, grande! Informe uma tabela, exemplo: AA1010")
		Return
	EndIF
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv("01", "01",,,,, {LEFT(cTable4,3)})
	
	
	cInjection:="TRUNCATE TABLE "+cTable4
	TCSQLExec(cInjection)
	TCRefresh(cTable4)
	DbCloseArea(cTable4)
	
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return



/*


			Executa o Pack da Tabela 
			

*/

Static Function PackTbl(cTable5)

	If !ApMsgYesNo("Vou apagar os registros macados como D_E_L_E_T_='*', Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If !ApMsgYesNo("Última chance de abortar! Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If Empty(cTable5)
		Alert("Você esqueceu de informar uma tabela, grande! Informe uma tabela, exemplo: AA1010")
		Return
	EndIF
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv("01", "01",,,,, {LEFT(cTable5,3)})
	
	
	cInjection:="DELETE "+cTable5+" WHERE D_E_L_E_T_='*' "
	TCSQLExec(cInjection)
	TCRefresh(cTable5)
	DbSelectArea(cTable5)
	
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return



/*


			Executa o Drop da Tabela 
			

*/

Static Function DropTbl(cTable6)

	If !ApMsgYesNo("Vou apagar A TABELA!!!!, Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If !ApMsgYesNo("Última chance de abortar! Continua?")
		Alert("Operação abortada!")
		Return
	EndIF
	
	If Empty(cTable6)
		Alert("Você esqueceu de informar uma tabela, grande! Informe uma tabela, exemplo: AA1010")
		Return
	EndIF
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv("01", "01",,,,, {LEFT(cTable6,3)})
	
	
	cInjection:="DROP TABLE "+cTable6
	TCSQLExec(cInjection)
	TCRefresh(cTable6)
	DbSelectArea(cTable6)
	
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return

/*


		Rotina de Refaz Indices



*/


Static Function Index(cTable2,lNoExists,lRebuild,lReindex,nBoxCpos2,lAllTab,lAllEmp)
//+------------------------------------------------------------------------------+
//|DECLARACAO DE VARIAVEIS                                                       |
//+------------------------------------------------------------------------------+
	PRIVATE cArqEmp 		:= "SigaMat.Emp"
	PRIVATE aSM0			:={}
	PRIVATE aStruSX3		:={}
	PRIVATE aStruSQL		:={}
	Private nTopErr		:=0
	Private cQuery		:=""
	Private cInjection	:=""


	IF lAllTab
		IF !APMSGNOYES("VOCÊ MARCOU TODAS AS TABELAS! QUER MESMO CONTINUAR,FERA?")
			RETURN
		endif
	ENDIF


//+--------------------------------------------------+
//| Validações                                       |
//+--------------------------------------------------+
	If Empty(cTable2)
		Alert("FERA...VOCÊ NÃO INFORMOU A TABELA, AÍ FICA DIFÍCIL.")
		Return
	EndIF

	IF Empty(nBoxCpos2) .AND. !lAllEmp
		Alert("JOW! ESOLHE UM EMPRESA ANTES DE CONTINUAR.")
		Return
	EndIF


//+--------------------------------------------------+
//|Preparando ambiente para execucao da Rotina       |
//+--------------------------------------------------+
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	

//+--------------------------------------------------+
//|Monta array com o SM0                             |
//+--------------------------------------------------+
	If lAllEmp
		While !Eof()
			If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
				Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
			EndIf
			dbSkip()
		EndDo
	Else
		While !Eof()
			If nBoxCpos2==SM0->M0_CODIGO
				If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
					Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIf

	ProcRegua(Len(aSM0))
//+--------------------------------------------------+
//|Processa a rotina para todas as empresas e filiais|
//+--------------------------------------------------+
	For nI := 1 To Len(aSM0)
	
	
	
	
	//+------------------------------------------------+
	//|Set o Proximo SM0                               |
	//+------------------------------------------------+
		SM0->(dbGoto(aSM0[nI][1]))
  				
			
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
		//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
		RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, {"SIX","SX2",cTable2})
		IncProc("Empresa/Filial: "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
	
	//+-----------------------------------------------------------------------+
	//|PROCESSANDO A ROTINA                                                   |
	//+-----------------------------------------------------------------------+
		
		
		IF lAllTab //Todas as Tabelas
			DbSelectArea("SX2")
			DbGotop()
			While !Eof()
				INCPROC(SX2->X2_CHAVE)
				IndexTbl(SX2->X2_CHAVE,lReindex,lRebuild,lNoExists,nBoxCpos2)
				DbSkip()
			End
		Else
			INCPROC(cTable2)
			IndexTbl(cTable2,lReindex,lRebuild,lNoExists,nBoxCpos2)
		EndIf
		
		
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
		RpcClearEnv()
	
	//+------------------------------------------------+
	//|Abre o Ambiente novamente para proxima execucao |
	//+------------------------------------------------+
		OpenSm0()
	Next nI

Return



Static function IndexTBL (cTable2,lReindex,lRebuild,lNoExists,nBoxCpos2)
	Local cInjection:=""
	Local cIDX:=""
	Local cIdxName:=""
	Local cQry:=""
	Local aSix:={}
	Local aTidx:={}


//+--------------------------------------------------+
//| Validações                                       |
//+--------------------------------------------------+
	If Empty(cTable2)
		Alert("FERA...VOCÊ NÃO INFORMOU A TABELA, AÍ FICA DIFÍCIL. NÃO SOU ADIVINHO!")
		Return
	EndIF
	
	If lReindex
		cInjection:=" DBCC DBREINDEX ('"+RetSqlname(cTable2)+"') "
		TCSQLExec(cInjection)
		TCRefresh(RetSqlname(cTable2))
		
		cAviso:="DBCC DBREINDEX executado no TOP na empresa: "+nBoxCpos2
		oAviso:SetText(cAviso)
		oAviso:CtrlRefresh()
	 
		
	EndIf
	
	
	If lRebuild
		DbSelectArea("SIX")
		If !DbSeek(cTable2)
			return()
		Else
			While !eof() .AND. SIX->INDICE==cTable2
				
				//Monta indice
				cIdx:=STRTRAN(SIX->CHAVE,"+",",")
				cIDX:=ALLTRIM(cIDX)+",R_E_C_N_O_, D_E_L_E_T_"
				
				cIdxName:=RetSqlName(cTable2)+SIX->ORDEM
				
				
				cInjection:="DROP INDEX "+cIdxName+" ON "+RetSqlName(ctable2)+" "
				TCSQLExec(cInjection)
				
				cInjection:=" CREATE INDEX "+cIdxName+"  ON "+RetSqlName(ctable2)+" ("+cIDX+") "
				TCSQLExec(cInjection)
				TCRefresh(RetSqlname(cTable2))
				DbSkip()
			end
			cAviso:="Indices recriados no TOP na empresa: "+nBoxCpos2
			oAviso:SetText(cAviso)
			oAviso:CtrlRefresh()
		endIf
	EndIf
	
	//Cria os indices inexistente na base
	If lNoExists
		DbSelectArea("SIX")
		If !DbSeek(cTable2)
			return()
		Else
			While !eof() .AND. SIX->INDICE==cTable2
				//Monta indice
				cIdx:=STRTRAN(SIX->CHAVE,"+",",")
				cIDX:=ALLTRIM(cIDX)+",R_E_C_N_O_, D_E_L_E_T_"
				
				cIdxName:=RetSqlName(cTable2)+SIX->ORDEM
				AADD(aSix,{cIdxName,cIDX})
				DbSkip()
			end
		EndIf
	
		cQry:=" SELECT * FROM ( SELECT '['+Sch.name+'].['+ Tab.[name]+']' AS TableName, "
		cQry+=" Ind.[name] AS IndexName, "
		
		cQry+=" LTRIM(SUBSTRING(( SELECT ', ' + AC.name "
		cQry+=" 	FROM sys.[tables] AS T "
		cQry+=" INNER JOIN sys.[indexes] I 			ON T.[object_id] = I.[object_id] "
		cQry+=" INNER JOIN sys.[index_columns] IC 	ON I.[object_id] = IC.[object_id]	AND I.[index_id] = IC.[index_id] "
		cQry+=" INNER JOIN sys.[all_columns] AC 	ON T.[object_id] = AC.[object_id]	AND IC.[column_id] = AC.[column_id] "
		cQry+=" 	WHERE "
		cQry+=" 	Ind.[object_id] = I.[object_id] "
		cQry+=" 	AND Ind.index_id = I.index_id "
		cQry+=" 	AND IC.is_included_column = 0 "
		cQry+=" 	ORDER BY IC.key_ordinal "
		cQry+=" 	FOR XML PATH('') "
		cQry+=" 	), 2, 8000)) AS KeyCols, "
		
		cQry+=" 	SUBSTRING(( SELECT ', ' + AC.name "
		cQry+=" 	FROM sys.[tables] AS T "
		cQry+=" 		INNER JOIN sys.[indexes] I "
		cQry+=" 		ON T.[object_id] = I.[object_id] "
		cQry+=" 		INNER JOIN sys.[index_columns] IC "
		cQry+=" 		ON I.[object_id] = IC.[object_id] "
		cQry+=" 		AND I.[index_id] = IC.[index_id] "
		cQry+=" 		INNER JOIN sys.[all_columns] AC "
		cQry+=" 		ON T.[object_id] = AC.[object_id]"
		cQry+=" 		AND IC.[column_id] = AC.[column_id]"
		cQry+=" 		WHERE Ind.[object_id] = I.[object_id]"
		cQry+=" 		AND Ind.index_id = I.index_id"
		cQry+=" 		AND IC.is_included_column = 1"
		cQry+=" 		ORDER BY IC.key_ordinal"
		cQry+=" 		FOR"
		cQry+=" 		XML PATH('')"
		cQry+=" 		), 2, 8000) AS IncludeCols"
		cQry+=" FROM sys.[indexes] Ind"
		cQry+=" INNER JOIN sys.[tables] AS Tab ON Tab.[object_id] = Ind.[object_id]"
		cQry+=" INNER JOIN sys.[schemas] AS Sch ON Sch.[schema_id] = Tab.[schema_id]"
		cQry+=" WHERE  Tab.[name]='"+RetSqlName(cTable2)+"'"
		cQry+=" ) AS TABELA ORDER BY TableName"
		
		IF SELECT("TIDX")>0
			TIDX->(DbCloseArea())
		ENDIF
		TCQUERY cQry NEW Alias "TIDX"
		
		DbSelectArea("TIDX")
		DbGotop()
		
		While !Eof()
			AADD(aTidx,{ALLTRIM(IndexName),ALLTRIM(KeyCols) })
			DbSkip()
		End
		
		For i:=1 to len(aSix)
			If aScan(aTidx,{|x| ALLTRIM(x[1]) == ALLTRIM(aSix[i][1])})==0
			EndIf
		Next
		
		cAviso:="Indices Inexistentes criados no TOP na empresa: "+nBoxCpos2
		oAviso:SetText(cAviso)
		oAviso:CtrlRefresh()
	EndIf
	
Return



/*


	Compatibiliza o SX3 com a Base de dados


*/


Static Function SX3VsSQL(cTable,lTdTBL,lTdEmp,nBoxCpos)
//+------------------------------------------------------------------------------+
//|DECLARACAO DE VARIAVEIS                                                       |
//+------------------------------------------------------------------------------+
	PRIVATE cArqEmp 		:= "SigaMat.Emp"
	PRIVATE aSM0			:={}
	PRIVATE aStruSX3		:={}
	PRIVATE aStruSQL		:={}
	Private nTopErr		:=0
	Private cQuery		:=""
	Private cInjection	:=""


	cTable := UPPER(cTable)

	IF lTdTBL
		IF !APMSGNOYES("VOCÊ MARCOU TODAS AS TABELAS! QUER MESMO CONTINUAR,CAMPEÃO?")
			RETURN
		endif
	ENDIF


//+--------------------------------------------------+
//| Validações                                       |
//+--------------------------------------------------+
	If Empty(cTable)
		Alert("FERA...VOCÊ NÃO INFORMOU A TABELA, AÍ FICA DIFÍCIL. NÃO SOU ADIVINHO!")
		Return
	EndIF

	IF Empty(nBoxCpos) .AND. !lTdEmp
		Alert("JOW! ESOLHE UM EMPRESA ANTES DE CONTINUAR.")
		Return
	EndIF


//+--------------------------------------------------+
//|Preparando ambiente para execucao da Rotina       |
//+--------------------------------------------------+
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	

//+--------------------------------------------------+
//|Monta array com o SM0                             |
//+--------------------------------------------------+
	If lTdEmp
		While !Eof()
			If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
				Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
			EndIf
			dbSkip()
		EndDo
	Else
		While !Eof()
			If nBoxCpos==SM0->M0_CODIGO
				If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
					Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIf

	ProcRegua(Len(aSM0))
//+--------------------------------------------------+
//|Processa a rotina para todas as empresas e filiais|
//+--------------------------------------------------+
	For nI := 1 To Len(aSM0)
	
	
	
	
	//+------------------------------------------------+
	//|Set o Proximo SM0                               |
	//+------------------------------------------------+
		SM0->(dbGoto(aSM0[nI][1]))
  				
	
		
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
		//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
		RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, {"SX3","SX2",cTable})
		IncProc("Empresa/Filial: "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
	
	//+-----------------------------------------------------------------------+
	//|PROCESSANDO A ROTINA                                                   |
	//+-----------------------------------------------------------------------+
		
		
		IF lTdTBL //Todas as Tabelas
			DbSelectArea("SX2")
			DbGotop()
			While !Eof()
				INCPROC(SX2->X2_CHAVE)
				AlterTbl(SX2->X2_CHAVE)
				DbSkip()
			End
		Else
			INCPROC(cTable)
			AlterTbl(cTable)
		EndIf
		
		
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
		RpcClearEnv()
	
	//+------------------------------------------------+
	//|Abre o Ambiente novamente para proxima execucao |
	//+------------------------------------------------+
		OpenSm0()
	Next nI
	
	cAviso:="SX3 x SQL executado no TOP, campos faltantes criados na empresa: "+nBoxCpos
	oAviso:SetText(cAviso)
	oAviso:CtrlRefresh()
	 
Return

//+---------------------------------------+
//Função de alteração de tabela 
//+---------------------------------------+
Static Function AlterTbl(cTable)
	Local aArea:=GETAREA()

		//Protecao de tabela inexistente
	If Empty(RetSqlName(cTable))
		return
	endIf
		
		//Stru do SX3
	aStruSX3 := {}
	nTopErr:=0
		
	DbSelectArea("SX3")
	DbSetOrder(1)
				
	DbSeek(cTable)
		
	While !EOF() .and. cTable==X3_ARQUIVO
		aadd(aStruSX3,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL})
		DbSkip()
	End
	 
	 	//Stru do TRB
	cQuery:=" SELECT TOP 1 * FROM "+RetSqlName(cTable)
	IF SELECT("TRB")>0
		TRB->(DbCloseArea())
	ENDIF
	 	
	TCQUERY cQuery NEW ALIAS "TRB"
	aStruSQL:=TRB->(DbStruct())
	 	
	 	//Alter Table
	 	
	For i:=1 to Len(aStruSX3)
	 		
		If  aScan(aStruSQL, {|x| ALLTRIM(X[1])== ALLTRIM(aStruSX3[i][1]) }  )==0
			IF aStruSX3[i][2]=="C"
				cInjection:= "ALTER TABLE "+RetSqlName(cTable)+" ADD "+aStruSX3[i][1]+" VARCHAR("+Str(aStruSX3[i][3],0)+") NOT NULL DEFAULT ('"+Space(aStruSX3[i][3])+"')"
			ELSEIF aStruSX3[i][2]=="D"
				cInjection:= "ALTER TABLE "+RetSqlName(cTable)+" ADD "+aStruSX3[i][1]+" VARCHAR(8) NOT NULL DEFAULT ('"+Space(8)+"')"
			ElseIf aStruSX3[i][2]=="N"
				cInjection:= "ALTER TABLE "+RetSqlName(cTable)+" ADD "+aStruSX3[i][1]+" FLOAT NOT NULL DEFAULT (0)"
			ElseIf aStruSX3[i][2]=="M"
				cInjection:= "ALTER TABLE "+RetSqlName(cTable)+" ADD "+aStruSX3[i][1]+" IMAGE "
			EndIf
	 				
			If !Empty(cInjection)
				TCSQLExec(cInjection)
			EndIf
		EndIf
	 	
	Next
	 	

	TCRefresh(RetSqlname(cTable))
		
	DbSelectArea(cTable)
	RestArea(aArea)
Return
	

//################################################
//## Faz um Refresh na tabela do TOP            ##
//################################################
Static Function RefreshTbl(cTable3,nBoxCpos3)


	//+--------------------------------------------------+
	//| Validações                                       |
	//+--------------------------------------------------+
	If Empty(cTable3)
		Alert("FERA...VOCÊ NÃO INFORMOU A TABELA, AÍ FICA DIFÍCIL. NÃO SOU ADIVINHO!")
		Return
	EndIF
	
	IF Empty(nBoxCpos3)
		Alert("JOW! ESOLHE UM EMPRESA ANTES DE CONTINUAR.")
		Return
	EndIF

		
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
	//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv(nBoxCpos3, "01",,,,, {"SX3","SX2",cTable3})
			
	//+-----------------------------------------------------------------------+
	//|PROCESSANDO A ROTINA                                                   |
	//+-----------------------------------------------------------------------+
		
	TCRefresh(RetSqlname(cTable3))
	cAviso:="TCRefresh executado no TOP, empresa: "+nBoxCpos3
	oAviso:SetText(cAviso)
	oAviso:CtrlRefresh()
		
	DbSelectArea(cTable3)
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return

	
//#################################################
//##       CARREGA AS EMPRESAS EM UM ARRAY       ##  
//#################################################
Static Function LoadEmps()
	Local aTemp:={}


	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	
	
	
	While !Eof()
		If aScan(aTemp,{|x| ALLTRIM(x)==SM0->M0_CODIGO })==0 .AND. !Deleted()
			Aadd(aTemp,SM0->M0_CODIGO )
		EndIf
		dbSkip()
	EndDo
	
Return (aTemp)


//############################################################
//+-*------------------------------------------------------*-+
//| *  01/01/2015   - DPS                                  * |
//| *                                                      * |
//| ******************************************************** |
//|  GERA A DOC DO SX3 CONTRA OUTRO SX3                      |
//+----------------------------------------------------------+
//############################################################
Static Function HELPSX3(cTable,lTdTBL,lTdEmp,nBoxCpos)

//+------------------------------------------------------------------------------+
//|DECLARACAO DE VARIAVEIS                                                       |
//+------------------------------------------------------------------------------+
	PRIVATE cArqEmp 		:= "SigaMat.Emp"
	PRIVATE aSM0			:={}
	PRIVATE aStruSX3		:={}
	PRIVATE aStruSQL		:={}
	Private nTopErr		:=0
	Private cQuery		:=""
	Private cFile			:= Space(150)


	cTable := UPPER(cTable)

	IF lTdTBL
		IF !APMSGNOYES("VOCÊ MARCOU TODAS AS TABELAS! QUER MESMO CONTINUAR,CAMPEÃO?")
			RETURN
		endif
	ENDIF


//+--------------------------------------------------+
//| Validações                                       |
//+--------------------------------------------------+
	If Empty(cTable)
		Alert("FERA...VOCÊ NÃO INFORMOU A TABELA, AÍ FICA DIFÍCIL. NÃO SOU ADIVINHO!")
		Return
	EndIF

	IF Empty(nBoxCpos) .AND. !lTdEmp
		Alert("JOW! ESOLHE UM EMPRESA ANTES DE CONTINUAR.")
		Return
	EndIF


//+--------------------------------------------------+
//|Preparando ambiente para execucao da Rotina       |
//+--------------------------------------------------+
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	

//+--------------------------------------------------+
//|Monta array com o SM0                             |
//+--------------------------------------------------+
	If lTdEmp
		While !Eof()
			If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
				Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
			EndIf
			dbSkip()
		EndDo
	Else
		While !Eof()
			If nBoxCpos==SM0->M0_CODIGO
				If aScan(aSM0,{|x| ALLTRIM(x[2])==SM0->M0_CODIGO })==0 .AND. !Deleted()
					Aadd(aSM0,{SM0->(RECNO()),SM0->M0_CODIGO })
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIf

	ProcRegua(Len(aSM0))
//+--------------------------------------------------+
//|Processa a rotina para todas as empresas e filiais|
//+--------------------------------------------------+
	For nI := 1 To Len(aSM0)
	
	
	
	
	//+------------------------------------------------+
	//|Set o Proximo SM0                               |
	//+------------------------------------------------+
		SM0->(dbGoto(aSM0[nI][1]))
  				
	
		
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
		//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
		RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, {"SX3","SX2",cTable})
		IncProc("Empresa/Filial: "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
	
	
		IF lTdTBL //Todas as Tabelas
			DbSelectArea("SX2")
			DbGotop()
			While !Eof()
				INCPROC(SX2->X2_CHAVE)
				HELPSX3B(SX2->X2_CHAVE)
				DbSkip()
			End
		Else
			INCPROC(cTable)
			HELPSX3B(cTable)
		EndIf
		
		
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
		RpcClearEnv()
	
	//+------------------------------------------------+
	//|Abre o Ambiente novamente para proxima execucao |
	//+------------------------------------------------+
		OpenSm0()
	Next nI
	
	//Aviso em tela
	cAviso:="DOC da tabela gerado  C:\TEMP\"+RetSqlName(cTable)+".xml"
	oAviso:SetText(cAviso)
	oAviso:CtrlRefresh()
	 
Return


//
// COMPARA O SX3 CONTRA O BANCO E GERA DOC DAS DIFERENÇAS
//
//

STATIC FUNCTION HELPSX3B(cTable)
	Local aDoc		:={}
	Local oExcel	:= fwmsexcel():new()
	Local aCampos	:={}
	
	If File("C:\TEMP\"+RetSqlName(cTable)+".xml")
		ferase("C:\TEMP\"+RetSqlName(cTable)+".xml")
	EndIf

		 //##############   SX3 ##########################

	oExcel:AddworkSheet("SX3")
	oExcel:AddTable("SX3","Estrutura da Tabela - "+cTable)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_ORDEM",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_CAMPO",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_TIPO",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_PICTURE",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_TAMANHO",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_DECIMAL",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_TITULO",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_PROPI",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_VALID",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_VLDUSER",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_BROWSE",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_VISUAL",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_CONTEXT",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_F3",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_NIVEL",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_RELACAO",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_CBOX",1,1)
	oExcel:AddColumn("SX3","Estrutura da Tabela - "+cTable,"X3_WHEN",1,1)
	 


		//Protecao de tabela inexistente
	If Empty(RetSqlName(cTable))
		return
	endIf
		
		//Stru do SX3
	aStruSX3 := {}
	nTopErr:=0
		
	DbSelectArea("SX3")
	DbSetOrder(1)
				
	DbSeek(cTable)
		
	While !EOF() .and. cTable==X3_ARQUIVO
		oExcel:AddRow("SX3","Estrutura da Tabela - "+cTable,{X3_ORDEM,X3_CAMPO,X3_TIPO,X3_PICTURE,X3_TAMANHO,X3_DECIMAL,X3_TITULO,;
			X3_PROPRI,X3_VALID,X3_VLDUSER,X3_BROWSE,X3_VISUAL,X3_CONTEXT,X3_F3,;
			X3_NIVEL,X3_RELACAO,X3_CBOX,X3_WHEN})
			
		AADD(aCampos,X3_CAMPO)
		DbSkip()
	End
	 
	 //##############   SX2 ##########################
	 
	oExcel:AddworkSheet("SX2")
	oExcel:AddTable("SX2","Estrutura da Tabela - "+cTable)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_ARQUIVO",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_NOME",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_MODO",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_MODOUN",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_MODOEMP",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_DELET",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_TTS",1,1)
	oExcel:AddColumn("SX2","Estrutura da Tabela - "+cTable,"X2_UNICO",1,1)
	
	
	DbSelectArea("SX2")
	DbSetOrder(1)
				
	DbSeek(cTable)
		
	While !EOF() .and. cTable==X2_CHAVE
		oExcel:AddRow("SX2","Estrutura da Tabela - "+cTable,{X2_ARQUIVO,X2_NOME,X2_MODO,X2_MODOUN,X2_MODOEMP,X2_DELET,X2_TTS,X2_UNICO})
		DbSkip()
	End

 	//##############   SXI ##########################
	 
	oExcel:AddworkSheet("SIX")
	oExcel:AddTable("SIX","Estrutura da Tabela - "+cTable)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"ORDEM",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"CHAVE",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"DESCRICAO",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"PROPRI",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"F3",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"NICKNAME",1,1)
	oExcel:AddColumn("SIX","Estrutura da Tabela - "+cTable,"SHOWPESQ",1,1)
	
	
	
	DbSelectArea("SIX")
	DbSetOrder(1)
				
	DbSeek(cTable)
		
	While !EOF() .and. cTable==INDICE
		oExcel:AddRow("SIX","Estrutura da Tabela - "+cTable,{ORDEM,CHAVE,DESCRICAO,PROPRI,F3,NICKNAME,SHOWPESQ})
		DbSkip()
	End
	
	
	oExcel:AddworkSheet("SX7")
	oExcel:AddTable("SX7","Estrutura da Tabela - "+cTable)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_CAMPO",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_SEQUENC",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_REGRA",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_CDOMIN",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_TIPO",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_SEEK",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_ALIAS",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_ORDEM",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_CHAVE",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_CONDIC",1,1)
	oExcel:AddColumn("SX7","Estrutura da Tabela - "+cTable,"X7_PROPRI",1,1)
	
	DbSelectArea("SX7")
	DbSetOrder(1)
	
	For i:=1 to Len(aCampos)
		If DbSeek(aCampos[i])
			oExcel:AddRow("SX7","Estrutura da Tabela - "+cTable,{X7_CAMPO,X7_SEQUENC,X7_REGRA,X7_CDOMIN,X7_TIPO,X7_SEEK,X7_ALIAS,X7_ORDEM,X7_CHAVE,X7_CONDIC,X7_PROPRI})
		EndIf
	Next
	
	

	oExcel:Activate()
	oExcel:GetXMLFile("C:\TEMP\"+RetSqlName(cTable)+".xml")
	 	
RETURN



//#########################################################
//+-------------------------------------------------------+
//| Data | 25/01/2016 | Autor | Daniel P Silveira         |
//+-------------------------------------------------------+
//| Decs | Faz o envio de email de teste pelo sistema     |
//+-------------------------------------------------------+
//#########################################################

STATIC FUNCTION TESTEMAIL()
	Local cPerg	:="PROT_DOC"
	Local aRet		:={}
	Local aOption	:={}
	Local oServer
	Local oMessage
	Local nNumMsg 	:= 0
	Local nTam    	:= 0
	Local nI      	:= 0
	Local cConta		:= ""
	Local cPass		:= ""
	Local cRemetente	:= ""
	Local cServer		:= ""
	Local nPorta		:= ""
	Local aAnexos		:={}
	Local cTxtTMP		:=""

//+------------------------------------------------------------------------------+
//|DECLARACAO DE VARIAVEIS                                                       |
//+------------------------------------------------------------------------------+
	PRIVATE cArqEmp 		:= "SigaMat.Emp"
	PRIVATE aSM0			:={}
	PRIVATE aStruSX3		:={}
	PRIVATE aStruSQL		:={}
	Private nTopErr		:=0
	Private cQuery		:=""
	Private cFile			:= Space(150)

//+--------------------------------------------------+
//|Preparando ambiente para execucao da Rotina       |
//+--------------------------------------------------+
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	
		
	//+------------------------------------------------+
	//|Configura para nao utilizar Licencas do Protheus|
	//+------------------------------------------------+
	//RpcSetType(3)
	
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, {"SX3","SX2"})


	//Perguntas
/*1*/	AADD(aOption,{1,"e-mail Destino",Space(255),"@!",".T.","",,100,.t.}) 
/*2*/	AADD(aOption,{1,"Conta: ",Space(255),"@!",".T.","",,100,.t.})
/*3*/	AADD(aOption,{1,"Senha: ",Space(255),"@!",".T.","",,100,.t.})
/*4*/	AADD(aOption,{1,"Servidor: ",Space(255),"@!",".T.","",,100,.t.})
/*5*/	AADD(aOption,{1,"Porta: ",Space(255),"@!",".T.","",,100,.t.})
	 //	AADD(aOption,{6,"Anexo: ",Space(255),"@!",".T.","",100,.t.})
	
	If !ParamBox(aOption,cPerg,@aRet,,,.t.,,,,cPerg,.t.,.t.)
		Return
	EndIf
	
		
	cEmails:= alltrim(aRet[1])
	cTitulo:= "E-mail de teste da Fini Guloseimas"
	cTexto	:= "Esse é um email de teste da Fini Guloseimas e foi gerado pelo sistema as "+time()+" na data: "+DTOC(DATE())
	cAnexo	:= "\EDI\Output\Web\35160103594123000196550030001570931001647968-nfe.xml"	
	cConta	:= alltrim(aRet[2])
	cRemetente := alltrim(aRet[2])
	cPass	:= alltrim(aRet[3])
	cServer := alltrim(aRet[4])
    nPorta	:= Val(alltrim(aRet[5]))
   
   
//Cria a conexão com o server STMP ( Envio de e-mail )
oServer := tMailManager():New()
oServer:Init( "", cServer, cConta, cPass, 0, nPorta ) //25252

oServer:SMTPAuth( cConta ,cPass )
   
//seta um tempo de time out com servidor de 1min
If oServer:SetSmtpTimeOut( 60 ) != 0
	Alert( "Falha ao setar o time out" )
    Return .F.
EndIf
   
//realiza a conexão SMTP
n:=oServer:SmtpConnect()
cErro:=oServer:GetErrorString(n)
If n!= 0
    alert( "Falha ao conectar  SMTP "+cErro )
    Return .F.
EndIf
alert("Conexão SMTP realizada com sucesso!")

//Apos a conexão, cria o objeto da mensagem                             
oMessage := tMailMessage():New()
   
//Limpa o objeto
oMessage:Clear()
   
//Popula com os dados de envio
oMessage:cFrom              := cConta
oMessage:cTo                := cEmails
oMessage:cCc                := cEmails
oMessage:cBcc               := ""
oMessage:cSubject           := cTitulo
oMessage:cBody              := cTexto
   

If !Empty(cAnexo)
	//Monta array de Anexos
	If AT(";",cAnexo)>0
		For i:=1 to Len(cAnexo)
			If Substr(cAnexo,i,1)==";"
				AADD(aAnexos,cTxtTmp)
				cTxtTmp:=""
			Else
				cTxtTMP+=Substr(cAnexo,i,1)
			EndIF
		Next 
		
		For i:=1 to Len(aAnexos)
			If oMessage:AttachFile( aAnexos[i] ) < 0
				alert( "Erro ao atachar o arquivo" )
				Return .F.
			Else
				//adiciona uma tag informando que é um attach e o nome do arq
				oMessage:AddAtthTag( aAnexos[i])
			EndIf	
		Next
	Else
			If oMessage:AttachFile( cAnexo ) < 0
				alert( "Erro ao atachar o arquivo" )
				Return .F.
			Else
				//adiciona uma tag informando que é um attach e o nome do arq
				oMessage:AddAtthTag(cAnexo)
			EndIf	
	EndIf
EndIf
   
//Envia o e-mail
n:=oMessage:Send( oServer )
cErro:=oServer:GetErrorString(n)
If n != 0
	alert( "Erro ao enviar o e-mail "+cErro )
	Return .F.
EndIf
alert("Email enviado com sucesso")
   
  //Desconecta do servidor
 n:=oServer:SmtpDisconnect()
 cErro:=oServer:GetErrorString(n)
If n != 0
	alert ( "Erro ao disconectar do servidor SMTP "+cErro )
	Return .F.
EndIf
alert("Desconectou do servidor com sucesso")


	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
RETURN



//Consulta se a NF-e está autorizada na SEFAZ
USER FUNCTION TSTNFE
	aParam:={'1  ','129816   ','129816   '}
	cUrl			:= Padr( GetNewPar("MV_SPEDURL",""), 250 )
	lCte	:=.f.
	cAviso:=""
	cModelo	:= "NFE"
	ARET:={}
	ARET:=procMonitorDoc("000007", cUrl, aParam, 1, cModelo, lCte, @cAviso)
	ALERT("")
RETURN 



/**/

Static Function Executar()
	OpenSm0()
	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGotop()
	
	If(empty(nBoxexec))
		Alert("Empresaaaaa! Escolha uma EMPRESAAAAAAAAAAAA! NÃO LEIO MENTES!")
		Return
	EndIf
	
	//+------------------------------------------------+
	//|Seta o Ambiente                                 |
	//+------------------------------------------------+
	RpcSetEnv(nBoxexec, SM0->M0_CODFIL,,,,, {"SX3","SX2"})
	
	u_EXECADVPL()
	
	//+------------------------------------------------+
	//|Fecha o ambiente atual                          |
	//+------------------------------------------------+
	RpcClearEnv()
Return