% Script para calcular o Modelo de Reflexão de Phong -Itens h, i, j, k
clear; clc;

% DEFINIÇÃO DA FUNÇÃO
function [Cor, Ln, Nn, Rn, Vn] = calcularPhong(L, N, R, V, LA, KA, LD, KD, LE, KE, shi)
  % Normalizando vetores 
  Ln = L / norm(L);
  Nn = N / norm(N);
  Rn = R / norm(R);
  Vn = V / norm(V);

  % Componente Ambiente: Ia = LA * KA
  Ambient = LA .* KA;

  % Componente Difusa: Id = (LD * KD) * (L . N)
  % max(0, ...) pra garantir que não tenha iluminação negativa
  dotLN = max(0, dot(Ln, Nn));
  Diffuse = (LD .* KD) * dotLN;

  % Componente Especular: Ie = (LE * KE) * (R . V)^shi
  dotRV = max(0, dot(Rn, Vn));
  Specular = (LE .* KE) * (dotRV^shi);

  % Cor Final = Ia + Id + Ie
  Cor = Ambient + Diffuse + Specular;
end

% DADOS
LA = [0.05, 0.16, 0.08]; KA = [1.0, 0.5, 1.0];
LD = [0.33, 0.51, 0.55]; KD = [1.0, 1.0, 1.0];
LE = [0.08, 0.16, 0.13]; KE = [1.0, 0.8, 1.0];
shi = 10;

% Vetores L e V 
L_coord = [0.87, 0.48, 0.42];
V_coord = [0.79, 0.26, 0.25];

% Vetores N e R para cada letra
letras = {'h', 'i', 'j', 'k'};
N_coords = [-0.13, 0.59, 0.16;  % h
             0.03, 0.61, 0.15;  % i
             0.24, 0.58, 0.16;  % j
             0.37, 0.51, 0.19]; % k

R_coords = [0.93, -0.20, -0.34; % h
            -0.85, -0.01, -0.31; % i
             0.60,  0.16, -0.24; % j
            -0.39,  0.18, -0.17]; % k

% RESULTADOS
for idx = 1:4
    [Cor, Ln, Nn, Rn, Vn] = calcularPhong(L_coord, N_coords(idx,:), R_coords(idx,:), V_coord, LA, KA, LD, KD, LE, KE, shi);
    
    fprintf('\n================ ITEM %s =================\n', letras{idx});
    fprintf('VETORES NORMALIZADOS:\n');
    fprintf('L: [%.4f, %.4f, %.4f]\n', Ln);
    fprintf('N: [%.4f, %.4f, %.4f]\n', Nn);
    fprintf('R: [%.4f, %.4f, %.4f]\n', Rn);
    fprintf('V: [%.4f, %.4f, %.4f]\n', Vn);
    fprintf('\nCOR FINAL (RGB):\n');
    fprintf('R: %.4f | G: %.4f | B: %.4f\n', Cor(1), Cor(2), Cor(3));
end
