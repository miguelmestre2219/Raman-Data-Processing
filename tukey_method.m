function [outliers, inliers]=tukey_method(data)
% Function aplying tukey method for detection of outliers for non-normal distribution by finding the 1st adn 3rd quartiles.
% Function returns the outliers and the inliers 

    % Calculate interquartile range (IQR)
    q1 = prctile(data,25); % 1st quartile
    q3 = prctile(data,75); % 3rd quartile
    IQR = q3 - q1;
    
    % Define outlier criteria using Tukey method
    k = 1.5; % Tukey's k parameter
    lower_threshold = q1 - k*IQR; % lower outlier threshold
    upper_threshold = q3 + k*IQR; % upper outlier threshold
    
    % Identify outliers and inliers
    outliers = find(data < lower_threshold | data > upper_threshold);
    inliers = find(data >= lower_threshold & data <= upper_threshold);

end