clc
clear
close all

a = 1;
b = [-1, 1];
figure(1);
zplane(b, a);
figure(2);
freqz(b, a);
