   �   !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Arial                          ?  )  winspool  Enviar a OneNote 2013  nul:                                                   �Enviar a OneNote 2013            � �/    �
od   X  X  Letter                                                        ����                DINU" � �  ���                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         �   SMTJ     � S e n d   t o   M i c r o s o f t   O n e N o t e   1 5   D r i v e r   RESDLL UniresDLL PaperSize LETTER Orientation PORTRAIT Resolution DPI600 ColorMode 24bpp                                                   �DRIVER=winspool
DEVICE=Enviar a OneNote 2013
OUTPUT=nul:
ORIENTATION=0
PAPERSIZE=1
COPIES=1
DEFAULTSOURCE=1
PRINTQUALITY=600
COLOR=2
YRESOLUTION=600
                                     GESTION.DBF                    GESTION                        
_RTC12DSPZ                     Arial                          "Procedencia:"                 De                             Arial                          Arial                          "Dirigido a:"                  Para                           Arial                          Gestion.areade                 Arial                          Gestion.areap                  Arial                          Gestion.resumen                Arial                          Gestion.asunto                 Arial                          Arial                          "Archivar en :"                Arial                          	"Asunto:"                      Arial                          "Fecha:"                       Arial                          "Folio:"                       Gestion.finrec                 Arial                          $alltrim(wareat)+' - '+ Gestion.folio                                                           Arial                          Arial                          "Hora:"                        Gestion.hora                   Arial                          Arial                          "Comentario"                   Arial                          "Confidencial"                 Arial                          	"Acordar"                      Arial                          	"Lectura"                      Arial                          "Dar Respuesta"                Arial                          "Turnado a:"                   Arial                          "No. de Oficio Recibido:"      Gestion.noof                   Arial                          Arial                          "Tipo de Documento:"           Gestion.tipo                   Arial                          Arial                          "Otro  ___________________"                                     Arial                          "Volante de Turno"             Arial                          	"Urgente"                      Arial                          "Fecha:"                       Arial                          "Folio:"                       Arial                          "Hora:"                        Arial                          "Volante de Descargo"          Arial                          "Responsable"                  Arial                          "Terminado"                    Arial                          "En Proceso"                   Arial                          "Firma del Responsable"        Arial                          $"SECRETARIA DE DESARROLLO ECONOMICO"                            Arial                          9"Fondo para el Desarrollo Social  de la Ciudad de Mexico"                                      "logo_fondeso__extendido.bmp"                                   Arial                          "Conocimiento"                 Arial                          $"SECRETARIA DE DESARROLLO ECONOMICO"                            Arial                          9"Fondo para el Desarrollo Social  de la Ciudad de Mexico"                                      "logo_fondeso__extendido.bmp"                                   Arial                          #"JUD DE PRESUPUESTO Y CONTABILIDAD"                             Arial                          9"JUD DE RECURSOS MATERIALES, ABASTECIMIENTOS Y SERVICIOS"       Arial                          "Instrucci�n:"                 Arial                          
"Atenci�n"                     Arial                          "Trato ___________________"                                     Arial                          "JUD DE TESORERIA"             Arial                          "Tr�mite Normal"               Arial                          "Area que Atendi�"             Arial                          	"Tr�mite"                      $alltrim(wareat)+' - '+ Gestion.folio                                                           Arial                          Arial                          ("JUD DE ADMINISTRACION Y CAPITAL HUMANO"                        Arial                          
"Destruir"                     Arial                          
"Archivar"                     Arial                          "Asistir en Representaci�n"                                     Arial                          "Instrucci�n"                  Arial Black                    "Turnado a:"                   Arial                          >"____________________________________________________________"                                   Arial                          Arial                          Arial                          Arial                          Arial                          Arial                          Arial Black                    dataenvironment                �Left = 0
Top = 0
Width = 0
Height = 0
AutoOpenTables = .T.
AutoCloseTables = .T.
InitialSelectedAlias = "GESTION"
Name = "dataenvironment"
                nPROCEDURE Destroy
*- [CONVERTER] Restablecer tablas para compatibilidadTHIS.OpenTablesTHIS.Init
ENDPROC
                    ����    �   �                         d�   %   _       x      p           �  U   
 ��  � �
 ��  � � U  THIS
 OPENTABLES INIT Destroy,     ��1 � � 2                       c       )   �                    TABL      cursor                         �Alias = "GESTION"
Order = "_RTC12DSPZ"
CursorSource = gestion.dbf
Name = "cursor1"
                                                                                                                                             �* WIZARD = MREPORT
* WIZNAME = W:\APPS\SOF\FOXPRO\WIZARDS\WZ_MREPO.APP
* WIZCLASS = REPORT
* VERSION = 1.0
* TIMESTAMP = 611815132,00
* STYLE = EXECUTIVE
* LAYOUT = TABULAR
* TITLE = Gestion
* COLUMNS = 1,00
* TABLE = "C:\GESTION\GESTION.DBF"
* FIELDS = De;Para;Areade;Areap;Asunto;Resumen;Status;Turnado;Folio;Finrec;Fconclu;Instruc;
* SORTS = Folio;
* GROUPS = Folio;
* MODIFIERS = ;
* TOTALS = 0,00
* SUBTOTALS = 0,00
* TOPBOTTOM = 1,00
* LABELS = ;
* AVERY = 1,00
* TAGASCEND = 1,00
             