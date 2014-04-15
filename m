From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] build: allow use of LLVM_CONFIG to override llvm-config
 config script
Date: Tue, 15 Apr 2014 11:00:45 -0700
Message-ID: <20140415180045.GA2707@leaf>
References: <1397582569-7043-1-git-send-email-cody@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43160 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaDOSAx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 14:00:53 -0400
Content-Disposition: inline
In-Reply-To: <1397582569-7043-1-git-send-email-cody@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 15, 2014 at 10:22:49AM -0700, Cody P Schafer wrote:
> On systems like ubuntu 12.04, llvm-config is llvm 2.9, but
> llvm-config-3.0 and llvm-config-3.3 (for example) are versions 3.0 and
> 3.3 respectively. Allow overriding the name/path of the llvm-config
> script so people can use these versioned config scripts
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c3f3104..bbdc088 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -30,9 +30,10 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
>  		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
>  		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
>  HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
> -HAVE_LLVM:=$(shell llvm-config --version >/dev/null 2>&1 && echo 'yes')
> -HAVE_LLVM_VERSION:=$(shell llvm-config --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
> -LLVM_VERSION=$(shell llvm-config --version)
> +LLVM_CONFIG=llvm-config
> +HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
> +HAVE_LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
> +LLVM_VERSION=$(shell $(LLVM_CONFIG) --version)
>  
>  GCC_BASE = $(shell $(CC) --print-file-name=)
>  BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
> @@ -84,9 +85,9 @@ HAVE_LLVM=no
>  else
>  LLVM_PROGS := sparse-llvm
>  $(LLVM_PROGS): LD := g++
> -LLVM_LDFLAGS := $(shell llvm-config --ldflags)
> -LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
> -LLVM_LIBS := $(shell llvm-config --libs)
> +LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
> +LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags | sed -e "s/-DNDEBUG//g")
> +LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
>  PROGRAMS += $(LLVM_PROGS)
>  INST_PROGRAMS += sparse-llvm sparsec
>  sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
> -- 
> 1.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
