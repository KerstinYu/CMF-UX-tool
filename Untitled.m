KbName('UnifyKeyNames');
escapeKey = KbName('escape');
Key(1)=KbName('Z');
Key(2)=KbName('M');
prompt={'输入你的姓名','输入你的性别'};
name='Basic Information';
numlines=1;
defaultanswer={'姓名拼音','女=1，男=2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer);


