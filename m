From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking
 pre-process.c
Date: Mon, 31 Jul 2017 16:29:24 +0100
Message-ID: <6545856e-5cb3-aad0-af87-bea7c0ccafd7@ramsayjones.plus.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
 <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
 <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
 <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:56286 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdGaP31 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 11:29:27 -0400
In-Reply-To: <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 31/07/17 16:05, Ramsay Jones wrote:
> 
> 
> On 31/07/17 01:12, Christopher Li wrote:
>> On Sun, Jul 30, 2017 at 8:05 PM, Christopher Li <sparse@chrisli.org> wrote:
>>> On Sun, Jul 30, 2017 at 7:27 PM, Ramsay Jones
>>>
>>> You actually don't need to introduce CHECKER_FLAGS.
>>> You can just do:
>>
>> Ah, I see what you mean here. You want to distinguish
>> CFLAGS for gcc, CHECKER_FLAGS for sparse specific
>> flags.
> 
> Err, ... well, yes and no! :-D
> 
> The main idea is to separate the 'additional' flags passed to
> sparse for the $(CHECKER) target - not necessarily for sparse
> specific flags.
> 
> In this case, for example, -W[no]-vla is also a gcc flag, viz:
> 
>   $ make CFLAGS=-Wno-vla pre-process.sc
>   Makefile:69: Your system does not have libxml, disabling c2xml
>   Makefile:82: Your system does not have libgtk2, disabling test-inspect
>   Makefile:102: Your system does not have llvm, disabling sparse-llvm
>        CHECK    pre-process.c
>   $ 
> 
>   $ rm pre-process.o
>   $ make CFLAGS=-Wno-vla pre-process.o
>   Makefile:69: Your system does not have libxml, disabling c2xml
>   Makefile:82: Your system does not have libgtk2, disabling test-inspect
>   Makefile:102: Your system does not have llvm, disabling sparse-llvm
>        CC       pre-process.o
>   $ 
> 
>   $ rm pre-process.o
>   $ make CFLAGS=-Wvla pre-process.o
>   Makefile:69: Your system does not have libxml, disabling c2xml
>   Makefile:82: Your system does not have libgtk2, disabling test-inspect
>   Makefile:102: Your system does not have llvm, disabling sparse-llvm
>        CC       pre-process.o
>   pre-process.c: In function ‘expand’:
>   pre-process.c:712:9: warning: ISO C90 forbids variable length array ‘args’ [-Wvla]
>     struct arg args[nargs];
>            ^
>   pre-process.c: In function ‘dump_macro’:
>   pre-process.c:2019:9: warning: ISO C90 forbids variable length array ‘args’ [-Wvla]
>     struct token *args[nargs];
>            ^
>   $ 
> 
> So, yes, I initially didn't have the $(CHECKER_FLAGS) and simply
> had the following addition:
> 
>   $ git diff
>   diff --git a/Makefile b/Makefile
>   index 64146db..8e4b0ae 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -198,6 +198,8 @@ endif
>  
>    c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
>  
>   +pre-process.sc: CFLAGS += -Wno-vla
>   +
>    %.o: %.c $(LIB_H)
>           $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
>  
>   $ 
> 
> ... which works just as well. [Note that gcc and sparse have a
> different default for -Wvla].
> 
> Also, note that we are using cgcc for checker, so non-gcc flags
> should never get to gcc anyway (or we have a bug).
> 
> So, if you prefer not to introduce another variable, I would be
> equally fine with that. However, bear in mind that you will have
> to remember to add -Wno-vla manually to CFLAGS if you invoke make
> with CFLAGS on the command line.

Hmm, actually the following may be a better patch. what do you
think?

ATB,
Ramsay Jones

-- >8 --
diff --git a/Makefile b/Makefile
index 64146db..93c7db9 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,7 @@ OS = linux
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
+BASIC_CFLAGS =
 LDFLAGS += -g
 LD = gcc
 AR = ar
@@ -24,7 +25,7 @@ ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
-#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
+#     BASIC_CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
 
 HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
@@ -36,7 +37,7 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+BASIC_CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
@@ -75,7 +76,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK2_CFLAGS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): BASIC_CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
 else
 $(warning Your system does not have libgtk2, disabling test-inspect)
@@ -196,7 +197,9 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: BASIC_CFLAGS += $(LIBXML_CFLAGS)
+
+pre-process.sc: BASIC_CFLAGS += -Wno-vla
 
 %.o: %.c $(LIB_H)
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
