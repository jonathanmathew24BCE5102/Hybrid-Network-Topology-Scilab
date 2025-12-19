clc;
clear;
xdel(winsid());

// -------------------- STAR TOPOLOGY --------------------
star_nodes = 1:10;
star_edges = [];
for i = 2:10
    star_edges = [star_edges; 1 i];
end

// -------------------- RING TOPOLOGY --------------------
ring_nodes = 11:18;
ring_edges = [];
for i = 11:17
    ring_edges = [ring_edges; i i+1];
end
ring_edges = [ring_edges; 18 11];

// -------------------- MESH TOPOLOGY --------------------
mesh_nodes = 19:25;
mesh_edges = [];
for i = 19:25
    for j = i+1:25
        mesh_edges = [mesh_edges; i j];
    end
end

// -------------------- HYBRID CONNECTIONS --------------------
hybrid_links = [5 11; 15 19];

// -------------------- COMBINE ALL EDGES --------------------
edges = [star_edges; ring_edges; mesh_edges; hybrid_links];

// -------------------- CREATE GRAPH --------------------
G = graph(edges(:,1), edges(:,2));

// -------------------- DISPLAY GRAPH --------------------
scf(1);
plot(G);
title("Hybrid Network Topology (Star + Ring + Mesh)");

// -------------------- NODE & EDGE NUMBERING --------------------
G.node_number = 1:G.nv;
G.edge_number = 1:G.ne;

// -------------------- COLOR NODES & EDGES --------------------
G.node_color = rand(1, G.nv) * 32;
G.edge_color = rand(1, G.ne) * 32;

// -------------------- DEGREE OF EACH NODE --------------------
degrees = degree(G);
disp("Node Degrees:");
disp(degrees);

// -------------------- NODE WITH MAXIMUM EDGES --------------------
[max_degree, node] = max(degrees);
disp("Node with Maximum Degree:");
disp(node);
disp("Maximum Degree:");
disp(max_degree);

// -------------------- TOTAL NODES & EDGES --------------------
disp("Total Number of Nodes:");
disp(G.nv);

disp("Total Number of Edges:");
disp(G.ne);
