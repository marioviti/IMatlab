function [ b ] = convertuint8(a)
    a = a*255;
    b = uint8(a);
end

