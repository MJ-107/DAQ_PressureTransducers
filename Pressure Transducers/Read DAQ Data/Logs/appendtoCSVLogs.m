function appendtoCSVLogs(filename, t, V, P)

    t = seconds(t);      % ensure double
    t = t(:);            % force column vector

    V = V(:,:);          % ensure 2D
    P = P(:,:);

    out = [t, V, P];

    writematrix(out, filename, 'WriteMode', 'append');

end
