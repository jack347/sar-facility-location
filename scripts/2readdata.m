## Script reading data from input file

## Load neccesary packages
pkg load io mapping

## Measure time preformance
time_performance(2).what = 'Data input';
time_performance(2).id = tic;

## Create data structure
data = struct();
              
data.("action") = struct(...
                     'i',0,...
                     'date','',... #for now date will be negligible, so leave it as a string
                     'lat', [0, 0, 0],... #latitude [deg, min, sec]
                     'lon', [0, 0, 0],... #longitude [deg, min, sec]
                     'airbase_code','',... #base from which heli started
                     'heli_type','',...   #type of heli
                     'latdec',0,... #latitude in decimal e.g. 54.4124
                     'londec',0);   #longitude in decimal e.g. 18.3583

data.("base") = struct(...
                   'airbase_code','',...
                   'latdec',0,...
                   'londec',0);

## Read data from spreadsheet and store it in temporary array variable
[numarr, txtarr] = xlsread ('../input/akcje.ods', 'A12:J325');

## Read data from spreadsheet about base locations
[bases_raw] = xlsread ('../input/akcje.ods', 'C2:H8');
              
## Assign data to structure
[~, acodes] = xlsread('../input/akcje.ods', 'B2:B8');

for i=1:length(acodes)
    data.base(i).airbase_code = acodes{i};
    data.base(i).londec = dms2degrees(bases_raw(i,1:3));
    data.base(i).latdec = dms2degrees(bases_raw(i,4:6));
endfor

for i = 1:(length(numarr))
    data.action(i).i = numarr(i,1);
    data.action(i).date = txtarr{i,1};
    data.action(i).lon(1,1) = numarr(i,3);
    data.action(i).lon(1,2) = numarr(i,4);
    data.action(i).lon(1,3) = numarr(i,5);
    data.action(i).lat(1,1) = numarr(i,6);
    data.action(i).lat(1,2) = numarr(i,7);
    data.action(i).lat(1,3) = numarr(i,8);
    data.action(i).airbase_code = txtarr{i,8};
    data.action(i).heli_type = txtarr{i,9};
endfor 

## Calculate latdec and londec

for i = 1:(length(numarr))
    data.action(i).latdec = ( data.action(i).lat(1,3)/60 + data.action(i).lat(1,2) )/60 +...
                     data.action(i).lat(1,1);
    data.action(i).londec = ( data.action(i).lon(1,3)/60 + data.action(i).lon(1,2) )/60 +...
                     data.action(i).lon(1,1);
endfor

## Sorting structure according to heli_type
## Source: https://blogs.mathworks.com/pick/2010/09/17/sorting-structure-arrays-based-on-fields/

datafields = fieldnames(data.action); #get field names
datacell = struct2cell(data.action);  #convert to cell

sz = size(datacell);           #get cell size

datacell = reshape(datacell, sz(1), []); #reshape the cell into 2d matrix, specifying only first dimension sz(1), rest must adapt []

datacell = datacell'; #transpose it so that sorting by rows can happen

datacell = sortrows(datacell, 6); #sort by heli type


datacell = reshape(datacell', sz); #put it back to original shape as specified in sz

datasorted = cell2struct(datacell,datafields,1); #convert back to struct

## Split datasorted in two
## Find the splitting point
i=0;
do
i++;
checkheli = datasorted(i).heli_type(1);
until (checkheli != 'M')
datasorted1set = datasorted(1:(i-1));
datasorted2set = datasorted(i:length(datasorted));


#Clearing junk
clear acodes  bases_raw checkheli datacell datafields datasorted numarr numarr2
clear i sz txtarr

#End time measurement
time_performance(2).duration = toc(time_performance(2).id);
