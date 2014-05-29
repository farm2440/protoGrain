unit protoGrain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ShellApi;

type
  TForm1 = class(TForm)
    Edit_tag: TEdit;
    Label1: TLabel;
    Edit_base: TEdit;
    Memo1: TMemo;
    Label2: TLabel;
    Button_run: TButton;
    ClientSocket: TClientSocket;
    Button_stop: TButton;
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button_runClick(Sender: TObject);
    procedure Button_stopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  startStop : boolean; //TRUE - start FALSE - stop

implementation

{$R *.dfm}
//------------------------------------------------------
procedure TForm1.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  xml : String;
begin
  Memo1.Lines.Add('Socket connected!');
  xml := '<SlClient>' +
            '<base>' + Edit_base.Text + '</base>' +
            '<tag>' + Edit_tag.Text + '</tag>';

  if startStop then xml := xml + '<cmd>START</cmd>'
  else xml := xml + '<cmd>STOP</cmd>';

  xml := xml + '</SlClient>';
  ClientSocket.Socket.SendText(xml);
  ClientSocket.Active := FALSE;
end;
//------------------------------------------------------
procedure TForm1.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo1.Lines.Add('Socket disconnected!');
end;
//------------------------------------------------------
procedure TForm1.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;
//------------------------------------------------------
procedure TForm1.Button_runClick(Sender: TObject);
var
  AppHandle : THandle;
  params : PAnsiChar;

  sdFile : TextFile;
  sdCommand : PAnsiChar; //Пълен път и името на ехе-то на SDispenser
  sdRunDir : PAnsiChar;  //Работна директория на SDispenser
  str : String;

begin
   startStop := TRUE;

//Проверка дали SDispenser е стартиран
  AppHandle:=FindWindow(nil, 'SDispenser v.1.2');
  Memo1.Lines.Add('Serching SDispenser: AppHandle=' + IntToStr(AppHandle));
  if AppHandle<>0 then
  begin
    Memo1.Lines.Add('SDispenser is running');
    Memo1.Lines.Add('Trying to connect socket...');
//SDispenser е бил стартиран. ССледва опит за свързване с SDispenser по TCP.
    try
      ClientSocket.Active := TRUE;
    except
      Memo1.Lines.Add('exception on try connect socket');
    end;

  end
  else
  begin

//Прочита се от текстов файл пътя до SDispenser
    AssignFile(sdFile,'path2sdispenser.txt');
    Reset(sdFile);
    if not Eof(sdFile) then ReadLn(sdFile, str);
    sdRunDir := PChar(str);
    sdCommand := PChar(str + 'SDispenser.exe');

//Стартира се SDispenser с параметри за дозиране - база и етикет
    Memo1.Lines.Add('SDispenser is not running');
    Memo1.Lines.Add('Trying to run SDispenser');
    params := PChar(Edit_base.Text + ' ' + Edit_tag.Text);
    ShellExecute(Handle,
               'open',
               sdCommand,
               params,       //Параметри - база етикет
               sdRunDir, SW_SHOWNORMAL) ;

  end;

end;

procedure TForm1.Button_stopClick(Sender: TObject);
var
  AppHandle : THandle;
begin
  startStop := FALSE;
  
//Проверка дали SDispenser е стартиран
  AppHandle:=FindWindow(nil, 'SDispenser v.1.2');
  Memo1.Lines.Add('Serching SDispenser: AppHandle=' + IntToStr(AppHandle));
  if AppHandle<>0 then
  begin
    Memo1.Lines.Add('SDispenser is running');
    Memo1.Lines.Add('Trying to connect socket...');
//SDispenser е бил стартиран. ССледва опит за свързване с SDispenser по TCP.
    try
      ClientSocket.Active := TRUE;
    except
      Memo1.Lines.Add('exception on try connect socket');
    end;
  end;
end;



end.
