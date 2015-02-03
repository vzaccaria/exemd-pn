"use strict";

_ = require('lodash')
Promise = require('bluebird')
{exec}  = require('shelljs')
uid     = require('uid')
live    = require('livescript')
debug   = require("debug")("exemd-pn")

cwd = process.cwd()

global.api = ->
  "ciao"

var nodes
var arcs

nodes := {}
arcs := [ ] 

global.label = (n) ->
  discs = (n.match(/\*/g) || []).length
  usename= (n.match(/\!/g) || []).length
  debug "#n - #discs"
  if discs > 0
    return "label=\"&\#9679;\""
  else 
    if usename > 0
      return "label=\"#{n.replace(/\!/g, "")}\""
    else
      return "label=\"\""

circle = (n) ->
  "[ fixedsize=true, #{label(n)}, width=0.3, shape=\"circle\" ]"

global.connect = (a,b) ->
        c = uid(3)
        if not _.is-array(a)
          a := [ a ]

        for n in a
          nodes[n] := circle(n)
          arcs := arcs ++ [ { source: n, dest: c } ]

        nodes[b] := circle(n)
        nodes[c] := "[ style=\"filled\", fillcolor=black, label=\"\", shape=\"rectangle\", width=0.5,  height=0.03 ]"
        arcs := arcs ++ [ { source: c, dest: b } ]

        debug arcs
        debug nodes

global.generate = ->
    debug nodes
    s = ""
    for name, value of nodes 
      s := s + " \"#name\" #value \n " 

    for x in arcs 
        s := s + " \"#{x.source}\" -> \"#{x.dest}\" [ arrowsize=0.5 ] \n"

    debug s
    return s;



gen-dot = (code) ->
  debug "compiling #code"
  code =  """
          #code
          return \"\"\"
              digraph g {
                graph [];
                \#{generate!}
              }
          \"\"\"
          """
  f = live.compile code
  debug f
  v = eval(f)
  debug v
  return v

_module = ->

    var pic-num
    pic-num := 0

    process = (block, opts) ->

      default-is-svg = { 

         cmd: (block, tmp-file, tmp-dir, params) -> 
            block = gen-dot(block)
            block.to("#tmp-dir/#tmp-file.dot")
            return "dot -Tsvg #params '#tmp-dir/#tmp-file.dot'"

         output: (tmp-file, tmp-dir, output) -> output 
         }

      targets = {

        default: default-is-svg

        svg: default-is-svg
        png: {

          cmd: (block, tmp-file, tmp-dir, params) -> 
               block = gen-dot(block)
               block.to("#tmp-dir/#tmp-file.dot")
               return "dot -Tpng #params '#tmp-dir/#tmp-file.dot' | base64"

          output: (tmp-file, tmp-dir, output) -> '\n <img class="exemd--diagram exemd--diagram__dot" src="data:image/png;base64,' + output + '" /> \n'  
        }

        pdf: {
          cmd: (block, tmp-file, tmp-dir, params) ->
            debug("invoked")
            block = gen-dot(block)
            block.to("#tmp-dir/#tmp-file.dot")

            cc = [
              "dot -Tsvg #params '#tmp-dir/#tmp-file.dot' > '#tmp-dir/#tmp-file.svg'"
              "mkdir -p '#cwd/figures'"
              "cat '#tmp-dir/#tmp-file.svg' | rsvg-convert -z 0.5 -f pdf > '#cwd/figures/f-dot-#{pic-num}.pdf'"
              "echo '#cwd/figures/f-dot-#{pic-num}.pdf'"
            ]
            pic-num := pic-num + 1
            return cc * ' && '

          output: (tmp-file, tmp-dir, output) ->
             fname = output
             return "![](#fname)"

        }
        
      }

      opts.plugin-template(targets, block, opts)

    iface = {
      process: process
    }
              
    return iface
               
module.exports = _module()










