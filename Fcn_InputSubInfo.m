
function inputAns = Fcn_InputSubInfo()

KbName('UnifyKeyNames');
escapeKey = KbName('escape');
Key(1)=KbName('Z');
Key(2)=KbName('M');
% inputAns = Fcn_inputName();
prompt={'�����������','��������Ա�'};
name='Basic Information';
numlines=1;
defaultanswer={'����ƴ��','Ů=1����=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
inputAns=inputdlg(prompt,name,numlines,defaultanswer);
if isempty(inputAns)==1
    cancelMsg = msgbox('You just canceled this test!');
    waitfor(cancelMsg);
    return;
elseif strcmp('����ƴ��',inputAns{1})== 1 || strcmp('Ů=1����=2',inputAns{2})== 1
    reInputMsg = msgbox('Please Check and Input Your Name or Your Gender Again!');
    waitfor(reInputMsg);
%     inputAns = Fcn_inputName();
    inputAns = Fcn_InputSubInfo();
    return;
end
% while strcmp('����ƴ��',inputAns{1})== 1 || strcmp('Ů=1����=2',inputAns{2})== 1
%     reInputMsg = msgbox('Please Check and Input Your Name or Your Gender Again!');
%     waitfor(reInputMsg);
% %     inputAns = Fcn_inputName();
%     inputAns = Fcn_InputSubInfo();
% end
return

% disp(inputAns)
% return

end

function inputAns = Fcn_inputName()
prompt={'�����������','��������Ա�'};
name='Basic Information';
numlines=1;
defaultanswer={'����ƴ��','Ů=1����=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
inputAns=inputdlg(prompt,name,numlines,defaultanswer);
end