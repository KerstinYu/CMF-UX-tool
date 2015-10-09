
function inputAns = Fcn_InputSubInfo()

KbName('UnifyKeyNames');
escapeKey = KbName('escape');
Key(1)=KbName('Z');
Key(2)=KbName('M');
% inputAns = Fcn_inputName();
prompt={'输入你的姓名','输入你的性别'};
name='Basic Information';
numlines=1;
defaultanswer={'姓名拼音','女=1，男=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
inputAns=inputdlg(prompt,name,numlines,defaultanswer);
if isempty(inputAns)==1
    cancelMsg = msgbox('You just canceled this test!');
    waitfor(cancelMsg);
    return;
elseif strcmp('姓名拼音',inputAns{1})== 1 || strcmp('女=1，男=2',inputAns{2})== 1
    reInputMsg = msgbox('Please Check and Input Your Name or Your Gender Again!');
    waitfor(reInputMsg);
%     inputAns = Fcn_inputName();
    inputAns = Fcn_InputSubInfo();
    return;
end
% while strcmp('姓名拼音',inputAns{1})== 1 || strcmp('女=1，男=2',inputAns{2})== 1
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
prompt={'输入你的姓名','输入你的性别'};
name='Basic Information';
numlines=1;
defaultanswer={'姓名拼音','女=1，男=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
inputAns=inputdlg(prompt,name,numlines,defaultanswer);
end