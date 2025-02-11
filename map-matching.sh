

if [ "$JAVA" = "" ]; then
 JAVA=java
fi

if [ "$1" = "action=start-server" ]; then
  function set_jar_path {
    JAR=$(ls matching-web/target/map-matching-web-*-dependencies.jar)
  }

  set_jar_path

  if [ ! -f "$JAR" ]; then
    mvn --projects matching-web,matching-core -DskipTests=true install assembly:single
    set_jar_path
  fi
  
  ARGS="graph.location=./graph-cache"
  
else
  function set_jar_path {
    JAR=$(ls matching-core/target/map-matching-*-dependencies.jar)
  }

  set_jar_path

  if [ ! -f "$JAR" ]; then
    mvn --projects matching-core -DskipTests=true install assembly:single
    set_jar_path
  fi
  
  ARGS="$@"
fi

exec "$JAVA" $JAVA_OPTS -jar $JAR $ARGS
