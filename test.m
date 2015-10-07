
function input()

KbName('UnifyKeyNames');
escapeKey = KbName('escape');
Key(1)=KbName('Z');
Key(2)=KbName('M');
Fcn_inputName(answer);
if isempty(answer)==1
    msgbox('You just canceled this test!')
    pause(1);
    return;
end
while strcmp('姓名拼音',answer{1})== 1 || strcmp('女=1，男=2',answer{2})== 1;
    msgbox('Please Check and Input Your Name or Your Gender Again!')
    Fcn_inputName()   
end


disp(answer)


end

function answer = Fcn_inputName(answer)
prompt={'输入你的姓名','输入你的性别'};
name='Basic Information';
numlines=1;
defaultanswer={'姓名拼音','女=1，男=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer)
end
