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
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
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
      label2.Caption := IntToStr(postX[0]);
      label3.Caption := IntToStr(postY[0]);
      label4.Caption := IntToStr(postX[1]);
      label5.Caption := IntToStr(postY[1]);
      label6.Caption := IntToStr(postX[2]);
      label7.Caption := IntToStr(postY[2]);
      label8.Caption := IntToStr(postX[3]);
      label9.Caption := IntToStr(postY[3]);
      label10.Caption := IntToStr(postX[4]);
      label11.Caption := IntToStr(postY[4]);
      label12.Caption := IntToStr(postX[5]);
      label13.Caption := IntToStr(postY[5]);
   end;

//decrypt
  for i:=0 to bitmapB[lebar-1,tinggi-1] do     //bitmapB stores text length that are inputted while being encrypted
  begin
  temp := temp + AnsiChar(bitmapR[postX[i],postY[i]]);
  resultText.Caption := temp;
  end;
end;

end.

