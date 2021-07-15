# An Autonomous Chess Playing Robot
The objective of this project is to bring the convenience of digital chess to a physical chess board. Whether your or not your opponent is a human, many players would prefer playing on a physical chess board.

![image](https://user-images.githubusercontent.com/60051148/124351373-7cfe0680-dc02-11eb-969f-93b719262e02.png)

The players in the advert are playing with the board rotated at 90 degrees, so that they can match each others’ moves more easily. For less experienced players this might distract from the game. The solution is an autonomous chess playing robot. A key aim is that the experience of playing against an autonomous robot must not be inferior to playing online. The system must pass a ”chess Turing test”, it must read, calculate and make moves at least as well as human.

![image](https://user-images.githubusercontent.com/60051148/124351174-7a4ee180-dc01-11eb-8baf-f94b6d7a1248.png)
                   Computer-aided design model
![image](https://user-images.githubusercontent.com/60051148/124351189-8f2b7500-dc01-11eb-9bbc-afd59376e067.png)
                   Prototype model

This repository contains the MATLAB computer vision files that I wrote in order to convert a video feed into chess algebraic notation. This was then fed into a chess engine, and the outputs were used with precalculated inverse kinematics in order to move the chess pieces. The hardware and software were designed from first principles.

Design:
A 3 D.O.F design was chosen, with 2 revolute joints, 1 prismatic and an electromagnet end effector. The inverse kinematics can be calculated geometrically:

![image](https://user-images.githubusercontent.com/60051148/124351591-edf1ee00-dc03-11eb-9abe-d15c69aeea0e.png)

![image](https://user-images.githubusercontent.com/60051148/124351586-e7637680-dc03-11eb-90eb-d33c7d963238.png)

The manipulator comprises of 6 joints, 1 prismatic joint between b and d and 5 revolute joints.

Find out more: https://pierretabet.com/helping-hand
