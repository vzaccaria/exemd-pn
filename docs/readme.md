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

You can also add external labels to nodes with `add-x-label`, such as
in:

    ```{pn !}
    add-x-label("p1*", "p1")
    add-x-label("p2*", "p2")
    add-x-label("p3*", "p3")
    connect(["p1*", "p2*"] ,"p3")
    ```

which generates:

![](https://dl.dropboxusercontent.com/u/5867765/tools/exemd/f-dot-1.pdf.png)

You can also have an array of node names as a destination of a
transition:

    ```{pn !}
    connect(["p0*", "p*"] ,["p1*", "p2"])
    connect(["p1*", "p2"] ,"p3")
    ```

    which generates:

![](https://dl.dropboxusercontent.com/u/5867765/tools/exemd/f-dot-2.pdf.png)

Author
------

* Vittorio Zaccaria

License
-------

{%= copyright() %} {%= license() %}

------------------------------------------------------------------------

{%= include("footer") %}
