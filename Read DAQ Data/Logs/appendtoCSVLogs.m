function appendtoCSVLogs(filename, t, V, P)

    out = [t, V, P];
    writematrix(out, filename, 'WriteMode', 'append');

end
