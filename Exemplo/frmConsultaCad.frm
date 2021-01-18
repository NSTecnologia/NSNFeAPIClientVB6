VERSION 5.00
Begin VB.Form frmConsultaCad 
   Caption         =   "frmConsultaCad"
   ClientHeight    =   5850
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   5505
   LinkTopic       =   "Form1"
   ScaleHeight     =   5850
   ScaleWidth      =   5505
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtRetornoCNPJ 
      Height          =   375
      Left            =   840
      TabIndex        =   17
      Top             =   2760
      Width           =   1935
   End
   Begin VB.TextBox txtRetornoIE 
      Height          =   405
      Left            =   3360
      TabIndex        =   16
      Top             =   2760
      Width           =   1935
   End
   Begin VB.TextBox txtCNPJ_CPF 
      Height          =   375
      Left            =   2760
      TabIndex        =   15
      Text            =   "34561261000283"
      Top             =   1200
      Width           =   1815
   End
   Begin VB.TextBox txtUF 
      Height          =   375
      Left            =   120
      TabIndex        =   14
      Text            =   "RN"
      Top             =   1080
      Width           =   495
   End
   Begin VB.TextBox txtCNPJCont 
      Height          =   375
      Left            =   120
      TabIndex        =   13
      Text            =   "07364617000135"
      Top             =   360
      Width           =   2535
   End
   Begin VB.ComboBox cbTtipoContrib 
      Height          =   315
      ItemData        =   "frmConsultaCad.frx":0000
      Left            =   1440
      List            =   "frmConsultaCad.frx":000D
      TabIndex        =   12
      Text            =   "CNPJ"
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox txtRetornoCep 
      Height          =   375
      Left            =   720
      TabIndex        =   4
      Top             =   4200
      Width           =   1575
   End
   Begin VB.TextBox txtRetornoXLgr 
      Height          =   375
      Left            =   720
      TabIndex        =   3
      Top             =   3720
      Width           =   4695
   End
   Begin VB.TextBox txtRetornoNome 
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Top             =   3240
      Width           =   4695
   End
   Begin VB.CommandButton cmdConsultarCad 
      Caption         =   "Consultar"
      Height          =   375
      Left            =   1920
      TabIndex        =   1
      Top             =   1800
      Width           =   1695
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "xNome"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   3240
      Width           =   555
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "CEP"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   4320
      Width           =   375
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "xLgr"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   3840
      Width           =   360
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "IE"
      Height          =   195
      Left            =   3120
      TabIndex        =   8
      Top             =   2880
      Width           =   150
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "CNPJ"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2880
      Width           =   465
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Retorno Consulta"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2400
      Width           =   1290
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "UF(ex:RS)"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   840
      Width           =   795
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BorderStyle     =   1  'Fixed Single
      Caption         =   "CNPJCont"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   795
   End
End
Attribute VB_Name = "frmConsultaCad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdConsultarCad_Click()
    On Error GoTo SAI
    Dim retorno As String
     
    Dim status As String
    Dim restContCad As String
    Dim infCons As String
    Dim auxInfCad As Variant
    Dim respInfCad As String
    Dim infCad As String
    
    Dim ie As String
    Dim cnpj As String
    Dim xNome As String
    Dim xLgr As String
    Dim nro As String
    Dim xCpl As String
    Dim xBairro As String
    Dim cMun As String
    Dim CEP As String
            
    retorno = consultarCadastroContribuinte(txtCNPJCont.Text, txtUF.Text, txtCNPJ_CPF.Text, cbTtipoContrib.Text)
    
    status = LerDadosJSON(retorno, "status", "", "")
    If (status = 200) Then
        auxInfCad = Split(retorno, """infCad"":[")
        auxInfCad = Split(auxInfCad(1), "]")
        auxInfCad = Split(auxInfCad(0), "},")

        If (UBound(auxInfCad) = 0) Then
            infCad = auxInfCad(0)

            ie = LerDadosJSON(infCad, "IE", "", "")
            cnpj = LerDadosJSON(infCad, "CNPJ", "", "")
            UF = LerDadosJSON(infCad, "UF", "", "")
            xNome = LerDadosJSON(infCad, "xNome", "", "")
            xLgr = LerDadosJSON(infCad, "ender", "xLgr", "")
            CEP = LerDadosJSON(infCad, "ender", "CEP", "")
            
            txtRetornoCNPJ.Text = cnpj
            txtRetornoIE.Text = ie
            txtRetornoNome.Text = xNome
            txtRetornoXLgr.Text = xLgr
            txtRetornoCep.Text = CEP

        Else
            Dim i As Integer
            For i = 0 To UBound(auxInfCad)
                infCad = auxInfCad(i)

                If (i <> UBound(auxInfCad)) Then
                    infCad = infCad & "}"
                End If

                ie = LerDadosJSON(infCad, "IE", "", "")
                cnpj = LerDadosJSON(infCad, "CNPJ", "", "")
                UF = LerDadosJSON(infCad, "UF", "", "")
                xNome = LerDadosJSON(infCad, "xNome", "", "")
                xLgr = LerDadosJSON(infCad, "ender", "xLgr", "")
                CEP = LerDadosJSON(infCad, "ender", "CEP", "")
            Next
        End If
    End If
    
    
    Exit Sub
    
SAI:
    MsgBox ("Problemas ao Requisitar emiss�o ao servidor" & vbNewLine & Err.Description), vbInformation, titleNFeAPI
End Sub
