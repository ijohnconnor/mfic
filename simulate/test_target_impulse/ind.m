function j = ind(i, N)

if 1 <= i && i <= N
    j = i;
end;

if i <= 0
    j = N + i;
end;

if i > N
    j = i - N;
end;
