function [O]=cosmicraystatistical(I, RR, ET)
% This function performs a cosmic ray correction, by considering the spectral image (matrix I) obtained at the CCD (charge-coupled device). In this method each row of the image is considered to represent an independent spectra. Thus, the affected rows are identified by determining the points that present noise standard deviations much greater than the majority of the rows.

    O=I;
    
    % calculate the standard deviation of each row within spectral image
    stds = sqrt(sum(((I-smoothdata(I,1)).^2 )'))/(RR*ET);

    % Determine the outlier rows using the Tukey range method
    [outliers, inliers] = tukey_method(stds);
    
    % Calculate the reference mean and standard deviation from unaffected rows
    ref_spec = mean(I(inliers,:));
    std_spec = std(I(inliers,:),0,1);

    % Correct affected rows by considering as threshold that the data point must be greater than 5 times the standard deviation from the mean.
    for a=1:length(outliers)
    vn=squeeze(I(outliers(a),:));
    idx = find (vn > ref_spec + 5*std_spec);

        for b=1:length(idx)
            O(outliers(a),idx(b))= ref_spec(idx(b));
        end
    end
    
end