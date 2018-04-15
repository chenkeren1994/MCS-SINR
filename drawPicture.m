function drawPicture( gNumber )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    x = 1:gNumber;
    y = csvread('./output/fitness.csv');
    plot(x,y,'.');
    xlabel('迭代次数');
    ylabel('适值');
end