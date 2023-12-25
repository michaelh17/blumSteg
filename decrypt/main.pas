unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ExtDlgs,
  StdCtrls, Windows,math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    resultText: TLabel;
    loadButton: TButton;
    decryptButton: TButton;
    originalImage: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure decryptButtonClick(Sender: TObject);
    procedure loadButtonClick(Sender: TObject);
    procedure resultTextClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var
  bitmapR, bitmapG, bitmapB : array [0..1000,0..1000] of integer;
  tinggi, lebar : integer;

procedure TForm1.loadButtonClick(Sender: TObject);
var
  x,y : integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    originalImage.Picture.LoadFromFile(OpenPictureDialog1.Filename);
    for y:=0 to originalImage.Height-1 do
    begin
      for x:=0 to originalImage.Width-1 do
      begin
        bitmapR[x,y] := GetRValue(originalImage.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(originalImage.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(originalImage.Canvas.Pixels[x,y]);
      end;
    end;
        tinggi := originalImage.Height;
        lebar := originalImage.Width;
  end;
end;

procedure TForm1.resultTextClick(Sender: TObject);
begin

end;

procedure TForm1.decryptButtonClick(Sender: TObject);
var
  temp : string;
  a : integer;
  b: array[0..7] of integer;
  x,y,i,j: integer;
  Count,proc,p,q,n,s : integer;
  postX, postY : array [0..1000] of integer;
  done : boolean;
begin
  temp := '';
  j := 0;
  a := 0;
  done := false;
  Count := 0;
  p := 11;
  q := 23;
  n := p*q;
  s := 5;

  //locating pixel that will used to store message
   for i:=0 to 100 do
   begin
      proc :=  trunc(power(s,2) mod n);
      s := proc;

      if(Count <= 5) then
      begin
      postX[i] := proc;

      if(i = 0) then
      begin
      postY[i] := 0;
      end;
      if(i > 0) then
      begin
        postY[i] := postY[i-1];
    end;
      Count := Count + 1;
   end;

      if(Count > 5) then
      begin
      postX[i] := proc;
      postY[i] := 1;
      Count := 0;
      end;
   end;

//decrypt
  for i:=0 to bitmapB[lebar-1,tinggi-1] do     //bitmapB stores text length that are inputted while being encrypted
  begin
  temp := temp + AnsiChar(bitmapR[postX[i],postY[i]]);
  resultText.Caption := temp;
  end;
end;

end.

