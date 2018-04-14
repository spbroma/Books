% ���� "�������� ��������� ��������", �������� ������� �1
% ��������� ��� �������� ������������ ������� ������ �3
% ����, ��������� ������������ � ����������������
% ������� ������������� ����� ������������
% (C) �.�.���������, 2015

% ��� �������� ������� ������� ���������� ������� ��� ������������� �������
% � ��������� ����� ��������� (���������� �������� �������, �������� ��� 
% � �������� �������). ����� ����� ���������� ��������� ���������.
% �������� ������� ����� � �������� ��������� ���������� ����������� 
% ������������ � ���������
% https://sites.google.com/site/eltechdsp/downloads/dsp_dz1_notes.pdf

a3_plots = -1:0.1:1; % ����� �������� a3 ��� ���������� �������� ��
%a3_plots = [-0.9 -0.5 0 0.3 0.6]; % ����� �������� a3 ��� ���������� �������� ��
N_plots = length(a3_plots);
a3_stability = -0.999:0.001:0.999;% ����� �������� a3 ��� �������� ������������
a3_all = [a3_plots a3_stability]; % ����� ����� �������� a3
stab_mask = false(size(a3_all));
for k = 1:length(a3_all)
    a3 = a3_all(k);
    % ������� ����� ������� ��� ������������� �������
    b0 = (5+5*a3)/18;
    b1 = 2.6*b0;
    b2 = 2.6*b0;
    b3 = b0;
    a1 = (2+11*a3)/9;
    a2 = (7-2*a3)/9;
    % ����� ������ ��� ������������� �������
    b = [b0 b1 b2 b3];
    a = [1 a1 a2 a3];
    [h, f] = freqz(b, a, 1024, 2);
    [z, p, ~] = tf2zp(b, a);
    pmax = max(abs(p));
    if k<=N_plots % plot frequency responses
        subplot(2,1,1)
        if pmax<1
            plot(f, abs(h))
        else
            plot(f, abs(h), ':')
        end
        hold on
        subplot(2,1,2)
        if pmax<1
            plot(f, unwrap(angle(h)))
        else
            plot(f, unwrap(angle(h)), ':')
        end
        hold on
    else % fill stability mask
        stab_mask(k-N_plots) = (pmax < 1); % stability check
    end
end
% stability bounds
a3min = a3_stability(find(stab_mask, 1, 'first'));
a3max = a3_stability(find(stab_mask, 1, 'last'));
% plot annotations
subplot(2,1,1)
xlabel('\omega/\pi')
ylabel('|K(\omega)|')
grid on
hold off
ylim([0 2])
subplot(2,1,2)
xlabel('\omega/\pi')
ylabel('arg(K(\omega))')
grid on
hold off
subplot(2,1,1)
title(sprintf('Stability: a_{3} = %g...%g\n', a3min, a3max))
