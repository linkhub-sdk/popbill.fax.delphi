(*
*=================================================================================
* Unit for base module for Popbill FAX API SDK. Main functionality is to
* send FAX with document file.( ex. pdf, doc, xls, hwp etc.)
*
* This module uses synapse library.( http://www.ararat.cz/synapse/doku.php/ )
* It's full open source library, free to use include commercial application.
* If you wish to donate that, visit their site.
* So, before using this module, you need to install synapse by user self.
* You can refer their site or detailed infomation about installation is available
* from below our site. We appreciate your visiting.
*
* For strongly secured communications, this module uses SSL/TLS with OpenSSL.
* So You need two dlls (libeay32.dll and ssleay32.dll) from OpenSSL. You can
* get it from Fulgan. ( http://indy.fulgan.com/SSL/ ) We recommend i386_win32 version.
* And also, dlls must be released with your executions. That's the drawback of this
* module, but we acommplished higher security level against that.
*
* http://www.popbill.com
* Author : Kim Seongjun (pallet027@gmail.com)
* Written : 2014-04-08

* Thanks for your interest. 
*=================================================================================
*)
unit PopbillFax;

interface
uses
        TypInfo,SysUtils,Classes,
        Popbill,
        Linkhub;
type
        TFaxChargeInfo = class
        public
                unitCost : string;
                chargeMethod : string;
                rateSystem : string;
        end;

        
        TReceiver = class
        public
                receiveNum : String;
                receiveName : String;
        end;
        TReceiverList = Array of TReceiver;

        TFaxDetail = class
        public
                sendState : Integer;
                convState : Integer;
                sendNum : String;
                senderName : String;
                receiveNum : String;
                receiveName : String;
                sendPageCnt : Integer;
                successPageCnt : Integer;
                failPageCnt : Integer;
                refundPageCnt : Integer;
                cancelPageCnt : Integer;
                receiptDT : String;
                reserveDT : String;
                sendDT : String;
                resultDT : String;
                sendResult : Integer;
                fileNames : ArrayOfString;
                destructor Destroy; override;
        end;

        TFaxDetailList = Array Of TFaxDetail;

        TFaxSearchList = class
        public
                code            :       Integer;
                total           :       Integer;
                perPage         :       Integer;
                pageNum         :       Integer;
                pageCount       :       Integer;
                message         :       String;
                list            :       TFaxDetailList;
                destructor Destroy; override;
        end;

        TFaxService = class(TPopbillBaseService)
        public
                constructor Create(LinkID : String; SecretKey : String);

                //회원별 전송 단가 확인.
                function GetUnitCost(CorpNum : String) : Single;

                //팩스전송 단일파일 단일 수신자.
                function SendFAX(CorpNum : String; sendnum : String; sendName : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String;     UserID:String) : String; overload;

                //팩스전송  단일파일 동보전송
                function SendFAX(CorpNum : String; sendnum : String; sendName : String; receivers : TReceiverList; filePath : String; reserveDT : String;     UserID:String) : String; overload;

                //팩스전송  다중파일(최대5개) 단일 수신자
                function SendFAX(CorpNum : String; sendnum : String; sendName : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; overload;

                //팩스전송  다중파일(최대5개 동보전송
                function SendFAX(CorpNum : String; sendnum : String; sendName : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; overload;

                //전송상태 및 상세정보 확인.
                function getSendDetail(CorpNum : String; receiptNum : String; UserID : String) : TFaxDetailList;
                //예약건 전송취소. 예약시간 10분 전까지만 가능.
                function CancelReserve(CorpNum : String; receiptNum : string; UserID : String) : TResponse;

                 //팩스관련 연결 url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String;

                //팩스 전송내역 조회
                function Search(CorpNum : String; SDate : String; EDate : String; State : Array Of String; ReserveYN : boolean; SenderOnly : boolean; Page : Integer; PerPage : Integer;Order : String; UserID : String) : TFaxSearchList;

                // 과금정보 확인
                function GetChargeInfo(CorpNum : String) : TFaxChargeInfo;

        end;
implementation

destructor TFaxDetail.Destroy;
begin
setlength(filenames,0);
filenames := nil;
end;

destructor TFaxSearchList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(list)-1 do
    if Assigned(list[I]) then
      list[I].Free;
  SetLength(list, 0);
  inherited Destroy;
end;

constructor TFaxService.Create(LinkID : String; SecretKey : String);
begin
       inherited Create(LinkID,SecretKey);
       AddScope('160');
end;

function TFaxService.GetUnitCost(CorpNum : String) : Single;
var
        responseJson : string;
begin
        responseJson := httpget('/FAX/UnitCost',CorpNum,'');

        result := strToFloat(getJSonString( responseJson,'unitCost'));

end;

function TFaxService.GetChargeInfo (CorpNum : string) : TFaxChargeInfo;
var
        responseJson : String;
begin
        responseJson := httpget('/FAX/ChargeInfo',CorpNum,'');

        try
                result := TFaxChargeInfo.Create;

                result.unitCost := getJSonString(responseJson, 'unitCost');
                result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                result.rateSystem := getJSonString(responseJson, 'rateSystem');

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

function TFaxService.Search(CorpNum : String; SDate : String; EDate : String; State : Array Of String; ReserveYN : boolean; SenderOnly : boolean; Page : Integer; PerPage : Integer; Order : String; UserID : String) :TFaxSearchList;
var
        responseJson : String;
        uri : String;
        StateList : String;
        jSons : ArrayOfString;
        i : Integer;
begin
        for i := 0 to High(State) do
        begin
                if State[i] <> '' Then
                begin
                        if i = High(State) Then
                        begin
                                StateList := StateList + State[i];
                        end
                        else begin
                                StateList := StateList + State[i] +',';
                        end;
                end
        end;

        uri := '/FAX/Search?SDate='+SDate+'&&EDate='+EDate;
        uri := uri + '&&State='+ StateList;

        if ReserveYN Then uri := uri + '&&ReserveYN=1'
        else uri := uri + '&&ReserveYN=0';

        if SenderOnly Then uri := uri + '&&SenderOnly=1'
        else uri := uri + '&&SenderOnly=0';
        
        uri := uri + '&&Page=' + IntToStr(Page);
        uri := uri + '&&PerPage=' + IntToSTr(PerPage);
        uri := uri + '&&Order=' + Order;

        responseJson :=  httpget(uri,CorpNum,UserID);

        result := TFaxSearchList.Create;

        result.code             := getJSonInteger(responseJson,'code');
        result.total            := getJSonInteger(responseJson,'total');
        result.perPage          := getJSonInteger(responseJson,'perPage');
        result.pageNum          := getJSonInteger(responseJson,'pageNum');
        result.pageCount        := getJSonInteger(responseJson,'pageCount');
        result.message          := getJSonString(responseJson,'message');

        try

                jSons := getJSonList(responseJson,'list');
                SetLength(result.list, Length(jSons));
                for i:=0 to Length(jSons)-1 do
                begin
                        result.list[i] := TFaxDetail.Create();

                        result.list[i].sendState := getJSonInteger(jsons[i],'sendState');
                        result.list[i].convState := getJSonInteger(jsons[i],'convState');

                        result.list[i].sendNum := getJSonString(jsons[i],'sendNum');
                        result.list[i].senderName := getJSonString(jsons[i],'senderName');
                        result.list[i].receiveNum := getJSonString(jsons[i],'receiveNum');
                        result.list[i].receiveName := getJSonString(jsons[i],'receiveName');

                        result.list[i].sendPageCnt := getJSonInteger(jsons[i],'sendPageCnt');
                        result.list[i].successPageCnt := getJSonInteger(jsons[i],'successPageCnt');
                        result.list[i].failPageCnt := getJSonInteger(jsons[i],'failPageCnt');
                        result.list[i].refundPageCnt := getJSonInteger(jsons[i],'refundPageCnt');
                        result.list[i].cancelPageCnt := getJSonInteger(jsons[i],'cancelPageCnt');

                        result.list[i].receiptDT := getJSonString(jsons[i],'receiptDT');
                        result.list[i].reserveDT := getJSonString(jsons[i],'reserveDT');
                        result.list[i].sendDT := getJSonString(jsons[i],'sendDT');
                        result.list[i].resultDT := getJSonString(jsons[i],'resultDT');
                        result.list[i].sendResult := getJSonInteger(jsons[i],'sendResult');
                        result.list[i].fileNames := getJsonList(jsons[i],'fileNames');

                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;


function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendName : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := SendFax(CorpNum,sendnum, sendName, receivers,filePath,reserveDT,UserID);
end;
function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendName : String; receivers : TReceiverList; filePath : String; reserveDT : String;     UserID:String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := SendFAX(CorpNum,sendnum,sendName,receivers,files,reserveDT,UserID);
end;
function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendName : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; 
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := SendFAX(CorpNum,sendnum,sendName, receivers,filePaths,reserveDT,UserID);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendName: String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String;     UserID:String) : String;
var
        files : TFileList;
        requestJson, responseJson : String;
        i : Integer;
begin
        SetLength(files,length(filePaths));

        for i:= 0 to Length(filePaths) -1 do begin
                files[i] := TFile.Create;
                files[i].FieldName := 'file';
                files[i].FileName := ExtractFileName(filePaths[i]);
                files[i].Data := TFileStream.Create(filePaths[i],fmOpenRead);
        end;

        requestJson := '{';
        requestJson := requestJson + '"snd":"'+sendnum+'",';
        requestJson := requestJson + '"sndnm":"'+sendName+'",';        
        requestJson := requestJson + '"sndDT":"'+reserveDT+'",';
        requestJson := requestJson + '"fCnt":"'+ intToStr(length(files))+'",';

        requestJson := requestJson + '"rcvs":[';

        for i:=0 to Length(receivers) -1 do begin
                requestJson := requestJson + '{';
                requestJson := requestJson + '"rcv":"'+receivers[i].receiveNum+'",';
                requestJson := requestJson + '"rcvnm":"'+receivers[i].receiveName+'"';
                requestJson := requestJson + '}';
                if i < Length(receivers) - 1 then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        requestJson := requestJson + '}';

       try
                responseJson := httppost('/FAX',CorpNum,UserID,requestJson,files);
       finally
                for i:= 0 to Length(files) -1 do begin
                        files[i].Data.Free;
                end;
       end;

       result := getJSonString(responseJson,'receiptNum');
end;
function TFaxService.getSendDetail(CorpNum : String; receiptNum : String; UserID : String) : TFaxDetailList;
var
        responseJson : String;
        jSons : ArrayOfString;
        i : Integer;
begin
        if receiptNum = '' then raise EPopbillException.Create(-99999999,'No ReceiptNum');

        responseJson := httpget('/FAX/' + receiptNum,CorpNum,UserID);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := TFaxDetail.Create;

                        result[i].sendState := getJSonInteger(jsons[i],'sendState');
                        result[i].convState := getJSonInteger(jsons[i],'convState');

                        result[i].sendNum := getJSonString(jsons[i],'sendNum');
                        result[i].senderName := getJSonString(jsons[i],'senderName');
                        result[i].receiveNum := getJSonString(jsons[i],'receiveNum');
                        result[i].receiveName := getJSonString(jsons[i],'receiveName');

                        result[i].sendPageCnt := getJSonInteger(jsons[i],'sendPageCnt');
                        result[i].successPageCnt := getJSonInteger(jsons[i],'successPageCnt');
                        result[i].failPageCnt := getJSonInteger(jsons[i],'failPageCnt');
                        result[i].refundPageCnt := getJSonInteger(jsons[i],'refundPageCnt');
                        result[i].cancelPageCnt := getJSonInteger(jsons[i],'cancelPageCnt');

                        result[i].receiptDT := getJSonString(jsons[i],'receiptDT');
                        result[i].reserveDT := getJSonString(jsons[i],'reserveDT');
                        result[i].sendDT := getJSonString(jsons[i],'sendDT');
                        result[i].resultDT := getJSonString(jsons[i],'resultDT');
                        result[i].sendResult := getJSonInteger(jsons[i],'sendResult');

                        result[i].fileNames := getJsonList(jsons[i],'fileNames');
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;

function TFaxService.CancelReserve(CorpNum : String; receiptNum : string; UserID : String) : TResponse;
var
        responseJson : String;
begin
        if receiptNum = '' then raise EPopbillException.Create(-99999999,'No ReceiptNum');

        try
                responseJson := httpget('/FAX/' + receiptNum + '/Cancel',CorpNum,UserID);

                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                        end;

                        result.code := le.code;
                        result.message := le.Message;
                end;
        end;
end;


function TFaxService.getURL(CorpNum : String; UserID : String; TOGO : String) : String;
var
        responseJson : String;
begin
        responseJson := httpget('/FAX/?TG=' + TOGO ,CorpNum,UserID);
        result := getJSonString(responseJson,'url');
end;

//End of Unit;
end.
