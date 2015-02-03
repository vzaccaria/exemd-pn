"use strict";

Promise = require('bluebird')
{exec}  = require('shelljs')
uid     = require('uid')

debug = require("debug")("exemd-dot")

cwd = process.cwd()

_module = ->

    var pic-num
    pic-num := 0

    process = (block, opts) ->

      default-is-svg = { 

         cmd: (block, tmp-file, tmp-dir, params) -> 
            block.to("#tmp-dir/#tmp-file.dot")
            return "dot -Tsvg #params '#tmp-dir/#tmp-file.dot'"

         output: (tmp-file, tmp-dir, output) -> output 
         }

      targets = {

        default: default-is-svg

        svg: default-is-svg
        png: {

          cmd: (block, tmp-file, tmp-dir, params) -> 
               block.to("#tmp-dir/#tmp-file.dot")
               return "dot -Tpng #params '#tmp-dir/#tmp-file.dot' | base64"

          output: (tmp-file, tmp-dir, output) -> '\n <img class="exemd--diagram exemd--diagram__dot" src="data:image/png;base64,' + output + '" /> \n'  
        }

        pdf: {
          cmd: (block, tmp-file, tmp-dir, params) ->
            debug("invoked")
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










