From: Christopher Li <sparse@chrisli.org>
Subject: [ANNOUNCE] sparse-0.2-cl2 is now available
Date: Fri, 9 Feb 2007 16:00:55 -0800
Message-ID: <20070210000055.GA19968@chrisli.org>
References: <20070204085329.GA6520@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:49228 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946804AbXBJA3b (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:29:31 -0500
Content-Disposition: inline
In-Reply-To: <20070204085329.GA6520@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>


Temporarily at:
    http://userweb.kernel.org/~chrisl/sparse-0.2-cl2

Will appear later at:
    http://ftp.kernel.org//pub/linux/kernel/people/chrisl/patches/sparse/sparse-0.2-cl2/


I have been play with sparse to add more Stanford checker style
of checking. The paper is "Checking System Rules Using System-
Specific, Programmer-Written Compiler Extensions" by Dawson Engler
etc.

Unlike the Stanford checker and smatch, this checker is working on
the linearization level instead of AST level. Linearization code
can be very convenient (when it works) to trace the data flow because
pseudo is in SSA form. There is define/user chain to avoid scan
every instruction.

I take the malloc checking for example to explain how the checker
works. The checking usually happen in three step:

The first step is scanning the linearize instruction. It look for
relevant operations. For malloc checker, the task is find out
the malloc/free function call and usage of malloced pointer.

The second step is converting the relevant operations into checker
instruction. The checker instruction is a simplification of the whole
program, only contain the operation relevant to checker.

The third step is executing the checker instruction. It try to execute
every possible execution flow in the function. The execution engine
will let the checker instruction perform state changes.

Thanks to step two, the size and complexity of the of program has been
greatly reduced.

The new checking has been very fast, it add a few seconds to the make C=1
run.

Again, comment and feed back are always welcome.

Chris

Change log in sparse-0.2-cl2:
 - adding pointer signedness fix
 - adding spinlock checking

Change log in sparse-0.2-cl1:
  The most interesting part is the inline function annotation.
  The new checker can find out inlined function usage. The interrupt
  checker does not depend on x86 asm instruction any more.


origin.patch
    006eff06c7adcfb0d06c6fadf6e9b64f0488b2bf URL: git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
incompatible-ptr-signess
    Bug fix in pointer modifiers inherent at function degeneration.
sizeof-incomplete
    Fix double semicolon in struct declare
anon-symbol
    Fix core dump on anonymous symbol.
instruction-buffer-size
    Fix core dump on huge switch
debug-checker
    Adding debug option for showing the linearized instruction.
no-dead-instruction
    Disable liveness "dead" instruction by default.
ptr-allocator
    Make the ptrlist using the sparse allocator.
annotate-inline-2
    Add annotation for inline function call.
malloc-checker
    Adding the malloc NULL pointer checker.
interrupt-checker
    Adding the interrupt checker
spinlock-checker
    Adding spinlock checker


Total 12 patches
