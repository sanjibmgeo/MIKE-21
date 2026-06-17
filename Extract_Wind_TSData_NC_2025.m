%Read Lat and Long
lon = ncread ('Wind_Data_2025.nc','longitude');
lat = ncread ('Wind_Data_2025.nc','latitude');

%Read Variables
u10 = ncread ('Wind_Data_2025.nc','u10');
v10 = ncread ('Wind_Data_2025.nc','v10');

%Locate point location for extraction
u1 = squeeze (u10(11,3,:));
v1 = squeeze (v10(11,3,:));

% Wind speed (m/s)
Speed = sqrt(u1.^2 + v1.^2);

% Wind direction (degrees clockwise from North)
Dir = mod(270 - atan2d(v1,u1), 360);

% Display first few values
disp(table(Speed(1:10), Dir(1:10), ...
    'VariableNames', {'WindSpeed_ms','WindDirection_deg'}));

Time = datetime(2025,1,1,0,0,0) + hours(0:length(Speed)-1);

%Create the data frame
T = timetable(Time', Speed, Dir);

%Export in Table
writetimetable(T,'Wind_Data_2025.csv');