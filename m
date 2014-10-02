From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] Link binaries with system libraries needed by LLVM
Date: Thu, 2 Oct 2014 13:05:46 -0700
Message-ID: <CAOMFOmUByeNvcDKh=yE_XptbpPfOn3x+CXmu8xGruEbRfwD4Tg@mail.gmail.com>
References: <1412259588-8542-1-git-send-email-anatol.pomozov@gmail.com>
	<20141002195322.GB3528@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:47968 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaJBUFr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 16:05:47 -0400
Received: by mail-vc0-f172.google.com with SMTP id lf12so1909605vcb.17
        for <linux-sparse@vger.kernel.org>; Thu, 02 Oct 2014 13:05:46 -0700 (PDT)
In-Reply-To: <20141002195322.GB3528@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, sparse@chrisli.org

Hi

On Thu, Oct 2, 2014 at 12:53 PM, Josh Triplett <josh@joshtriplett.org> wrote:
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
> Does llvm-config support passing multiple options, such as "llvm-config
> --libs --system-libs"?  If so, I'd suggest just adding --system-libs to
> the call in LLVM_LIBS, rather than adding a second variable.

Thanks. Yeap it is better. Will send update in a second.

>
> (It's obnoxious that llvm requires its own configuration tool rather
> than using pkg-config.)
>
> - Josh Triplett
