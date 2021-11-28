function judgement = ikine_judgement(T,d,a)
% �ж�Tλ���Ƿ�������
% �ۺϽ���������ֵ����������λ�˴�ʹ����ֵ�����
% judgement:�ж�ֵ,1�н⣬0�޽�
% T:λ�˾���
% d,a:��е�۲���

%     a=[0,408,376,0,0,0];
%     d=[121.5,140.5,-121.5,102.5,102.5,94];
    
    nx=T(1,1);ny=T(2,1);nz=T(3,1);
    ox=T(1,2);oy=T(2,2);oz=T(3,2);
    ax=T(1,3);ay=T(2,3);az=T(3,3);
    px=T(1,4);py=T(2,4);pz=T(3,4);
    
    %���ؽڽ�1
    m=d(6)*ay-py;  n=ax*d(6)-px; 
    
    if ~isreal(sqrt(m^2+n^2-(d(2)+d(3)+d(4))^2))
        %theta1�޽⣬��ȥ
        judgement=0;
%     elseif m^2+n^2-(d(2)+d(3)+d(4))^2==0
%         %��������λ�ˣ�ʹ����ֵ�����
%         judgement=sub_judgement(T,d,a);
    else
        %theta1�н⣬������ⲽ��
        theta1(1,1)=atan2(m,n)-atan2(d(2)+d(3)+d(4),sqrt(m^2+n^2-(d(2)+d(3)+d(4))^2));  
        theta1(1,2)=atan2(m,n)-atan2(d(2)+d(3)+d(4),-sqrt(m^2+n^2-(d(2)+d(3)+d(4))^2));
        
        if any((ax*sin(theta1)-ay*cos(theta1))>1) || any((ax*sin(theta1)-ay*cos(theta1))<-1)
            %acos����Ҫ��-1��1����������ȥ
            judgement=0;
%         elseif any((ax*sin(theta1)-ay*cos(theta1))==1) || any((ax*sin(theta1)-ay*cos(theta1))==-1)
%             %��Ӧsin(theta5)==0������λ�ˣ�ʹ����ֵ�����
%             judgement=sub_judgement(T,d,a);
        else
            %���ؽڽ�5
            theta5(1,1:2)=acos(ax*sin(theta1)-ay*cos(theta1));
            theta5(2,1:2)=-acos(ax*sin(theta1)-ay*cos(theta1));  
            
            %���ؽڽ�6
            mm=nx*sin(theta1)-ny*cos(theta1); nn=ox*sin(theta1)-oy*cos(theta1);
            theta6=atan2(mm,nn)-atan2(-sin(theta5),0);
            
            %���ؽڽ�3
            mmm=-d(5)*(sin(theta6).*(nx*cos(theta1)+ny*sin(theta1))+cos(theta6).*(ox*cos(theta1)+oy*sin(theta1))) ...
                -d(6)*(ax*cos(theta1)+ay*sin(theta1))+px*cos(theta1)+py*sin(theta1);
            nnn=pz-d(1)-az*d(6)-d(5)*(oz*cos(theta6)+nz*sin(theta6));
            
            if any(any(((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)))>1)) || any(any(((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)))<-1))
                %acos����Ҫ��-1��1����������ȥ
                judgement=0;
%             elseif any(any(((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)))==1)) || any(any(((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)))==-1))
%                 %����λ�ˣ�ʹ����ֵ������
%                 judgement=sub_judgement(T,d,a);
            else
                %������㣬�������
                judgement=1;
            end
        end
    end
end

