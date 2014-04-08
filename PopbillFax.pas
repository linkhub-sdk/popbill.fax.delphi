(*
*=================================================================================
* Unit for base module for Popbill Messaging API SDK. Main functionality is to
* send Short Messaging To Cell phones. Also LMS and MMS.
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
* Written : 2014-04-01

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
                receiveNum : String;
                receiveName : String;
                sendPageCnt : Integer;
                successPageCnt : Integer;
                failPageCnt : Integer;
                refundPageCnt : Integer;
                cancelPageCnt : Integer;
                reserveDT : String;
                sendDT : String;
                resultDT : String;
                sendResult : Integer;
        end;

        TFaxDetailList = Array Of TFaxDetail;

        TFaxService = class(TPopbillBaseService)
        public
                constructor Create(PartnerID : String; SecretKey : String);

                //회원별 전송 단가 확인.
                function GetUnitCost(CorpNum : String) : Single;

                //팩스전송 단일파일 단일 수신자.
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String;     UserID:String) : String; overload;
                //팩스전송  단일파일 동보전송
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String;     UserID:String) : String; overload;
                //팩스전송  다중파일(최대5개) 단일 수신자
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; overload;
                //팩스전송  다중파일(최대5개 동보전송
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; overload;

                //전송상태 및 상세정보 확인.
                function getSendDetail(CorpNum : String; receiptNum : String; UserID : String) : TFaxDetailList;
                //예약건 전송취소. 예약시간 10분 전까지만 가능.
                function CancelReserve(CorpNum : String; receiptNum : string; UserID : String) : TResponse;

        end;
implementation
constructor TFaxService.Create(PartnerID : String; SecretKey : String);
begin
       inherited Create(PartnerID,SecretKey);
       AddScope('160');
end;

function TFaxService.GetUnitCost(CorpNum : String) : Single;
var
        responseJson : string;
begin
        responseJson := httpget('/FAX/UnitCost',CorpNum,'');

        result := strToFloat(getJSonString( responseJson,'unitCost'));

end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String) : String;
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := SendFax(CorpNum,sendnum,receivers,filePath,reserveDT,UserID);
end;
function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String;     UserID:String) : String;
var
        files : Array Of String;
begin
        SetLength(files,1);
        files[0] := filePath;

        result := SendFAX(CorpNum,sendnum,receivers,files,reserveDT,UserID);
end;
function TFaxService.SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String;     UserID:String) : String; 
var
        receivers : TReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TReceiver.create;
        Receivers[0].receiveNum := receiveNum;
        Receivers[0].receiveName := receiveName;

        result := SendFAX(CorpNum,sendnum,receivers,filePaths,reserveDT,UserID);
end;

function TFaxService.SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String;     UserID:String) : String;
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
                files[0].Data.Free;
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
                        result[i].receiveNum := getJSonString(jsons[i],'receiveNum');
                        result[i].receiveName := getJSonString(jsons[i],'receiveName');

                        result[i].sendPageCnt := getJSonInteger(jsons[i],'sendPageCnt');
                        result[i].successPageCnt := getJSonInteger(jsons[i],'successPageCnt');
                        result[i].failPageCnt := getJSonInteger(jsons[i],'failPageCnt');
                        result[i].refundPageCnt := getJSonInteger(jsons[i],'refundPageCnt');
                        result[i].cancelPageCnt := getJSonInteger(jsons[i],'cancelPageCnt');

                        result[i].reserveDT := getJSonString(jsons[i],'reserveDT');
                        result[i].sendDT := getJSonString(jsons[i],'sendDT');
                        result[i].resultDT := getJSonString(jsons[i],'resultDT');
                        result[i].sendResult := getJSonInteger(jsons[i],'sendResult');



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

        responseJson := httpget('/FAX/' + receiptNum + '/Cancel',CorpNum,UserID);

        result.code := getJSonInteger(responseJson,'code');
        result.message := getJSonString(responseJson,'message');
end;
//End of Unit;
end.
