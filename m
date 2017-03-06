From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: sparse-next assertion failures on cygwin
Date: Mon, 6 Mar 2017 22:17:36 +0000
Message-ID: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:54569 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbdCFW0Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 17:26:16 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi Luc, Christopher,

I have had 3 additional (backend related) failures on cygwin for a long
time now. When they first appeared, I had a quick look and, since they
seemed to be cygwin specific, I have effectively ignored them ever since.
(At the time, I had the llvm tools installed on linux, and these errors
did not appear there. I don't have the llvm tools installed on linux at
the moment).

With the sparse-next branch from today, I now have another failure and
the current failures have changed a little, to now include an assert
failure. For example, with the current master branch:

   $ make check
   Makefile:66: Your system does not have libxml, disabling c2xml
   Makefile:78: Your system does not have libgtk2, disabling test-inspect
        TEST     __func__ (__func__.c)
   
   ...
   
        TEST     'hello, world' code generation (backend/hello.c)
   error: actual error text does not match expected error text.
   error: see backend/hello.c.error.* for further investigation.
   --- backend/hello.c.error.expected	2017-03-06 20:56:47.161540100 +0000
   +++ backend/hello.c.error.got	2017-03-06 20:56:47.430860000 +0000
   @@ -0,0 +1,6 @@
   +{standard input}: Assembler messages:
   +{standard input}:14: Error: invalid register for .seh_pushreg
   +{standard input}:14: Error: junk at end of line, first unrecognized character is `5'
   +{standard input}:20: Error: invalid register for .seh_setframe
   +{standard input}:20: Error: missing separator
   +mv: cannot stat '/tmp/tmp.RXtXMQ.o': No such file or directory
   
   ...
   
        TEST     Loops (backend/loop.c)
   error: actual error text does not match expected error text.
   error: see backend/loop.c.error.* for further investigation.
   --- backend/loop.c.error.expected	2017-03-06 20:56:49.981803500 +0000
   +++ backend/loop.c.error.got	2017-03-06 20:56:50.321243300 +0000
   @@ -0,0 +1,6 @@
   +{standard input}: Assembler messages:
   +{standard input}:14: Error: invalid register for .seh_pushreg
   +{standard input}:14: Error: junk at end of line, first unrecognized character is `6'
   +{standard input}:17: Error: invalid register for .seh_pushreg
   +{standard input}:17: Error: junk at end of line, first unrecognized character is `7'
   +mv: cannot stat '/tmp/tmp.geNp6E.o': No such file or directory
   
   ...
   
        TEST     sum from 1 to n (backend/sum.c)
   error: actual output text does not match expected output text.
   error: see backend/sum.c.output.* for further investigation.
   --- backend/sum.c.output.expected	2017-03-06 20:56:54.297468500 +0000
   +++ backend/sum.c.output.got	2017-03-06 20:56:54.368834400 +0000
   @@ -1,2 +0,0 @@
   -15
   -5050
   
   ...
   
        TEST     warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
   Out of 218 tests, 207 passed, 11 failed (8 of them are known to fail)
   make: *** [Makefile:213: check] Error 1
   $ 
   
Note that for the 'hello world' test, the gas assembler is complaining about
some structured exception directives (it looks like a register number is
being used rather than a register name. eg. 5 rather than %rbp).

If I run the tools by hand, and remove lines 14 and 20 from the assembler
file, then:

   $ cd validation/
   $ ../sparse-llvm backend/hello.c >zz.llvm
   $ /usr/bin/llc -o xx.S zz.llvm
   $ vim xx.S       # delete lines 20 and 14
   $ as xx.S -o xx.o
   $ gcc -o xx xx.o
   $ ./xx
   hello, world
   $ 

So, this looks like a cygwin specific toolchain problem. I also assumed that
the 'backend/loop.c' test had the same problem (but I admit to never having
checked properly!).

The 'backend/sum.c' test is yet another oddity. If I run the exact same
commands issued by the sparsei script by hand, then the 'test' passes:

   $ cd validation/
   $ ../sparse-llvm backend/sum.c | /usr/bin/lli
   15
   5050
   $ 
   
I eventually found a solution, that looked like this:

   diff --git a/sparsei b/sparsei
   index 3431a9f..d915b1f 100755
   --- a/sparsei
   +++ b/sparsei
   @@ -10,4 +10,4 @@ if [ $# -eq 0 ]; then
      exit 1
    fi
    
   -$DIRNAME/sparse-llvm $@ | $LLI
   +$DIRNAME/sparse-llvm $@ | $LLI -force-interpreter=true

So, I speculate that, when run at the terminal, lli flushes the output
stream (when JITing the code), but not otherwise. Presumably, when using
the interpreter it always flushes the output stream.

So, again, this seems like a cygwin specific llvm tool problem.

Having updated today, the 'sparse-next' branch (@ commit ab8076b "llvm: fix
output_op_[ptr]cast()", 05-03-2017), the test run looks like:

   $ make check
   Makefile:66: Your system does not have libxml, disabling c2xml
   Makefile:78: Your system does not have libgtk2, disabling test-inspect
        TEST     __func__ (__func__.c)
   
   ...
   
        TEST     'hello, world' code generation (backend/hello.c)
   error: actual error text does not match expected error text.
   error: see backend/hello.c.error.* for further investigation.
   --- backend/hello.c.error.expected	2017-03-06 21:57:24.847706600 +0000
   +++ backend/hello.c.error.got	2017-03-06 21:57:25.092496200 +0000
   @@ -0,0 +1,6 @@
   +{standard input}: Assembler messages:
   +{standard input}:14: Error: invalid register for .seh_pushreg
   +{standard input}:14: Error: junk at end of line, first unrecognized character is `5'
   +{standard input}:20: Error: invalid register for .seh_setframe
   +{standard input}:20: Error: missing separator
   +mv: cannot stat '/tmp/tmp.sSmppX.o': No such file or directory
   
   ...
   
        TEST     Loops (backend/loop.c)
   error: actual error text does not match expected error text.
   error: see backend/loop.c.error.* for further investigation.
   --- backend/loop.c.error.expected	2017-03-06 21:57:27.695953300 +0000
   +++ backend/loop.c.error.got	2017-03-06 21:57:30.636386100 +0000
   @@ -0,0 +1,2 @@
   +assertion "ctype" failed: file "sparse-llvm.c", line 312, function: val_to_value
   +.././sparsec: line 35:  8900 Aborted                 (core dumped) $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
        TEST     Loops with unused counter (backend/loop2.c)
   error: actual error text does not match expected error text.
   error: see backend/loop2.c.error.* for further investigation.
   --- backend/loop2.c.error.expected	2017-03-06 21:57:31.062468300 +0000
   +++ backend/loop2.c.error.got	2017-03-06 21:57:33.949417000 +0000
   @@ -0,0 +1,2 @@
   +assertion "ctype" failed: file "sparse-llvm.c", line 312, function: val_to_value
   +.././sparsec: line 35:  4808 Aborted                 (core dumped) $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
   
   ...
   
        TEST     sum from 1 to n (backend/sum.c)
   error: actual output text does not match expected output text.
   error: see backend/sum.c.output.* for further investigation.
   --- backend/sum.c.output.expected	2017-03-06 21:57:38.398598700 +0000
   +++ backend/sum.c.output.got	2017-03-06 21:57:38.485067900 +0000
   @@ -1,2 +0,0 @@
   -15
   -5050
   error: actual error text does not match expected error text.
   error: see backend/sum.c.error.* for further investigation.
   --- backend/sum.c.error.expected	2017-03-06 21:57:38.419504300 +0000
   +++ backend/sum.c.error.got	2017-03-06 21:57:41.135029400 +0000
   @@ -0,0 +1,2 @@
   +assertion "ctype" failed: file "sparse-llvm.c", line 312, function: val_to_value
   +'main' function not found in module.
   error: Actual exit value does not match the expected one.
   error: expected 0, got 255.
   
   ...
   
        TEST     warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
   Out of 230 tests, 217 passed, 13 failed (9 of them are known to fail)
   make: *** [Makefile:213: check] Error 1
   $ 

Note that 'backend/loop2.c' now also fails and, with the exception of
the 'backend/hello.c' test, they now fail with an assert.

I don't have time to look into this further tonight (I'm guessing that
you are not seeing this on linux), so I just wanted to let you know
about it.

ATB,
Ramsay Jones

