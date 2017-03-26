From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: extra 'make check' failures on 32bit Linux
Date: Sun, 26 Mar 2017 23:21:44 +0100
Message-ID: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:48129 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdCZWVr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Mar 2017 18:21:47 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hi Christopher, Luc,

On occasion I build sparse on 32-bit Linux and I have noticed, for some
weeks now, unexpected test failures. I have been meaning to take a look
at fixing these failures, but I just haven't had the time ... :(

So, as the next best thing, I thought I should at least let you know
about the failures, viz:

  $ make check
  Makefile:66: Your system does not have libxml, disabling c2xml
  Makefile:78: Your system does not have libgtk2, disabling test-inspect
  Makefile:98: Your system does not have llvm, disabling sparse-llvm
       TEST     abstract array declarator static (abstract-array-declarator-static.c)
       TEST     address_space attribute (address_space.c)
  ...
  
       TEST     bool-cast-explicit (bool-cast-explicit.c)
  error: Actual output contains some patterns which are not expected.
       TEST     bool-cast-implicit (bool-cast-implicit.c)
  error: Actual output contains some patterns which are not expected.
  ...
  
       TEST     call-inlined (call-inlined.c)
  error: actual output text does not match expected output text.
  error: see call-inlined.c.output.* for further investigation.
  --- call-inlined.c.output.expected	2017-03-26 18:26:03.358108923 +0100
  +++ call-inlined.c.output.got	2017-03-26 18:26:03.370120836 +0100
  @@ -15,14 +15,14 @@
   bas:
   .L6:
   	<entry-point>
  -	add.64      %r16 <- "abc", $1
  -	ret.64      %r16
  +	add.32      %r16 <- "abc", $1
  +	ret.32      %r16
   
   
   qus:
   .L9:
   	<entry-point>
  -	add.64      %r21 <- messg, $1
  -	ret.64      %r21
  +	add.32      %r21 <- messg, $1
  +	ret.32      %r21
   
   
       TEST     call-variadic (call-variadic.c)
  error: actual output text does not match expected output text.
  error: see call-variadic.c.output.* for further investigation.
  --- call-variadic.c.output.expected	2017-03-26 18:26:03.398148634 +0100
  +++ call-variadic.c.output.got	2017-03-26 18:26:03.402152605 +0100
  @@ -1,14 +1,14 @@
   foo:
   .L0:
   	<entry-point>
  -	push.64     "msg %c: %d %d/%ld %ld/%p %p\n"
  +	push.32     "msg %c: %d %d/%ld %ld/%p %p\n"
   	push.32     $120
   	push.32     %arg2
   	push.32     $7
  -	push.64     %arg3
  -	push.64     $0
  -	push.64     %arg4
  -	push.64     $0
  +	push.32     %arg3
  +	push.32     $0
  +	push.32     %arg4
  +	push.32     $0
   	call.32     %r5 <- print
   	ret.32      %r5
   
  ...
  
       TEST     division constants (div.c)
  error: actual error text does not match expected error text.
  error: see div.c.error.* for further investigation.
  --- div.c.error.expected	2017-03-26 18:26:04.142887258 +0100
  +++ div.c.error.got	2017-03-26 18:26:04.142887258 +0100
  @@ -2,8 +2,6 @@
   div.c:4:20: warning: division by zero
   div.c:5:22: warning: division by zero
   div.c:7:25: warning: constant integer operation overflow
  -div.c:8:27: warning: constant integer operation overflow
   div.c:9:34: warning: constant integer operation overflow
   div.c:11:25: warning: constant integer operation overflow
  -div.c:12:27: warning: constant integer operation overflow
   div.c:13:34: warning: constant integer operation overflow
  ...
  
       TEST     warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
  Out of 210 tests, 196 passed, 14 failed (9 of them are known to fail)
  39 tests were disabled
  Makefile:213: recipe for target 'check' failed
  make: *** [check] Error 1
  
  $ cat validation/bool-cast-explicit.c.output.got
  fs32:
  .L0:
  	<entry-point>
  	setne.1     %r2 <- %arg1, $0
  	ret.1       %r2
  
  
  fu32:
  .L2:
  	<entry-point>
  	setne.1     %r5 <- %arg1, $0
  	ret.1       %r5
  
  
  fvdp:
  .L4:
  	<entry-point>
  	cast.32     %r8 <- (32) %arg1
  	setne.1     %r9 <- %r8, $0
  	ret.1       %r9
  
  
  fsip:
  .L6:
  	<entry-point>
  	cast.32     %r12 <- (32) %arg1
  	setne.1     %r13 <- %r12, $0
  	ret.1       %r13
  
  
  fdbl:
  .L8:
  	<entry-point>
  	set.64      %r16 <- 0.000000
  	setne.1     %r17 <- %arg1, %r16
  	ret.1       %r17
  
  
  ffun:
  .L10:
  	<entry-point>
  	cast.32     %r20 <- (32) ffun
  	setne.1     %r21 <- %r20, $0
  	ret.1       %r21
  
  
  fres:
  .L12:
  	<entry-point>
  	setne.1     %r24 <- %arg1, $0
  	ret.1       %r24
  
  
  $ 

Note that the output file for bool-cast-implicit.c is identical to the
above file for bool-cast-explicit.c, so I haven't included it here.

Again, I haven't had time to look properly, but it seems that some
expected output files assume a 64-bit platform and that long and pointers
are 64-bit rather than 32-bit. (or something like that :-) )

ATB,
Ramsay Jones

