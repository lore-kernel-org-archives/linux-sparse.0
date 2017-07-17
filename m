From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: make selfcheck
Date: Mon, 17 Jul 2017 17:30:14 +0100
Message-ID: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:60262 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdGQQaR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 12:30:17 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hi Christopher,

The 'make selfcheck' target fails very quickly on cygwin, like so:

  $ make selfcheck
       CHECK    target.c
       CHECK    parse.c
  /usr/include/sys/_default_fcntl.h:163:14: error: redefinition of struct flock
  make: *** [Makefile:204: parse.sc] Error 1
  $ 

This is caused by sparse not defining the '__CYGWIN__' macro, which
would have been defined by cgcc, so the follwing fixes that:

-- >8 --
diff --git a/Makefile b/Makefile
index 4214e17..a3d3b9c 100644
--- a/Makefile
+++ b/Makefile
@@ -201,7 +201,7 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) ./sparse -c $(ALL_CFLAGS) $<
+	$(QUIET_CHECK) ./cgcc -c $(ALL_CFLAGS) $<
 
 selfcheck: $(LIB_OBJS:.o=.sc) $(addsuffix .sc, $(PROGRAMS))
 
----

Having applied the above patch, the output on cygwin is almost
the same as Linux. Only two additional warnings (x2 instances),
which is caused by sparse not defining some symbols that gcc
defines by default. Unfortunately, the C library on cygwin (well
the header files anyway) assumes that the compiler will define
these symbols (unlike glibc which has reasonable fallbacks).
So, I forgot to mention, that on cygwin I have to have the
following in my config.mak file to use sparse on the git code
base:

  SPARSE_FLAGS += -D__INTPTR_TYPE__='long int'
  SPARSE_FLAGS += -D__INT32_TYPE__=int
  SPARSE_FLAGS += -D__INT32_MAX__=2147483647
  SPARSE_FLAGS += -D__UINT32_TYPE__='unsigned int'
  SPARSE_FLAGS += -D__UINT32_MAX__=4294967295U
  SPARSE_FLAGS += -D__INT64_TYPE__='long int'
  SPARSE_FLAGS += -D__INT64_MAX__=9223372036854775807L
  SPARSE_FLAGS += -D__UINT64_TYPE__='long unsigned int'
  SPARSE_FLAGS += -D__UINT64_MAX__=18446744073709551615UL
  SPARSE_FLAGS += -D__INTMAX_TYPE__='long int'
  SPARSE_FLAGS += -D__INTMAX_MAX__=9223372036854775807L
  SPARSE_FLAGS += -D__UINTMAX_TYPE__='long unsigned int'
  SPARSE_FLAGS += -D__UINTMAX_MAX__=18446744073709551615UL
  SPARSE_FLAGS += -D__SIZE_TYPE__='long unsigned int'
  SPARSE_FLAGS += -D__SIZE_MAX__=18446744073709551615UL

[Just FYI, 'make selfcheck' on cygwin looks like:

  $ make selfcheck
  Makefile:67: Your system does not have libxml, disabling c2xml
  Makefile:80: Your system does not have libgtk2, disabling test-inspect
       CHECK    target.c
       CHECK    parse.c
       CHECK    tokenize.c
  /usr/include/sys/_intsup.h:68:2: error: "Unable to determine type definition of intptr_t"
  /usr/include/sys/_intsup.h:75:2: error: "Unable to determine type definition of int32_t"
       CHECK    pre-process.c
  pre-process.c:712:25: warning: Variable length array is used.
  pre-process.c:2019:28: warning: Variable length array is used.
       CHECK    symbol.c
       CHECK    lib.c
  lib.c:194:6: error: symbol 'error_die' redeclared with different type (originally declared at lib.h:98) - different modifiers
  lib.c:203:6: error: symbol 'die' redeclared with different type (originally declared at lib.h:94) - different modifiers
  lib.c:283:5: warning: symbol 'arch_msize_long' was not declared. Should it be static?
       CHECK    scope.c
       CHECK    expression.c
       ...
       CHECK    sparse-llvm.c
  /usr/include/sys/_intsup.h:68:2: error: "Unable to determine type definition of intptr_t"
  /usr/include/sys/_intsup.h:75:2: error: "Unable to determine type definition of int32_t"
  $ 

Note the additional intptr_t and int32_t errors.]

I think Luc already added some of these symbols, but we maybe
need to add some more. (This is the difference between applying
sparse to a user-space project rather than the kernel).

I have to go now, so this is just a heads-up! ;-)

ATB,
Ramsay Jones



