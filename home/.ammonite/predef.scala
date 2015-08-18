///////////////////////////////////////////////////////////////////////////////
// .ammonite/predef.scala
//
// Configuration file which will be executed the first thing when the Ammonite
// REPL is loaded
//
// Ammonite is a cleanroom re-implementation of the Scala REPL from first
// principles. It is much more featureful than the default REPL and comes with
// a lot of ergonomic improvements and configurability that may be familiar to
// people coming from IDEs or other REPLs such as IPython or Zsh. It can be
// combined with Ammonite-Ops to replace Bash as your systems shell, but also
// can be used alone as a superior version of the default Scala REPL, or as a
// debugging tool.
//
// Ammonite-Ops is a library to make common filesystem operations in Scala as
// concise and easy-to-use as from the Bash shell, while being robust enough to
// use in large applications without getting messy. It lives in the same repo
// as the Ammonite REPL, but can easily be used stand-alone in a normal
// SBT/maven project.
//
// http://lihaoyi.github.io/Ammonite/
// https://github.com/lihaoyi/ammonite
// http://tinyurl.com/beyondbash
// https://news.ycombinator.com/item?id=10068058
///////////////////////////////////////////////////////////////////////////////


// import Ammonite-Ops for all global REPL instances.
import ammonite.ops._
