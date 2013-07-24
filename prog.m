
function varargout = prog(varargin)
% PROG M-file for prog.fig
%      PROG, by itself, creates a new PROG or raises the existing
%      singleton*.
%
%      H = PROG returns the handle to a new PROG or the handle to
%      the existing singleton*.
%
%      PROG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROG.M with the given input arguments.
%
%      PROG('Property','Value',...) creates a new PROG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prog

% Last Modified by GUIDE v2.5 21-Jun-2013 17:23:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prog_OpeningFcn, ...
                   'gui_OutputFcn',  @prog_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before prog is made visible.
function prog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prog (see VARARGIN)

% Choose default command line output for prog

set(handles.mask,'Value',1);

handles.im_handle=0;
handles.pc_hanlde=0;
handles.image_coordinates=0;
handles.coordinates_3d=0;
handles.int_parameters=0;
handles.rotation_number=0;
handles.plane_points_hndl=0;

handles.output = hObject;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Load_image.
function Load_image_Callback(hObject, eventdata, handles)
% hObject    handle to Load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[filename pathname]=uigetfile({'*.bmp;*.tif;*.jpg;*.pcx;*.png;*.hdf;*.xwd;*.ras;*.pbm;*.pgm;*.ppm;*.pnm', 'All MATLAB SUPPORTED IMAGE Files (*.bmp,*.tif,*.jpg,*.pcx,*.png,*.hdf,*.xwd,*.ras,*.pbm,.pgm,*.ppm,*.pnm)'},'File Selector');
if pathname==0, return; end  
image =strcat(pathname, filename);
im=imread(image);
axes(handles.axes1);
imshow(image)
set (handles.imagename,'String',filename) %Showing information of file
handles.rotation_number=0;
handles.im_handle=im;
handles.image_pathandname=image;
guidata(hObject, handles);




% --- Executes on button press in load_image_coord.
function load_image_coord_Callback(hObject, eventdata, handles)
% hObject    handle to load_image_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[filename pathname]=uigetfile({'*.txt'},'File Selector');
if pathname==0, return; end  
fullpathname =strcat(pathname, filename);
text = fileread (fullpathname);% Reading information inside a file
xy=load(fullpathname);
handles.image_coordinates=xy;
guidata(hObject, handles);


% --- Executes on button press in load_3d_coordinates.
function load_3d_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to load_3d_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

[filename pathname]=uigetfile({'*.txt'},'File Selector');
if pathname==0, return; end  
fullpathname =strcat(pathname, filename);
text = fileread (fullpathname);% Reading information inside a file
XYZ=load(fullpathname);
%D= sqrt(((XYZ(1,1)- XYZ(2,1))^2+(XYZ(1,2)- XYZ(2,2))^2)+(XYZ(1,3)- XYZ(2,3))^2)
handles.coordinates_3d=XYZ;
guidata(hObject, handles);

% --- Executes on button press in load_pc.
function load_pc_Callback(hObject, eventdata, handles)

% hObject    handle to load_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[filename pathname]=uigetfile({'*.txt'},'File Selector');
if pathname==0, return; end  
fullpathname =strcat(pathname, filename);
text = fileread (fullpathname);% Reading information inside a file
pc=load(fullpathname);
set (handles.text21,'String',filename)

XYZ=handles.coordinates_3d;
num_col=size(pc,2);

if num_col==4  
pc=pc(:,2:4);

else if num_col>4
    h = msgbox('The point cloud must be a nX3 matrix with the X,Y,Z coordinates, or a nX4, with the first column representing the id of the points','Not Suitable File');
    return;
    end
end  

handles.pc_hanlde=pc;


cont=numel(pc(:,1));
handles.cont_pc=cont;

if cont>1000
axes(handles.axes2)

vhma=floor(cont/1000);
scatter3(pc(1:vhma:cont,1),pc(1:vhma:cont,2),pc(1:vhma:cont,3),'MarkerFaceColor','b')% apo 2ws 4
hold on

  if XYZ~=0
  scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'MarkerFaceColor','r') 
  
%  for i=1:size(XYZ,1)
%  text(XYZ(i,1), XYZ(i,2), XYZ(i,3), [' ',int2str(i)]);
%  end

  end
  rotate3d on;
  hold off

else
axes(handles.axes2)
scatter3(pc(:,1),pc(:,2),pc(:,3),'MarkerFaceColor','c') % ektypwnw olo to nefos an einai katw apo 1000 shmeia
hold on
  if XYZ~=0
  scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'MarkerFaceColor','r') 
% labels = num2str(1:size(XYZ,1));   
% for i=1:size(XYZ,1)
% text(XYZ(i,1)+0.2, XYZ(i,2)+0.2, XYZ(i,3)+0.2,labels(i), 'horizontal','left','FontSize',7200);
% end
  end
  rotate3d on;
hold off
h = msgbox('Point cloud file contains less than 1000 points. The algorithm might not have the desired results. In case of orthophoto, the "crop point cloud" function is unavailable','Note');

end



guidata(hObject, handles);


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject); 
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'load_intr'
      
    set(handles.xo,'Enable','off') %disable checkbox1
    set(handles.xo,'String','')
    set(handles.yo,'Enable','off')
    set(handles.yo,'String','')
    set(handles.c,'Enable','off')
    set(handles.c,'String','')
    set(handles.k0,'Enable','off')
    set(handles.k0,'String','')
    set(handles.k1,'Enable','off')
    set(handles.k1,'String','')
    set(handles.k2,'Enable','off')
    set(handles.k2,'String','')
    set(handles.p1,'Enable','off')
    set(handles.p1,'String','')
    set(handles.p2,'Enable','off')
    set(handles.p2,'String','')
    set(handles.skewness,'Enable','off')
    set(handles.skewness,'String','')
    set(handles.pixel_size,'Enable','off')
    set(handles.pixel_size,'String','')
    set(handles.kx_ky,'Enable','off')
    set(handles.kx_ky,'String','')


         set(handles.load_intrinsic_par,'Enable','on')  %enable checkbox1
        
    case 'manual_intr'
        
    set(handles.xo,'Enable','on') %disable checkbox1
    set(handles.yo,'Enable','on')
    set(handles.c,'Enable','on')
    set(handles.k0,'Enable','on')
    set(handles.k1,'Enable','on')
    set(handles.k2,'Enable','on')
    set(handles.p1,'Enable','on')
    set(handles.p2,'Enable','on')
    set(handles.skewness,'Enable','on')
    set(handles.pixel_size,'Enable','on')
    set(handles.kx_ky,'Enable','on')

    set(handles.load_intrinsic_par,'Enable','off') 
    
        
end
guidata(hObject, handles);


% --- Executes on button press in load_intrinsic_par.
function load_intrinsic_par_Callback(hObject, eventdata, handles)
% hObject    handle to load_intrinsic_par (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

[filename pathname]=uigetfile({'*.txt'},'File Selector');
if pathname==0, return; end  

fullpathname =strcat(pathname, filename);
text = fileread (fullpathname);% Reading information inside a file
int_par=load(fullpathname);
handles.int_parameters=int_par;
guidata(hObject, handles);


function xo_Callback(hObject, eventdata, handles)
% hObject    handle to xo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xo as text
%        str2double(get(hObject,'String')) returns contents of xo as a double


% --- Executes during object creation, after setting all properties.
function xo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yo_Callback(hObject, eventdata, handles)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yo as text
%        str2double(get(hObject,'String')) returns contents of yo as a double


% --- Executes during object creation, after setting all properties.
function yo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c as text
%        str2double(get(hObject,'String')) returns contents of c as a double


% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k0_Callback(hObject, eventdata, handles)
% hObject    handle to k0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k0 as text
%        str2double(get(hObject,'String')) returns contents of k0 as a double


% --- Executes during object creation, after setting all properties.
function k0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k1_Callback(hObject, eventdata, handles)
% hObject    handle to k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k1 as text
%        str2double(get(hObject,'String')) returns contents of k1 as a double


% --- Executes during object creation, after setting all properties.
function k1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k2_Callback(hObject, eventdata, handles)
% hObject    handle to k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k2 as text
%        str2double(get(hObject,'String')) returns contents of k2 as a double


% --- Executes during object creation, after setting all properties.
function k2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1 as text
%        str2double(get(hObject,'String')) returns contents of p1 as a double

% --- Executes during object creation, after setting all properties.
function p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2_Callback(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2 as text
%        str2double(get(hObject,'String')) returns contents of p2 as a double

% --- Executes during object creation, after setting all properties.
function p2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function skewness_Callback(hObject, eventdata, handles)
% hObject    handle to skewness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skewness as text
%        str2double(get(hObject,'String')) returns contents of skewness as a double

% --- Executes during object creation, after setting all properties.
function skewness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skewness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pixel_size_Callback(hObject, eventdata, handles)
% hObject    handle to pixel_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixel_size as text
%        str2double(get(hObject,'String')) returns contents of pixel_size as a double


% --- Executes during object creation, after setting all properties.
function pixel_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixel_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function kx_ky_Callback(hObject, eventdata, handles)
% hObject    handle to kx_ky (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kx_ky as text
%        str2double(get(hObject,'String')) returns contents of kx_ky as a double


% --- Executes during object creation, after setting all properties.
function kx_ky_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kx_ky (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aprox_dist_Callback(hObject, eventdata, handles)
% hObject    handle to aprox_dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aprox_dist as text
%        str2double(get(hObject,'String')) returns contents of aprox_dist as a double


% --- Executes during object creation, after setting all properties.
function aprox_dist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aprox_dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel9.
function uipanel9_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel9 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Run_button.
handles = guidata(hObject);
  
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'ortho_radio'
      

         set(handles.ortho_run,'Enable','on') 
         set(handles.Automatic,'Enable','on')
         set(handles.plane_points,'Enable','on')
         set(handles.proj_run,'Enable','off')
         set(handles.mask,'Enable','on')
         set(handles.Automatic,'Value',1)
         set(handles.cut_point_cloud, 'Enable', 'on')
         set(handles.system_rotation, 'Enable', 'on')
       
        
    case 'proj_radio'
        
         set(handles.ortho_run,'Enable','off')
         set(handles.Automatic,'Enable','off')
         set(handles.Automatic,'Value',0)
         set(handles.plane_points,'Value',0)
         set(handles.load_plane,'Enable','off')
         set(handles.plane_points,'Enable','off')
         set(handles.mask,'Enable','off')
         set(handles.cut_point_cloud, 'Enable', 'off')
         set(handles.cut_point_cloud, 'Value', 0)
         set(handles.system_rotation, 'Enable', 'off')

         set(handles.proj_run,'Enable','on')
         
        
end
guidata(hObject, handles);


% --- Executes when selected object is changed in uipanel10.
function uipanel10_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel10 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject); 
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'Automatic'
      
         set(handles.load_plane,'Enable','off')  
        
    case 'plane_points'
        
         set(handles.load_plane,'Enable','on')
        
end
guidata(hObject, handles);


% --- Executes on button press in load_plane.
function load_plane_Callback(hObject, eventdata, handles)
% hObject    handle to load_plane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[filename pathname]=uigetfile({'*.txt'},'File Selector');
if pathname==0, return; end  
fullpathname =strcat(pathname, filename);
text = fileread (fullpathname);% Reading information inside a file
points_for_plane=load(fullpathname);
set(handles.save_button,'Enable','off')
handles.plane_points_hndl=points_for_plane;
guidata(hObject, handles);


% --- Executes on selection change in mask.
function mask_Callback(hObject, eventdata, handles)
% hObject    handle to mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mask contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mask



guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ortho_run.
function ortho_run_Callback(hObject, eventdata, handles)

handles = guidata(hObject);

format long g
global points_for_plane int_par
% hObject    handle to ortho_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%........................eisagwgh stoixeiwn-------an kapoio stoixeio den
%uparxei o algorithmos stamata------------------------
handles = guidata(hObject);
xy=handles.image_coordinates;

if xy==0 
    h = msgbox('Insert Image Coordinates','File Not Found');
    return;
end

XYZ=handles.coordinates_3d;
if XYZ==0 
    h = msgbox('Insert 3D Coordinates','File Not Found');
    return;
end

im=handles.im_handle;
if im==0 
    h = msgbox('Insert Image','File Not Found');
    return;
end

pc=handles.pc_hanlde;
if pc==0 
    h = msgbox('Insert Point Cloud','File Not Found');
    return;
end

size_xy=size(xy,1);
size_XYZ=size(XYZ,1);

if size_xy ~= size_XYZ
 h = msgbox('Image Coordinates and 3D Coordinates Must Have The Same Number of Points ','Error');
    return;
end





im_num=str2double(get(handles.text19,'string'));


if get(handles.manual_intr, 'Value')
    
    
a1=get(handles.xo,'string');
a2=get(handles.yo,'string');    
a3=get(handles.c,'string');
a4=get(handles.k0,'string');
a5=get(handles.k1,'string');
a6=get(handles.k2,'string');
a7=get(handles.p1,'string');
a8=get(handles.p2,'string');
a9=get(handles.skewness,'string'); 
a10=get(handles.pixel_size,'string');
a11=get(handles.kx_ky,'string');
    
    
    
if isempty(a1)||isempty(a2)||isempty(a2)||isempty(a4)||isempty(a5)||isempty(a6)||isempty(a7)||isempty(a8)||isempty(a9)||isempty(a10)||isempty(a11)
 
 h = msgbox('Feel the missing data','Error');
return;
  
else
       
xo_vath = str2double(get(handles.xo,'string'));%.. eisagei ton arithmo apo ton xrhsth!!!!

yo_vath = str2double(get(handles.yo,'string'));

c_mm = str2double(get(handles.c,'string'));

k0 = str2double(get(handles.k0,'string'));
k1 = str2double(get(handles.k1,'string'));

k2 = str2double(get(handles.k2,'string'));

p1 = str2double(get(handles.p1,'string'));

p2 = str2double(get(handles.p2,'string'));

e = str2double(get(handles.skewness,'string'));
 
pixel_size=str2double(get(handles.pixel_size,'string'));

logos=str2double(get(handles.kx_ky,'string'));
end
elseif get(handles.load_intr, 'Value')
    
int_par=handles.int_parameters;


if int_par==0 
    h = msgbox('Insert Intrinsic Parameters','File Not Found');
    return;
end

xo_vath=int_par(1);
yo_vath=int_par(2);
c_mm=int_par(3);
pixel_size=int_par(4);
logos=int_par(5);
e=int_par(6);
k0=int_par(7);
k1=int_par(8);
k2=int_par(9);
p1=int_par(10);
p2=int_par(11);

end

if logos==0
    logos=1;
end

set(handles.save_button,'Enable','off')


if isempty(get(handles.aprox_dist,'string'))
  h = msgbox('Insert approximate distance','Error');
return;   
else
H=str2double(get(handles.aprox_dist,'string'));
end



if isempty(get(handles.scale_box,'String'))
  h = msgbox('Insert desired scale of the new image','Error');
return;   
else
klim = str2double(get(handles.scale_box,'String'));
end



edafo=(0.1*klim)/1000;

points_for_plane=handles.plane_points_hndl;

h2 = msgbox('Please wait...','Orthophoto');

val = get(handles.mask,'Value');
switch val
    case 1
mask=3;        
    case 2
mask=5;   
    case 3
mask=7;
    case 4
mask=9;
        
end


rows=size(im,1);
cols=size(im,2);

rot_num=handles.rotation_number;

 if rot_num==1;%allazei prwteuon shmeio kai klimakes... an strafei h eikona
xo=cols-yo_vath;  % ta strammena logw ths fwto
yo=xo_vath;
kx=1;
ky=logos;
 elseif rot_num==2;
 xo= xo_vath;  % ta mh strammena
 yo=yo_vath;
 kx=1;
 ky=logos*kx;
 elseif rot_num==0
xo=xo_vath;  % ta strammena logw ths fwto
yo=yo_vath;
kx=1;
ky=logos;   
 end


xom=xo*pixel_size;
yom=yo*pixel_size;


%% _strofh susthmatwn



if get(handles.system_rotation, 'Value')==1
XYZ_first=XYZ;
pc_first=pc;


if im_num~=1
   xyz_st_1= handles.XYZ_st_1;         
Dx=xyz_st_1(2,1)-xyz_st_1(1,1);
Dy=xyz_st_1(2,2)-xyz_st_1(1,2);
[a_str] = angle_calculation_1(Dx,Dy);
gon_str=a_str*180/pi();
point_rotation=xyz_st_1(1,:);
   else

Dx=XYZ(2,1)-XYZ(1,1);
Dy=XYZ(2,2)-XYZ(1,2);
[a_str] = angle_calculation_1(Dx,Dy);
gon_str=a_str*180/pi();
point_rotation=XYZ(1,:);

end
   

[points_for_plane, Rr, t] = AxelRot(points_for_plane',gon_str, [0,0,1], point_rotation);
points_for_plane=points_for_plane';
points_for_plane=[points_for_plane(:,1),points_for_plane(:,3),-points_for_plane(:,2)];

[k_XYZ, Rr, t] = AxelRot(XYZ',gon_str, [0,0,1], point_rotation);
k_XYZ=k_XYZ';
XYZ_tel=[k_XYZ(:,1),k_XYZ(:,3),-k_XYZ(:,2)];

[P_s, Rr, t] = AxelRot(pc',gon_str,[0,0,1],point_rotation);
P_s=P_s';
pc=[P_s(:,1),P_s(:,3),-P_s(:,2)];
XYZ=XYZ_tel;

   points_for_plane(1,3)=points_for_plane(1,3)+0.0001;
end






%% affinikos

if k0 == 0&& k1==0 && k2==0
    if xo==0 && yo==0
        [ xdyd ] = rotation_and_translation( xy,im,pixelsize);
    else
    [ xdyd ] = affine_no_distortion(e,kx,ky,xy,xo,yo,pixelsize);
    end

else   
    
[xdyd, affine_coeff]=affine_transformation(e,kx,ky,k0,k1,k2,p1,p2,xy,xo,yo,xom,yom);

end

%% ............dlt.........................
xy2(:,1:2)=xdyd; % ta parapanw x, y se enan pinaka xy mazi
n=2*size(xy2,1);
m=11;
proswrines_times=dlt_initial(n,m,xy2,XYZ,xom,yom);


%% ..................... opisthotomia.............
m=6;                 %arithmos agnwstwn parametrwn m (stoixia ekswterikou prosanatolismou)
[Xo,Yo,Zo,w,f,k]=resection_eop(n,m,c_mm,xy2,XYZ,proswrines_times,klim,H);


%------------------allagh se katakorufo kata 90 moires--------------------------------------------------

if get(handles.system_rotation, 'Value')==1
    
[points_for_plane, Rr, t] = AxelRot(points_for_plane', 90, [1,0,0], [0,0,0]);
points_for_plane=points_for_plane';

P_inv1=[Xo;Yo;Zo];
[P_inv2, Rr, t] = AxelRot(P_inv1, 90, [1,0,0], [0,0,0]);
Xo=P_inv2(1);
Yo=P_inv2(2);
Zo=P_inv2(3);

[pc, Rr, t] = AxelRot(pc', 90, [1,0,0], [0,0,0]);
pc=pc';


[xyz, Rr, t] = AxelRot(XYZ', 90, [1,0,0], [0,0,0]);
XYZ=xyz';

 w=w+pi()/2;


end 



r=rmatrix(w,f,k);
l=r(3,1);
m=r(3,2);
n=r(3,3);
lo=[Xo,Yo,Zo];
lvec=[l,m,n];


% crop point cloud..................................................


if get(handles.cut_point_cloud, 'Value')==1
SK=(H*1000)/c_mm;%proseggistikh klimaka arxikhs eikonas
Dx=(cols*pixel_size*SK)/1000;%diastaseis eikonas anhgmenes sthn pragmatikothta
Dy=(rows*pixel_size*SK)/1000;
[n_norm,D]=plane_3points(XYZ(1,:),XYZ(2,:),XYZ(3,:)); % kathorismos epipedou pou periexei 3 shmeia ths epiloghs tou xrhsth

point=plane_line_intersect(n_norm,lo,lvec,D);    % h provolh tou provolikou shmeiou sto nefos


pointcloud = crop_pointcloud(point,pc,lvec,Dx,Dy); % to teliko nefos

else
    pointcloud=pc;
end

%projection
%plane...............................................................
if im_num~=1
    plane_coeff= handles.first_plane;
    proj_center=handles.first_proj;
else
    
proj_center=lo;

if get(handles.Automatic, 'Value')
        plane_coeff=[l,m,0];
    
    elseif get(handles.plane_points, 'Value')
       
        
         cont=numel(points_for_plane(:,1));
       if cont==2
          A=-(points_for_plane(2,2)-points_for_plane(1,2));
          B=points_for_plane(2,1)-points_for_plane(1,1);
          plane_coeff=[A,B,0];
           
       elseif cont==3
               [plane_coeff,d_sunt]=plane_3points(points_for_plane(1,:),points_for_plane(2,:),points_for_plane(3,:)); %ta D na fugoun!!
          
       end
end
      
end


 R=pointcloud;
cont=numel(R(:,1));
v=(1:cont);

T = zeros(size(R));%..Points projection

for i=1:cont
    d=-(plane_coeff(1)*proj_center(1)+plane_coeff(2)*proj_center(2)+plane_coeff(3)*proj_center(3));
    t=-((plane_coeff(1)*R(i,1)+plane_coeff(2)*R(i,2)+plane_coeff(3)*R(i,3))+d)/(plane_coeff(1)^2+plane_coeff(2)^2+plane_coeff(3)^2);
    T(i,1)=plane_coeff(1)*t+R(i,1);
    T(i,2)=plane_coeff(2)*t+R(i,2);
    T(i,3)=plane_coeff(3)*t+R(i,3);
end







axes(handles.axes3)
plot_geometry(R,r,plane_coeff,Xo,Yo,Zo,proj_center) %.... vgazei to figure pou mou deixnei thn gewmetria pou thelw!

 set(handles.uipanel14,'Title', 'Optical Axis, Point Cloud, Projection Plane');




if get(handles.plane_points, 'Value')
       
        
     cont_plane=numel(points_for_plane(:,1)); 
      if cont_plane==3
                  
% point cloud rotation


unit_norm=plane_coeff(:)/norm(plane_coeff);

gon_plane=-((pi()/2)-acos(unit_norm(3)))*180/pi(); % edw diereunhsh????????


n_line=cross(unit_norm,[0,0,1]);
n_line=n_line(:)/norm(n_line);

n_line = line_direction( n_line,R,T);
  
K_arxiko=T;

    
[K, Rr, trans] = AxelRot(T', gon_plane, n_line, proj_center);
K=K';
T=K;

      end
end




close(h2);



choice2 = questdlg('Do you want to continue with the orthophoto?', ...
	'Checking The Geometry', 'Yes','No', 'Yes');

switch choice2
    
     
    case 'No'
       
        return;
    
    
    case 'Yes'

[xmax, inxmx] =max(T(:,1));
[xmin, inxmn] =min(T(:,1));

[ymax, inymx] = max(T(:,2));
[ymin, inymn] = min(T(:,2));

[zmax, inzmx] =max(T(:,3));
[zmin, inzmn]=min(T(:,3));

zlong=abs((zmax-zmin));


xylong=sqrt((xmax-xmin)^2+(ymax-ymin)^2);



length=ceil(xylong/edafo);
height=ceil(zlong/edafo);

v1=ceil(mask/2);%...gia 3X3...2....5x5...3
v2=v1-1;%........gia 3X3...1,,,,,,,5x5 ...2

l_orth=length+2*v2;%pros8hkh aparaithtwn sthlwn kai grammwn
h_orth=height+2*v2;

ortho=zeros(h_orth,l_orth,3); %Creation of empty camvas

sa=-plane_coeff(1)/plane_coeff(2);

ag=atan(sa); %vriskw thn gwnia tou epipedou (ths eutheias xy) me ton axona x...l/m o suntelesths a ths exiswshs eutheis y=ax+d, a=l/m, a=tan(ag)

[xma,yma,pros1,pros2] = planeandpointcloud(R,T,sa); % function pou kanei thn diereunhsh!


im=double(im);

if get(handles.Automatic, 'Value')
Distp=sqrt((T(:,1)-R(:,1)).^2+(T(:,2)-R(:,2)).^2+(T(:,2)-R(:,2)).^2);

elseif get(handles.plane_points, 'Value')
           
     cont_plane=numel(points_for_plane(:,1)); 
      if cont_plane==3
          
       Distp=sqrt((K_arxiko(:,1)-R(:,1)).^2+(K_arxiko(:,2)-R(:,2)).^2+(K_arxiko(:,2)-R(:,2)).^2);
      else
     Distp=sqrt((T(:,1)-R(:,1)).^2+(T(:,2)-R(:,2)).^2+(T(:,2)-R(:,2)).^2);
  
      end 
end


T=[T,Distp,v'];%probalomeno nefos, me 4h sthlh gia apostaseis apo to kanoniko kai 5h sthlh me thn arithmhsh



h = waitbar(0,'Please wait...');

   
       %diorthwsh oriwn me thn prosthhkh sthlwn kai grammwnn anafora se gwnies
       %oxi kentra...

       zmax=zmax+edafo*v2;
       xma=xma-(pros1)*v2*edafo*cos(ag);
       yma=yma-(pros2)*v2*edafo*abs(sin(ag));
        
tic;    
for ro=v1:h_orth-v2  
    
    tz1= zmax-(ro-v1)*edafo;
    tz2= zmax-mask*edafo-(ro-v1)*edafo;
    
    
    T1 = T(T(:,3)<tz1 & T(:,3)>tz2,:);
    
    for co=v1:l_orth-v2
        
        
        tx1= xma+(pros1)*(co-v1)*edafo*cos(ag);
        tx2= tx1+(pros1)*mask*edafo*cos(ag);
        ty1= yma+(pros2)*(co-v1)*edafo*abs(sin(ag));
        ty2= ty1+(pros2)*mask*edafo*abs(sin(ag));
        
        
        kx1=max(tx1,tx2);
        kx2=min(tx1,tx2);
        ky1=max(ty1,ty2);
        ky2=min(ty1,ty2);
        
        
        T2=T1(T1(:,1)<kx1 & T1(:,1)>kx2,:);
        
        T3 = T2(T2(:,2)<ky1 & T2(:,2)>ky2,:);
        
        d_anoxhs=mask*edafo;
        Ddis=min(T3(:,4))+d_anoxhs;
        
        last=T3(T3(:,4)<Ddis,:);
        
        C=last(:,5);
        
        Ccon=numel(C);
        
        
        
        
         if Ccon~=0
             
            mat=R((C'),:);
            
            mo=mean(mat,1); 
             X=mo(1);
             Y=mo(2);
             Z=mo(3);
            
           % colinearity equation
            
            x= -(c_mm*((r(1,1)*(X-Xo)+r(1,2)*(Y-Yo)+r(1,3)*(Z-Zo))/(r(3,1)*(X-Xo)+r(3,2)*(Y-Yo)+r(3,3)*(Z-Zo))));
            y= -(c_mm*((r(2,1)*(X-Xo)+r(2,2)*(Y-Yo)+r(2,3)*(Z-Zo))/(r(3,1)*(X-Xo)+r(3,2)*(Y-Yo)+r(3,3)*(Z-Zo))));
            
            X_px= distortion_inverse_affine(x,y,xom,yom,p1,p2,k0,k1,k2,affine_coeff);
            
             X_px2=round(X_px);
            
            if X_px2(1) <1 || X_px2(2)<1||X_px2(1)>=cols||X_px2(2)>rows
                
                ortho(ro,co,:)=255; 
            else
                
                            g1=floor(X_px);
                            g1(g1==0)=1;
                            
                
                            g2=ceil(X_px);
                            
                            g2(g2(2)>rows,2)=rows;
                            g2(g2(1)>cols,1)=cols;
                
                
                            b_=X_px(1)-g1(1);
                            a_=X_px(2)-g1(2);
                
                
                            Red=round((1-a_)*(1-b_)*im(g1(2),g1(1),1)  +(1-a_)*b_*im(g1(2),g2(1),1)   +a_*(1-b_)*im(g2(2),g1(1),1)   +a_*b_*im(g2(2),g2(1),1));
                            
                            
                            
                            
                            Green=round((1-a_)*(1-b_)*im(g1(2),g1(1),2)+(1-a_)*b_*im(g1(2),g2(1),2)+a_*(1-b_)*im(g2(2),g1(1),2)+a_*b_*im(g2(2),g2(1),2));
                            Blue=round((1-a_)*(1-b_)*im(g1(2),g1(1),3)+(1-a_)*b_*im(g1(2),g2(1),3)+a_*(1-b_)*im(g2(2),g1(1),3)+a_*b_*im(g2(2),g2(1),3));
                
                            tr=[Red,Green,Blue];
                
                            ortho(ro,co,:)=tr;
                           
                
            end
            
        end
        
        
        
        
        
    end
   
%     height
%     iii=iii+1
    %....dispTimeLeft(v1,1,height,ro)
    waitbar(ro/height)
    
end
toc

 ortho_last=uint8(ortho);
 axes(handles.axes3)
 imshow(ortho_last)
 set(handles.uipanel14,'Title', 'Orthophoto');
 
  handles.image_save = ortho_last;
   set(handles.save_button,'Enable','on')

close(h)





if im_num==1
   handles.first_plane = plane_coeff;
    handles.first_proj = proj_center;
    
    
    if get(handles.system_rotation, 'Value')==1
    handles.XYZ_st_1=XYZ_first(1:2,:);
    end
   
    
      top_left=[xma,yma,zmax];
      handles.top_left_coor=top_left; 
      
    twf_f=georeference(edafo,100,100);
else
    top_left1=handles.top_left_coor; 
    
%     if top_left1(1)<xma
%     topleft(1)=-topleft(1);
%     end
    
    Dis_xy=sqrt((top_left1(1)-xma)^2+(top_left1(2)-yma)^2)+100;
    
    Dis_z=100+(zmax-top_left1(3)); % aut;o panw h katw??
    
    twf_f=georeference(edafo,Dis_xy,Dis_z);
       
end

handles.twf_file=twf_f;


choice = questdlg('DO you want to project another image on the same plane?', ...
	'Add Image', 'Yes','No', 'No');
% Handle response
switch choice
    case 'Yes'
        
        im_num=im_num+1;
        set(handles.text19,'String', im_num);
        set(handles.Automatic,'Enable','off')
        set(handles.load_plane,'Enable','off')
        set(handles.plane_points,'Enable','off')
        set(handles.mask,'Enable','off')
       
        
        
    case 'No'
       
    set(handles.text19,'String', '1');
    set(handles.Automatic,'Enable','on')
    set(handles.plane_points,'Enable','on')
    set(handles.Automatic,'Value',1)
    set(handles.plane_points,'Value',0)
    set(handles.mask,'Enable','on')
   
end

end

guidata(hObject, handles);






% --- Executes on button press in proj_run.
function proj_run_Callback(hObject, eventdata, handles)
% hObject    handle to proj_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);


xy=handles.image_coordinates;

if xy==0 
    h = msgbox('Insert Image Coordinates','File Not Found');
    return;
end

im=handles.im_handle;
if im==0 
    h = msgbox('Insert Image','File Not Found');
    return;
end

XYZ=handles.coordinates_3d;
if XYZ==0 
    h = msgbox('Insert 3D Coordinates','File Not Found');
    return;
end


if isempty(get(handles.scale_box,'string'))
  h = msgbox('Insert desired scale of the new image','Error');
return;   
else
klim = str2double(get(handles.scale_box,'String'));
end


h1 = msgbox('Please wait...','2D projection');

set(handles.save_button,'Enable','off')

rows=size(im,1);
cols=size(im,2);

%----------------------

Dx=XYZ(2,1)-XYZ(1,1);
Dy=XYZ(2,2)-XYZ(1,2);

[plane_coeff,D_axr]=plane_3points(XYZ(1,:),XYZ(2,:),XYZ(3,:));

unit_norm=abs(plane_coeff(:)/norm(plane_coeff));% edw evala absolute giati to acos dinei times apo 0 ews 180 (pi), gia times apo -1 ews 1 (0-->90) emeis theloume panta thn mikroterh gvnia

gon_plane=((pi()/2)-acos(unit_norm(3)))*180/pi(); % edw diereunhsh!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!????????

n_line=[Dx,Dy,0];
n_line=n_line(:)/norm(n_line);

%n_line = line_direction( n_line,R,T);  
    
[XYZ, Rr, trans] = AxelRot(XYZ', gon_plane, n_line, [0,0,0]);
XYZ=XYZ';



%---------------------------



Dx=XYZ(2,1)-XYZ(1,1);
Dy=XYZ(2,2)-XYZ(1,2);


az=angle_calculation_2(Dx,Dy); 
%pinakas strofhs
R=[cos(((pi()/2)-az+2*pi())) sin(((pi()/2)-az+2*pi())) ; -sin(((pi()/2)-az+2*pi())) cos(((pi()/2)-az+2*pi()))];

% strofh 1: to antikeimeno parallhlo me ton x,
% strofh 2: antimetamesh aksonvn

XYZ_strofh_1=zeros(size(XYZ,1),2);
for i=1:size(XYZ,1)
   XYZ_strofh_1(i,1:2)=[XYZ(1,1) ; XYZ(1,2)]+R*[(XYZ(i,1)-XYZ(1,1)) ; (XYZ(i,2)-XYZ(1,2))];
end
XYZ_strofh_1(:,3)=XYZ(:,3);
XYZ_strofh_2(:,1:3)=[XYZ_strofh_1(:,1),XYZ_strofh_1(:,3),-XYZ_strofh_1(:,2)]

XYZ_strofh_2=XYZ_strofh_2(:,1:2);

%XYZ_strofh_2=XYZ;

[a, So] = projective2D_coefficients(XYZ_strofh_2,xy); % a=pinakas parametrwn So= sfalma se m))

%kathorizw to pixel size

edafo=(0.1*klim)/1000;


xy_oria=[1,1; size(im,2),1; size(im,2),size(im,1); 1,size(im,1)]; %ta 4 oria ths fwtografias se pixels sun/mes xy_pixel

%vriskw tis antistoixes gewdaitikes sun/nes twn oriwn XY
XY_oria=zeros(size(xy_oria));
for i=1:4
    XY_oria(i,1)=(xy_oria(i,1)*a(1)+xy_oria(i,2)*a(2)+a(3))/(xy_oria(i,1)*a(7)+xy_oria(i,2)*a(8)+1);
    XY_oria(i,2)=(xy_oria(i,1)*a(4)+xy_oria(i,2)*a(5)+a(6))/(xy_oria(i,1)*a(7)+xy_oria(i,2)*a(8)+1);
end

minx=min(XY_oria(:,1));
miny=min(XY_oria(:,2));
maxx=max(XY_oria(:,1));
maxy=max(XY_oria(:,2));

% kathorismos tou megethous ths telikhs anhgmenhs eikonas
width=ceil((maxx-minx)/edafo);
height=ceil((maxy-miny)/edafo);


% Oi parametroi tou antistrofou provolikou ( apo xy--> XY)
A=inverse_affine_coefficients(a);



im_proj= zeros(height, width,3); %megethos ths telikhs eikonas

im=double(im);

for i=1:height
    for j=1:width
        
        Xi=minx+edafo*(j-1);
        Yi=maxy-edafo*(i-1);
        
        xi=(A(1)*Xi+A(2)*Yi+A(3))/(A(7)*Xi+A(8)*Yi+1);
        yi=(A(4)*Xi+A(5)*Yi+A(6))/(A(7)*Xi+A(8)*Yi+1); 
        
        X_px=[xi,yi];
        
         X_px2=round(X_px);
            
            if X_px2(1) <1 || X_px2(2)<1||X_px2(1)>=cols||X_px2(2)>rows
                
                 im_proj(i,j,:)=0 ; % ta shmeia poy den anhkoun sth fwto alla mono sto nefos
            else
                
                            g1=floor(X_px);
                            g1(g1==0)=1;
                            
                
                            g2=ceil(X_px);
                            
                            g2(g2(2)>rows,2)=rows;
                            g2(g2(1)>cols,1)=cols;
                
                
                            b_=X_px(1)-g1(1);
                            a_=X_px(2)-g1(2);
                
                
                            Red=round((1-a_)*(1-b_)*im(g1(2),g1(1),1)+(1-a_)*b_*im(g1(2),g2(1),1)+a_*(1-b_)*im(g2(2),g1(1),1)+a_*b_*im(g2(2),g2(1),1));
                            Green=round((1-a_)*(1-b_)*im(g1(2),g1(1),2)+(1-a_)*b_*im(g1(2),g2(1),2)+a_*(1-b_)*im(g2(2),g1(1),2)+a_*b_*im(g2(2),g2(1),2));
                            Blue=round((1-a_)*(1-b_)*im(g1(2),g1(1),3)+(1-a_)*b_*im(g1(2),g2(1),3)+a_*(1-b_)*im(g2(2),g1(1),3)+a_*b_*im(g2(2),g2(1),3));
                
                            tr=[Red,Green,Blue];
                
                      im_proj(i,j,:)=tr;    
            end
        
    end
end

im_proj=uint8(im_proj);
axes(handles.axes3)
imshow(im_proj)

set(handles.uipanel14,'Title', '2D Projection');

handles.image_save = im_proj;

twf_f=georeference(edafo,100,100);%gewanafora anagwghs

handles.twf_file=twf_f;%arxeio geoanaforas anagwghs


set(handles.save_button,'Enable','on')


close(h1);

guidata(hObject, handles); 







% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

[FileName, PathName] = uiputfile({'*.tif';'*.jpg'},'Save As'); 
if PathName==0, return; end  
Name = fullfile(PathName,FileName); 
  img= handles.image_save;
 
imwrite(img, Name);


name_txt= Name(1:end-4);
name_last=[name_txt,'.tfw'];

twf_save=handles.twf_file; %apothhkeush geoanaforas

saveascii(twf_save,name_last, 6 )

guidata(hObject, handles);


% --- Executes on button press in Select_im_coor.
function Select_im_coor_Callback(hObject, eventdata, handles)
% hObject    handle to Select_im_coor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);


im=handles.im_handle;

if im==0 
    h = msgbox('Insert Image','File Not Found');
    return;
end

format long g
    
fh = figure(), imshow(im);

xy=ginput2('.k')

handles.image_coordinates=xy;

imagename=handles.image_pathandname;
name_txt= imagename(1:end-4);
name_last=[name_txt,'_xy.txt'];

saveascii(xy,name_last,[5 5] )


close(fh)

guidata(hObject, handles);  


% --- Executes on button press in select_3D_coor.
function select_3D_coor_Callback(hObject, eventdata, handles)
% hObject    handle to select_3D_coor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


pc=handles.pc_hanlde;

if pc==0 
    h = msgbox('You must load a point cloud','File Not Found');
    return;
end

format long g
    
pc_sel=pc;
pc_sel=pc_sel';

fh = figure();
set(0, 'currentfigure', fh);
XY = clickA3DPoint(pc_sel);

    


% --- Executes on button press in cut_point_cloud.
function cut_point_cloud_Callback(hObject, eventdata, handles)
% hObject    handle to cut_point_cloud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cut_point_cloud


% --- Executes on button press in rotate_image.
function rotate_image_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

im=handles.im_handle;

if im==0 
    h = msgbox('Insert Image','File Not Found');
    return;
end


rot_num=handles.rotation_number;

if rot_num==3
    rot_num=0;
end

img = imrotate(im,-90);

axes(handles.axes1)
imshow(img)
rot_num=rot_num+1;
handles.rotation_number=rot_num;
handles.im_handle=img;

guidata(hObject, handles);


% --- Executes on button press in system_rotation.
function system_rotation_Callback(hObject, eventdata, handles)
% hObject    handle to system_rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of system_rotation



function scale_box_Callback(hObject, eventdata, handles)
% hObject    handle to scale_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_box as text
%        str2double(get(hObject,'String')) returns contents of scale_box as a double


% --- Executes during object creation, after setting all properties.
function scale_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hole_filling.
function hole_filling_Callback(hObject, eventdata, handles)
% hObject    handle to hole_filling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
im= handles.image_save;
im_new=hole_fill(im);
axes(handles.axes3)
imshow(im_new)
handles.image_save=im_new;

guidata(hObject, handles);
