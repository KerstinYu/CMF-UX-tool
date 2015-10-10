function Fcn_ColorEmotion(mainDir)
%% 2014/5/11 Kerstin  CMF_lab
% main test procedure��
% 84(or 100)colors are presented in a random order
% 1,evaluation: color preferrence,valence,arousal in 5 points lekert scale��mutidimentional scaling in future study��
% 2��interval 500ms
% 3��visual angel 5�㣻visual distance 50cm
%%
try
%     introImgName = [mainDir '\PanelPics\1.png'];
%     introTitle = 'Color Emotion Introduction';
%     introStr = {'This test is for color emotion',...
%     'Relax and ebjoy....'};
%     %%
%     close all
%     introImg = imread(introImgName);
%     introF = figure(500);
%     screenSize = get(0,'screensize');
%     cx = screenSize(3)/2;
%     cy = screenSize(4)/2;
%     screenW = screenSize(3);
%     screenH = screenSize(4);
%     set(introF,'toolbar','none','menubar','none','color',[1 1 1],...
%         'position',[cx-screenW/4,cy-screenH/4,cx,cy]);
%     imgAx = axes('position',[0.05,0.3,0.4,0.3]);
%     axis off
%     imshow(introImg);
%     titleText = uicontrol(introF,'style','text','position',[80 270 200 50],'fontsize',14,...
%     'backgroundcolor',[1 1 1],...
%     'string',introTitle);
%     introText = uicontrol(introF,'style','text','HorizontalAlignment','Left',...
%         'position',[350 50 400 300],...
%         'fontsize',14,'backgroundcolor',[0 1 1],...
%     'string',introStr);
% contButton = uicontrol(introF,'style','pushbutton','position',[40 50,100,50],...
%     'string','Continue','fontsize',15);
% cancleButton = uicontrol(introF,'style','pushbutton','position',[200,50 100 50],...
%     'string','Cancel','fontsize',15);
%     %%
    
    
    
    for i = 1:sum(clock)
        textureOrder = randperm(100);
    end
    
    inputAns = Fcn_InputSubInfo();
    if isempty(inputAns)
        return
    end
    
    textureOrder =randperm(100);
    dataCollection = nan(length(textureOrder),3);
    % load data
    % cd ('D:\Matlab\Kerstin\CMF�о�\MainExp');
    loadWait = waitbar(0,'���������ȴ�...');
    
    stimuliRGB= xlsread('ColorEmotionPara\color2','sheet1','B2:I101');
    waitbar(0.3)
    [ndata, text, dataLabel]= xlsread('ColorEmotionPara\color2','sheet1','A2:A101');
    waitbar(0.7)
    stimuliLabel = xlsread('ColorEmotionPara\color2','sheet1','A2:A101');
    waitbar(1)
    close(loadWait);
    %% input parameter
    ScreenSize=Screen('Rect',0);
%     ScreenSize=[0 0 1440 900];
    
    monitorSize=13;
    viewDis=50;
    degree=5;
    screenWidth = monitorSize*2.54/sqrt(1+ScreenSize(4)^2/ScreenSize(3)^2);  % calculate screen width in cm
    pixLength=screenWidth/ScreenSize(3); %wRect(3); %calculates the size of a pixel in cm
    pixs = round(2*tan((degree/2)*pi/180) * viewDis / pixLength);
    
    
    %% background setting
    %
    xNumber = 25;
    yNumber = 4;
    cx =ScreenSize(3)/2;
    cy = ScreenSize(4)/2;
    GridLength = ScreenSize(3)/1.2;
    GridHeight = GridLength/4;
    SingleGridLength = GridLength/(xNumber+2);
    SingleGridLength2=SingleGridLength/1.5;
    GridX = linspace(cx-GridLength/2,cx+GridLength/2,xNumber);
    GridY = linspace(cy-GridHeight/2,cy+GridHeight/2,yNumber);
    GridY2 = (GridY-250)/2;
    textureDis =ones(ScreenSize(4),ScreenSize(3),3)*0.5;
    background = figure('position',ScreenSize,'menubar','no','toolbar','no','color',[0.5,0.5,0.5]);
    stimulus = rectangle('position',[cx-pixs/2-10 cy-pixs/2+30 pixs pixs],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5],'visible','off');
    textureDefult =ones(ScreenSize(4),ScreenSize(3),3)*0.5;
    textureDefult2 =ones(ScreenSize(4),ScreenSize(3),3)*0.5;
    
    textureContorl = ones(length(textureOrder),3);
    textureTemp = ones(ScreenSize(4),ScreenSize(3),3)*0.5;
    
    tampPref=nan;
    tampVale=nan;
    tampArou=nan;
    for i=1:length(textureOrder)
        textureContorl(i,:)=stimuliRGB(textureOrder(i),1:3)/255;
    end
    %
    iCount=0;
    for iX = 1:xNumber
        for iY = 1:yNumber
            iCount=iCount+1;%��Ҫ����ϵ��ʼ������
            %         textureLabel(iCount)=uicontrol(background,'style','text','position',[GridX(iX)./1.28+155 GridY(yNumber+1-iY)./1.25+60 45 10],'visible','on',...
            %     'fontsize',5,'string',dataLabel(textureOrder (iCount)),'BackgroundColor',[0.5 0.5 0.5]);
            textureDis(GridY(iY)-SingleGridLength/2:GridY(iY)+SingleGridLength/2,...
                GridX(iX)-SingleGridLength/2:GridX(iX)+SingleGridLength/2,1)=textureContorl(iCount,1);
            textureDis(GridY(iY)-SingleGridLength/2:GridY(iY)+SingleGridLength/2,...
                GridX(iX)-SingleGridLength/2:GridX(iX)+SingleGridLength/2,2)=textureContorl(iCount,2);
            textureDis(GridY(iY)-SingleGridLength/2:GridY(iY)+SingleGridLength/2,...
                GridX(iX)-SingleGridLength/2:GridX(iX)+SingleGridLength/2,3)=textureContorl(iCount,3);
            textureDefult2(GridY2(iY)-SingleGridLength2/2:GridY2(iY)+SingleGridLength2/2,...
                GridX(iX)-SingleGridLength2/2:GridX(iX)+SingleGridLength2/2,1)=stimuliRGB(iCount,1)/255;
            textureDefult2(GridY2(iY)-SingleGridLength2/2:GridY2(iY)+SingleGridLength2/2,...
                GridX(iX)-SingleGridLength2/2:GridX(iX)+SingleGridLength2/2,2)=stimuliRGB(iCount,2)/255;
            textureDefult2(GridY2(iY)-SingleGridLength2/2:GridY2(iY)+SingleGridLength2/2,...
                GridX(iX)-SingleGridLength2/2:GridX(iX)+SingleGridLength2/2,3)=stimuliRGB(iCount,3)/255;
        end
    end
    image(textureDis);
    axis off;
    Guide.dis =uicontrol(background,'style','text','position',[cx-340 cy+250 680  30],'visible','on',...
        'fontsize',20,'string','����ʵ����ֵ���ɫ�Լ����˳�����£���ȷ��','BackgroundColor',[0.5 0.5 0.5]);
    
    beginButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-300 120 30],...
        'string','ȷ��','fontsize',18,'visible','on');
    set(beginButton,'callback',{@Fcn_SetVisibleOff,beginButton});
    waitfor(beginButton,'visible','off');
    
    set(beginButton,'visible','off');
    set(Guide.dis,'visible','off');
    % set(textureLabel,'visible','off');
    image(textureDefult2);
    axis off;
    %% procedure setting
    % for i=1:5
    % textValue(i)=text(cx-350+100*i,cy-150,num2str(i),'visible','off');
    % end
    okButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370  120 40],...
        'string','��һ��','fontsize',20,'visible','off');
    set(okButton,'callback',{@Fcn_SetVisibleOff,okButton})
    label={'ϲ��' '��ϲ��' '����' '����' '�ͻ���' '�߻���'};
    for i=1:6
        check.Label(i) = uicontrol(background,'style','text','position',[cx-35-400*(mod(i,2)-0.5)*2 cy-157-ceil(i./2)*40 70 25],'visible','on',...
            'fontsize',16,'string',label(i),'BackgroundColor',[0.5 0.5 0.5]);
    end
    check.Value = uicontrol(background,'style','text','position',[cx-340 cy-160 680 25],'visible','on',...
        'fontsize',19,'string','-2 --------------- -1---------------- 0 --------------- 1 --------------- 2'...
        ,'BackgroundColor',[0.5 0.5 0.5]);
    check.Value2 = uicontrol(background,'style','text','position',[cx-340 cy-300 680 25],'visible','on',...
        'fontsize',19,'string','1  --------------- 2 ---------------- 3 --------------- 4 --------------- 5'...
        ,'BackgroundColor',[0.5 0.5 0.5]);
    check.Preferrence =uicontrol(background,'style','slider','position',[cx-350 cy-200 700 39],'visible','on','Value',2.5,...
        'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
    check.Valence = uicontrol(background,'style','slider','position',[cx-350 cy-240 700 39],'visible','on','Value',2.5,...
        'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
    check.Arousal = uicontrol(background,'style','slider','position',[cx-350 cy-280 700 39],'visible','on','Value',2.5,...
        'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0, 'backgroundColor',[0.35 0.35 0.35]);
    set(check.Arousal,'callback',{@Fcn_SetVisibleOn,okButton});
    
    % check.Preferrence =uicontrol(background,'style','slider','position',[cx-350 cy-200 700 39],'visible','on','Value',2.5,...
    %     'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
    % check.Valence = uicontrol(background,'style','slider','position',[cx-350 cy-240 700 39],'visible','on','Value',2.5,...
    %  'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
    % check.Arousal = uicontrol(background,'style','slider','position',[cx-350 cy-280 700 39],'visible','on','Value',0,...
    % 'fontsize',20,'SliderStep',[0.01,0.1],'Max',5,'Min',0, 'backgroundColor',[0.35 0.35 0.35]);
    
    fixpoint=rectangle('position',[cx-pixs/2+90 cy-pixs/2+20 10 10],'Curvature', [1 1],'FaceColor',[1 0 0],'EdgeColor',[0.5 0.5 0.5],'visible','on');
    Guide.guide =uicontrol(background,'style','text','position',[cx-320 cy-110 650  300],'visible','on',...
        'fontsize',19,'string',{'ʵ �� ˵ ��'...
        ''...
        '1.��������ῴ��һϵ����ɫ����ע������Ļ��������Ƿֱ����ϲ��vs.��ϲ��������������vs.�������������߻���vs.�ͻ��ѣ����������������ǿ�ҳ̶ȣ�������ά�ȡ�'...
        ''...
        '2.���������˷ֱ���������ά���ϵ��������˸��ܣ���������㿴����ɫ֮��ĸ��ܣ�������϶������������жϡ�'},'BackgroundColor',[0.5 0.5 0.5]);
    konwnButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370 120 40],...
        'string','������','fontsize',20,'visible','on');
    set(konwnButton,'callback',{@Fcn_SetVisibleOff,konwnButton});
    % uiwait;
    pause(0.5);
    waitfor(konwnButton,'visible','off');
    % set(okButton,'visible','on');
    % set(konwnButton,'visible','off');
    set(Guide.guide,'visible','off');
    tampPref=get(check.Preferrence,'Value');
    tampVale=get(check.Valence,'Value');
    tampArou=get(check.Arousal,'Value');
    set(check.Preferrence,'visible','off','Value',2.5);
    set(check.Valence,'visible','off','Value',2.5);
    set(check.Arousal ,'visible','off','Value',2.5);
    %% main test
    stimulus = rectangle('position',[cx-pixs/2-20 cy-pixs/2-90 pixs pixs],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5],'visible','off');
    for i=1:100
        set(fixpoint,'visible','on');
        pause(0.5);
        set(fixpoint,'visible','off');
        set(check.Preferrence,'visible','on');
        set(check.Valence,'visible','on');
        set(check.Arousal ,'visible','on');
        set(stimulus,'visible','on','FaceColor',textureContorl(i,:));
        pause(0.5)
        %   uiwait;
        %
        waitfor(okButton,'visible','on');
        %     waitforbuttonpress;
        %     set(okButton,'visible','on');
        pause(0.5)
        %     uiwait;
        %   waitforbuttonpress;
        %     set(okButton,'visible','off');
        waitfor(okButton,'visible','off');
        set(stimulus,'visible','off');
        tampPref=get(check.Preferrence,'Value');
        tampVale=get(check.Valence,'Value');
        tampArou=get(check.Arousal,'Value');
        dataCollection(textureOrder(i),:)=[tampPref tampVale tampArou];
        set(check.Preferrence,'visible','off','Value',2.5);
        set(check.Valence,'visible','off','Value',2.5);
        set(check.Arousal ,'visible','off','Value',2.5);
    end
    
    
    Guide.End =uicontrol(background,'style','text','position',[cx-60 cy-30 120 30],'visible','on',...
        'fontsize',19,'string','THE END','BackgroundColor',[0.5 0.5 0.5]);
    Guide.CloseButton = uicontrol(background,'style','pushbutton','position',[cx-60 cy-60 120 30],'visible','on',...
        'fontsize',19,'string','Quit','BackgroundColor',[0.7 0.7 0.7]);
    set(Guide.CloseButton,'callback',{@Fcn_CloseFig,background});
    
    %% data saving and result plotting
    DataCollection=dataCollection;
    currentfile=sprintf([inputAns{1} '_' inputAns{2} '_' 'color']);
    % cd('D:\Matlab\Kerstin\CMF�о�\MainExp\ColorEmotionPara\UserData')
    cd('ColorEmotionPara\UserData');
    save(currentfile,'dataCollection','DataCollection');
    cd(mainDir);
catch ME
    cd(mainDir);
end
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