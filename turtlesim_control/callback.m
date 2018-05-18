function [pubmsg , beta] = callback(recvMsg, X , Y)

    x = recvMsg.X;
    y = recvMsg.Y;
    theta = recvMsg.Theta;
    d=sqrt((X-x)*(X-x) + (Y-y)*(Y-y));
    phi = atan2((Y-y),(X-x));
    beta = phi - theta;
    if (beta >= 3.14)
          beta = beta - 2*3.14;
          
    end
    if (beta <= -3.14)
          beta = 2*3.14 + beta;
    end 
        
    if(d <= 0.15)
        
            pubmsg.angular.z = 0;
            pubmsg.linear.x = 0;
    end
    if(beta < 0.08 && beta > -0.08)
                pubmsg.angular.z = 0;
                pubmsg.linear.x = 0.5;
    end
    if(beta >= 0.08)
         pubmsg.angular.z = 0.08;
    end
    if(beta <= -0.08)
         pubmsg.angular.z = -0.08;
    end
        
