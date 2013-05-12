From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] sparse, llvm: fix link errors
Date: Sat, 11 May 2013 22:10:24 -0400
Message-ID: <518EFA10.6040108@gmail.com>
References: <1368219684-4567-1-git-send-email-xi.wang@gmail.com> <518E8CEE.6060001@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:63266 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3ELCKc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 May 2013 22:10:32 -0400
Received: by mail-vc0-f170.google.com with SMTP id gf12so4724260vcb.29
        for <linux-sparse@vger.kernel.org>; Sat, 11 May 2013 19:10:31 -0700 (PDT)
In-Reply-To: <518E8CEE.6060001@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>

On 05/11/2013 02:24 PM, Christopher Li wrote:
> The EXTRA_OBJS is only mean for real objects.
> the LDFLAGS should be not belong to here.
> 
> I can't duplicate the link error myself.
> It seems that you only want the LLVM_LDFLAGS apply to
> sparse-llvm only.
> 
> Can you try this patch?

This doesn't work for me.

The problem is that -ldl (`llvm --ldflags`) must come _after_
-lLLVMSupport (`llvm --libs`).

Can we move LDFLAGS?

diff --git a/Makefile b/Makefile
index 35e3801..3cec8f0 100644
--- a/Makefile
+++ b/Makefile
@@ -84,7 +84,7 @@ HAVE_LLVM=no
 else
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
-LDFLAGS += $(shell llvm-config --ldflags)
+$(LLVM_PROGS): LDFLAGS += $(shell llvm-config --ldflags)
 LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
 LLVM_LIBS := $(shell llvm-config --libs)
 PROGRAMS += $(LLVM_PROGS)
@@ -173,7 +173,7 @@ compile_EXTRA_DEPS = compile-i386.o
 
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
+	$(QUIET_LINK)$(LD) -o $@ $^ $($@_EXTRA_OBJS) $(LDFLAGS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
