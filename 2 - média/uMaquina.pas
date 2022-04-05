unit uMaquina;

interface

uses
  uIMaquina, Classes, uTroco;

type

  TMaquina = class(TInterfacedObject, IMaquina)
  public
    function MontarTroco(AValor: Double): TList;
  end;

implementation

uses math, System.SysUtils;

function TMaquina.MontarTroco(AValor: Double): TList;
var
  I : integer;
  Quantidade : integer;
  Troco : TTroco;
begin
  I := 0;
  Result := TList.Create;
  while (AValor > 4.54636328584002e-14) do    // valor muito pr�ximo de 0 que pode ocorrer quando dois pontos flutuantes iguais s�o subtraidos
  begin
    case I of
     0..5:
     begin
      Quantidade := trunc(AValor) div trunc(CValorCedula[TCedula(i)]);

      if Quantidade > 0 then
      begin
        Troco := TTroco.Create(TCedula(I), Quantidade);
        Troco.ehMoeda := False;
        Result.Add(Troco);
        AValor := AValor - (CValorCedula[TCedula(i)] * Quantidade);
      end;
     end;

     6..10:
     begin
      Quantidade := trunc(RoundTo(AValor * 100, 0)) div trunc(CValorCedula[TCedula(i)] * 100);

      if Quantidade > 0 then
      begin
        Troco := TTroco.Create(TCedula(I), Quantidade);
        Troco.ehMoeda := True;
        Result.Add(Troco);
        AValor := AValor - (CValorCedula[TCedula(i)] * Quantidade);
      end;
     end;

     11:
     begin
      Quantidade := trunc(RoundTo(AValor * 100, 0));
      if Quantidade > 0 then
      begin
        Troco := TTroco.Create(TCedula(I), Quantidade);
        Troco.ehMoeda := True;
        Result.Add(Troco);
        AValor := 0;
      end;
     end;
    end;
    inc(I);
  end;

end;

end.

