unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    ZNX: TZConnection;
    ZtblProduits: TZTable;
    DSProduits: TDataSource;
  private

  public
    procedure AddProduit();
    procedure EditProduit();
    procedure CancelProduit();
    procedure DeleteProduit();

    function IsEditOrInsertProduit():Boolean;
    function ValidateProduit():Boolean;
    function IsInsertProduit() : Boolean ;
    function IsEditProduit() : Boolean  ;
    function IsBrowseProduit() : Boolean  ;
    function RechercherProduit(aRecherche : string):boolean;

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.AddProduit();
begin
 if self.ZtblProduits.State  in [dsInsert,dsEdit] then exit;
    self.ZtblProduits.Append;
end;

procedure TDM.CancelProduit();
begin
  if NOT (self.ZtblProduits.State  in [dsInsert,dsEdit]) then exit;
    self.ZtblProduits.Cancel;
end;

procedure TDM.DeleteProduit();
begin
  //
end;

procedure TDM.EditProduit();
begin
  if self.ZtblProduits.State  in [dsInsert,dsEdit] then exit;
    self.ZtblProduits.Edit;
end;

function TDM.ValidateProduit(): Boolean;
begin

   try
     if NOT(self.IsEditOrInsertProduit()) then exit;
        self.ZtblProduits.post;
     result := True;
   except

     result := false;

   end;


end;

function TDM.IsBrowseProduit(): Boolean;
begin
    Result := (Self.ZtblProduits.State = dsBrowse);
end;

function TDM.IsEditProduit(): Boolean;
begin
   Result := (Self.ZtblProduits.State = dsEdit);
end;

function TDM.IsInsertProduit(): Boolean;
begin
   Result := (Self.ZtblProduits.State = dsInsert);
end;

function TDM.IsEditOrInsertProduit: Boolean;
begin
    Result := (Self.ZtblProduits.State in [dsEdit,dsInsert]);
end;

function TDM.RechercherProduit(aRecherche: string): boolean;
begin
  Result := False;
  if  not self.ZtblProduits.IsEmpty then
  Result :=  self.ZtblProduits.Locate('marque',trim(aRecherche),[]);
end;

end.

