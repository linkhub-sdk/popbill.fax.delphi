(*
*=================================================================================
* Unit for base module for Popbill FAX API SDK. Main functionality is to
* send FAX with document file.( ex. pdf, doc, xls, hwp etc.)
*
* For strongly secured communications, this module uses SSL/TLS with OpenSSL.
*
* http://www.popbill.com
* Author : Kim Seongjun (pallet027@gmail.com)
* Contributor : Jeong Yohan (code@linkhub.co.kr)
* Written : 2014-04-08
* Updated : 2017-07-19
* Contributor : Kim Eunhye (code@linkhub.co.kr)
* Updated : 2018-06-12
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
                state : Integer;
                result : Integer;
                title : String;
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

        TFAXSenderNumber = class
        public
                number : string;
                state : integer;
                representYN : Boolean;
        end;

        TFAXSenderNumberList = Array of TFAXSenderNumber;

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
        private
                function RequestFAX(CorpNum:String; sendnum:String; sendname:String; receivers:TReceiverList; filePaths: Array Of String; reserveDT: String; UserID:String; adsYN:Boolean; title:String = ''; RequestNum : String = '') : String;
        public
                constructor Create(LinkID : String; SecretKey : String);

                //회원별 전송 단가 확인.
                function GetUnitCost(CorpNum : String) : Single;

                //팩스전송 단일파일 단일 수신자.
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; Title:String; RequestNum : String) : String; overload;


                //팩스전송  단일파일 동보전송
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;


                //팩스전송  다중파일(최대20개) 단일 수신자
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;

                //팩스전송  다중파일(최대20개) 동보전송
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;


                //팩스 재전송(단일, 동보)
                function ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname : String; receiveNum : String; receiveName : String; reserveDT : String; UserID:String = ''; title:String = '') : String; overload;
                function ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname : String; receivers : TReceiverList; reserveDT : String; UserID:String = ''; title:String='') : String; overload;

                //팩스 재전송(단일, 동보) - 요청번호 할당
                function ResendFAXRN(CorpNum : String; RequestNum : String; sendnum : Variant; sendname : String; receiveNum : String; receiveName : String; reserveDT : String; OrignalRequestNum : String; UserID:String = ''; title:String = '') : String; overload;
                function ResendFAXRN(CorpNum : String; RequestNum : String; sendnum : Variant; sendname : String; receivers : TReceiverList; reserveDT : String; OrignalRequestNum : String; UserID:String = ''; title:String='') : String; overload;


                //전송상태 및 상세정보 확인.
                function getSendDetail(CorpNum : String; receiptNum : String; UserID : String = '') : TFaxDetailList;

                //전송상태 및 상세정보 확인 - 요청번호 할당.
                function getSendDetailRN(CorpNum : String; RequestNum : String; UserID : String = '') : TFaxDetailList;

                //예약건 전송취소. 예약시간 10분 전까지만 가능.
                function CancelReserve(CorpNum : String; receiptNum : string; UserID : String = '') : TResponse;

                //예약건 전송취소 - 요청번호 할당. 예약시간 10분 전까지만 가능.
                function CancelReserveRN(CorpNum : String; RequestNum : string; UserID : String = '') : TResponse;


                 //팩스관련 연결 url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String; overload;

                 //팩스관련 연결 url.
                function GetURL(CorpNum : String; TOGO : String) : String; overload;

                
                //팩스 전송내역 조회
                function Search(CorpNum : String; SDate : String; EDate : String; State : Array Of String; ReserveYN : boolean; SenderOnly : boolean; Page : Integer; PerPage : Integer;Order : String; UserID : String = '') : TFaxSearchList;

                // 과금정보 확인
                function GetChargeInfo(CorpNum : String) : TFaxChargeInfo;

                // 발신번호 목록 조회
                function GetSenderNumberList(CorpNum : String; UserID : String = '') : TFAXSenderNumberList;
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
                        result.list[i].state := getJSonInteger(jsons[i],'state');
                        result.list[i].result := getJSonInteger(jsons[i],'result');

                        result.list[i].sendState := getJSonInteger(jsons[i],'sendState');
                        result.list[i].convState := getJSonInteger(jsons[i],'convState');

                        result.list[i].title := getJSonString(jsons[i],'title');
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

// 단일파일 전송
function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum :String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFax(CorpNum,sendnum, '', receivers,filePath,reserveDT,UserID,False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFax(CorpNum,sendnum, '', receivers,filePath,reserveDT,UserID,adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFax(CorpNum,sendnum, sendname, receivers,filePath,reserveDT,UserID,False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFax(CorpNum,sendnum, sendname, receivers,filePath,reserveDT,UserID,adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFax(CorpNum,sendnum, sendname, receivers,filePath,reserveDT,UserID,adsYN,title, RequestNum);
end;


function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := RequestFAX(CorpNum,sendnum, '', receivers,files,reserveDT,UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;
        result := RequestFAX(CorpNum,sendnum, '', receivers,files,reserveDT,UserID, adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,files,reserveDT,UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,files,reserveDT,UserID,adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,files,reserveDT,UserID,adsYN,title, RequestNum);
end;



function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFAX(CorpNum,sendnum, '', receivers,filePaths,reserveDT,UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFAX(CorpNum,sendnum, '', receivers,filePaths,reserveDT,UserID, adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname :String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,filePaths,reserveDT,UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname :String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,filePaths,reserveDT,UserID,adsYN, '', RequestNum);
end;


function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname :String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := RequestFAX(CorpNum,sendnum, sendname, receivers,filePaths,reserveDT,UserID,adsYN, title, RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String;
begin
        result := RequestFAX(CorpNum, sendnum, '', receivers, filePaths, reserveDT, UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
begin
        result := RequestFAX(CorpNum, sendnum, '', receivers, filePaths, reserveDT, UserID, adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: string; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String;
begin
        result := RequestFAX(CorpNum, sendnum, sendname, receivers, filePaths, reserveDT, UserID, False, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: string; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String;
begin
        result := RequestFAX(CorpNum, sendnum, sendname, receivers, filePaths, reserveDT, UserID, adsYN, '', RequestNum);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; sendname: string; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String;
begin
        result := RequestFAX(CorpNum, sendnum, sendname, receivers, filePaths, reserveDT, UserID, adsYN, title, RequestNum);
end;


function TFaxService.RequestFAX(CorpNum:String; sendnum:String; sendname:String; receivers:TReceiverList; filePaths: Array Of String; reserveDT: String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String;
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

        if adsYN then
        requestJson := requestJson + '"adsYN":true,';

        requestJson := requestJson + '"snd":"'+sendnum+'",';
        requestJson := requestJson + '"sndDT":"'+reserveDT+'",';
        requestJson := requestJson + '"sndnm":"'+sendname+'",';
        requestJson := requestJson + '"title":"'+title+'",';        
        requestJson := requestJson + '"fCnt":"'+ intToStr(length(files))+'",';
        if RequestNum <> '' then requestJson := requestJson + '"requestNum":"'+RequestNum+'",';

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


function TFaxService.ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname :String; receiveNum : String; receiveName : String; reserveDT : String; UserID:String; title:String) : String;
var
        receivers : TReceiverList;
begin
        // 수신자정보가 있는경우 수신정보배열 구성
        if ( receiveNum <> '' ) AND ( receiveName <> '' ) then begin

                SetLength(Receivers,1);
                Receivers[0] := TReceiver.create;

                if receiveNum <> '' then
                        Receivers[0].receiveNum := receiveNum;

                if receiveName <> '' then
                        Receivers[0].receiveName := receiveName;
        end
        // 수신자 정보가 없는경우 수신정보배열 길이 0으로 처리
        else begin
                SetLength(Receivers,0);
        end;

        result := ResendFAX(CorpNum, ReceiptNum, sendnum, sendname, receivers, reserveDT, UserID, title);
end;

function TFaxService.ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname: String; receivers : TReceiverList; reserveDT : String; UserID:String; title:String) : String;
var
        requestJson, responseJson : String;
        i : Integer;
begin
        if ReceiptNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '팩스접수번호(ReceiptNum)가 입력되지 않았습니다.');
                Exit;
        end;

        // ResendFax 호출시 기존전송정보로 전송하는 JsonString 구성
        // 1) 해당 항목의 변수의 값이 null 인 경우
        // 2) 항목변수 자체가 JsonString에 정의되지 않은 경우
        // 3) 동보전송의 경우 rcvs 항목이 JsonString 에 포함되지 않아야함

        requestJson := '{';

        if sendnum <> '' then
                requestJson := requestJson + '"snd":"'+sendnum+'",';

        if reserveDT <> '' then
                requestJson := requestJson + '"sndDT":"'+reserveDT+'",';

        if sendname <> '' then
                requestJson := requestJson + '"sndnm":"'+sendname+'",';
                
        if title <> '' then
                requestJson := requestJson + '"title":"'+title+'",';

        // 수신정보배열 구성
        if Length(receivers) > 0 then begin
                requestJson := requestJson + '"rcvs":[';
                
                for i:=0 to Length(receivers) -1 do begin
                
                        requestJson := requestJson + '{';

                        if receivers[i].receiveNum <> '' then
                                requestJson := requestJson + '"rcv":"'+receivers[i].receiveNum+'",';

                        if receivers[i].receiveName <> '' then
                                requestJson := requestJson + '"rcvnm":"'+receivers[i].receiveName+'"';

                        requestJson := requestJson + '}';

                        if i < Length(receivers) - 1 then requestJson := requestJson + ',';
                end; // end of for

                requestJson := requestJson + ']';
        end
        else begin
                // JsonString 이 콤마(,)로 끝나는 경우, 마지막 문자 trim 처리
                if Length(requestJson) <> 1 then
                        requestJson := Copy(requestJson, 0, Length(requestJson)-1)
        end;

        requestJson := requestJson + '}';

        responseJson := httppost('/FAX/'+ ReceiptNum, CorpNum, UserID, requestJson);

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
                        result[i].state := getJSonInteger(jsons[i],'state');
                        result[i].result := getJSonInteger(jsons[i],'result');
                        result[i].title := getJSonString(jsons[i],'title');

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

function TFaxService.getURL(CorpNum : String; TOGO : String) : String;
begin
        result := getURL(CorpNum, '', TOGO);
end;

function TFaxService.getURL(CorpNum : String; UserID : String; TOGO : String) : String;
var
        responseJson : String;
begin
        responseJson := httpget('/FAX/?TG=' + TOGO ,CorpNum,UserID);
        result := getJSonString(responseJson,'url');
end;

function TFaxService.GetSenderNumberList(CorpNum : string; UserID: String) : TFAXSenderNumberList;
var
        responseJson : String;
        jSons : ArrayOfString;
        i : Integer;
begin

        responseJson := httpget('/FAX/SenderNumber',CorpNum, UserID);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result[i] := TFAXSenderNumber.Create;
                        result[i].number := getJsonString(jSons[i],'number');
                        result[i].state := getJsonInteger(jSons[i],'state');
                        result[i].representYN := getJsonBoolean(jSons[i],'representYN');
                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

function TFaxService.getSendDetailRN(CorpNum, RequestNum, UserID: String): TFaxDetailList;
var
        responseJson : String;
        jSons : ArrayOfString;
        i : Integer;
begin
        if RequestNum = '' then raise EPopbillException.Create(-99999999,'No RequestNum');

        responseJson := httpget('/FAX/Get/' + RequestNum, CorpNum, UserID);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := TFaxDetail.Create;
                        result[i].state := getJSonInteger(jsons[i],'state');
                        result[i].result := getJSonInteger(jsons[i],'result');
                        result[i].title := getJSonString(jsons[i],'title');

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

function TFaxService.CancelReserveRN(CorpNum, RequestNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if RequestNum = '' then raise EPopbillException.Create(-99999999,'No RequestNum');

        try
                responseJson := httpget('/FAX/Cancel/' + RequestNum, CorpNum, UserID);

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

function TFaxService.ResendFAXRN(CorpNum, RequestNum: String; sendnum: Variant;
                                 sendname, receiveNum, receiveName, reserveDT,
                                 OrignalRequestNum, UserID, title: String): String;
var
        receivers : TReceiverList;
begin
        // 수신자정보가 있는경우 수신정보배열 구성
        if ( receiveNum <> '' ) AND ( receiveName <> '' ) then begin

                SetLength(Receivers,1);
                Receivers[0] := TReceiver.create;

                if receiveNum <> '' then
                        Receivers[0].receiveNum := receiveNum;

                if receiveName <> '' then
                        Receivers[0].receiveName := receiveName;
        end
        // 수신자 정보가 없는경우 수신정보배열 길이 0으로 처리
        else begin
                SetLength(Receivers,0);
        end;

        result := ResendFAXRN(CorpNum, RequestNum, sendnum, sendname, receivers,
                              reserveDT, OrignalRequestNum, UserID, title);
end;

function TFaxService.ResendFAXRN(CorpNum, RequestNum: String; sendnum: Variant;
                                 sendname: String; receivers: TReceiverList;
                                 reserveDT, OrignalRequestNum, UserID, title: String): String;
var
        requestJson, responseJson : String;
        i : Integer;
begin
        if RequestNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '전송요청번호(RequestNum)가 입력되지 않았습니다.');
                Exit;
        end;

        if OrignalRequestNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '원본 팩스의 전송요청번호(OrignalRequestNum)가 입력되지 않았습니다.');
                Exit;
        end;

        // ResendFax 호출시 기존전송정보로 전송하는 JsonString 구성
        // 1) 해당 항목의 변수의 값이 null 인 경우
        // 2) 항목변수 자체가 JsonString에 정의되지 않은 경우
        // 3) 동보전송의 경우 rcvs 항목이 JsonString 에 포함되지 않아야함

        requestJson := '{';

        if sendnum <> '' then
                requestJson := requestJson + '"snd":"'+sendnum+'",';

        if reserveDT <> '' then
                requestJson := requestJson + '"sndDT":"'+reserveDT+'",';

        if sendname <> '' then
                requestJson := requestJson + '"sndnm":"'+sendname+'",';
                
        if title <> '' then
                requestJson := requestJson + '"title":"'+title+'",';

        if RequestNum <> '' then
                requestJson := requestJson + '"requestNum":"'+RequestNum+'",';

        // 수신정보배열 구성
        if Length(receivers) > 0 then begin
                requestJson := requestJson + '"rcvs":[';
                
                for i:=0 to Length(receivers) -1 do begin
                
                        requestJson := requestJson + '{';

                        if receivers[i].receiveNum <> '' then
                                requestJson := requestJson + '"rcv":"'+receivers[i].receiveNum+'",';

                        if receivers[i].receiveName <> '' then
                                requestJson := requestJson + '"rcvnm":"'+receivers[i].receiveName+'"';

                        requestJson := requestJson + '}';

                        if i < Length(receivers) - 1 then requestJson := requestJson + ',';
                end; // end of for

                requestJson := requestJson + ']';
        end
        else begin
                // JsonString 이 콤마(,)로 끝나는 경우, 마지막 문자 trim 처리
                if Length(requestJson) <> 1 then
                        requestJson := Copy(requestJson, 0, Length(requestJson)-1)
        end;

        requestJson := requestJson + '}';

        responseJson := httppost('/FAX/Resend/'+ OrignalRequestNum, CorpNum, UserID, requestJson);

        result := getJSonString(responseJson,'receiptNum');
end;


//End of Unit;
end.

