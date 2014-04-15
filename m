From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: allow use of LLVM_CONFIG to override llvm-config
 config script
Date: Tue, 15 Apr 2014 15:05:21 -0700
Message-ID: <CANeU7QmOQwveOeTRP9rrcXaCJYv3DMBGAW_yp1uGG0Juvm0agw@mail.gmail.com>
References: <1397582569-7043-1-git-send-email-cody@linux.vnet.ibm.com>
	<20140415180045.GA2707@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:46692 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaDOWFW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 18:05:22 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so9889887qaq.36
        for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 15:05:21 -0700 (PDT)
In-Reply-To: <20140415180045.GA2707@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 15, 2014 at 11:00 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Apr 15, 2014 at 10:22:49AM -0700, Cody P Schafer wrote:
>> On systems like ubuntu 12.04, llvm-config is llvm 2.9, but
>> llvm-config-3.0 and llvm-config-3.3 (for example) are versions 3.0 and
>> 3.3 respectively. Allow overriding the name/path of the llvm-config
>> script so people can use these versioned config scripts
>>
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Applied with trivial modification to use simple
expanded variable.

Chris

diff --git a/Makefile b/Makefile
index bbdc088..f453ded 100644
--- a/Makefile
+++ b/Makefile
@@ -30,10 +30,10 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c &&
                $(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
                echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
 HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
-LLVM_CONFIG=llvm-config
+LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 HAVE_LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version | grep "^[3-9].*" >/dev/nul
-LLVM_VERSION=$(shell $(LLVM_CONFIG) --version)
+LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)

 GCC_BASE = $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
