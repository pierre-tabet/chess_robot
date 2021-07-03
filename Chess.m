

clc;    % Clear command window
close all;  % Close all the figures
clear;  % Erase all existing variables
workspace;
%%
load('C:/Users/Pierre/Documents/MATLAB/Detection/imagePoints.mat');
load('C:/Users/Pierre/Documents/MATLAB/Detection/net2.mat');
load('C:/Users/Pierre/Documents/MATLAB/Detection/anglesx.mat');
stockexe='C:\Users\Pierre\Documents\MATLAB\ChessMaster\engines\stockfish_20011801_x64_modern.exe';
pypath='C:\Users\Pierre\Documents\MATLAB\Detection\pystock.py'; %path where the pystock file is located
%%
cam = webcam('Logitech');

%chess grid
%namesquare=["h1","h2","h3","h4","h5","h6","h7","h8","g1","g2","g3","g4","g5","g6","g7","g8","f1","f2","f3","f4","f5","f6","f7","f8","e1","e2","e3","e4","e5","e6","e7","e8","d1","d2","d3","d4","d5","d6","d7","d8","c1","c2","c3","c4","c5","c6","c7","c8","b1","b2","b3","b4","b5","b6","b7","b8","a1","a2","a3","a4","a5","a6","a7","a8"];
%initialize game status
namesquare=["h8","h7","h6","h5","h4","h3","h2","h1","g8","g7","g6","g5","g4","g3","g2","g1","f8","f7","f6","f5","f4","f3","f2","f1","e8","e7","e6","e5","e4","e3","e2","e1","d8","d7","d6","d5","d4","d3","d2","d1","c8","c7","c6","c5","c4","c3","c2","c1","b8","b7","b6","b5","b4","b3","b2","b1","a8","a7","a6","a5","a4","a3","a2","a1"];

gamestatus=repmat(["Red","Red","Empty","Empty","Empty","Empty", "Green", "Green"],[1,8]);
castled=0;
moves=[];
gamestate = 1;
skill_level = 20; %0 - 20 difficulty

while gamestate==1 %while neither side has won
    input('Press enter once you take your turn')
    I = snapshot(cam); %Takes picture of board;
    img = imrotate(I,180,'bilinear');  %Rotates image 180;
    clear from to computer_move comp comp_from comp_to
    changes=0;
    froms=[];
    tos=[];
    newstatus=strings([1,64]);
    turn_taken=0;
    computer_castled=0
    for a = 1:64 %for each tile on the board
        label = classify(net,imcrop(img,[imagePoints(a,1) imagePoints(a,2) 46 46])); %get status of that tile
        newstatus(a)=label; %save this to the new gamestate
        if gamestatus(a)~=label %if the state of this tile has changed
            changes=changes+1;
            if strfind(gamestatus(a),'Red')==1 & label ~= 'Green' %if a red tile has moved, something is wrong
                warning('Warning: you did not properly move for the computer player')
                continue
            elseif label=='Empty' %if this tile is newly empty, it is where the piece moved from
                from=namesquare(a);
                froms=[froms,from];
                turn_taken=1;
            else %if this tile is newly filled, it is where the piece moved to
                to=namesquare(a);
                tos=[tos,to];
            end
        end
    end
    if ~turn_taken
        warning("Warning: you must take your turn")
        continue
    end
    if castled==0 & length(froms)==2 %if castling has not occurred and this was a castling
        from='d1'; %where the king moved from;
        if any(tos=="b1")%finding where the king moved to
            to="b1";
        elseif any(tos=="f1")
            to="f1";
        end
    end
    playermove=strcat(from,to); %the player's move
    disp(['Your move is', switchnums(playermove)])
    moves=[moves,playermove]; %add it to the move list
    computer_move=string(py.pystock.use_stockfish(py.list(cellstr(moves)),py.str(stockexe),skill_level)); %get the computer's move
    if computer_move=="Game Over" %check if the game ended
        disp("The game is over!")
        gamestate=0;
    elseif computer_move=="Invalid" %check if the player tried an invalid move
        disp("You have selected an invalid move, please try again")
        continue
        moves=moves(1:end-1);
    else
        disp(['The computer move is', switchnums(computer_move)])
        moves=[moves,computer_move];
    end
    %add castling capability for computer player
    gamestatus=newstatus;
    comp=char(computer_move);
    comp_from=comp(1:2);
    gamestatus(find(namesquare==comp_from))='Empty';
    comp_to=comp(3:4);
    gamestatus(find(namesquare==comp_to))='Red';
    from_angle=anglesx(find(namesquare==comp_from),:)
    to_angle=anglesx(find(namesquare==comp_to),:)
    if gamestate(find(namesquare==comp_to))=='Green'
        %move from to angle to bin
    end
    %move piece
    if computer_castled==0 & comp_from=="d8" & (comp_to=="b8" | comp_to=="f8")
        computer_castled=1
        if comp_to=="b8"
            gamestatus(find(namesquare=="a8"))=="Empty"
            gamestatus(find(namesquare=="c8"))=="Red"
            %move rook
        elseif comp_to=="f8"
            gamestatus(find(namesquare=="h8"))=="Empty"
            gamestatus(find(namesquare=="e8"))=="Red"
            %move the rook
        end
    end
end

