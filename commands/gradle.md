#### Clean all dependencies
```
rm -rf $HOME/.gradle/caches/
```

#### Build specific module
```
gralde :module:build
```

#### See dependency tree
```
gradle :module -q dependencies
```
