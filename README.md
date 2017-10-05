## Dancer2 sample app

 This is a very trivial "hello, world" demonstration of using Dancer 2 to serve GraphQL.

### To use:

```
    cpanm --installdeps .
    plackup bin/app.psgi
```

Point your browser at http://localhost:5000

After clicking through to the GraphiQL tool, try entering this query in the upper left-hand pane:

```
{ helloWorld }
```

## Acknowledgements

A complete revamp of this applet, simplifying, clarifying and adding a
test, was contributed by Nick Tonkin https://github.com/1nickt
