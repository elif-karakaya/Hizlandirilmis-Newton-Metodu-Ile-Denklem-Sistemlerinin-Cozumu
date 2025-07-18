clc;
clear;


syms x y

fprintf('HIZLANDIRILMIŞ NEWTON METODU\n');
f1_str = input('1. denklemi girin : ', 's');
f2_str = input('2. denklemi girin : ', 's');


f1 = str2sym(f1_str);
f2 = str2sym(f2_str);


df1_dx = diff(f1, x);
df1_dy = diff(f1, y);
df2_dx = diff(f2, x);
df2_dy = diff(f2, y);


x0 = input('x0 başlangıç değerini girin: ');
y0 = input('y0 başlangıç değerini girin: ');
tol = input('Tolerans değerini girin: ');
max_iter = 100;
iter = 0;

fprintf('\nİterasyon\t\tx\t\ty\t\t|Δx|\t\t|Δy|\n');
fprintf('-------------------------------------------------------------\n');

while iter < max_iter
    iter = iter + 1;

    
    f1_deger = double(subs(f1, [x, y], [x0, y0]));
    df1_dx_deger = double(subs(df1_dx, [x, y], [x0, y0]));

    if abs(df1_dx_deger) < 1e-12
        error('f1 fonksiyonunun x türevi sıfıra çok yakın, bölme hatası!');
    end

    x1 = x0 - f1_deger / df1_dx_deger;

    f2_deger = double(subs(f2, [x, y], [x1, y0]));
    df2_dy_deger = double(subs(df2_dy, [x, y], [x1, y0]));

    if abs(df2_dy_deger) < 1e-12
        error('f2 fonksiyonunun y türevi sıfıra çok yakın, bölme hatası!');
    end

    y1 = y0 - f2_deger / df2_dy_deger;

   
    dx = abs(x1 - x0);
    dy = abs(y1 - y0);

    fprintf('%d\t\t%.6f\t%.6f\t%.6f\t%.6f\n', iter, x1, y1, dx, dy);

    
    if max(dx, dy) < tol
        break;
    end

    x0 = x1;
    y0 = y1;
end

if iter == max_iter
    fprintf('\nUYARI: Maksimum iterasyon sayısına ulaşıldı, yakınsama sağlanamadı.\n');
else
    fprintf('\nYakınsak çözüm bulundu:\n');
    fprintf('x = %.6f, y = %.6f\n', x1, y1);
    fprintf('Toplam iterasyon sayısı: %d\n', iter);
end
