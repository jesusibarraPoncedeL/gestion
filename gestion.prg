
* FECHA    : 13/05/98
************
*
********************************************************************
* SET's DEL SISTEMA
********************************************************************
                                       ****************************************
                                       *CONFIGURA EL SISTEMA
                                       ****************************************
*
*CLOSE ALL
*CLEAR ALL
*
Old_WTitle=wtitle('screen')
*
SET CENTURY ON                          && A�o 2000
SET CARRY OFF
SET TALK OFF
SET CLOCK STATUS
SET DATE TO DMY
SET EXCLUSIVE OFF
SET LOCK OFF
SET DELETE ON
SET SAFETY OFF
SET READBORDER ON
*
SET UDFPARMS  TO REFERENCE
SET PROCEDURE TO COMUNES
SAVE MACROS   TO TMPMACRO
CLEAR MACROS
*
*SET SYSMENU TO
SET SYSMENU AUTOMATIC
*
MODIFY WINDOW SCREEN ; 
       FILL FILE (LOCFILE("bmps\tapete0.bmp","BMP|ICO|PCT|ICN", "Where is tapete0?" ))
Tapete0 = .t.

*
********************************************************************
* INICIALIZA VARIABLES GLOBALES DEL SISTEMA
********************************************************************
*

                                       ****************************************
                                       * DEL CONFSIS
                                       ****************************************
PUBLIC GNOMCIA, GNOMCIAC, GNOMSIS, GVERSION, GTONO  , GANOCIE, GMESCIE ,;
       GCR0000, GCO0000 , GCJ0000, GCN0000, GCA0000 , GUT0000
select 0
use confsis
go top
gnomcia  = nomcia
gnomciac = nomciac
gnomsis  = nomsis
gversion = version
gactivo  = activo
gCR0000  = CR0000
gCO0000  = CO0000
gCJ0000  = CJ0000
gCN0000  = CN0000
gCA0000  = CA0000
gUT0000  = Ut0000
ganocie  = anocie
gmescie  = mescie



                                       ****************************************
                                       *DEL CONFUSER
                                       ****************************************
PUBLIC GTONO, GPREVISTA , gPathRuta , gColor256
select 0
use confuser
go top
gtono     = tono
gColor256 = Color256
gprevista = prevista
gPathRuta = alltrim( PathRuta )
                                       ****************************************
                                       *CLAVES DE ACCESO
                                       ****************************************
PUBLIC GOPCIONES, GUSUARIO, GNOMUSU, GDEPTO, GUSUAUT , GNOMUSUL
gusuario = ''
gnomusu  = ''
gdepto   = ''
gusuaut  = ''

                                       ****************************************
                                       *DE USO COMUN
                                       ****************************************
PUBLIC GINIDATE, GHELPVALOR,  GHELPCVE,  GHELPINT, GHELP, XINVALIDA, ;
       GEJECUTA, GSALIRAPP,   GSALIRSIS, XOLDTITULO ,;
       EJECUTA  , gmindate, xvectex , gPrgAct
ginidate  = ctod('  /  /  ')
gHelpValor= ''
gHelpCve  = ''
gHelpInt  = ''
xinvalida = .f.
GEjecuta  = .t.
gSalirApp = .f.
gSalirSis = .f.
agerror    = ''
aaviso    = ''
amsg      = ''
xOldTitulo= ''
gPrgAct   = ''



*
#REGION 1
PRIVATE wzfields,wztalk
IF SET("TALK") = "ON"
	SET TALK OFF
	m.wztalk = "ON"
ELSE
	m.wztalk = "OFF"
ENDIF
m.wzfields=SET('FIELDS')
SET FIELDS OFF
IF m.wztalk = "ON"
	SET TALK ON
ENDIF



#REGION 0
REGIONAL m.currarea, m.talkstat, m.compstat

IF SET("TALK") = "ON"
	SET TALK OFF
	m.talkstat = "ON"
ELSE
	m.talkstat = "OFF"
ENDIF
m.compstat = SET("COMPATIBLE")
SET COMPATIBLE FOXPLUS

m.rborder = SET("READBORDER")
SET READBORDER ON

m.currarea = SELECT()
m.strBusca = ''


set procedure to comunes
*       *********************************************************
*       *                                                         
*       *     S5406886/Windows Databases, Indexes, Relations      
*       *                                                         
*       *********************************************************
*

IF USED("nombres")
	SELECT nombres
	SET ORDER TO TAG "_rtf0o4uiu"
ELSE
	SELECT 0
	USE (LOCFILE("nombres.dbf","DBF","Where is nombres?"));
		AGAIN ALIAS nombres ;
		ORDER TAG "_rtf0o4uiu"
ENDIF

IF USED("gestion")
	SELECT gestion
	SET ORDER TO TAG "_rtc12dspz"
ELSE
	SELECT 0
	USE (LOCFILE("gestion.dbf","DBF","Where is gestion?"));
		AGAIN ALIAS gestion ;
		ORDER TAG "_rtc12dspz"
ENDIF


select 0
use turnado order turnado0
select 0
use claves  order Claves

xcampo = 8

*
********************************************************************
* MENU del sistema
********************************************************************
*
DEFINE PAD _msm_edit OF _MSYSMENU PROMPT "Edici�n" COLOR SCHEME 3 ;
	KEY ALT+E, "" ;
	MESSAGE "Manipulaci�n de Textos y Objeto OLE"
ON PAD _msm_edit    OF _MSYSMENU ACTIVATE POPUP _medit
*
DEFINE POPUP _medit MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR _med_undo OF _medit PROMPT "\<Deshacer" ;
	KEY CTRL+Z, "Ctrl+Z" ;
	MESSAGE "Deshace la �ltima acci�n de edici�n"
DEFINE BAR _med_redo OF _medit PROMPT "\<Repetir" ;
	KEY CTRL+R, "Ctrl+R" ;
	MESSAGE "Repite la �ltima acci�n de edici�n"
DEFINE BAR _med_sp100 OF _medit PROMPT "\-"
DEFINE BAR _med_cut OF _medit PROMPT "Cor\<tar" ;
	KEY CTRL+X, "Ctrl+X" ;
	MESSAGE "Corta la selecci�n y la coloca en el portapapeles"
DEFINE BAR _med_copy OF _medit PROMPT "\<Copiar" ;
	KEY CTRL+C, "Ctrl+C" ;
	MESSAGE "Copia la selecci�n y la coloca en el portapapeles"
DEFINE BAR _med_paste OF _medit PROMPT "\<Pegar" ;
	KEY CTRL+V, "Ctrl+V" ;
	MESSAGE "Inserta el contenido del portapapeles en el punto de inserci�n"
DEFINE BAR _med_pstlk OF _medit PROMPT "Pegado E\<special..." ;
	MESSAGE "Inserta el contenido del portapapeles como un objeto vinculado, incrustado o con otro formato"
DEFINE BAR _med_clear OF _medit PROMPT "Borrar" ;
	MESSAGE "Elimina la selecci�n sin colocarla en el portapapeles"
DEFINE BAR _med_sp200 OF _medit PROMPT "\-"
DEFINE BAR _med_insob OF _medit PROMPT "\<Insertar Objecto..." ;
	MESSAGE "Incrusta un Objeto"
DEFINE BAR _med_obj OF _medit PROMPT "\<Objeto..." ;
	MESSAGE "Activa el Objecto OLE"
DEFINE BAR _med_link OF _medit PROMPT "Cambiar Obj\<eto..." ;
	MESSAGE "Abre el Objeto para que pueda ser modificado"
DEFINE BAR _med_cvtst OF _medit PROMPT "Con\<vierte a Est�tico" ;
	MESSAGE "Cambia el Objecto vinculado o incrustado a una imagen est�tica"
DEFINE BAR _med_sp300 OF _medit PROMPT "\-"
DEFINE BAR _med_slcta OF _medit PROMPT "Seleccionar \<Todo" ;
	KEY CTRL+Y, "Ctrl+Y" ;
	MESSAGE "Seleccionar todos las lineas del texto"
DEFINE BAR _med_sp400 OF _medit PROMPT "\-"
DEFINE BAR _MWI_ROTAT OF _medit PROMPT '\<Cambiar Ventana' ;
	key Ctrl+F1, 'Ctrl + F1' ;
	MESSAGE "Activa la siguiente ventana"
DEFINE BAR 20 OF _medit PROMPT 'Calc\<uladora' ;
	KEY Ctrl+F2, 'Ctrl + F2' ;
	MESSAGE "Calculadora"

ON SELECTION BAR 20 OF _medit do xcal


*
********************************************************************
* pantalla de menu
********************************************************************
*
SELECT gestion
*
DEFINE WINDOW wgestion ;
	AT  0.000, 0.000  ;
	SIZE 33.615,110.167 ;
	TITLE "Gestion" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	FLOAT ;
	CLOSE ;
	NOMINIMIZE ;
	COLOR RGB(,,,192,192,192);
	SYSTEM
MOVE WINDOW wgestion CENTER



*       *********************************************************
*       *                                                         
*       *         GESTION/Windows Setup Code - SECTION 2          
*       *                                                         
*       *********************************************************
*

#REGION 1

#DEFINE C_DBFEMPTY		'Database is empty, add a record?'
#DEFINE C_EDITS			'Please finish your edits.'
#DEFINE C_TOPFILE		'Top of file.'
#DEFINE C_ENDFILE		'End of file.'
#DEFINE C_BRTITLE		'Locate Record'
#DEFINE C_NOLOCK		'Sorry, could not lock record -- try again later.'
#DEFINE C_ECANCEL		'Edits Canceled.'
#DEFINE C_DELREC		'Delete selected record?'
#DEFINE C_NOFEAT		'Feature not available yet.'
#DEFINE C_NOWIZ			'Wizard application is not available.'
#DEFINE C_MAKEREPO		'Creating report with Report Wizard.'
#DEFINE C_NOREPO		'Could not create report.'
#DEFINE C_DELNOTE 		'Deleting records...'
#DEFINE C_READONLY 		'Table is read-only. No editing allowed.'
#DEFINE C_NOTABLE 		'No table selected. Open table or run query.'
#DEFINE C_BADEXPR		'Invalid expression.'
#DEFINE C_LOCWIZ		'Locate WIZARD.APP:'
#DEFINE C_MULTITABLE	'You have multiple related tables. Adding records in not allowed.'

MOVE WINDOW 'wGestion' CENTER
PRIVATE isediting,isadding,wztblarr
PRIVATE wzolddelete,wzolderror,wzoldesc
PRIVATE wzalias, tempcurs,wzlastrec
PRIVATE isreadonly,find_drop,is2table

IF EMPTY(ALIAS())
	WAIT WINDOW C_NOTABLE
	RETURN
ENDIF

m.wztblarr= ''
m.wzalias=SELECT()
m.isediting=.F.
m.isadding=.F.
m.is2table = .F.
m.wzolddelete=SET('DELETE')
SET DELETED ON
m.tempcurs=SYS(2015)  &&used if General field
m.wzlastrec = 1
m.wzolderror=ON('error')

*ON ERROR DO wizerrorhandler

wzoldesc=ON('KEY','ESCAPE')
ON KEY LABEL ESCAPE
m.find_drop = IIF(_DOS,0,2)

m.isreadonly=IIF(ISREAD(),.T.,.F.)
IF m.isreadonly
	WAIT WINDOW C_READONLY TIMEOUT 1
ENDIF

select nombres
count to x for !deleted()
if x>0
	dimension ADE(x,2)
else
	dimension ADE(1,2)
EndIf 	
go top
contador =1
Do while contador<=x
	store nombres.nombre + " (" + str(recno(),4)+") " to ade(contador,1)
    store nombres.area   to ade(contador,2)		
	contador = contador + 1
	skip
Enddo

Select gestion

IF RECCOUNT()=0 AND !m.isreadonly AND fox_alert(C_DBFEMPTY)
    APPEND BLANK
    *GO BOTTOM    NO FUNCIONO
    *replace wpsystem  with  wpsystem2
ENDIF

GOTO TOP
SCATTER MEMVAR MEMO

*       *********************************************************
*       *                                                         
*       *              GESTION/Windows Screen Layout              
*       *                                                         
*       *********************************************************
*


dimension aLstUD[1, 2]
aLstUD     = ''
xnMxLstUD  = 0
xLstUD     = 0
*
dimension aLstUA[1, 2]
aLstUA     = ''
xnMxLstUA  = 0
xLstUA     = 0




#REGION 1
*
*********************************************************************
* pantalla
*********************************************************************
*
ACTIVATE WINDOW wGestion
*
@ 4.538,0.500 TO 4.538,108.833 ;
	PEN 2, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 7.538,3.000 SAY "Procedencia" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 9.308,3.000 SAY "Area" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 7.615,57.333 SAY "Dirigido a" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
*
@ 12.308,62.000 SAY "# Oficio Recibido" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 16.462,3.000 SAY "Asunto" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 12.077,3.000 SAY "Tipo Doc." ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 5.385,3.000 SAY "Status" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 25.615,3.000 SAY "Archivar en" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 13.846,3.000 SAY "Instrucci�n" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 9.385,57.333 SAY "Area" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 0.769,91.167 SAY "Folio" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.077,91.167 SAY "Fecha" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 3.308,91.167 SAY "Hora" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 4.615,0.500 TO 4.615,108.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.923,0.833 TO 10.923,108.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 7.000,1.000 TO 11.000,108.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 15.769,0.833 TO 24.615,108.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 15.846,1.000 TO 24.692,108.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 11.308,0.833 TO 15.385,108.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 11.385,1.000 TO 15.462,108.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 25.000,0.833 TO 27.154,108.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 25.077,1.000 TO 27.231,108.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 0.923,1.167 SAY "Gestion" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(255,255,255,,,,)
@ 0.846,1.000 SAY "Gestion" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,,,,)
@ 29.923,1.167 TO 29.923,109.500 ;
	PEN 2, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 30.000,1.167 TO 30.000,109.334 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
*
=gwinname(program())
*
*********************************************************************
* funcion general
*********************************************************************
*
@ 0.692,98.167 GET m.folio ;
	SIZE 1.000,11.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "9999" ;
	WHEN isediting ;
	VALID !empty(m.folio) ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 2.000,98.167 GET m.finrec ;
	SIZE 1.000,11.600 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	WHEN isediting ;
	VALID !empty(m.finrec) ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 3.231,98.167 GET m.hora ;
	SIZE 1.000,11.600 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99:99" ;
	WHEN isediting ;
	VALID !empty(m.finrec) ;
	COLOR ,RGB(0,0,0,255,255,255)
*
@ 5.231,14.500 GET m.status ;
	PICTURE "@^ En tr�mite;Archivado;Recibido" ;
	SIZE 1.538,21.800 ;
	DEFAULT "En tr�mite" ;
	FONT "MS Sans Serif", 8 ;
	WHEN isediting
*
@ 7.462,14.500 GET m.de ;
	PICTURE "@^" ;
	FROM ade ;
	SIZE 1.538,49.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN isediting ;
	VALID _rur12xwk4()
@ 9.231,14.833 GET m.areade ;
	SIZE 1.000,48.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	DISABLE ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 7.538,65.667 GET m.Para ;
	PICTURE "@^" ;
	FROM ade ;
	SIZE 1.538,49.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN isediting ;
	VALID _rur12xwl9()
@ 9.308,66.000 GET m.areap ;
	SIZE 1.000,48.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	DISABLE ;
	COLOR ,RGB(0,0,0,255,255,255)
*
@ 11.769,14.500 GET m.tipo ;
	PICTURE "@^ Oficio Original ;Copia de oficio;Volante de Turno ;CD ;Correo Electr�nico ;Circular ;Nota Informativa ;Otros" ;
	SIZE 1.538,21.600 ;
	DEFAULT "Oficio Original " ;
	FONT "MS Sans Serif", 8 ;
	WHEN isediting
@ 13.462,14.500 GET m.instruc ;
	PICTURE "@^ ATENCION;Comentario;Enviar Oficio de Resp.;Elaborar Informe y Comentar;Conocimiento;Preparar Nota Informativa;Archivar;Asistir en Representaci�n;Otro" ;
	SIZE 1.538,31.200 ;
	DEFAULT "." ;
	FONT "MS Sans Serif", 8 ;
	WHEN isediting
*
@ 12.308,77.167 GET m.noof ;
	SIZE 1.000,34.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	WHEN isediting ;
	COLOR ,RGB(0,0,0,255,255,255)
*
@ 16.538,14.833 EDIT m.resumen ;
	SIZE 7.538,110.000,0.000 ;
	PICTURE "@K" ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	SCROLL ;
	WHEN isediting ;
	COLOR ,RGB(0,0,0,255,255,255)
*
@ 25.692,14.833 GET m.asunto ;
	SIZE 1.000,69.200 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN isediting ;
	COLOR ,RGB(0,0,0,255,255,255)
*
@ 30.231,1.667 GET m.top_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wztop.bmp","BMP|ICO|PCT|ICN","Where is wztop?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('TOP') ;
	MESSAGE 'Go to first record.'
@ 30.231,6.500 GET m.prev_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzback.bmp","BMP|ICO|PCT|ICN","Where is wzback?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('PREV') ;
	MESSAGE 'Go to previous record.'
@ 30.231,11.333 GET m.next_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wznext.bmp","BMP|ICO|PCT|ICN","Where is wznext?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('NEXT') ;
	MESSAGE 'Go to next record.'
@ 30.231,16.000 GET m.end_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzend.bmp","BMP|ICO|PCT|ICN","Where is wzend?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('END') ;
	MESSAGE 'Go to last record.'
*
@ 30.231,22.167 GET m.add_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wznew.bmp","BMP|ICO|PCT|ICN","Where is wznew?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('ADD') ;
	MESSAGE 'Add a new record.'
@ 30.231,27.000 GET m.edit_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzedit.bmp","BMP|ICO|PCT|ICN","Where is wzedit?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('EDIT') ;
	MESSAGE 'Edit current record.'
@ 30.231,31.833 GET m.del_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzdelete.bmp","BMP|ICO|PCT|ICN","Where is wzdelete?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('DELETE') ;
	MESSAGE 'Delete current record.'
*
@ 30.231,37.667 GET m.loc_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzlocate.bmp","BMP|ICO|PCT|ICN","Where is wzlocate?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('LOCATE') ;
	MESSAGE 'Locate a record.'
@ 30.231,48.500 GET m.save_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzsave.bmp","BMP|ICO|PCT|ICN","Where is wzsave?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('SAVE') ;
	MESSAGE 'Save edits.'
@ 30.231,53.167 GET m.can_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzundo.bmp","BMP|ICO|PCT|ICN","Where is wzundo?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('CANCEL') ;
	MESSAGE 'Cancel edits.'
*
@ 30.231,42.333 GET m.prnt_btn ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\wzprint.bmp","BMP|ICO|PCT|ICN","Where is wzprint?")) ;
	SIZE 2.077,4.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	VALID btn_val('PRINT') ;
	MESSAGE 'Print report.'
*
@ 30.385,61.000 GET m.busca ;
	PICTURE "@*HN Buscar" ;
	SIZE 1.923,11.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID btn_val('BUSCA') ;
	MESSAGE 'Busca un documento'
@ 30.385,71.000 GET m.newfunc ;
	PICTURE "@*HN Nuevo Funcionario" ;
	SIZE 1.923,23.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID btn_val('ADDFUNC') ;
	MESSAGE 'Agrega los datos de un nuevo funcionario'
*
@ 27.769,78.500 GET xTurnado ;
	PICTURE "@*HN \<Turnado" ;
	SIZE 1.923,11.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xTurnado(m.folio)
@ 27.769,88.333 GET xClaves ;
	PICTURE "@*HN \<Claves" ;
	SIZE 1.923,11.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xclaves()
@ 27.769,98.167 GET xReporte ;
	PICTURE "@*HN \<Reporte" ;
	SIZE 1.923,11.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID repgest()
*
@ 30.231,97.333 GET m.exit_btn ;
	PICTURE "@*HN Salir" ;
	SIZE 2.077,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID btn_val('EXIT') ;
	MESSAGE 'Close screen.'


IF NOT WVISIBLE("wGestion")
	ACTIVATE WINDOW wGestion
ENDIF


*       *********************************************************
*       *                                                         
*       *    WindowsREAD contains clauses from SCREEN s5406886    
*       *                                                         
*       *********************************************************
*

READ CYCLE ;
	ACTIVATE READACT() ;
	DEACTIVATE READDEAC() ;
	NOLOCK

RELEASE WINDOW wGestion

*       *********************************************************
*       *                                                         
*       *                Windows Closing Databases                
*       *                                                         
*       *********************************************************
*

IF USED("nombres")
	SELECT nombres
	USE
ENDIF

IF USED("gestion")
	SELECT gestion
	USE
ENDIF

SELECT (m.currarea)


#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF




*       *********************************************************
*       *                                                         
*       *              GESTION/Windows Cleanup Code               
*       *                                                         
*       *********************************************************
*

#REGION 1
SET DELETED &wzolddelete
SET FIELDS &wzfields
ON ERROR &wzolderror
ON KEY LABEL ESCAPE &wzoldesc
DO CASE
CASE _DOS AND SET('DISPLAY')='VGA25'
	@24,0 CLEAR TO 24,79
CASE _DOS AND SET('DISPLAY')='VGA50'
	@49,0 CLEAR TO 49,79
CASE _DOS
	@24,0 CLEAR TO 24,79
ENDCASE
*
********************************************************************
* funcion final
********************************************************************
*
do xreconfigura
*
return





procedure xReconfigura
************
* PROGRAMA : xReconfigura
* OBJETIVO : Reconfigura Fox a como estaba antes
************
clear
                                       ****************************************
                                       *LIBERA VARIABLES
                                       ****************************************
release GNOMGPO, GNOMSIS, GVERSION, GTONO
release GINIDATE, GHELPCVE, GHELPINT, XINVALIDA, ;
        GEJECUTA, GSALIRAPP
release GOPCIONES,GUSUARIO
release ALL LIKE G*
*
ON KEY LABEL F9 
*
RELEASE linea, doblelinea, ejecuta 
*
clear window all
deactivate window all
release window all
set sysmenu to default
set udfparms to value
set talk on
set exclusive on
modify window screen title Old_WTitle
restore macros from tmpmacro
erase tmpmacro.fky
close all
*
on error 
*
return



*
*
*                     P R O C E D I M I E N T O S
*
*

#REGION 1
PROCEDURE readdeac
  IF isediting
    ACTIVATE WINDOW 'wGestion'
    WAIT WINDOW C_EDITS NOWAIT
  ENDIF
  IF !WVISIBLE(WOUTPUT())
    CLEAR READ
    RETURN .T.
  ENDIF
RETURN .F.

PROCEDURE readact
  IF !isediting
  	SELECT (m.wzalias)
  	SHOW GETS
  ENDIF
  DO REFRESH
RETURN

PROCEDURE wizerrorhandler
	* This very simple error handler is primarily intended
	* to trap for General field OLE errors which may occur
	* during editing from the MODIFY GENERAL window.
	WAIT WINDOW message()
RETURN


PROCEDURE printrec
	  PRIVATE sOldError,wizfname,saverec,savearea,tmpcurs,tmpstr
	  PRIVATE prnt_btn,p_recs,p_output,pr_out,pr_record,fdel,fal,formato
      Store 1 to formato
      Store date() TO FDEL
      sTORE date() TO FAL
	  STORE 1 TO p_recs,p_output
	  STORE 0 TO prnt_btn
	  STORE RECNO() TO saverec
	  m.sOldError=ON('error')
	  DO pdialog
	  IF m.prnt_btn = 2
	    RETURN
	  ENDIF
*	  IF !FILE(ALIAS()+'.FRX')
*	  	m.wizfname=SYS(2004)+'WIZARDS\'+'WIZARD.APP'
*	  	IF !FILE(m.wizfname)
*			ON ERROR *
*			m.wizfname=LOCFILE('WIZARD.APP','APP',C_LOCWIZ)
*			ON ERROR &sOldError
*			IF !'WIZARD.APP'$UPPER(m.wizfname)
*     			WAIT WINDOW C_NOWIZ
*    			RETURN
*			ENDIF
*	  	ENDIF
*    	WAIT WINDOW C_MAKEREPO NOWAIT
*		m.savearea=SELECT()
*		m.tmpcurs='_'+LEFT(SYS(3),7)
*		CREATE CURSOR (m.tmpcurs) (comment m)
*		m.tmpstr = '* LAYOUT = COLUMNAR'+CHR(13)+CHR(10)
*		INSERT INTO (m.tmpcurs) VALUES(m.tmpstr)
*		SELECT (m.savearea)
*	  	DO (m.wizfname) WITH '','WZ_QREPO','NOSCRN/CREATE',ALIAS(),m.tmpcurs
*		USE IN (m.tmpcurs)
*     	WAIT CLEAR
*	  	IF !FILE(ALIAS()+'.FRX')  &&wizard could not create report
*     		WAIT WINDOW C_NOREPO
*     		RETURN
*	  	ENDIF
*	  ENDIF
      
      zrecno = recno()
      
	  DO CASE
	     CASE WAREAT = 'Planeacion'
	    	  m.repname=IIF(m.formato=1,'Gestion1','gestionl')
	     CASE WAREAT = 'DG'
         	  m.repname=IIF(m.formato=1,'Gestion5','gestionl')
  	     CASE WAREAT = 'GAJ'
         	  m.repname=IIF(m.formato=1,'Gestion2','gestionl')
         CASE WAREAT = 'CAF'
         	  m.repname=IIF(m.formato=1,'Gestion3','gestionl')
         CASE WAREAT = 'DPRE'
         	  m.repname=IIF(m.formato=1,'Gestion4','gestionl')
         CASE WAREAT = 'OIC'
         	  m.repname=IIF(m.formato=1,'Gestion6','gestionl')      
      ENDCASE      
      
	  *m.repname=IIF(m.formato=1,'Gestion1','gestionl')
	  
  	  m.pr_out=IIF(m.p_output=1,'TO PRINT NOCONSOLE','PREVIEW')
	  m.pr_record=IIF(m.p_recs=1,'record ' + alltrim(str(zrecno)),'FOR FINREC>=ctod("'+dtoc(m.fdel)+'")'+' and finrec<=ctod("'+dtoc(m.fal)+'")')
  	  REPORT FORM (m.repname) &pr_out &pr_record
	  GO m.saverec
RETURN


PROCEDURE BTN_VAL
	PARAMETER m.btnname
	DO CASE
	CASE  m.btnname='TOP'
		GO TOP
		WAIT WINDOW C_TOPFILE NOWAIT
	CASE  m.btnname='BUSCA'
	      do xbusca
	CASE  m.btnname='PREV'
		IF !BOF()
			SKIP -1
	 	ENDIF
	 	IF BOF()
			WAIT WINDOW C_TOPFILE NOWAIT
			GO TOP
		ENDIF
	CASE  m.btnname='NEXT'
		IF !EOF()
			SKIP 1
		ENDIF
		IF EOF()
			WAIT WINDOW C_ENDFILE NOWAIT
			GO BOTTOM
		ENDIF
	CASE  m.btnname='END'
		GO BOTTOM
		WAIT WINDOW C_ENDFILE NOWAIT
	CASE  m.btnname='LOCATE'
		DO loc_dlog
	CASE  m.btnname=='ADD'  AND !isediting &&add record
	    close index  
        set order to 1
		isediting=.T.
		isadding=.T.
		=edithand('ADD')
		_curobj=1
		DO refresh
		SHOW GETS
		RETURN
	CASE  m.btnname=='ADDFUNC'
	    do ADDFUNC
		
	CASE  m.btnname='EDIT'  AND !isediting &&edit record
		IF EOF() OR BOF()
			WAIT WINDOW C_ENDFILE NOWAIT
			RETURN
		ENDIF
		IF RLOCK()
			isediting=.T.
			_curobj=1
			DO refresh
			RETURN
		ELSE
			WAIT WINDOW C_NOLOCK
			RETURN
		ENDIF
	CASE m.btnname='SAVE'  AND isediting &&save record
		IF isadding
			=edithand('SAVE')
			replace wpsystem  with  wpsystem2
		ELSE
		    m.de = substr(m.de,1,60)
		    m.para = substr(m.para,1,60)
			GATHER MEMVAR MEMO
		ENDIF
		UNLOCK
		isediting=.F.
		isadding=.F.
		DO refresh
	CASE m.btnname='CANCEL'  AND isediting &&cancel record
		IF isadding
			=edithand('CANCEL')
		ENDIF
		isediting=.F.
		isadding=.F.
		UNLOCK
		WAIT WINDOW C_ECANCEL NOWAIT
		DO refresh
	CASE m.btnname='DELETE'
		IF EOF() OR BOF()
			WAIT WINDOW C_ENDFILE NOWAIT
			RETURN
		ENDIF
		IF fox_alert(C_DELREC)
			DELETE
			IF !EOF() AND DELETED()
				SKIP 1
			ENDIF
			IF EOF()
				WAIT WINDOW C_ENDFILE NOWAIT
				GO BOTTOM
			ENDIF
		ELSE
			RETURN	
		ENDIF
	CASE m.btnname='PRINT'
		DO printrec
		RETURN
	CASE m.btnname='EXIT'
		m.bailout=.T.	&&this is needed if used with FoxApp
		CLEAR READ
		RETURN
	OTHERWISE
		RETURN	
	ENDCASE
	SCATTER MEMVAR MEMO
	SHOW GETS
RETURN


PROCEDURE REFRESH
  DO CASE
  CASE m.isreadonly AND RECCOUNT()=0
	SHOW GETS DISABLE
	SHOW GET exit_btn ENABLE
  CASE m.isreadonly
	SHOW GET add_btn DISABLE
	SHOW GET edit_btn DISABLE
	SHOW GET del_btn DISABLE
	SHOW GET save_btn DISABLE
	SHOW GET can_btn DISABLE
  CASE (RECCOUNT()=0 OR EOF()) AND !m.isediting
	SHOW GETS DISABLE
	SHOW GET add_btn ENABLE
	SHOW GET exit_btn ENABLE
  CASE m.isediting
    SHOW GET busca    DISABLE
    SHOW GET newfunc  DISABLE
    SHOW GET xTurnado DISABLE
    SHOW GET xClaves  DISABLE
    SHOW GET xReporte DISABLE
    *
    SHOW GET find_drop DISABLE
	SHOW GET top_btn DISABLE
	SHOW GET prev_btn DISABLE
	SHOW GET loc_btn DISABLE
	SHOW GET next_btn DISABLE
	SHOW GET end_btn DISABLE
	SHOW GET add_btn DISABLE
	SHOW GET edit_btn,1 DISABLE
	SHOW GET del_btn,1 DISABLE
	SHOW GET prnt_btn DISABLE
	SHOW GET exit_btn DISABLE
	SHOW GET save_btn ENABLE
	SHOW GET can_btn ENABLE

	ON KEY LABEL ESCAPE DO BTN_VAL WITH 'CANCEL'
	RETURN
  OTHERWISE
    SHOW GET busca ENABLE
    SHOW GET newfunc ENABLE
    SHOW GET xTurnado ENABLE
    SHOW GET xClaves  ENABLE
    SHOW GET xReporte ENABLE
    *    
    SHOW GET find_drop ENABLE
	SHOW GET top_btn ENABLE
	SHOW GET prev_btn ENABLE
	SHOW GET loc_btn ENABLE
	SHOW GET next_btn ENABLE
	SHOW GET end_btn ENABLE
	SHOW GET add_btn ENABLE
	SHOW GET edit_btn,1 ENABLE
	SHOW GET del_btn,1 ENABLE
	SHOW GET prnt_btn ENABLE
	SHOW GET exit_btn ENABLE
	SHOW GET save_btn DISABLE
	SHOW GET can_btn DISABLE
  ENDCASE
  IF m.is2table
  	SHOW GET add_btn DISABLE
  ENDIF
  ON KEY LABEL ESCAPE
RETURN

PROCEDURE edithand
	PARAMETER m.paction
	* procedure handles edits
	DO CASE
	CASE m.paction = 'ADD'
		SCATTER MEMVAR MEMO BLANK
		go bottom
		m.folio=replicate('0',4-len(alltrim(str(val(folio)+1))))+        alltrim(str(val(folio)+1))
        m.finrec=date()
        m.hora = time()
	CASE m.paction = 'SAVE'
	    m.de = substr(m.de,1,60)
	    m.para = substr(m.para,1,60)	    
		INSERT INTO (ALIAS()) FROM MEMVAR
	CASE m.paction = 'CANCEL'
		* nothing here
	ENDCASE
RETURN

PROCEDURE fox_alert
    PARAMETER wzalrtmess
    PRIVATE alrtbtn
    m.alrtbtn=2
	DEFINE WINDOW _qec1ij2t7 AT 0,0 SIZE 8,50 ;
	  FONT "MS Sans Serif",10 STYLE 'B' ;
	  FLOAT NOCLOSE NOMINIMIZE DOUBLE TITLE WTITLE()
	MOVE WINDOW _qec1ij2t7 CENTER
	ACTIVATE WINDOW _qec1ij2t7 NOSHOW
	@ 2,(50-txtwidth(wzalrtmess))/2 SAY wzalrtmess;
	  FONT "MS Sans Serif", 10 STYLE "B"
	@ 6,18 GET m.alrtbtn ;
	  PICTURE "@*HT \<OK;\?\!\<Cancel" ;
	  SIZE 1.769,8.667,1.333 ;
	  FONT "MS Sans Serif", 8 STYLE "B"
	ACTIVATE WINDOW _qec1ij2t7
	READ CYCLE MODAL
	RELEASE WINDOW _qec1ij2t7
RETURN m.alrtbtn=1


PROCEDURE pdialog
	DEFINE WINDOW _qjn12zbvh ;
		AT  0.000, 0.000  ;
		SIZE 18.231,60 ;
		TITLE "Microsoft FoxPro" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT NOCLOSE MINIMIZE SYSTEM
	MOVE WINDOW _qjn12zbvh CENTER
	ACTIVATE WINDOW _qjn12zbvh NOSHOW
	@ 2.846,33.600 SAY "Ver en:"  ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT"
	@ 2.846,4.800 SAY "Impresora:"  ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT"
	@ 4.692,7.200 GET m.p_recs ;
		PICTURE "@*RVN \<Registro Actual;\<Selecci�n" ;
		SIZE 1.308,18.500,0.308 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT"
	@ 8.0,7.200 GET m.fdel ;
		PICTURE "@D" ;
		SIZE 1.308,18.500,0.308 ;
		DEFAULT date();
		FONT "MS Sans Serif", 8 ;
		STYLE "BT";
		Message "Fecha Inicial";
		When m.p_recs=2
	@ 9.0,7.200 GET m.fal ;
		PICTURE "@D" ;
		SIZE 1.308,18.500,0.308 ;
		DEFAULT date() ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT";
		Message "Fecha final Final";
		When m.p_recs=2
	@10.5,7.2 Get m.formato;
		PICTURE "@*RHN \<Formato;\<Listado" ;
		SIZE 1.308,12.000,0.308 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT"
		
	@ 4.692,36.000 GET m.p_output ;
		PICTURE "@*RVN \<Impresora;Pre\<ver" ;
		SIZE 1.308,12.000,0.308 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "BT"
	@ 12.154,16.600 GET m.prnt_btn ;
		PICTURE "@*HT Im\<prime;Ca\<ncela" ;
		SIZE 1.769,8.667,0.667 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B"
	ACTIVATE WINDOW _qjn12zbvh
	READ CYCLE MODAL
	RELEASE WINDOW _qjn12zbvh
RETURN


PROCEDURE loc_dlog
	PRIVATE gfields,i
	DEFINE WINDOW wzlocate FROM 1,1 TO 20,40;
		SYSTEM GROW CLOSE ZOOM FLOAT FONT "MS Sans Serif",8
	MOVE WINDOW wzlocate CENTER
	m.gfields=SET('FIELDS',2)
	IF !EMPTY(RELATION(1))
		SET FIELDS ON
		IF m.gfields # 'GLOBAL'
			SET FIELDS GLOBAL
		ENDIF
		IF EMPTY(FLDLIST())
			m.i=1
			DO WHILE !EMPTY(OBJVAR(m.i))
				IF ATC('M.',OBJVAR(m.i))=0
					SET FIELDS TO (OBJVAR(m.i))
				ENDIF
				m.i = m.i + 1
			ENDDO
		ENDIF
	ENDIF
	BROWSE WINDOW wzlocate NOEDIT NODELETE ;
		NOMENU TITLE C_BRTITLE
	SET FIELDS &gfields
	SET FIELDS OFF
	RELEASE WINDOW wzlocate
RETURN


Procedure ADDFUNC
	select nombres
	do nombres
	count to x for !deleted()
	if x>0
		dimension ADE(x,2)
	else
		dimension ADE(1,2)
	EndIf 	
	go top
	contador =1
	Do while contador<=x
       store nombres.nombre + " (" + str(recno(),4)+") " to ade(contador,1)
       store nombres.area   to ade(contador,2)		
       contador = contador + 1
	   skip
	Enddo
	Select gestion
Return 		


*       *********************************************************
*       *                                                         
*       * _RUR12XWK4           m.de VALID                         
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         GESTION,     Record Number:   14   
*       * Variable:            m.de                               
*       * Called By:           VALID Clause                       
*       * Object Type:         Popup                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _rur12xwk4     &&  m.de VALID
#REGION 1
Select Nombres

rno=val(substr(m.de,63,4))
if rno <> 0 then 
   go rno
   M.AREADE=nombres.area
else 
   M.AREADE=space(60)
endif    

Show get m.areade
Select Gestion

*       *********************************************************
*       *                                                         
*       * _RUR12XWL9           m.para VALID                       
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         GESTION,     Record Number:   17   
*       * Variable:            m.para                             
*       * Called By:           VALID Clause                       
*       * Object Type:         Popup                              
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _rur12xwl9     &&  m.para VALID
#REGION 1
select nombres

rno=val(substr(m.para,63,4))
if rno <> 0 then 
   go rno
   M.AREAp=nombres.area
else 
   M.AREAp=space(60)
endif    

Show get m.areap
Select gestion


Procedure xbusca 
	DEFINE WINDOW wbusca ;
		AT  0.000, 0.000  ;
		SIZE 27.538,98.400 ;
		TITLE "Buscar" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM
	MOVE WINDOW wbusca CENTER
    ACTIVATE WINDOW wbusca
@ 6.538,4.800 GET xcampo ;
	PICTURE "@*RVN Procedencia ;Area de Procedencia;Dirigido a;Area Destino ;Asunto;Status;Turnado ;Folio;Instruccion;Tipo de doc.;No. Of.;Fecha de recibo " ;
	SIZE 1.308,23.833,0.308 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 3.769,4.400 SAY "Campo:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 3.769,57.200 SAY "Dato:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 5.615,55.600 GET m.strBusca ;
	SIZE 1.000,37.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K"
READ  modal
release window wbusca 

		If alltrim(m.StrBusca)==''
		   close index 
		   set order to 1
		Else 
		   DO case 
		      case xcampo = 1
		           Locate for alltrim(upper(m.StrBusca))$alltrim(upper(De))
                   if found() 
                      index on de to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(De))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
		      case xcampo = 2
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Areade))
                   if found() 
                      index on areade to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Areade))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
		      case xcampo = 3
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Para))
                   if found() 
                      index on Para to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Para))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
		      case xcampo = 4
                   Locate for alltrim(upper(m.StrBusca))$upper(alltrim(AreaP))
                   if found() 
                      index on AreaP to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(AreaP))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Case xcampo = 5
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Resumen))
                   if found() 
                      index on Folio to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Resumen))
                   Else 
                      WAIT WINDOW "No se encontro el documento"
                      go top 
                   EndIf 	  
              Case xcampo = 6    
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Status))
                   if found() 
                      index on Status to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Status))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Case xcampo = 7    
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Turnado))
                   if found() 
                      index on Turnado to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Turnado))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Case xcampo = 8    
                   *Locate for alltrim(m.StrBusca)$folio

                   index on folio to idxtmp for alltrim(m.StrBusca)$folio
                   go top
                   if eof()
                      set index to 
                   endif
                   
*                   if found() 
*                      index on folio to idxtmp for alltrim(m.StrBusca)$folio
*                   Else 
*                	  WAIT WINDOW "No se encontro el documento"
*                	  go top 
*                   EndIf 	                     
              Case xcampo = 9    
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Instruc))
                   if found() 
                      index on Instruc to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(Instruc))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	 
              Case xcampo = 10    
                   Locate for alltrim(upper(m.StrBusca))$alltrim(upper(Tipo))
                   if found() 
                      index on NoOf+tipo to idxtmp for alltrim(upper(m.StrBusca))$alltrim(upper(tipo))
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Case xcampo = 11    
                   Locate for alltrim(m.StrBusca)$NoOf
                   if found() 
                      index on NoOf+tipo to idxtmp for alltrim(m.StrBusca)$NoOf
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Case xcampo = 12    
                   Locate for ctod(alltrim(m.StrBusca))=finrec
                   if found() 
                      index on dtos(finrec)+NoOf+tipo to idxtmp for ctod(alltrim(m.StrBusca))=finrec
                   Else 
                	  WAIT WINDOW "No se encontro el documento"
                	  go top 
                   EndIf 	  
              Endcase      

        ***   m.StrBusca = ''
                   
        EndIf            
Return 


procedure nada
report form gestion
report form gestionl
return 

procedure xCal
************
* PROGRAMA : xCal
* OBJETIVO : Calculadora
************
*
! /N calc.EXE
*
return


procedure xJalaImagenes
************
* PROGRAMA : xJalaImagenes
* OBJETIVO : Jalar las Imagenes para general el Ejecutable
************
*
@ 0.000,0.000 SAY ;
   (LOCFILE( "bmps\tapete0.bmp","BMP|ICO|PCT|ICN", "Where is Tapete0?" )) BITMAP ;
	SIZE 13.083,18.750 ;
	STYLE "T"
*
return
