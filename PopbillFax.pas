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

                //ȸ���� ���� �ܰ� Ȯ��.
                function GetUnitCost(CorpNum : String) : Single;

                //�ѽ����� �������� ���� ������.
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; Title:String; RequestNum : String) : String; overload;


                //�ѽ�����  �������� ��������
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePath : String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;


                //�ѽ�����  ��������(�ִ�20��) ���� ������
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receiveNum : String; receiveName : String; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;

                //�ѽ�����  ��������(�ִ�20��) ��������
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; RequestNum : String) : String; overload;
                function SendFAX(CorpNum : String; sendnum : String; sendname : String; receivers : TReceiverList; filePaths : Array Of String; reserveDT : String; UserID:String; adsYN:Boolean; title:String; RequestNum : String) : String; overload;


                //�ѽ� ������(����, ����)
                function ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname : String; receiveNum : String; receiveName : String; reserveDT : String; UserID:String = ''; title:String = '') : String; overload;
                function ResendFAX(CorpNum : String; ReceiptNum : String; sendnum : Variant; sendname : String; receivers : TReceiverList; reserveDT : String; UserID:String = ''; title:String='') : String; overload;

                //�ѽ� ������(����, ����) - ��û��ȣ �Ҵ�
                function ResendFAXRN(CorpNum : String; RequestNum : String; sendnum : Variant; sendname : String; receiveNum : String; receiveName : String; reserveDT : String; OrignalRequestNum : String; UserID:String = ''; title:String = '') : String; overload;
                function ResendFAXRN(CorpNum : String; RequestNum : String; sendnum : Variant; sendname : String; receivers : TReceiverList; reserveDT : String; OrignalRequestNum : String; UserID:String = ''; title:String='') : String; overload;


                //���ۻ��� �� ������ Ȯ��.
                function getSendDetail(CorpNum : String; receiptNum : String; UserID : String = '') : TFaxDetailList;

                //���ۻ��� �� ������ Ȯ�� - ��û��ȣ �Ҵ�.
                function getSendDetailRN(CorpNum : String; RequestNum : String; UserID : String = '') : TFaxDetailList;

                //����� �������. ����ð� 10�� �������� ����.
                function CancelReserve(CorpNum : String; receiptNum : string; UserID : String = '') : TResponse;

                //����� ������� - ��û��ȣ �Ҵ�. ����ð� 10�� �������� ����.
                function CancelReserveRN(CorpNum : String; RequestNum : string; UserID : String = '') : TResponse;


                 //�ѽ����� ���� url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String; overload;

                 //�ѽ����� ���� url.
                function GetURL(CorpNum : String; TOGO : String) : String; overload;

                
                //�ѽ� ���۳��� ��ȸ
                function Search(CorpNum : String; SDate : String; EDate : String; State : Array Of String; ReserveYN : boolean; SenderOnly : boolean; Page : Integer; PerPage : Integer;Order : String; UserID : String = '') : TFaxSearchList;

                // �������� Ȯ��
                function GetChargeInfo(CorpNum : String) : TFaxChargeInfo;

                // �߽Ź�ȣ ��� ��ȸ
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
                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
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
                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
        end;
end;

// �������� ����
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
        // ������������ �ִ°�� ���������迭 ����
        if ( receiveNum <> '' ) AND ( receiveName <> '' ) then begin

                SetLength(Receivers,1);
                Receivers[0] := TReceiver.create;

                if receiveNum <> '' then
                        Receivers[0].receiveNum := receiveNum;

                if receiveName <> '' then
                        Receivers[0].receiveName := receiveName;
        end
        // ������ ������ ���°�� ���������迭 ���� 0���� ó��
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
                raise EPopbillException.Create(-99999999, '�ѽ�������ȣ(ReceiptNum)�� �Էµ��� �ʾҽ��ϴ�.');
                Exit;
        end;

        // ResendFax ȣ��� �������������� �����ϴ� JsonString ����
        // 1) �ش� �׸��� ������ ���� null �� ���
        // 2) �׸񺯼� ��ü�� JsonString�� ���ǵ��� ���� ���
        // 3) ���������� ��� rcvs �׸��� JsonString �� ���Ե��� �ʾƾ���

        requestJson := '{';

        if sendnum <> '' then
                requestJson := requestJson + '"snd":"'+sendnum+'",';

        if reserveDT <> '' then
                requestJson := requestJson + '"sndDT":"'+reserveDT+'",';

        if sendname <> '' then
                requestJson := requestJson + '"sndnm":"'+sendname+'",';
                
        if title <> '' then
                requestJson := requestJson + '"title":"'+title+'",';

        // ���������迭 ����
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
                // JsonString �� �޸�(,)�� ������ ���, ������ ���� trim ó��
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
                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
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
                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
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
                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
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
        // ������������ �ִ°�� ���������迭 ����
        if ( receiveNum <> '' ) AND ( receiveName <> '' ) then begin

                SetLength(Receivers,1);
                Receivers[0] := TReceiver.create;

                if receiveNum <> '' then
                        Receivers[0].receiveNum := receiveNum;

                if receiveName <> '' then
                        Receivers[0].receiveName := receiveName;
        end
        // ������ ������ ���°�� ���������迭 ���� 0���� ó��
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
                raise EPopbillException.Create(-99999999, '���ۿ�û��ȣ(RequestNum)�� �Էµ��� �ʾҽ��ϴ�.');
                Exit;
        end;

        if OrignalRequestNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '���� �ѽ��� ���ۿ�û��ȣ(OrignalRequestNum)�� �Էµ��� �ʾҽ��ϴ�.');
                Exit;
        end;

        // ResendFax ȣ��� �������������� �����ϴ� JsonString ����
        // 1) �ش� �׸��� ������ ���� null �� ���
        // 2) �׸񺯼� ��ü�� JsonString�� ���ǵ��� ���� ���
        // 3) ���������� ��� rcvs �׸��� JsonString �� ���Ե��� �ʾƾ���

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

        // ���������迭 ����
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
                // JsonString �� �޸�(,)�� ������ ���, ������ ���� trim ó��
                if Length(requestJson) <> 1 then
                        requestJson := Copy(requestJson, 0, Length(requestJson)-1)
        end;

        requestJson := requestJson + '}';

        responseJson := httppost('/FAX/Resend/'+ OrignalRequestNum, CorpNum, UserID, requestJson);

        result := getJSonString(responseJson,'receiptNum');
end;


//End of Unit;
end.

