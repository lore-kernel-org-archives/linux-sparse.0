From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Link binaries with system libraries needed by LLVM
Date: Thu, 02 Oct 2014 21:11:31 +0100
Message-ID: <542DB173.6030901@ramsay1.demon.co.uk>
References: <1412259588-8542-1-git-send-email-anatol.pomozov@gmail.com> <20141002195322.GB3528@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:33848 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752611AbaJBULg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 16:11:36 -0400
In-Reply-To: <20141002195322.GB3528@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@oracle.com, sparse@chrisli.org

On 02/10/14 20:53, Josh Triplett wrote:
> On Thu, Oct 02, 2014 at 07:19:48AM -0700, Anatol Pomozov wrote:
>> It is needed on Linux Arch with latest LLVM installed
>>
>> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> 
> One comment below.
> 
>>  Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 28c4df6..25087d7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -112,11 +112,12 @@ LLVM_PROGS := sparse-llvm
>>  $(LLVM_PROGS): LD := g++
>>  LLVM_LDFLAGS := $(shell llvm-config --ldflags)
>>  LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
>> +LLVM_SYSTEM_LIBS := $(shell llvm-config --system-libs)
>>  LLVM_LIBS := $(shell llvm-config --libs)
>>  PROGRAMS += $(LLVM_PROGS)
>>  INST_PROGRAMS += sparse-llvm sparsec
>>  sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
>> -sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
>> +sparse-llvm_EXTRA_OBJS := $(LLVM_SYSTEM_LIBS) $(LLVM_LIBS) $(LLVM_LDFLAGS)
> 

This issue is addressed in commit d92353b4eacbac54d693edd62fb565f071e3ba86
("sparse-llvm: Fix LLVM 3.5 linker errors", 24-09-2014) in the main sparse
repo and in a follow-up commit a5bdeee9e145cc4313526f9722f80674321ab491
("Use LLVM_CONFIG instead of llvm-config in Makefile", 24-09-2014) in 
Christopher's public repo on kernel.org.

Neither commit is in a released version of sparse.

> Does llvm-config support passing multiple options, such as "llvm-config
> --libs --system-libs"?  If so, I'd suggest just adding --system-libs to
> the call in LLVM_LIBS, rather than adding a second variable.

An old version of llvm-config (prior to adding --system-libs) would
respond like so:

    $ llvm-config --libs --system-libs
    -lLLVM-3.4.2
    usage: llvm-config <OPTION>... [<COMPONENT>...]
    
    Get various configuration information needed to compile programs which use
    LLVM.  Typically called from 'configure' scripts.  Examples:
      llvm-config --cxxflags
      llvm-config --ldflags
      llvm-config --libs engine bcreader scalaropts

    Options:
      --version         Print LLVM version.
      --prefix          Print the installation prefix.
      --src-root        Print the source root LLVM was built from.
      --obj-root        Print the object root used to build LLVM.
...
      --build-mode      Print build mode of LLVM tree (e.g. Debug or Release).
    Typical components:
      all               All LLVM libraries (default).
      engine            Either a native JIT or a bitcode interpreter.
    $ echo $?
    1
    $ 

HTH

ATB,
Ramsay Jones


