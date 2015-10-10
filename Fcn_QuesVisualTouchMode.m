function Fcn_QuesVisualTouchMode(mainDir)
try
    
    % mainDir = 'D:\Matlab\Kerstin\CMF�о�\MainExp';
    cd(mainDir);
    
    %% Collect Demographical Data
    for i =1:sum(clock)
        imageRand = randperm(length(100));
    end
    
    inputAns = Fcn_InputSubInfo();
    if isempty(inputAns)
        return
    end
    %% input parameter
    
    
    screenSize=Screen('Rect',0);
    monitorSize=13;
    viewDis=50;
    degree=5;
    screenWidth = monitorSize*2.54/sqrt(1+screenSize(4)^2/screenSize(3)^2);  % calculate screen width in cm
    pixLength=screenWidth/screenSize(3); %wRect(3); %calculates the size of a pixel in cm
    pixs = round(2*tan((degree/2)*pi/180) * viewDis / pixLength);
    axis([0 screenSize(3) 0 screenSize(4)]);
    axis off
    
    cx =screenSize(3)/2;
    cy = screenSize(4)/2;
    %% Load Data & Pra Intial
    
    background = figure('position',screenSize,'menubar','no','toolbar','no','color',[0.5,0.5,0.5]);
    
    sectOneNum = 11;
    sectTwoNum = 10;
    sectThreeNum = 1;
    
    imageDir = [mainDir,'\QuesVisualTouchPara\ImageData'];
    imageF = dir(imageDir);
    imageNum = length(imageF)-2;
    loadWait = waitbar(0,'���������ȴ�...');
    StimuliusInitial=nan(imageNum,1000,1000,3);
    for i=1:imageNum
        ImageTemp=imread([imageDir '\' imageF(i+2).name]);
        StimuliusInitial(i,:,:,:)=ImageTemp(1:1000,1:1000,:);
        waitbar(i/(imageNum))
    end
    ImageContorl = bsxfun(@rdivide,StimuliusInitial,255);
    close(loadWait);
    % close(1);
    
    SectOneData = nan(imageNum,sectOneNum);
    SectTwoData = nan(imageNum,sectTwoNum);
    SectThreeData = cell(imageNum,sectThreeNum);
    
    LabelVec.SecOne= {'�⻬' '�ֲ�';...
        '�޹���' '�й���';...
        '��͸��','͸��';...
        'ɫ�ʰ���','ɫ������';...
        'ɫ�ʻ���','ɫ�ʴ���';...
        '����ƽ��','���氼͹';...
        '��','��';...
        '��','Ӳ';...
        '����','ʪ��';...
        '��ճ','ճ';...
        '����','����'};
    LabelVec.SecTwo = {'ƽ����','�̼���';...
        '���Ƶ�','���ֵ�';...
        '��ª��','Ư����';...
        '��ͳ��','ʱ�е�';...
        '�����˵�','���˰�ȫ��';...
        '�������','�����';...
        '������','�ݳ޵�';...
        'Ů�Ե�������','���Ե����յ�';...
        '������Զ��','�����׽���';...
        '�˹���','��Ȼ��'};
    
    %% initialize window
    okButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370  120 40],...
        'string','��һ��','fontsize',20,'visible','off');
    set(okButton,'callback',{@Fcn_SetVisibleOff,okButton});
    
    guideText =uicontrol(background,'style','text','position',[cx-320 cy-90 650  300],'visible','on',...
        'fontsize',19,'string',{'Part 1 ʵ �� ˵ ��'...
        ''...
        '�����ÿһ������ָ�꣬�������ṩ�Ĳο�����������ÿһ����һ���ʵĸо�����ֵ'...
        ''...
        '���ϸ������б������жԱȺ���������'},'BackgroundColor',[0.5 0.5 0.5]);
    for i=1:2
        check.LabelOne(i) = uicontrol(background,'style','text','position',[cx-55-400*(mod(i,2)-0.5)*2 cy-190-ceil(i./2)*45 100 25],'visible','on',...
            'fontsize',12,'string',LabelVec.SecOne(1,i),'BackgroundColor',[0.5 0.5 0.5]);
    end
    check.Value = uicontrol(background,'style','text','position',[cx-360 cy-190 710 25],'visible','on',...
        'fontsize',16.5,'string','0 ----- 1 ----- 2 ----- 3 ----- 4 ----- 5 ----- 6 ----- 7 ----- 8 ----- 9 ----- 10'...
        ,'BackgroundColor',[0.5 0.5 0.5]);
    check.Slider = uicontrol(background,'style','slider','position',[cx-350 cy-240 700 39],'visible','on','Value',5,...
        'fontsize',20,'SliderStep',[0.01,0.1],'Max',10,'Min',0,'backgroundColor',[0.35 0.35 0.35]);
    set(check.Slider,'callback',{@Fcn_SetVisibleOn,okButton});
    
    konwnButton = uicontrol(background,'style','pushbutton','position',[ cx-60 cy-370 120 40],...
        'string','������','fontsize',20,'visible','on');
    set(konwnButton,'callback',{@Fcn_SetVisibleOff,konwnButton});
    pause(0.5);
    waitfor(konwnButton,'visible','off');
    set(check.Value,'visible','off');
    set(check.LabelOne,'visible','off');
    set(check.Value,'visible','off');
    set(check.Slider,'visible','off');
    set(guideText,'visible','off');
    
    tampScore=get(check.Slider,'Value');
    set(check.Slider,'visible','off','Value',5);
    %% Part 1
    sectOneNum = 11;
    
    quesRank = randperm(sectOneNum);
    imageRank = randperm(imageNum);
    stimulue.Label = uicontrol(background,'style','text','position',[cx-pixs/2 cy-pixs/2 225 50],'visible','on',...
        'fontsize',16,'string','','BackgroundColor',[0.5 0.5 0.5]);
    for img_i =1:imageNum
        clear tempImg
        tempImg = squeeze(ImageContorl(imageRank(img_i),:,:,:));
        imgH = image([cx-pixs/2-20 cx-pixs/2-20+pixs],[cy-pixs/2-90 cy-pixs/2-90+pixs],tempImg);
        axis([0 screenSize(3) 0 screenSize(4)]);
        axis off
        for que_i = 1:sectOneNum
            clear tempLabel
            %         display(quesRank(que_i))
            tempLabel = LabelVec.SecOne(quesRank(que_i),:);
            set(check.LabelOne,'visible','on');
            set(check.LabelOne(1),'string',tempLabel(1));
            set(check.LabelOne(2),'string',tempLabel(2));
            set(check.Slider,'visible','on');
            set(check.Value,'visible','on');
            
            pause(0.5)
            waitfor(okButton,'visible','on');
            pause(0.5)
            waitfor(okButton,'visible','off');
            tampScore=get(check.Slider,'Value');
            SectOneData(imageRank(img_i),quesRank(que_i))=tampScore;
            set(check.Slider,'visible','off','Value',5);
        end
    end
    set(check.Value,'visible','off');
    set(check.LabelOne,'visible','off');
    set(check.Value,'visible','off');
    set(check.Slider,'visible','off');
    set(guideText,'visible','off');
    set(imgH,'visible','off');
    %% Part 2
    set(guideText,'visible','on','string',{'Part 2 ʵ �� ˵ ��'...
        ''...
        '������Լ����жϸ���ÿһ������ָ���������ֵ'});
    set(check.LabelOne(1),'visible','on','string',LabelVec.SecTwo(1,1));
    set(check.LabelOne(2),'visible','on','string',LabelVec.SecTwo(1,2));
    set(check.Slider,'visible','on');
    set(check.Value,'visible','on');
    set(konwnButton,'visible','on');
    pause(0.5);
    waitfor(konwnButton,'visible','off');
    set(check.Value,'visible','off');
    set(check.LabelOne,'visible','off');
    set(check.Value,'visible','off');
    set(check.Slider,'visible','off');
    set(guideText,'visible','off');
    
    quesRank = randperm(sectTwoNum);
    imageRank = randperm(imageNum);
    stimulue.Label = uicontrol(background,'style','text','position',[cx-pixs/2 cy-pixs/2 225 50],'visible','on',...
        'fontsize',16,'string','','BackgroundColor',[0.5 0.5 0.5]);
    set(imgH,'visible','on');
    for img_i =1:imageNum
        clear tempImg
        tempImg = squeeze(ImageContorl(imageRank(img_i),:,:,:));
        imgH = image([cx-pixs/2-20 cx-pixs/2-20+pixs],[cy-pixs/2-90 cy-pixs/2-90+pixs],tempImg);
        axis([0 screenSize(3) 0 screenSize(4)]);
        axis off
        for que_i = 1:sectTwoNum
            clear tempLabel
            tempLabel = LabelVec.SecTwo(quesRank(que_i),:);
            set(check.LabelOne,'visible','on');
            set(check.LabelOne(1),'string',tempLabel(1));
            set(check.LabelOne(2),'string',tempLabel(2));
            set(check.Slider,'visible','on');
            set(check.Value,'visible','on');
            
            pause(0.5)
            waitfor(okButton,'visible','on');
            pause(0.5)
            waitfor(okButton,'visible','off');
            tampScore=get(check.Slider,'Value');
            SectTwoData(imageRank(img_i),quesRank(que_i))=tampScore;
            set(check.Slider,'visible','off','Value',5);
        end
    end
    
    %% Part 3
    set(check.LabelOne,'visible','off');
    set(check.Value,'visible','off');
    set(check.Slider,'visible','off');
    
    set(guideText,'visible','on','string',{'Part 3 ʵ �� ˵ ��'...
        ''...
        '������Լ��ľ��������飬������ÿһ�ֲ��ʵ�����,������ɺ��������������������ȷ��'});
    set(konwnButton,'visible','on');
    pause(0.5);
    waitfor(konwnButton,'visible','off');
    
    set(guideText,'visible','off');
    check.Edit = uicontrol(background,'style','edit','position',[cx-400,cy-325,800,300],'visible','on',...
        'backgroundcolor',[0.8 0.8 0.8],'fontsize',15,'max',50,'HorizontalAlignment','left');
    set(check.Edit,'callback',{@Fcn_SetVisibleOn,okButton});
    
    imageRank = randperm(imageNum);
    % stimulue.Label = uicontrol(background,'style','text','position',[cx-pixs/2 cy-pixs/2 225 50],'visible','on',...
    %     'fontsize',16,'string','','BackgroundColor',[0.5 0.5 0.5]);
    set(imgH,'visible','on');
    for img_i =1:imageNum
        clear tempImg
        tempImg = squeeze(ImageContorl(imageRank(img_i),:,:,:));
        imgH = image([cx-pixs/2-20 cx-pixs/2-20+pixs],[cy-pixs/2-90 cy-pixs/2-90+pixs],tempImg);
        axis([0 screenSize(3) 0 screenSize(4)]);
        axis off
        
        set(check.Edit,'string','');
        pause(0.5)
        waitfor(okButton,'visible','on');
        pause(0.5)
        waitfor(okButton,'visible','off');
        clear tempStr
        tempStr=get(check.Edit,'String');
        SectThreeData{imageRank(img_i)}=tempStr;
        %     set(check.Slider,'visible','off','Value',5);
    end
    set(check.Edit,'visible','off');
    set(okButton,'visible','off');
    set(imgH,'visible','off');
    Guide.End =uicontrol(background,'style','text','position',[cx-60 cy-30 120 30],'visible','on',...
        'fontsize',19,'string','THE END','BackgroundColor',[0.5 0.5 0.5]);
    Guide.CloseButton = uicontrol(background,'style','pushbutton','position',[cx-60 cy-60 120 30],'visible','on',...
        'fontsize',19,'string','Quit','BackgroundColor',[0.7 0.7 0.7]);
    set(Guide.CloseButton,'callback',{@Fcn_CloseFig,background});
    %% Save Data
    
    saveName = ['Ques_' inputAns{2}];
    cd([mainDir,'\QuesVisualTouchPara\UserData']);
    save(saveName,'inputAns','SectOneData','SectTwoData','SectThreeData');
    %----Ϊ�˼ӿ�����ٶȣ�������Exceд�룬��Ҫʱ�������Ժ�ɳ����������浥������һ�����ݷ��������Ĺ���
    % xlswrite(saveName,{imageF(3:end).name},1,'C1');
    % xlswrite(saveName,{LabelVec.SecOne{:,1}}',1,'A2');
    % xlswrite(saveName,{LabelVec.SecOne{:,2}}',1,'B2');
    % xlswrite(saveName,{LabelVec.SecTwo{:,1}}',1,'A13');
    % xlswrite(saveName,{LabelVec.SecTwo{:,2}}',1,'B13');
    % xlswrite(saveName,{'��������'},1,'A23');
    % xlswrite(saveName,SectOneData',1,'C2');
    % xlswrite(saveName,SectTwoData',1,'C13');
    % % display(SectThreeData)
    % xlswrite(saveName,SectThreeData',1,'C23');
    
catch ME
    cd(mainDir);
end
%%
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