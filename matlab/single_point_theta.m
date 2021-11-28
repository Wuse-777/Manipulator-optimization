function [theta,N] = single_point_theta(d,a,point,n,m)
%single_point_theta �����е�۵�������
%������ת������������������z�᷽���ƶ�ϵ��ת������x����ת0-pi��Χ������z����ת0-2*pi��Χ
%�ڻ��һ������z�᷽���ĩ������ϵ�󣬻���Ҫ��z����ת2*pi��������
% d,a��е�۲���
% point:����㣬Ϊ1x3�ľ���
% n:x����ת������Ŀ
% m:z����ת�Ƕ���Ŀ
% theta:�õ������
% N:����������Ϊ�˱�֤�Ƕȷֲ����ȣ�pi�����Եģ���2*pi��ͷβ��ӵģ���������ͬ
% ����������������N=2*n^2-6*n+6

N=0;

%��������
count=0;

for i=0:n-1
    for j=0:(2*n-3)
        flag=0;
        rot_xz=rotz(j/(2*n-2)*2*pi)*rotx(i/(n-1)*pi)*eye(3);%xy��ת
        for k=1:m
            if m==1 
                %mΪ1������ת
                rot_xyz=rot_xz;
            else
                rot_xyz=rot_xz*rotz(k/(m-1)*2*pi);
            end
            T=eye(4);
            T(1:3,1:3)=rot_xyz;
            T(1:3,4)=point;
            %�ж����
            
            flag=ikine_judgement(T,d,a);
        end
        if flag==1
            count=count+1;
        end
        N=N+1;
        %z�붨ϵ�غϣ�����Ҫ��ת
        if (i==0||i==n-1)
            break
        end
    end      
end
theta=count/N;

end

