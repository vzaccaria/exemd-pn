```{pn !}
connect(["invoked", "p*"] ,"x_has_value")
```


```{pn !}
add-x-label("p1*", "p1")
add-x-label("p2*", "p2")
add-x-label("p3", "p3")
connect(["p1*", "p2*"] ,"p3")
```

```{pn !}
connect(["p0*", "p*"] ,["p1*", "p2"])
connect(["p1*", "p2"] ,"p3")
```
