---
sort: 6
---

# Debugging solids4foam

---

Prepared by Ali Bozorgzadeh and Philip Cardiff

---

## Section Aims

This section aims to:

1. Introduce and motivate debugging OpenFOAM
1. Setting Up debugging tools and compiling OpenFOAM in debug mode
1. Basic debugging with GDB/LLDB

---

## Introduction

<!-- markdownlint-disable MD033 -->
> Frame by frame (suddenly)<br>
> Death by drowning (from within)<br>
> In your own, in your own analysis<br>
>
> Step by step (suddenly)<br>
> Doubt by numbers (from within)<br>
> In your own, in your own analysis
> &emsp;&emsp;&mdash;_King Crimson, Frame By Frame, 1981_
<!-- markdownlint-enable MD033 -->

OpenFOAM users face many errors in their journey. Sometimes the error message is
unhelpful and doesn't give any clue. Other times the program crashes and prints
a stack trace similar to below.

<!-- markdownlint-disable MD013 -->
```txt
#0 Foam::error::printStack(Foam::-Ostream&) in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libOpenFOAM.so"
#1 Foam::sigFpe::sigFpeHandler(int) in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libOpenFOAM.so"
#2 Uninterpreted: [0xb7f8b420]
#3 Foam::divide(Foam::Field<double>&, Foam::UList<double> const&, Foam::UList<double> const&) in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libOpenFOAM.so"
#4 void Foam::divide<foam::fvpatchfield,>(Foam::GeometricField<double,>&, Foam::GeometricField<double,> const&, Foam::GeometricField<double,> const&) in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libincompressibleTurbulenceModels.so"
#5 Foam::tmp<foam::geometricfield<double,> > Foam::operator/<foam::fvpatchfield,>(Foam::tmp<foam::geometricfield<double,> > const&, Foam::GeometricField<double,> const&) in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libincompressibleTurbulenceModels.so"
#6 Foam::turbulenceModels::kEpsilon::correct() in "/home/<user>/OpenFOAM/OpenFOAM-1.4.1/lib/linuxGccDPOpt/libincompressibleTurbulenceModels.so"
...
```
<!-- markdownlint-enable MD013 -->

This is, perhaps, where OpenFOAM's self-discoveribility plummets to zero and the
famous
[banana trick](https://openfoamwiki.net/index.php/OpenFOAM_guide/Use_bananas)
can no longer save the day. Many resort to trial and error, rerunning
simulations blindly—often without understanding what went wrong.

But what really happened? How do we go beyond such arcane and seemingly unhelpful
errors and extract valuable debugging information?

```note
**Stack Trace**: A stack trace is a list of function calls that were made in the
program leading up to the point where the program crashed or encountered an
error. It typically starts from the function where the error occurred (with
frame number 0) and goes back in time, with each successive function call having
a higher frame number. The stack trace helps in identifying the sequence of
function calls that led to the error, making it a valuable tool for debugging.

**Frame/Stack**: A frame (or stack frame) refers to a single entry in the call
stack, representing a function call and its associated information, such as
local variables, return address, and parameters. The call stack is a data
structure that stores these frames in a _last-in, first-out_ (_LIFO_) order.
When a function is called, a new frame is pushed onto the stack. When the
function returns, its frame is popped off the stack. The stack grows and shrinks
as functions are called and return, and it can be used to trace the flow of
program execution.
```

```note
Such stack traces are emitted by the runtime when a common error occurs, such
as:

- **Floating-point exceptions (FPEs)**: Divide-by-zero, invalid mathematical
  operations (e.g., 1/0).
- **Segmentation faults (SIGSEGV)**: Dereferencing a null or uninitialized
  pointer.
- **Memory corruption**: Accessing freed memory, buffer overflows.
- **Infinite loops & unresponsive solvers**: Simulation hangs indefinitely due
  to logic errors.

While the stack trace provides function call information, it is often difficult
to pinpoint the root cause directly from it. OpenFOAM's templated and
inline-heavy C++ codebase further complicates debugging. However, we are not
powerless—with the right tools, we can systematically diagnose and fix these
issues.
```

## Debugging in OpenFOAM

OpenFOAM is a [Free and Open-Source
Software](https://en.wikipedia.org/wiki/Free_and_open-source_software) project.
This means that whenever our solver crashes, whether it prints a long stack
trace, throws a segmentation fault, or even fails silently, we have full access
to its internals to debug it. Unlike closed-source software, we are not limited
to cryptic error messages. We can:

- Inspect OpenFOAM's source code and understand how a function behaves.
- Recompile solvers with debugging symbols enabled.
- Attach interactive debuggers like GDB (GNU Debugger) or LLDB to step through
  the code in real-time.

OpenFOAM developers have three main methods for debugging:

1. `Info` Statements

    - This is the simplest form of debugging, used to locate approximately where
      an issue occurs.
    - While useful for quick debugging, it is often not enough for complex issues.

1. Debug Switches (`$WM_PROJECT_DIR/etc/controlDict`)

    - OpenFOAM provides built-in debug switches that allow finer control over
      solver execution.
    - These are useful for logging additional details but require prior setup.

1. Interactive Debugging with GDB/LLDB (Our Focus)

    - This method provides full control over the running process.
    - It allows us to step through the code, find where exactly the application
      crashes, inspect variable values, and even modify them at runtime to test
      different conditions.

In this section, we will focus on the third method, using `gdb` and `lldb` to
systematically diagnose and fix OpenFOAM crashes.

```note
Debuggers are more than just tools for fixing errors; they provide deep insight
into code execution, making it easier to diagnose issues, optimize performance,
and understand complex software.

"I don't like debuggers. Never have, probably never will. I use gdb all the
time, but I tend to use it not as a debugger, but as a disassembler on
steroids that you can program."
—[_Linus Torvalds, 6 Sep 2000_](https://lkml.org/lkml/2000/9/6/65)
```

---

## Setting Up OpenFOAM for Debugging

OpenFOAM is typically compiled with optimizations enabled for performance
reasons. Optimizations are compiler techniques that rearrange, eliminate, and
even transform code (while maintaining code semantics) to make it run faster.
However, these optimizations drastically alter the relationship between the
compiled machine code and the original source code. This makes it very difficult
for a debugger to correlate the machine instructions with the corresponding
lines of C++ code, variable names, and function calls. Therefore, to effectively
utilize GDB or LLDB for debugging, it's crucial to recompile OpenFOAM in debug
mode. This compilation process with debug flags is essential for unlocking the
power of debuggers, injecting extra information into the compiled code. Without
these flags, the debugger can only present disassembly of the optimized code,
which does not map to the original source code, rendering debugging nearly
impossible. Compiling OpenFOAM in debug mode instructs the compiler to

1. Disable optimizations (`-O0`): Ensures that the generated code closely
   matches the source, making debugging easier and preventing optimizations that
   could alter variable lifetimes or control flow.
1. Include debugging symbols (`-g`, `-ggdb3`, `-glldb`): Embeds debugging
   information in the binary, enabling debuggers to provide detailed insights
   into the code, including variable names, line numbers, and stack traces.
1. Define OpenFOAM-specific macros (`-DFULLDEBUG`): Activates additional runtime
   checks in the code, such as bounds checking and assertions, which help
   identify issues during development and testing.

There are two main approaches to compile in debug mode:

### 1. Compile All of OpenFOAM in Debug Mode

To rebuild the entire OpenFOAM environment with debugging enabled, we modify the
**`WM_COMPILE_OPTION`** environment variable.

By default, OpenFOAM is built with `Opt` (optimized mode), but we can switch to
`Debug` mode by editing the OpenFOAM startup script, `WM_PROJECT_DIR/etc/bashrc`:

<!-- markdownlint-disable MD013 -->
```sh
cp "$WM_PROJECT_DIR"/etc/bashrc{,.debug}
sed -E -i 's/(export WM_COMPILE_OPTION=)Opt/\1Debug/' "$WM_PROJECT_DIR"/etc/bashrc.debug
echo "alias ofdebug='source $WM_PROJECT_DIR/etc/bashrc.debug'" >> ~/.bashrc # or ~/.zshrc
```
<!-- markdownlint-enable MD013 -->

This allows us to switch between optimized and debug builds conveniently:

- Run `of` to source OpenFOAM normally (optimized mode).
- Run `ofdebug` to switch to debug mode.

Once in debug mode, we can recompile OpenFOAM with:

```sh
ofdebug
foam
./Allwmake -j$(nproc)  # Rebuild OpenFOAM in debug mode
```

This method is useful when debugging core OpenFOAM functionalities, but it takes
significantly more disk space and compilation time. Additionally, not only does
the final executable run much slower, but it also runs even slower when executed
through a debugger.

### 2. Compile Only a Specific Application in Debug Mode

If we only need debugging for a specific solver or application, we can recompile
just that component without rebuilding the entire OpenFOAM environment.

1. First, switch to debug mode:

   ```sh
   ofdebug
   ```

1. Navigate to the solver source directory (e.g., `laplacianFoam`):

   ```sh
   sol
   cd basic/laplacianFoam
   ```

1. Clean previous builds and compile with debugging enabled:

   ```sh
   wclean && wmake
   ```

This method is **faster and more efficient**, as it avoids recompiling the
entire OpenFOAM library. However, we won't be able to step inside OpenFOAM's
libraries.

```note
Other debugging flags not included by OpenFOAM can be added either by including
them in `Make/options` for local projects or by altering the rules defined in
`$WM_DIR/rules` globally.

Also, starting with OpenFOAM v2206, users can

1. Enable debugging by passing the `-debug` option to `wmake`

    ~~~sh
    wmake -debug
    ~~~

    This avoids editing the `Make/options` file.

1. The `FOAM_EXTRA_CXXFLAGS` are now appended at the end of the compile line,
   making it easier to override preceeding flags.
```

---

## The Debugging Process

Now, it's time to dive into the actual debugging process. In this section, we
will demonstrate how to debug OpenFOAM solvers using two popular debugging
tools: **GDB** (GNU Debugger) and **LLDB** (LLVM Debugger).

```note
For simplicity, we will focus on debugging the serial version of a solver. While
parallel or multi-thread executions introduce additional complexities, the core
principles and commands we discuss apply to both serial and parallel runs.
However, some bugs, particularly those related to race conditions or
synchronization, only manifest in parallel runs, so debugging serial code alone
may not catch all issues.
```

```note
From here on, since there are two debuggers, we differentiate between their
commands by their prompts. Lines starting with `(gdb)` denote GDB commands, and
those starting with `(lldb)` represent LLDB commands. If a command is the same
for both debuggers, we omit the prompt.
```

### Getting Started with Debugging

To begin debugging, we need to run the solver within the debugger. On Linux, you
can use either GDB or LLDB, whereas on macOS, only LLDB is available.

1. **Launch the Debugger**

    To start debugging, we need to run our solver inside a debugger.

    ```sh
    > gdb laplacianFoam
    > gdb --args laplacianFoam -case /path/to/case -otherOptions

    > lldb laplacianFoam
    > lldb -- laplacianFoam -case /path/to/case -otherOptions
    ```

    ```note
    To prevent `gdb` from printing its banner information on startup, use the
    `-q` or `--quiet` option.
    ```

    If you forget to specify the executable before starting the debugger, you
    can set it inside the debugger using:

    ```txt
    (gdb)  file laplacianFoam
    (lldb) target create laplacianFoam
    ```

1. **Set Breakpoints**: Breakpoints pause execution at specific lines of code.

    ```txt
    # Set a breakpoint at a function
    (gdb)  break main  # b main
    (lldb) breakpoint set --name main  # b main

    # Set a breakpoint at a specific line in a specific file
    (gdb)  break pEqn.H:150  # b pEqn.H:150
    (lldb) breakpoint set --file pEqn.H --line 150  # b pEqn.H:150

    # Set a breakpoint at a specific line in the current file
    (gdb)  break 42  # b 42
    (lldb) breakpoint set --line 42  # b 42

    # List breakpoints
    (gdb)  info breakpoints
    (lldb) breakpoints list
    ```

    ```note
    There are various ways to set a breakpoint (including conditional
    breakpoints, etc.). Additionally, breakpoints can be enabled, disabled, and
    deleted.
    ```

1. **Run the Solver**: After setting breakpoints, we can start the solver using
   the `run` command:

    <!-- markdownlint-disable MD013 MD046 -->
    ```txt
    run # or r

    # If your solver requires arguments (e.g., case directory), provide them after
    run -case /path/to/case -otherOptions
    ```
    <!-- markdownlint-enable MD013 MD046 -->

    The debugger will execute the program and stop at the breakpoints we've set,
    allowing us to inspect the state of the program.

    <!-- markdownlint-disable MD046 -->
    ```note
    For added convenience, GDB offers the `start` command, which automatically
    sets a _temporary_ breakpoint at the beginning of the `main()` function and
    initiates program execution up to that point.
    ```
    <!-- markdownlint-enable MD046 -->

1. **Control Execution**:

    - **Continue**: Resume execution until the next breakpoint or program
      termination: `c` or `continue`
    - **Next**: Execute the next line of code, stepping over function calls:
      `next` or `n`
    - **Step**: Execute the next line of code, stepping into function calls:
      `step` or `s`
    - **Finish**: Execute until the current function returns: `finish`
    - **List**: Displays the source code around the current line of execution:
      `list` or `l`

1. **Inspect Variables**: Once execution stops at a breakpoint, we can inspect
   the values of variables and check if anything seems wrong. This part of
   debugging can help detect memory corruption or unexpected values. We can

    - **Print the value of a variable**:

      ```txt
      # Check the pressure value at a cell.
      print U[cellI]  # p U[cellI]
      ```

    - **Print the type of a variable**:

      ```txt
      (gdb)  ptype phi
      (lldb) type phi
      ```

    - **Display the contents of an array**:

      ```txt
      # arrayName@numberOfElements
      (gdb)  p U.internalField().component(0)@10

      # arrayName[range]
      (lldb) expr -- U.internalField().component(0)[0:10]
      ```

    - **Checking Memory**: Check local variables and memory usage.

      ```txt
      (gdb)  info locals
      (lldb) frame variable
      ```

    - We can also change the value of a variable at runtime:

      ```txt
      (gdb)  set p[cellI] = 1.0
      (lldb) expr p[cellI] = 1.0
      ```

1. **Examine the Call Stack**: When the solver crashes, for example as a result
   of a segfault, the debugger will halt execution, and you can use `backtrace`
   to see where the crash originated.

    - **View the call stack (backtrace)**: This shows the sequence of function
      calls leading to the current point of execution.

      ```txt
      (gdb)  backtrace # bt
      (lldb) bt
      ```

    - **View details about the current stack**: Provides information about
      memory addresses, saved registers, and the function's location in the call
      stack.

      ```txt
      (gdb)  info frame
      (lldb) frame info
      ```

    - **Navigate through the call stack**: Move up or down the call stack to
      examine variables in different functions:

      ```txt
      # Switch to frame <index>
      (gdb)  frame <n>  # f <index>
      (lldb) frame select <index>  # f <index>

      # Move up/down one level in the stack
      up
      down
      ```

    - OpenFOAM often handles runtime errors by printing messages to standard
      output and then exiting. This prevents a crash, making a backtrace
      unavailable. To capture the call stack before exit, set breakpoints on
      `exit` and `_exit`.

      ```txt
      b exit
      b _exit
      r
      bt
      ```

1. **Watch Variables**: Set a "watchpoint" to halt execution when a variable's
   value changes:

    ```txt
    (gdb) watch p[cellI]
    ```

1. **Quit Debugger**: `quit` or `q`

### **Handling macOS M1 Chips**

On macOS, particularly with M1 chips, the default `lldb` installation may be
restricted by Apple's System Integrity Protection (SIP), which prevents certain
environment variables from being passed. You can resolve this by using one of
the following approaches:

1. **Update `DYLD_LIBRARY_PATH` within `lldb`:**
<!-- markdownlint-disable MD013 -->
   ```txt
   > lldb solids4Foam
   (lldb) env DYLD_LIBRARY_PATH=/Users/your_user/OpenFOAM/OpenFOAM-v2312/platforms/darwin64ClangDPInt32Debug/lib
   ```
<!-- markdownlint-enable MD013 -->

   Change `DYLD_LIBRARY_PATH` according to your OpenFOAM installation.

1. **Use `lldb` from the Xcode Command Line Tools:**
   Update your `PATH` to use the version of `lldb` from Xcode:

    <!-- markdownlint-disable MD013 -->
    ```sh
    > echo 'PATH="/Applications/Xcode.app/Contents/Developer/usr/bin/:$PATH"' >> ~/.bashrc  # ~/.zshrc
    ```
    <!-- markdownlint-enable MD013 -->

1. **Use `lldb` from Homebrew:**
   Or if you prefer, install `lldb` from the `llvm` package via Homebrew:

    <!-- markdownlint-disable MD013 -->
    ```sh
    > brew install llvm
    > echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.bash_profile  # ~/.zprofile
    ```
    <!-- markdownlint-enable MD013 -->

   ```note
   The `llvm` package also includes usefull softwares like `clangd` and
   `clang-format`.
   ```

---

## References

<!-- markdownlint-disable MD013 -->
- [LLDB Documentation](https://lldb.llvm.org/index.html)
- [GDB Documentation](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_chapter/gdb_toc.html)
- [HowTo debugging - openfoamwiki.net](https://openfoamwiki.net/index.php/HowTo_debugging)
- [Troubleshooting - openfoamwiki.net](https://openfoamwiki.net/index.php/FAQ/Troubleshooting)
- [Debugging OpenFOAM implementations (CFD with OpenSource Software, 2014)](https://www.tfd.chalmers.se/~hani/kurser/OS_CFD_2014/debugging.pdf)
- [18th OpenFOAM Workshop - OpenFOAM Code Debugging and Profiling](https://youtu.be/l3UhJXdwOuE)
- [v2206: New and improved usability](https://www.openfoam.com/news/main-news/openfoam-v2206/usability)
<!-- markdownlint-enable MD013 -->
