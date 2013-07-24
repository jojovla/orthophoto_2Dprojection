function [twf_file ] = georeference(edafo, X_topleft, Y_topleft)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



twf_file=[edafo;0;0;-edafo;X_topleft;Y_topleft];


end

