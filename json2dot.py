#!/usr/bin/python
# -*- coding: utf-8 -*-

#
#  File Name	: json2dot.py
#  Author	: Steve NGUYEN
#  Contact      : steve.nguyen.000@gmail.com
#  Created	: mercredi, novembre 28 2018
#  Revised	:
#  Version	:
#  Target MCU	:
#
#  This code is distributed under the GNU Public License
# 		which can be found at http://www.gnu.org/licenses/gpl.txt
#
#
#  Notes:	Quick and dirty hack
#           python json2dot.py  > output.dot
#           dot -Tps2 output.dot -o outfile.pdf
#
# from pygraphviz import *

from graphviz import Digraph
import json
import sys
import copy
import os

COLORS=["red", "pink", "blue", "green", "orange", "cyan", "magenta", "purple"]

class Pipeline:
    def __init__(self, jsonfilename):
        self._jsonfilename=jsonfilename
        self._jsonfile=open(sys.argv[1])
        self._pipeline=json.loads(self.clean_comments(self._jsonfile))
        self._graph=Digraph()
        self._color_it=0

    def clean_comments(self, f):
        jj=''
        for l in f.readlines():
            if l.find('//')<0: #just to remove the comments
                jj+=l
        f.close()
        return jj

    def get_pipeline(self):
        for p in self._pipeline["pipeline"]["paths"]:
            f=open(os.path.dirname(os.path.dirname(self._jsonfilename))+'/'+p)
            j=json.loads(self.clean_comments(f))
            # self._graph.append(self.get_filters(j))
            self.get_filters(j, os.path.basename(p))

    def get_filters(self, subpipe, name):
        # subtree = Digraph()
        color=COLORS[self._color_it]
        self._color_it+=1
        subtree=self._graph
        for f in subpipe:
            # print(f)
            subtree.node(f["content"]["name"], 'Name: '+f["content"]["name"]+'\nClass: '+f["class name"] , color=color)
            for d in f["content"]["dependencies"]:
                subtree.edge(d,f["content"]["name"])
        # print(subtree)
        return subtree
    def print_graph(self):
        for g in self._graph:
            print(g)


if __name__=='__main__':

    if len(sys.argv)==1:
        print "Usage : python json2dot.py path_to_all.json"
        sys.exit(1)

    p=Pipeline(sys.argv[1])
    p.get_pipeline()
    p.print_graph()



