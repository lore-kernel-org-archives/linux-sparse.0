From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Link binaries with system libraries needed by LLVM
Date: Thu, 2 Oct 2014 12:53:23 -0700
Message-ID: <20141002195322.GB3528@jtriplet-mobl1>
References: <1412259588-8542-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33913 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbaJBTxa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 15:53:30 -0400
Content-Disposition: inline
In-Reply-To: <1412259588-8542-1-git-send-email-anatol.pomozov@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@oracle.com, sparse@chrisli.org

On Thu, Oct 02, 2014 at 07:19:48AM -0700, Anatol Pomozov wrote:
> It is needed on Linux Arch with latest LLVM installed
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

One comment below.

>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 28c4df6..25087d7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -112,11 +112,12 @@ LLVM_PROGS := sparse-llvm
>  $(LLVM_PROGS): LD := g++
>  LLVM_LDFLAGS := $(shell llvm-config --ldflags)
>  LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
> +LLVM_SYSTEM_LIBS := $(shell llvm-config --system-libs)
>  LLVM_LIBS := $(shell llvm-config --libs)
>  PROGRAMS += $(LLVM_PROGS)
>  INST_PROGRAMS += sparse-llvm sparsec
>  sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
> -sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
> +sparse-llvm_EXTRA_OBJS := $(LLVM_SYSTEM_LIBS) $(LLVM_LIBS) $(LLVM_LDFLAGS)

Does llvm-config support passing multiple options, such as "llvm-config
--libs --system-libs"?  If so, I'd suggest just adding --system-libs to
the call in LLVM_LIBS, rather than adding a second variable.

(It's obnoxious that llvm requires its own configuration tool rather
than using pkg-config.)

- Josh Triplett
