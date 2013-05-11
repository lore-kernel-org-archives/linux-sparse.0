From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse, llvm: fix link errors
Date: Sat, 11 May 2013 11:24:46 -0700
Message-ID: <518E8CEE.6060001@chrisli.org>
References: <1368219684-4567-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:56121 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3EKSYx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 May 2013 14:24:53 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so3506679pbc.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 May 2013 11:24:53 -0700 (PDT)
In-Reply-To: <1368219684-4567-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>



On 05/10/2013 02:01 PM, Xi Wang wrote:
> This patch fixes the following link errors.
> 
>     libLLVMSupport.a(Signals.o): In function `llvm::sys::PrintStackTrace(_IO_FILE*)':
>     Signals.inc:269: undefined reference to `dladdr'
>     Signals.inc:281: undefined reference to `dladdr'


> -sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS)
> +sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)

The EXTRA_OBJS is only mean for real objects.
the LDFLAGS should be not belong to here.

I can't duplicate the link error myself.
It seems that you only want the LLVM_LDFLAGS apply to
sparse-llvm only.

Can you try this patch?

Thanks


Chris

diff --git a/Makefile b/Makefile
index 35e3801..549e669 100644
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

