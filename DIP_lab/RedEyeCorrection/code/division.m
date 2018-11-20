function [tagimg,tag,xmin,xmax,ymin,ymax,b_count,tot_count] = division(bm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tag = 0;
max_div = 1000;
xmin = zeros(max_div);
xmax = zeros(max_div);
ymin = zeros(max_div);
ymax = zeros(max_div);
b_count = zeros(max_div);
tot_count = zeros(max_div);
[m,n] = size(bm);
tagimg = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        if bm(i,j) == 0 && tagimg(i,j) == 0
            s = CStack();
            tag = tag + 1;
            tagimg(i,j) = tag;
            xmin(tag) = j;
            xmax(tag) = j;
            ymin(tag) = i;
            ymax(tag) = i;
            s.push([i,j]);
            while ~s.empty()
                l = s.pop();
                xi = l(1);
                xj = l(2);
                xmin(tag) = min([xj,xmin(tag)]);
                xmax(tag) = max([xj,xmax(tag)]);
                ymin(tag) = min([xi,ymin(tag)]);
                xmin(tag) = min([xi,ymax(tag)]);
                tot_count(tag) = tot_count(tag) + 1;
               
                count = 0;
                if bm(xi-1,xj-1) == 0 && tagimg(xi-1,xj-1) == 0
                    tagimg(xi-1,xj-1) = tag;
                    s.push([xi-1,xj-1]);
                    count  = count + 1;
                end
                if bm(xi,xj-1) == 0 && tagimg(xi,xj-1) == 0
                    tagimg(xi,xj-1) = tag;
                    s.push([xi,xj-1]);
                    count  = count + 1;
                end
                if bm(xi+1,xj-1) == 0 && tagimg(xi+1,xj-1) == 0
                    tagimg(xi+1,xj-1) = tag;
                    s.push([xi+1,xj-1]);
                    count  = count + 1;
                end
                if bm(xi-1,xj) == 0 && tagimg(xi-1,xj) == 0
                    tagimg(xi-1,xj) = tag;
                    s.push(xi-1,xj);
                    count  = count + 1;
                end
                if bm(xi+1,xj) == 0 && tagimg(xi+1,xj) == 0
                    tagimg(xi+1,xj) = tag;
                    s.push([xi+1,xj]);
                    count  = count + 1;
                end
                if bm(xi-1,xj+1) == 0 && tagimg(xi-1,xj+1) == 0
                    tagimg(xi-1,xj+1) = tag;
                    s.push([xi-1,xj+1]);
                    count  = count + 1;
                end
                if bm(xi,xj+1) == 0 && tagimg(xi,xj+1) == 0
                    tagimg(xi,xj+1) = tag;
                    s.push([xi,xj+1]);
                    count  = count + 1;
                end
                if bm(xi+1,xj+1) == 0 && tagimg(xi+1,xj+1) == 0
                    tagimg(xi+1,xj+1) = tag;
                    s.push([xi+1,xj+1]);
                    count  = count + 1;
                end
                if count ~= 8
                   b_count(tag) = b_count(tag) + 1;
                end
                
            end
        end
    end
                
end

xmin = xmin(1:tag);
xmax = xmax(1:tag);
ymin = ymin(1:tag);
ymax = ymax(1:tag);
b_count  = b_count(1:tag);
tot_count = tot_count(1:tag);

end

