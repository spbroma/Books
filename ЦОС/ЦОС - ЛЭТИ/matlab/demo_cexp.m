function demo_cexp
w = pi/10;
phi = 0;
h_arrow = [];
h_freq = [];
Running = false;

f = figure('Visible','off','Position',[360,500,543,500],...
    'WindowStyle', 'normal');

annotation('textbox', [0 0 0.25 0.06],...
    'String', '\omega, rad/sample:',...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle',...
    'FontSize', 12,...
    'LineStyle', 'none');

FreqEdit = uicontrol('Style','edit','String', 'pi/10',...
    'Units','normalized',...
    'FontSize', 12,...
    'Position',[0.25,0.00,0.25,0.06]);

StartButton = uicontrol('Style','pushbutton','String','Start',...
    'Units','normalized',...
    'FontSize', 12,...
    'Position',[0.50,0.00,0.25,0.06],...
    'Callback',{@StartButton_Callback});

StopButton = uicontrol('Style','pushbutton','String','Stop',...
    'Units','normalized',...
    'FontSize', 12,...
    'Position',[0.75,0.00,0.25,0.06],...
    'Callback',{@StopButton_Callback});
set(StopButton,'Enable','off');

set(f,'Units','normalized');
set(f,'Name','Harmonic Signal Demo');
set(f,'NumberTitle','off');
movegui(f,'center');
set(f,'Resize','off');
set(f,'MenuBar','none');
set(f,'Visible','on');

%uiwait(f);

    function StartButton_Callback(~,~)
        w = str2num(get(FreqEdit, 'String'));
        try
            delete(h_freq);
        catch
        end
        h_freq = annotation('textbox', [0 0.75 1 0.1],...
            'String', ['\omega = ' get(FreqEdit, 'String') ' rad/sample'],...
            'HorizontalAlignment', 'center',...
            'FontSize', 20,...
            'LineStyle', 'none');
        Running = true;
        set(StartButton,'Enable','off');
        set(StopButton,'Enable','on');
        set(FreqEdit,'Enable','off');
        while Running
            s = exp(1i*phi);
            phi = mod(phi + w, 2*pi);
            try
                delete(h_arrow);
            catch
            end
            h_arrow = annotation('arrow',[0.5 0.5+0.5*real(s)], [0.5 0.5+0.5*imag(s)]);
            drawnow;
            pause(2/25)
        end
    end

    function StopButton_Callback(~,~)
        Running = false;
        phi = 0;
        set(StartButton,'Enable','on');
        set(StopButton,'Enable','off');
        set(FreqEdit,'Enable','on');
    end

end




