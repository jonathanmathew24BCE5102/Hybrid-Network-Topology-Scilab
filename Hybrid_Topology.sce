clc;
clear;
xdel(winsid());

// ===================== NODES =====================
nodes = 1:25;

// ===================== STAR TOPOLOGY =====================
star_edges = [];
for i = 2:9
    star_edges = [star_edges; 1 i];
end

// ===================== RING TOPOLOGY =====================
ring_edges = [];
for i = 10:16
    ring_edges = [ring_edges; i i+1];
end
ring_edges = [ring_edges; 17 10];

// ===================== MESH TOPOLOGY =====================
mesh_edges = [];
for i = 18:25
    for j = i+1:25
        mesh_edges = [mesh_edges; i j];
    end
end

// ===================== HYBRID LINKS =====================
hybrid_edges = [
    5 10;
    9 18
];

// ===================== COMBINE EDGES =====================
edges = [star_edges; ring_edges; mesh_edges; hybrid_edges];
total_edges = size(edges,1);

// ===================== FIXED NODE POSITIONS =====================
x = zeros(1,25);
y = zeros(1,25);

// ---- STAR (Left) ----
x(1)=1; y(1)=3;
x(2)=0.5; y(2)=4;
x(3)=1; y(3)=4.5;
x(4)=1.5; y(4)=4;
x(5)=1.8; y(5)=3;
x(6)=1.5; y(6)=2;
x(7)=1; y(7)=1.5;
x(8)=0.5; y(8)=2;
x(9)=0.2; y(9)=3;

// ---- RING (Center) ----
theta = 0:%pi/4:2*%pi;
idx = 10:17;
for k = 1:8
    x(idx(k)) = 4 + cos(theta(k));
    y(idx(k)) = 3 + sin(theta(k));
end

// ---- MESH (Right) ----
row = [6 7 8 9];
col = [4 3 2 1];
n = 18;
for i = 1:4
    for j = 1:2
        x(n) = row(i);
        y(n) = col(j);
        n = n + 1;
    end
end

// ===================== DISPLAY TOPOLOGY =====================
scf(1);
clf();

// Draw edges
for k = 1:total_edges
    n1 = edges(k,1);
    n2 = edges(k,2);
    plot([x(n1) x(n2)], [y(n1) y(n2)], "b-");
end

// Draw nodes
plot(x, y, "ro");

// ===================== NUMBER NODES =====================
for i = 1:25
    xstring(x(i)+0.05, y(i)+0.05, string(i));
end

// ===================== NUMBER EDGES =====================
for k = 1:total_edges
    xm = (x(edges(k,1)) + x(edges(k,2))) / 2;
    ym = (y(edges(k,1)) + y(edges(k,2))) / 2;
    xstring(xm, ym, string(k));
end

xtitle("Clean Hybrid Topology (Star + Ring + Mesh)");

// ===================== DEGREE CALCULATION =====================
degree = zeros(1,25);
for k = 1:total_edges
    degree(edges(k,1)) = degree(edges(k,1)) + 1;
    degree(edges(k,2)) = degree(edges(k,2)) + 1;
end

disp("Node Degrees:");
for i = 1:25
    disp("Node " + string(i) + " : " + string(degree(i)));
end

[max_deg, node] = max(degree);
disp("Node with Maximum Degree:");
disp(node);
disp("Maximum Degree:");
disp(max_deg);

disp("Total Nodes:");
disp(25);
disp("Total Edges:");
disp(total_edges);
