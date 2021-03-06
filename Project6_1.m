%% ECE 384 Project 6.1
%% Tyler Botelho, Lewis Brum, Matt LaVoie, Dylan Tocci
clear;clc; close all;

% 1. Generate six sequences of uniform random variables (length = 10,000) in the
% range [−0.5, 0.5]. Each element in the ith sequence can be considered to be one
% realization of the random variable Xi
    % Generate six sequences
    X1 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X2 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X3 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X4 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X5 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X6 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    
    % Generate new random variables Y1 and Y2
    Y1 = X1+X2+X3+X4+X5+X6; % -2.5 to 2.5
    Y2 = X1 + (0.5.*X2) + (0.8.*X3) + (1.8.*X4) + (0.3.*X5) + (0.5.*X6); % -2.45 to 2.45
    
    [PDY1,CDY1,pY1Range, cY1Range] = PdfCdf(Y1,25); % Calculate Y1 PDF and CDF with 25 bins
    [PDY2,CDY2,pY2Range, cY2Range] = PdfCdf(Y2,25); % Calculate Y2 PDF and CDF with 25 bins
    
    % Graph measured Y1 and Y2 PDF and CDF
    sgtitle("Measured versus theoretical PDF/CDF for Y1 and Y2")
    figure(1);
    subplot(2,2,1)
    plot(pY1Range, PDY1); % Graph Y1 PDF 
    title("Measured versus Theoretical Y1 PDF")
    xlabel("y");
    ylabel("y1");
    xlim([-2.5,2.5])
    subplot(2,2,2)
    plot(cY1Range,CDY1);% Graph Y1 CDF 
    title("Measured versus Theoretical Y1 CDF")
    xlabel("y");
    ylabel("Y1");
    xlim([-2.5,2.5])
    subplot(2,2,3)
    plot(pY2Range,PDY2); % Graph Y2 PDF
    title("Measured versus Theoretical Y2 PDF")
    xlabel("y");
    ylabel("y2");
    xlim([-2.5,2.5])
    subplot(2,2,4)
    plot(cY2Range,CDY2);% Graph Y2 CDF
    title("Measured versus Theoretical Y2 CDF")
    xlabel("y");
    ylabel("Y2");
    xlim([-2.5,2.5])
    
    % Calculate mean and variance for Y1 and Y2
    mY1=mean(Y1)
    mY2=mean(Y2)
    varY1=var(Y1)
    varY2=var(Y2)
    
    % Generate theoretical PDFs
    xRange = linspace(-2.5,2.5,10000);
    Y1PT = normpdf(xRange,mY1,sqrt(varY1));
    Y2PT = normpdf(xRange,mY2,sqrt(varY2));
    Y1CT = normcdf(xRange,mY1,sqrt(varY1));
    Y2CT = normcdf(xRange,mY2,sqrt(varY2));
    
    % Plot theoretical PDF
    figure(1)
    subplot(2,2,1)
    hold on;
    plot(xRange,Y1PT); % Graph Y1 theoretical PDF
    hold off;
    subplot(2,2,2)
    hold on;
    plot(xRange,Y1CT); % Graph Y1 theoretical CDF 
    hold off;
    subplot(2,2,3)
    hold on;
    plot(xRange,Y2PT); % Graph Y2 theoretical PDF
    hold off; 
    subplot(2,2,4)
    hold on;
    plot(xRange,Y2CT); % Graph Y2 theoretical CDF
    hold off; 
    
% 2. Generate 20 sequences of IID exponential random variables Xi using parameter
% lambda = 0.5i for the ith sequence.

    lambda = 0.5;
    Y=0;
    % summation from 1 to 20 of Xi
    for i = 1:20
        Y = Y + exprnd(lambda*i,1,10000); % generates [1:10000] vector Xi and sums it
    end
  
    [PDY,CDY,pYRange, cYRange] = PdfCdf(Y,20); % generates PDF with 20 bins (looked best)
    
    %Plot measured PDF and CDF
    figure(2)
    sgtitle("Measured versus Theoretical PDF and CDF of Y")
    subplot(2,1,1)
    plot(pYRange, PDY) % Plot measured Y PDF
    title("Measured versus Theoretical Y PDF")
    xlabel("y");
    ylabel("Y");
    subplot(2,1,2);
    plot(cYRange, CDY) % Plot measured Y CDF
    title("Measured versus Theoretical Y CDF")
    xlabel("y");
    ylabel("Y");

   yRange = linspace(40,250,10000);
   mY = mean(Y);
   varY = var(Y);
   
   YTP = normpdf(yRange,mY,sqrt(varY)); % Generate theoretical PDF
   YTC = normcdf(yRange,mY,sqrt(varY)); % Generate theoretical CDF

   % Plot theoretical mean and PDF
   figure(2)
   subplot(2,1,1)
   hold on;
   plot(yRange, YTP) % Plot theoretical Y PDF
   hold off;
   subplot(2,1,2)
   hold on;
   plot(yRange, YTC) % Plot theoretical Y CDF
   hold off;
    
% 3. Successively convolve 50 Bernoulli PMFs (not the random variables). Choose
% p = 0.8 for all of the PMFs. Plot and compare the shape (only the shape)
% of the result to that of the Gaussian PDF
    tempDist=0;
    bernDist=1;
    % Generate the 50 trials and convolve them
     for k = 1:49
         tempDist=binopdf(0:1,1,0.8);
         bernDist=conv(tempDist,bernDist);
     end
    
    figure(3)
    bar(1:50,bernDist)
    
    % INCORRECT BELOW
    mBD = mean(bernDist)
    varBD = var(bernDist)
    bdRange = [1:50];
    
    BDT = normpdf(bdRange,mBD,sqrt(varBD));
    figure(3)
    hold on;
    plot(bdRange, BDT);