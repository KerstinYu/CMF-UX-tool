function Fcn_MaterialEmotion(mainDir)
%% 2014/5/11 Kerstin  CMF_lab
% main test procedure：
% 84(or 100)colors are presented in a random order
% 1,evaluation: color preferrence,valence,arousal in 5 points lekert scale【mutidimentional scaling in future study】
% 2，interval 500ms
% 3，visual angel 5°；visual distance 50cm
%%
% close all;
% clear all;
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

for i = 1:sum(clock)
    textureOrder = randperm(100);
end

% textureOrder =randperm(100);
textureOrder =[1:23];
dataCollection = nan(length(textureOrder),2);

%%--- Loading Dialog
loadWait = waitbar(0,'载入程序，请等待...');

% load data
% cd ('C:\Users\TianxinYu\Desktop\ColorMaterialCorres')
% stimuliRGB= xlsread('color2','sheet1','B2:I101');
% [ndata, text, dataLabel]= xlsread('color2','sheet1','A2:A101');
% stimuliLabel = xlsread('color2','sheet1','A2:A101');

% cd ('D:\Matlab\Kerstin\CMF研究\material\material_emotion\data')
cd([mainDir '\MaterialEmotionPara\data']);
FileName=dir([mainDir '\MaterialEmotionPara\data']);
FileNumber=length(FileName);
StimuliusInitial=nan(FileNumber-2,1000,1000,3);
for i=1:FileNumber-2
    ImageTemp=imread(FileName(i+2).name);
    StimuliusInitial(i,:,:,:)=ImageTemp(1:1000,1:1000,:);
    waitbar(i/(FileNumber-2))
end

close(loadWait);

% image([10 100],[10 100], I);
% axis([0 1440 0 900])
% axis off
% hold on
% image([100 200],[100 200], I*0.5);
%present


%% input parameter
screenSize=Screen('Rect',0);
monitorSize=13;
viewDis=50;
degree=5;
screenWidth = monitorSize*2.54/sqrt(1+screenSize(4)^2/screenSize(3)^2);  % calculate screen width in cm
pixLength=screenWidth/screenSize(3); %wRect(3); %calculates the size of a pixel in cm
pixs = round(2*tan((degree/2)*pi/180) * viewDis / pixLength);

%% background setting
%


xNumber = 12;
yNumber = 2;
cx =screenSize(3)/2;
cy = screenSize(4)/2;
GridLength = screenSize(3)/1.1;
GridHeight = GridLength/4;
SingleGridLength = GridLength/(xNumber+2);
SingleGridLength2=SingleGridLength/1.5;
GridX = linspace(cx-GridLength/2,cx+GridLength/2,xNumber);
GridY = linspace(cy-GridHeight/2,cy+GridHeight/2,yNumber);
GridY2 = (GridY-250)/2;
% textureDis =ones(screenSize(4),screenSize(3),3)*0.5;

background = figure('position',screenSize,'menubar','no','toolbar','no','color',[0.5,0.5,0.5]);
stimulus = rectangle('position',[cx-pixs/2-10 cy-pixs/2+30 pixs pixs],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5],'visible','off');
textureDefult =ones(screenSize(4),screenSize(3),3)*0.5;
textureDefult2 =ones(screenSize(4),screenSize(3),3)*0.5;

ImageContorl = ones(length(textureOrder),1000,1000,3);
axis([0 1440 0 900])
axis off
% tampPref=nan;
tampVale=nan;
tampArou=nan;
% for i=1:length(textureOrder)
%     ImageContorl(i,:,:,:)=StimuliusInitial(textureOrder(i),:,:,:)/255;
% end
%
ImageContorl = bsxfun(@rdivide,StimuliusInitial,255);
iCount=0;
for iY = 1:yNumber
    for iX = 1:xNumber
        iCount=iCount+1;%主要坐标系起始点区别
        if iCount<FileNumber-1
            textureLabel(iCount)=uicontrol(background,'style','text','position',[GridX(iX)./1.28+155 GridY(yNumber+1-iY)./1.25+10 60 15],'visible','off',...
                'fontsize',10,'string',FileName(iCount+2).name,'BackgroundColor',[0.5 0.5 0.5]);
            image([GridX(iX)-SingleGridLength/2 GridX(iX)+SingleGridLength/2],[GridY(iY)-SingleGridLength/2 GridY(iY)+SingleGridLength/2],squeeze(ImageContorl(iCount,:,:,:)))
            hold on
            axis([0 1440 0 900])
            axis off
        else
            
        end
        
    end
end
axis off;
set(textureLabel,'visible','on');
Guide.dis =uicontrol(background,'style','text','position',[cx-340 cy+250 680  30],'visible','on',...
    'fontsize',20,'string','本次实验呈现的样品呈现顺序如下，请确定','BackgroundColor',[0.5 0.5 0.5]);

beginButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-300 120 30],...
    'string','确定','fontsize',18,'visible','on');
set(beginButton,'callback',{@Fcn_SetVisibleOff,beginButton});
waitfor(beginButton,'visible','off');
set(Guide.dis,'visible','off');
set(textureLabel,'visible','off');
image(textureDefult2);
axis off;
%% procedure setting
% for i=1:5
% textValue(i)=text(cx-350+100*i,cy-150,num2str(i),'visible','off');
% end
okButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370  120 40],...
    'string','下一个','fontsize',20,'visible','off');
set(okButton,'callback',{@Fcn_SetVisibleOff,okButton});
label={ '负面' '正面' '低唤醒' '高唤醒'};
for i=1:4
    check.Label(i) = uicontrol(background,'style','text','position',[cx-35-400*(mod(i,2)-0.5)*2 cy-180-ceil(i./2)*45 70 25],'visible','on',...
        'fontsize',16,'string',label(i),'BackgroundColor',[0.5 0.5 0.5]);
end
check.Value = uicontrol(background,'style','text','position',[cx-360 cy-190 710 25],'visible','on',...
    'fontsize',16.5,'string','-5 ----- -4 ----- -3 ----- -2 ----- -1 ----- 0 ----- 1 ----- 2 ----- 3 ----- 4 ----- 5'...
    ,'BackgroundColor',[0.5 0.5 0.5]);
check.Value2 = uicontrol(background,'style','text','position',[cx-340 cy-300 680 25],'visible','on',...
    'fontsize',17,'string','0 ----- 1 ----- 2 ----- 3 ----- 4 ----- 5 ----- 6 ----- 7 ----- 8 ----- 9 ----- 10'...
    ,'BackgroundColor',[0.5 0.5 0.5]);
% check.Preferrence =uicontrol(background,'style','slider','position',[cx-350 cy-200 700 39],'visible','on','Value',2.5,...
%     'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35], ...
%     'callback','tampPref=get(check.Preferrence,''Value'');');
check.Valence = uicontrol(background,'style','slider','position',[cx-350 cy-240 700 39],'visible','on','Value',2.5,...
    'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
check.Arousal = uicontrol(background,'style','slider','position',[cx-350 cy-280 700 39],'visible','on','Value',0,...
    'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0, 'backgroundColor',[0.35 0.35 0.35]);
set(check.Arousal,'callback',{@Fcn_SetVisibleOn,okButton});
fixpoint=rectangle('position',[cx-pixs/2+90 cy-pixs/2+20 10 10],'Curvature', [1 1],'FaceColor',[1 0 0],'EdgeColor',[0.5 0.5 0.5],'visible','on');
Guide.guide =uicontrol(background,'style','text','position',[cx-320 cy-90 650  300],'visible','on',...
    'fontsize',19,'string',{'实 验 说 明'...
    ''...
    '1.接下来你会看到一系列材料样品，请注意下面的滑条，它们分别代表【正性情绪vs.负性情绪】【高唤醒vs.低唤醒（给你带来的情绪的强烈程度）】三个维度。'...
    ''...
    '2.滑条的两端分别代表了这个维度上的两个极端感受，请你根据你看到样品之后的感受，用鼠标拖动滑条，做出判断。'},'BackgroundColor',[0.5 0.5 0.5]);
konwnButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370 120 40],...
    'string','明白了','fontsize',20,'visible','on');
set(konwnButton,'callback',{@Fcn_SetVisibleOff,konwnButton});
pause(0.5);
waitfor(konwnButton,'visible','off');
set(Guide.guide,'visible','off');
set(check.Arousal,'visible','off');
set(check.Valence,'visible','off');
set(fixpoint,'visible','off');
set(check.Label,'visible','off');
set(check.Value,'visible','off');
set(check.Value2,'visible','off');

tampVale=get(check.Valence,'Value');
tampArou=get(check.Arousal,'Value');
%% main test
stimulue.Label = uicontrol(background,'style','text','position',[cx-pixs/2 cy-pixs/2 225 50],'visible','on',...
    'fontsize',16,'string','','BackgroundColor',[0.5 0.5 0.5]);
%  stimulus = rectangle('position',[cx-pixs/2-20 cy-pixs/2-90 pixs pixs],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5],'visible','off');
for i=1:23
    set(fixpoint,'visible','on');
    pause(0.5);
    set(check.Arousal,'visible','on');
    set(check.Valence,'visible','on');
    set(fixpoint,'visible','off');
    set(check.Label,'visible','on');
    set(check.Value,'visible','on');
    set(check.Value2,'visible','on');
    set(stimulue.Label,'string',FileName(i+2).name)
    %   set(stimulus,'visible','on','FaceColor',ImageContorl(i,:))
    image([cx-pixs/2-20 cx-pixs/2-20+pixs],[cy-pixs/2-90 cy-pixs/2-90+pixs],squeeze(ImageContorl(i,:,:,:)))
    pause(0.5)
    waitfor(okButton,'visible','on');
    pause(0.5)
    waitfor(okButton,'visible','off');
    %   set(stimulus,'visible','off');
    tampVale=get(check.Valence,'Value');
    tampArou=get(check.Arousal,'Value');
    dataCollection(textureOrder(i),1)=tampVale;
    dataCollection(textureOrder(i),2)=tampArou;
    %   set(check.Preferrence,'visible','off','Value',2.5);
    set(check.Valence,'visible','off','Value',2.5);
    set(check.Arousal ,'visible','off','Value',0);
end
set(Guide.guide,'visible','off');
set(check.Arousal,'visible','off');
set(check.Valence,'visible','off');
set(fixpoint,'visible','off');
set(check.Label,'visible','off');
set(check.Value,'visible','off');
set(check.Value2,'visible','off');
set(stimulue.Label,'visible','off')
image([cx-pixs/2-20 cx-pixs/2-20+pixs],[cy-pixs/2-90 cy-pixs/2-90+pixs],squeeze(ImageContorl(i,:,:,:))*0+0.5)
Guide.End =uicontrol(background,'style','text','position',[cx-60 cy-30 120 30],'visible','on',...
    'fontsize',19,'string','THE END','BackgroundColor',[0.5 0.5 0.5]);
Guide.CloseButton = uicontrol(background,'style','pushbutton','position',[cx-60 cy-60 120 30],'visible','on',...
    'fontsize',19,'string','Quit','BackgroundColor',[0.7 0.7 0.7]);
set(Guide.CloseButton,'callback',{@Fcn_CloseFig,background});
%% data saving and result plotting
DataCollection=dataCollection;
dataCollection2=fix(dataCollection*(11/6));
currentfile=sprintf([answer{1} '_' answer{2} '_' 'metal']);
name={answer{1}};

cd([mainDir '\MaterialEmotionPara\UserData']);


%    d= {FileName(i+2).name,; dataCollection(textureOrder(i),1); dataCollection(textureOrder(i),2)};
xlswrite('data12_18.xlsx', {FileName(3:25).name}',1, 'A2');
xlswrite('data12_18.xlsx', {FileName(3:25).name}',2, 'A2');
xlswrite('data12_18.xlsx', dataCollection2(:,1), 1, 'B2');
xlswrite('data12_18.xlsx', dataCollection2(:,2), 2, 'B2');
xlswrite('data12_18.xlsx', name, 1, 'B1');
xlswrite('data12_18.xlsx', name, 2, 'B1');

save(currentfile,'dataCollection','DataCollection');
cd(mainDir);
%% sub functions
    function Fcn_SetVisibleOff(hObject,eventdata,hChild)
        set(hChild,'visible','off');
    end

    function Fcn_SetVisibleOn(hObject,eventdata,hChild)
        set(hChild,'visible','on');
    end
    function Fcn_CloseFig(hObjec,eventdata,hChild)
        close(hChild);
    end
end