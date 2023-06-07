
function [Sn] = cosmicray(map, position_x, position_y,RR,ET)
% This function is based on the algorithm proposed by Barton and Hennelly ([1] doi:10.1177/0003702819839098) to correct cosmic rays expected to appear when using a Charged Couple Device Detector. The function takes the spectrum at positions (position_x,position_y) and corrects by comparing it to the best match within the data set. Firstly, the covariance of the spectrum of interest is calculated to define the best match and then the correction is performed by comparing the spectrum of interest to it.  Comparison is performed by subtracting the two spectra and identifying the outlier points defined to present a value greater than 5 times the noise standard deviation.

    % Calculate the dimensions of the input map
    dimensions = size(map);
    
    % Get the spectrum of interest
    Sn = squeeze(map(position_y, position_x, :));
    
    map(position_y,position_x,:)=zeros(1,1,1600);

    % Calculate the covariance vector to identify the best match spectrum within all points in the data set
  
    map_2d = reshape(map, [], dimensions(3))';
    
    C = ((Sn' * map_2d) .^ 2) ./ (sum(Sn .^ 2) .* sum(map_2d .^ 2, 1));
    
    % Identify the spectrum with the highest covariance which is the best match
    [~, idx] = max(C);
                
    % Compute the row and column indices of the best match spectrum
    row = ceil(idx / dimensions(2));
    col = mod(idx - 1, dimensions(2)) + 1;
                
    % Get the best match spectrum
    Sm = squeeze(map(row, col, :));
                
    % Calculate the spectrum's own std considering the readout rate (RR) in kHz and the exposure time of ET in s
    std = sqrt(sum((Sn - smooth(Sn)).^2)) / (RR*ET);
                
    % Identify outliers based on divergence from the best match spectrum
    outliers = find(Sn - Sm > 5 * std);
                
    % Replace outliers with the corresponding values in the best match spectrum
    Sn(outliers,1) = Sm(outliers,1);
            
end

