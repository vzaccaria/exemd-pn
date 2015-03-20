{%= name %} {%= badge("fury") %}
================================

> {%= description %}

{%= include("install-global") %}

Additional instructions
-----------------------

Install `dot` or `graphviz` before this plugin.

Short help
----------

`connect` connects an array of named nodes to a single node. One or more
stars `*` after the name of the node mean that one or more tokens are
displayed on the node:

    ```{pn !}
    connect(["invoked", "p*"] ,"x_has_value")
    ```

Will generate this:

![](https://dl.dropboxusercontent.com/u/5867765/tools/exemd/f-dot-0.pdf.png)

You can also add external labels to nodes, such as in:

    ```{pn !}
    add-x-label("invoked*", "bindx\ninvoked")
    connect(["invoked*", "p*"] ,"x_has_value")
    ```

which generates:

![](https://dl.dropboxusercontent.com/u/5867765/tools/exemd/f-dot-1.pdf.png)

Author
------

{%= include("author") %}

License
-------

{%= copyright() %} {%= license() %}

------------------------------------------------------------------------

{%= include("footer") %}
