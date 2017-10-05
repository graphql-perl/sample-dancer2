## Dancer2 sample app

 This is a very trivial "hello, world" demonstration of using Dancer 2 to serve GraphQL.

### To use:

```
    cpanm --installdeps .
    plackup bin/app.psgi
```

then point your browser at http://localhost:5000

Now try entering this query in the upper left-hand pane:

```
{ helloWorld }
```
