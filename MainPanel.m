% funtion MainPanel
%% Main Control Panel
% 2015/6
%----main control panel include three modules so far, which are color
%emotion ,material emotion and questionnaire for Material Sensory
%Properties. 
%% Control Panel Initialization
clear all
close all;

mainDir = 'C:\Users\Qicheng Ding\Documents\GitHub\CMF-UX-tool';
cd(mainDir);

reSize = get(0,'ScreenSize');
%reSize = reSize/2;
offSet = [8 -5];
mainFig = figure(100);
set(mainFig,'Position',[offSet(1) offSet(2) reSize(3) reSize(4)]);
set(mainFig,'MenuBar','none','NumberTitle','off','color','w');
BackgroColor = get(mainFig,'Color');
% layout
cx = reSize(3)/2;
cy = reSize(4)/2;
xGrid = reSize(3)/15; 
yGrid = reSize(4)/9;
% start point of block
xStart=[cx-xGrid*5 cx-xGrid*1.4 cx+xGrid*2.2];
yStart=[yGrid*5 yGrid*2.5];
blockWidth=xGrid*2.8;
blockHeight=yGrid*0.5;
buttonWidth=2.7*xGrid;
buttonHeight=0.35*yGrid;

% button
buttonOffsetX=( blockWidth-buttonWidth)/2;
buttonOffsetY=0.1*yGrid; 


Panel.title = uicontrol(mainFig,'Style','text','position',[cx-250,cy + yGrid*2.5,500 100],'Fontsize',19,...
    'BackgroundColor',BackgroColor,...
    'String',{'Quantitive Evaluation for CMF Research'});
%% pics for each section
cd([mainDir '\PanelPics']);
FileName=dir([mainDir '\PanelPics']);
FileNumber=length(FileName);
testpic=nan(FileNumber-2,160,320,3);
for i=1:FileNumber-2
    ImageTemp=imread(FileName(i+2).name);
    testpic(i,:,:,:)=ImageTemp(1:160,1:320,:);
end
testpicConvert = bsxfun(@rdivide,testpic,255);
picxStart = [50 495 940 ];
picyStart = [140 800];
for i=1:FileNumber-2
    image([picxStart(i) picxStart(i)+400],[picyStart(1) picyStart(1)+200],squeeze(testpicConvert(i,:,:,:))) 
    hold on
     axis([0 1440 0 900])
     axis off
end
cd(mainDir);
%% Color Emotion Section
Panel.colorEmoText = uicontrol(mainFig,'visible','off','style','text','position',[xStart(1),yStart(1),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for color emotion',...
    'Click Select button to start test'});
Panel.colorEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(1)+buttonOffsetX,yStart(1)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',13,'string','Color-Emotion Correspondence');
set(Panel.colorEmoButton,'callback', 'Fcn_ColorEmotion(mainDir);');
%% Material Emotion Section
Panel.materialEmoText = uicontrol(mainFig,'visible','off','style','text','position',[xStart(2),yStart(1),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for material emotion',...
    'Click Select button to start test'});
Panel.materialEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(2)+buttonOffsetX,yStart(1)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',13,'string','Material-Emotion Correspondence');
set(Panel.materialEmoButton,'callback', 'Fcn_MaterialEmotion(mainDir);');
%% Questionnaire for visual touch mode
Panel.quesEmoText = uicontrol(mainFig,'visible','off','style','text','position',[xStart(3),yStart(1),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for visual touch mode',...
    'Click Select button to start test'});
Panel.quesEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(3)+buttonOffsetX,yStart(1)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',13,'string','Material Perception Test');
set(Panel.quesEmoButton,'callback', 'Fcn_QuesVisualTouchMode(mainDir);'); 

%% Part 4
Panel.partFourText = uicontrol(mainFig,'style','text','position',[xStart(1),yStart(2),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'For new test',...
    ''});
Panel.partFourButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(1)+buttonOffsetX,yStart(2)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',15,'string','Coming Soon...');
set(Panel.partFourButton,'callback', 'Fcn_QuesVisualTouchMode(mainDir);'); 

%% Part 5
Panel.partFiveText = uicontrol(mainFig,'style','text','position',[xStart(2),yStart(2),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'For new test',...
    ''});
Panel.partFiveButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(2)+buttonOffsetX,yStart(2)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',15,'string','Coming Soon...');
set(Panel.partFiveButton,'callback', 'Fcn_QuesVisualTouchMode(mainDir);'); 

%% Part 6
Panel.partSixText = uicontrol(mainFig,'style','text','position',[xStart(3),yStart(2),blockWidth ,blockHeight],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'For new test',...
    ''});
Panel.partSixButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[xStart(3)+buttonOffsetX,yStart(2)+buttonOffsetY,buttonWidth,buttonHeight]','fontsize',15,'string','Coming Soon...');
set(Panel.partSixButton,'callback', 'Fcn_QuesVisualTouchMode(mainDir);'); 

%% Quit Button Section
Panel.quitText = uicontrol(mainFig,'style','text','position',[cx-xGrid*2,yGrid*1.2 ,xGrid*4 ,yGrid*0.5],'fontsize',14,...
    'backgroundcolor',BackgroColor,...
    'string',{'Click Quit button to end entire procedure'});
Panel.quitButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[cx-0.4*xGrid,yGrid*1,xGrid*0.8,yGrid*0.40]','fontsize',15,'string','Quit');
set(Panel.quitButton,'callback','close(mainFig)');


