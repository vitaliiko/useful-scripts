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
gradle -q dependencies
gradle -q :module:dependencies
```

#### Specific dependency insight
```
gradle dependencyInsight --dependency log4j
gradle :module:dependencyInsight --dependency log4j
```

#### Upgrade Gradle wrapper
```
./gradlew wrapper --gradle-version=7.1
```
