function y_pred=predict(y)
a=zeros(6,3);
t=3;
for i=1:6
    a(i,1)=1/35*(-3*y(i)+12*y(i+1)+17*y(i+2)+12*y(i+3)-3*y(i+4));
    a(i,2)=1/10*(-2*y(i)-y(i+1)+y(i+3)+2*y(i+4));
    a(i,3)=1/14*(2*y(i)-y(i+1)-2*y(i+2)-y(i+3)+2*y(i+4));
end
y_pred=a(6,1)+a(6,2)*t+a(6,3)*t^2;