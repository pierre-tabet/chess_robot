# -*- coding: utf-8 -*-
"""
Created on Sun Jun  7 16:19:43 2020

@author: Di Lorenzo Tech
"""
from stockfish import Stockfish

def use_stockfish(moves,path,skill_level):
    stock=Stockfish(path,parameters={"Skill Level": skill_level})
    stock.set_position(moves[0:-1])
    if stock.is_move_correct(moves[-1])==False:
        comp="Invalid"
    else:
        stock.set_position(moves)
        comp=stock.get_best_move()
    if comp is None:
        comp="Game Over"
    return comp