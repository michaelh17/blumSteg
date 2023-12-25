unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ExtDlgs,
  StdCtrls, Windows, math;

type

  { TForm1 }


  TForm1 = class(TForm)
    Label1: TLabel;
    saveButton: TButton;
    loadButton: TButton;
    processButton: TButton;
    originalImage: TImage;
    resultImage: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    typeText: TEdit;
    procedure labelTest1Click(Sender: TObject);
    procedure loadButtonClick(Sender: TObject);
    procedure originalImageClick(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure processButtonClick(Sender: TObject);
    procedure saveButtonClick(Sender: TObject);
    procedure typeTextChange(Sender: TObject);
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
    originalImage.Picture.LoadFromFile(OpenPictureDialog1.Filename); //TImage
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

procedure TForm1.originalImageClick(Sender: TObject);
begin

end;

procedure TForm1.PaintBox1Click(Sender: TObject);
begin

end;

procedure TForm1.labelTest1Click(Sender: TObject);
begin

end;

procedure TForm1.processButtonClick(Sender: TObject);
var
  x,y,i,j : integer;
  p,q,n,s : integer; //bum bum shub key
  a : integer; //variable to store ASCII binary
  b : array [0..7] of integer;
  proc : integer;
  postX : array[0..100] of integer; //array to store X position
  postY : array[0..100] of integer; //array to store Y position
  textLength : integer;
  temp : string;
  Count : integer;

begin
  tinggi := originalImage.Height;
  lebar := originalImage.Width;
  resultImage.Picture.Clear;
  resultImage.Picture := originalImage.Picture;
  temp := typeText.text;
  textLength := length(temp);
  Count := 0;
  p := 11;
  q := 23;
  n := p*q;
  s := 5;

   bitmapB[lebar-1,tinggi-1] := textLength;
  //locating pixel that will used to store message
   for i:=0 to textLength do
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

   ///steganography
    for i:=0 to High(postX) do
    begin
      a := ord(temp[i]);
      if (i <= textLength) then
      begin
      bitmapR[postX[i],postY[i]] := a;
      end
      else
      break;
    end;

  for y:=0 to tinggi do
  begin
    for x:=0 to lebar do
    begin
      resultImage.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],bitmapG[x,y],bitmapB[x,y]);
    end;
  end;
end;

procedure TForm1.saveButtonClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
      resultImage.Picture.SaveToFile(SavePictureDialog1.Filename);
  end;
end;

procedure TForm1.typeTextChange(Sender: TObject);
begin

end;

end.

