% funtion MainPanel
%% Main Control Panel
% 2015
%----main control panel include three module so far, which are color
%emotion ,material emotion and questionnaire for Material Sensory
%Properties. 
%% Control Panel Initialization
close all
clear all

mainDir = 'D:\Matlab\Kerstin\CMFÑÐ¾¿\MainExp';
cd(mainDir);

resSize = get(0,'screensize');
mainFig = figure(100);
set(mainFig,'Position',resSize);
BackgroColor = get(mainFig,'Color');

cx = resSize(3)/2;
cy = resSize(4)/2;

Panel.title = uicontrol(mainFig,'Style','text','position',[cx-300,cy-50,500 400],'Fontsize',19,...
    'BackgroundColor',BackgroColor,...
    'String',{'Quantitive Evaluation for Material Sensory'});
%% Color Emotion Section
Panel.colorEmoText = uicontrol(mainFig,'style','text','position',[cx-700,cy,500,150],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for color emotion',...
    'Click Select button to start test'});
Panel.colorEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[cx-500,cy+20,100,50]','fontsize',15,'string','Select');
set(Panel.colorEmoButton,'callback', 'Fcn_ColorEmotion(mainDir);');
%% Material Emotion Section
Panel.materialEmoText = uicontrol(mainFig,'style','text','position',[cx-700,cy-180,500,150],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for material emotion',...
    'Click Select button to start test'});
Panel.materialEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[cx-500,cy-160,100,50]','fontsize',15,'string','Select');
set(Panel.materialEmoButton,'callback', 'Fcn_MaterialEmotion(mainDir);');
%% Questionnaire for visual touch mode
Panel.materialEmoText = uicontrol(mainFig,'style','text','position',[cx,cy-50,500,150],'fontsize',14,...
    'backgroundcolor',[0.9 0.9 0.9],...
    'string',{'This test is for quantitive evaluation for visual touch mode',...
    'Click Select button to start test'});
Panel.materialEmoButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[cx+200,cy-30,100,50]','fontsize',15,'string','Select');
set(Panel.materialEmoButton,'callback', 'Fcn_QuesVisualTouchMode(mainDir);');

%% Quit Button Section
Panel.quitText = uicontrol(mainFig,'style','text','position',[cx-700,cy-320,500,100],'fontsize',14,...
    'backgroundcolor',[0.7 0.7 0.7],...
    'string',{'Click Quit button to end entire procedure'});
Panel.quitButton = uicontrol(mainFig,'style','pushbutton',...
    'position',[cx-500,cy-300,100,50]','fontsize',15,'string','Quit');
set(Panel.quitButton,'callback','close(mainFig)');


