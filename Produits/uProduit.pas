unit uProduit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BtnNouveau: TButton;
    BtnModifier: TButton;
    BtnSuprimer: TButton;
    BtnAnnuler: TButton;
    BtnValider: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DbedtCouleur: TDBEdit;
    DbedtTarif: TDBEdit;
    DbedtTaille: TDBEdit;
    DbedtPoid: TDBEdit;
    DbedtMarque: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure BtnNouveauClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSuprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
  private
     function ValiderSaisieProduit(): boolean;
     procedure GestionBottons;
  public

  end;

var
  Form1: TForm1;

implementation
 uses uDM;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.GestionBottons;
end;

function TForm1.ValiderSaisieProduit(): boolean;
begin
    //marque nn tarif <0 nn   taille < 0    poid <0
    Result := False;
      if   Length(trim(DbedtMarque.Text)) < 1 then
      begin
        ShowMessage('Marque Obligatoire');
        DbedtMarque.SetFocus;
        exit;
      end;
       if   Length(trim(DbedtTarif.Text)) < 1 then
      begin
        ShowMessage('Tarif Obligatoire');
        DbedtTarif.SetFocus;
        exit;
      end;
        if   StrToCurr(trim(DbedtTarif.Text)) <= 0 then
      begin
        ShowMessage('Tarif Obligatoir  Non Null');
        DbedtTarif.SetFocus;
        exit;
      end;
      if   Length(trim(DbedtTaille.Text)) < 1 then
      begin
        ShowMessage('Taille Obligatoire ');
        DbedtTaille.SetFocus;
        exit;
      end;
      if  StrToFloat(trim(DbedtTaille.Text)) <= 0   then
      begin
        ShowMessage('Taille Obligatoire Non Nul');
        DbedtTaille.SetFocus;
        exit;
      end;
      if   Length(trim(DbedtPoid.Text)) < 1 then
      begin
        ShowMessage('Poid Obligatoire');
        DbedtPoid.SetFocus;
        exit;
      end;

       if   StrToFloat(trim(DbedtPoid.Text)) <= 0 then
      begin
        ShowMessage('Poid Obligatoire Non Nul');
        DbedtPoid.SetFocus;
        exit;
      end;

    Result := True;
end;

procedure TForm1.BtnValiderClick(Sender: TObject);
begin
   if  NOT self.ValiderSaisieProduit() then
   begin
     exit;
   end;
   if dm.ValidateProduit() = true then
   showmessage('Operation Produit ajoute avec succes')
   else
     showmessage('Operation Non Effectue');
   self.GestionBottons;
end;

procedure TForm1.BtnNouveauClick(Sender: TObject);
begin
   DM.AddProduit();
   self.GestionBottons;
end;

procedure TForm1.BtnModifierClick(Sender: TObject);
begin
  DM.EditProduit();
  self.GestionBottons;
end;

procedure TForm1.BtnSuprimerClick(Sender: TObject);
begin
  DM.DeleteProduit();
  self.GestionBottons;
end;

procedure TForm1.BtnAnnulerClick(Sender: TObject);
begin
  DM.CancelProduit();
  self.GestionBottons;
end;

procedure TForm1.GestionBottons;
begin
  BtnNouveau.Enabled:=dm.IsBrowseProduit();
  BtnModifier.Enabled:=dm.IsBrowseProduit();
  BtnAnnuler.Enabled:=dm.IsEditOrInsertProduit();
  BtnValider.Enabled:=dm.IsEditOrInsertProduit();
end;


procedure TForm1.DBEdit1Change(Sender: TObject);
begin
  self.GestionBottons;
end;

end.

