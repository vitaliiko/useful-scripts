## Gradle

Clean all dependencies
```bash
rm -rf $HOME/.gradle/caches/
```

Build specific module
```bash
gralde :module:build
```

See dependency tree
```bash
gradle -q dependencies
gradle -q :module:dependencies
```

Specific dependency insight
```bash
gradle dependencyInsight --dependency log4j
gradle :module:dependencyInsight --dependency log4j
```

Upgrade Gradle wrapper
```bash
./gradlew wrapper --gradle-version=8.10
```

Get list of all tasks
```
gradle -q :tasks --all
```
