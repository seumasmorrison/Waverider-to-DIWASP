function [geo_PSD,new_dirs] = diwasp_bins_to_DW(cart_PSD,orig_dirs)

% Ensure first part of input corresponds to direction.  Change back at the
% end if this is the case.
is_direction = size(cart_PSD) == length(orig_dirs);
if is_direction(2)
    cart_PSD = cart_PSD';
end
% Do the same to the direction vector
transpose_dir_vec = size(orig_dirs,1)==1;
orig_dirs = orig_dirs(:);  % Change back at end if transpose_dir_vec is true


% Convert Cartesian to geographic directions between 0 and 360;
cart_dirs = 90-orig_dirs;
cart_dirs(cart_dirs<0)=360+cart_dirs(cart_dirs<0);

% Is the first entry a duplicate of the last?
% If so, average and remove duplicates.
is_duplicated = cart_dirs(1) == cart_dirs(end);
if is_duplicated
    cart_PSD(1,:) = 0.5*(cart_PSD(1,:)+cart_PSD(end,:));
    cart_PSD(end,:) = [];
    cart_dirs(end,:) = [];
end

% Directions ascending from zero to 360
[new_dirs,transfer_vec] = sort(cart_dirs);
geo_PSD = cart_PSD(transfer_vec,:);

% If vectors were transposed, transpose them back.
if is_direction(2)
    geo_PSD = geo_PSD';
end
if transpose_dir_vec
    new_dirs = new_dirs';
end

end

