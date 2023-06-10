program text2twits;
{$APPTYPE CONSOLE}

uses
  SysUtils, Classes;

var
  path, inputFile, inputText, tempText: string;
  sl: TStringList;
  i, lastSpace, twitCount: Integer;

Const
  NEXTTWITCHAR = '🔽';

procedure saveNewTwit(text: String);
begin
  sl := TStringList.Create;
  sl.text := text;
  sl.SaveToFile(path + 'Twit' + intToStr(twitCount) + '.txt', Tencoding.UTF8);
  sl.Free;
  writeln('Twit ' + intToStr(twitCount) + ' save.');
  inc(twitCount);
end;

begin
  writeln('Helo text 2 Twits :)');
  path := ExtractFilePath(paramstr(0));
  if paramCount < 1 then
    writeln('Not input Arguments!')
  else
  begin
    inputFile := paramstr(1);
    if not FileExists(inputFile) then
      writeln('File not Exists!')
    else
    begin
      writeln('Input File:' + inputFile);
      sl := TStringList.Create;
      sl.LoadFromFile(inputFile, Tencoding.UTF8);
      inputText := trim(sl.text);
      sl.Free;
      writeln('Length input text:' + intToStr(length(inputText)) + ' chars');
      twitCount := 1;
      tempText := '';
      i := 1;
      lastSpace := 0;
      while length(inputText) > 279 do
      begin
        if inputText[i] in [#32, #10, #13] then
          lastSpace := i;
        inc(i);
        if i > 278 then
        begin
          tempText := copy(inputText, 1, lastSpace);
          delete(inputText, 1, lastSpace);
          saveNewTwit(trim(tempText) + NEXTTWITCHAR);
          i := 1;
          lastSpace := 0;
          tempText := '';
        end;
      end;
      saveNewTwit(inputText);
    end;
  end;
  writeln('Press ENTER to Exit.');
  readln;

end.
