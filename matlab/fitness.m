function result = fitness(x)
%Ŀ�꺯��
%Ϊ1/lambda

%��е�۲���
a=[0,408,376,0,0,0];
d=[121.5,140.5,-121.5,102.5,102.5,94];

%�Ż�6�γ�
d(1)=x(1);a(2)=x(2);a(3)=x(3);d(4)=x(4);d(5)=x(5);d(6)=x(6);

%�Ż�2�γ�
% a(2)=x(1);a(3)=x(2);


%��������
N_workspace=0;
N_cal=0;

%�������ռ�������
L_max=1200;

%���ֱ߳�ΪL_max*2��������,�ҽ�ȡ�������ڰ뾶ΪL_max��Ĳ����Լ�����Ч�����
%��һ�����ټ��������ڲ����ǹؽڽ����Ƶ��������xoz,yozƽ���и��������1/4��

n_length=20; %��������ȡ��ļ����ʵ����Ϊn_length+1����
N=0;
%�����ܵ���
for i=0:n_length*2
    for j=0:n_length*2
        for k=0:n_length*2
            point=[i,j,k]/(n_length*2)*2*L_max-L_max;
            if norm(point)<L_max
                N=N+1;
            end
        end
    end
end

N_total_cal=0;
%�����ܼ������
for i=0:n_length
    for j=0:n_length
        for k=0:n_length*2
            point=[i/(n_length)*L_max,j/(n_length)*L_max,k/(n_length*2)*2*L_max-L_max];
            if norm(point)<L_max
                N_total_cal=N_total_cal+1;
            end
        end
    end
end

lambda_data=zeros(N,4);

%������תȡ������single_point_theta����
n_single_point_direction=6;
n_single_point_direction_count=2*n_single_point_direction^2-6*n_single_point_direction+6;
m_rotz=6;


% 
% fprintf("��ʼ����\n����ռ��ܵ���Ϊ%d��\nʵ�ʼ����ܵ���Ϊ%d��\nÿ���������ϵľ���������Ϊ%d��\n�������Ӧ����ת�������Ϊ%d��\n",N,N_total_cal,n_single_point_direction_count,m_rotz);
% fprintf("==========================\n");


t1=clock;
for i=0:n_length
    for j=0:n_length
        for k=0:n_length*2
            point=[i/(n_length)*L_max,j/(n_length)*L_max,k/(n_length*2)*2*L_max-L_max];
            if norm(point)<L_max
                t2=clock;
                N_cal=N_cal+1;
%                 fprintf("��ʼ�����%d���㣬�������Ϊ[%.2f,%.2f,%.2f]\n",N_cal,point(1),point(2),point(3));
                theta=single_point_theta(d,a,point,n_single_point_direction,m_rotz);
%                 fprintf("��%d�������������\n�������%d����\n",N_cal,N_total_cal-N_cal);
                if theta>0
                    lambda_data(N_workspace+1,:)=[point theta];
                    N_workspace=N_workspace+1;
%                     fprintf("�õ��ڹ����ռ��ڣ�����Ϊ%.4f\n",theta);
                    if (i/(n_length)*L_max>0)&&(j/(n_length)*L_max>0)
                        lambda_data(N_workspace+1:N_workspace+3,:)=...
                            [ -point(1) point(2) point(3) theta;point(1) -point(2) point(3) theta;-point(1) -point(2) point(3) theta];
                        N_workspace=N_workspace+3;
%                         fprintf("�������������ԳƵ�\n");
                    elseif (i/(n_length)*L_max==0)&&(~(j/(n_length)*L_max==0))
                        lambda_data(N_workspace+1,:)=[point(1) -point(2) point(3) theta];
                        N_workspace=N_workspace+1;
%                         fprintf("��������һ���ԳƵ�\n");
                    elseif (~(i/(n_length)*L_max==0))&&(j/(n_length)*L_max==0)
                        lambda_data(N_workspace+1,:)=[ -point(1) point(2) point(3) theta];
                        N_workspace=N_workspace+1;
%                         fprintf("��������һ���ԳƵ�\n");
                    end
%                     fprintf("Ŀǰ�������Ч�����ռ��λ����Ϊ%d\n",N_workspace);
                else
%                     fprintf("�õ��ڹ����ռ���\n");
%                     fprintf("Ŀǰ����Ĺ����ռ��λ����Ϊ%d\n",N_workspace);
                end
                t3=clock;
%                 fprintf("�õ�����ʱ: %.4f ��\n",etime(t3,t2));
%                 fprintf("��ʱ��: %.4f ��\n",etime(t3,t1));
%                 fprintf("==========================\n");
            end
        end
    end
end

lambda_data(all(lambda_data==0,2),:)=[];
% fprintf("�����������ʼ��ͼ\n");

% ������
% scatter3(lambda_data(:,1),lambda_data(:,2),lambda_data(:,3),10,lambda_data(:,4),'filled');
% grid on;
% h=colorbar;
% set(get(h,'label'),'string','��̬����ϵ��');

%��yozƽ�����У�ȡxoyƽ���ϰ벿��
% p=lambda_data(:,1)>=0;
% A=lambda_data(p,:);
% p=find(A(:,3)>=0);
% A=A(p,:);
% 
% scatter��ͼ
% scatter3(A(:,1),A(:,2),A(:,3),100,A(:,4),'filled');
% grid on;
% h=colorbar;
% set(get(h,'label'),'string','��̬����ϵ��');
% axis equal;


alpha=0.55;

if isempty(lambda_data)
    result=inf;
else
%     n_lambda=sum(lambda_data(:,4)>alpha);
%     lambda=n_lambda/N_workspace;
%     result=-lambda;
    result=-sum(lambda_data(:,4)==1)*(L_max/n_length)^3*10^(-9);
end
% fprintf("���н���\nÿ���������ϵľ���������Ϊ%d��\nÿ��z�ᳯ���Ӧ����ת�������Ϊ%d��\n",n_single_point_direction_count,m_rotz);
% printf("����ռ��ڵĵ���%d��\n",N);
% fprintf("ʵ�ʼ�����%d���㣬�����ڹ����ռ��ڵĵ�Ϊ%d��\n",N_cal,N_workspace);
% fprintf("������̬����ϵ��>%.2f�ĵ�ĸ���Ϊ%d��\n",alpha,sum(lambda_data(:,4)>alpha));
% fprintf("alpha=%.2fʱ�ɲ�����Ϊ%.4f\n",alpha,lambda);


end

