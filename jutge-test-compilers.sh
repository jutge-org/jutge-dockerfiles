#!/usr/bin/env bash

# Assert exit code 0 and that the file contains exactly "Hello, World!" (bash strips one
# trailing newline from $(cat ...) in [ ], matching typical printf/println output).
function assert_hello_stdout() {
    local out="$1"
    local ec="$2"
    if [ "$ec" -ne 0 ] || [ "$(cat "$out")" != "Hello, World!" ]; then
        echo "🔴 fail"
    else
        echo "✅ pass"
    fi
}

function test_GCC() {
    echo "Testing GCC..."
    cat > hello.c <<'EOF'
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
EOF

    gcc -o hello.c.exe hello.c
    ./hello.c.exe > hello.c.out 2> hello.c.err
    assert_hello_stdout hello.c.out $?
}

function test_GXX() {
    echo "Testing G++..."
    cat > hello.cpp <<'EOF'
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
EOF

    g++ -o hello.cpp.exe hello.cpp
    ./hello.cpp.exe > hello.cpp.out 2> hello.cpp.err
    assert_hello_stdout hello.cpp.out $?
}

function test_Python() {
    echo "Testing Python..."
    cat > hello.py <<'EOF'
print("Hello, World!")
EOF

    python3 hello.py > hello.py.out 2> hello.py.err
    assert_hello_stdout hello.py.out $?
}

function test_Java() {
    echo "Testing Java..."
    cat > Hello.java <<'EOF'
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
EOF

    javac Hello.java
    java Hello > hello.java.out 2> hello.java.err
    assert_hello_stdout hello.java.out $?
}

function test_Bun() {
    echo "Testing Bun..."
    cat > hello.bun.ts <<'EOF'
console.log("Hello, World!")
EOF

    bun hello.bun.ts > hello.bun.out 2> hello.bun.err
    assert_hello_stdout hello.bun.out $?
}

function test_PHP() {
    echo "Testing PHP..."
    cat > hello.php <<'EOF'
<?php
echo "Hello, World!\n";
EOF

    php hello.php > hello.php.out 2> hello.php.err
    assert_hello_stdout hello.php.out $?
}

function test_Julia() {
    echo "Testing Julia..."
    cat > hello.jl <<'EOF'
println("Hello, World!")
EOF

    julia hello.jl > hello.jl.out 2> hello.jl.err
    assert_hello_stdout hello.jl.out $?
}

function test_Haskell() {
    echo "Testing Haskell (GHC)..."
    cat > hello.hs <<'EOF'
main :: IO ()
main = putStrLn "Hello, World!"
EOF

    ghc -o hello.hs.exe hello.hs
    ./hello.hs.exe > hello.hs.out 2> hello.hs.err
    assert_hello_stdout hello.hs.out $?
}

function test_Clojure() {
    echo "Testing Clojure..."
    cat > hello.clj <<'EOF'
(println "Hello, World!")
EOF

    clj -M hello.clj > hello.clj.out 2> hello.clj.err
    assert_hello_stdout hello.clj.out $?
}

function test_Kotlin() {
    echo "Testing Kotlin..."
    cat > hello.kt <<'EOF'
fun main() {
    println("Hello, World!")
}
EOF
    
    kotlinc hello.kt -include-runtime -d hello.kt.jar 
    java -jar hello.kt.jar > hello.kt.out 2> hello.kt.err
    assert_hello_stdout hello.kt.out $?
}

function test_Rust() {
    echo "Testing Rust..."
    cat > hello.rs <<'EOF'
fn main() {
    println!("Hello, World!");
}
EOF
    rustc hello.rs -o hello.rs.exe
    ./hello.rs.exe > hello.rs.out 2> hello.rs.err
    assert_hello_stdout hello.rs.out $?
}

function test_Lua() {
    echo "Testing Lua..."
    cat > hello.lua <<'EOF'
print("Hello, World!")
EOF
    lua hello.lua > hello.lua.out 2> hello.lua.err
    assert_hello_stdout hello.lua.out $?
}

function test_Go() {
    echo "Testing Go..."
    cat > hello.go <<'EOF'
package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}
EOF

    go build -o hello.go.exe hello.go 
    ./hello.go.exe > hello.go.out 2> hello.go.err
    assert_hello_stdout hello.go.out $?
}

function test_Erlang() {
    echo "Testing Erlang..."
    cat > hello.erl <<'EOF'
-module(hello).
-export([main/0]).
main() -> io:format("Hello, World!\n").
EOF
    erlc hello.erl

    erl -noshell -s hello main -s init stop > hello.erl.out 2> hello.erl.err
    assert_hello_stdout hello.erl.out $?
}

function test_Clang() {
    echo "Testing Clang (C)..."
    cat > hello.clang.c <<'EOF'
#include <stdio.h>
int main(void) {
    printf("Hello, World!\n");
    return 0;
}
EOF
    clang -o hello.clang.c.exe hello.clang.c
    ./hello.clang.c.exe > hello.clang.c.out 2> hello.clang.c.err
    assert_hello_stdout hello.clang.c.out $?
}

function test_ClangXX() {
    echo "Testing Clang++ (C++)..."
    cat > hello.clangxx.cpp <<'EOF'
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
EOF
    clang++ -o hello.clangxx.exe hello.clangxx.cpp
    ./hello.clangxx.exe > hello.clangxx.out 2> hello.clangxx.err
    assert_hello_stdout hello.clangxx.out $?
}

function test_CLISP() {
    echo "Testing CLISP..."
    cat > hello.clisp.lisp <<'EOF'
(format t "Hello, World!~%")
EOF
    clisp -q hello.clisp.lisp > hello.clisp.out 2> hello.clisp.err
    assert_hello_stdout hello.clisp.out $?
}

function test_Codon() {
    echo "Testing Codon (Python)..."
    cat > hello.codon.py <<'EOF'
print("Hello, World!")
EOF
    codon build -o hello.codon.exe hello.codon.py
    ./hello.codon.exe > hello.codon.out 2> hello.codon.err
    assert_hello_stdout hello.codon.out $?
}

function test_FBC() {
    echo "Testing FreeBASIC (fbc)..."
    cat > hello.fbc.bas <<'EOF'
Print "Hello, World!"
EOF
    fbc -x hello.fbc.exe hello.fbc.bas
    ./hello.fbc.exe > hello.fbc.out 2> hello.fbc.err
    assert_hello_stdout hello.fbc.out $?
}

function test_GDC() {
    echo "Testing GDC (D)..."
    cat > hello.d <<'EOF'
import std.stdio;
void main() {
    writeln("Hello, World!");
}
EOF
    gdc -o hello.d.exe hello.d
    ./hello.d.exe > hello.d.out 2> hello.d.err
    assert_hello_stdout hello.d.out $?
}

function test_GFortran() {
    echo "Testing GFortran..."
    cat > hello.f90 <<'EOF'
program hello
  print '(A)', 'Hello, World!'
end program hello
EOF
    gfortran -o hello.f90.exe hello.f90
    ./hello.f90.exe > hello.f90.out 2> hello.f90.err
    assert_hello_stdout hello.f90.out $?
}

function test_GNAT() {
    echo "Testing GNAT (Ada)..."
    cat > hello.adb <<'EOF'
with Ada.Text_IO; use Ada.Text_IO;
procedure Hello is
begin
   Put_Line ("Hello, World!");
end Hello;
EOF
    gnatmake -o hello.ada.exe hello.adb
    ./hello.ada.exe > hello.ada.out 2> hello.ada.err
    assert_hello_stdout hello.ada.out $?
}

function test_GObjC() {
    echo "Testing GNU Objective-C (gobjc / gcc)..."
    cat > hello.m <<'EOF'
#include <stdio.h>
int main(void) {
    printf("Hello, World!\n");
    return 0;
}
EOF
    # gobjc package provides GCC with Objective-C; compiling .m selects it.
    gcc -o hello.m.exe hello.m
    ./hello.m.exe > hello.m.out 2> hello.m.err
    assert_hello_stdout hello.m.out $?
}

function test_Nim() {
    echo "Testing Nim..."
    cat > hello.nim <<'EOF'
echo "Hello, World!"
EOF
    nim c -o:hello.nim.exe hello.nim
    ./hello.nim.exe > hello.nim.out 2> hello.nim.err
    assert_hello_stdout hello.nim.out $?
}

function test_Perl() {
    echo "Testing Perl..."
    cat > hello.pl <<'EOF'
print "Hello, World!\n";
EOF
    perl hello.pl > hello.perl.out 2> hello.perl.err
    assert_hello_stdout hello.perl.out $?
}

function test_R() {
    echo "Testing R..."
    cat > hello.R <<'EOF'
cat("Hello, World!\n")
EOF
    Rscript hello.R > hello.R.out 2> hello.R.err
    assert_hello_stdout hello.R.out $?
}

function test_Ruby() {
    echo "Testing Ruby..."
    cat > hello.rb <<'EOF'
puts "Hello, World!"
EOF
    ruby hello.rb > hello.ruby.out 2> hello.ruby.err
    assert_hello_stdout hello.ruby.out $?
}

function test_Zig() {
    echo "Testing Zig..."
    cat > hello.zig <<'EOF'
const std = @import("std");

pub fn main() !void {
    try std.io.getStdOut().writer().print("Hello, World!\n", .{});
}
EOF
    zig build-exe hello.zig -femit-bin=hello.zig.exe
    ./hello.zig.exe > hello.zig.out 2> hello.zig.err
    assert_hello_stdout hello.zig.out $?
}


test_GCC
test_GXX
test_Python
test_Java
test_Bun
test_PHP
test_Julia
test_Haskell
test_Clojure
test_Kotlin
test_Rust
test_Lua
test_Go
test_Erlang
test_Clang
test_ClangXX
test_CLISP
test_Codon
test_FBC
test_GDC
test_GFortran
test_GNAT
test_GObjC
test_Nim
test_Perl
test_R
test_Ruby
test_Zig