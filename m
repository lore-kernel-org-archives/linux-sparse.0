From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking
 pre-process.c
Date: Mon, 31 Jul 2017 16:05:10 +0100
Message-ID: <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
 <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
 <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:49063 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbdGaPFN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 11:05:13 -0400
In-Reply-To: <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 31/07/17 01:12, Christopher Li wrote:
> On Sun, Jul 30, 2017 at 8:05 PM, Christopher Li <sparse@chrisli.org> wrote:
>> On Sun, Jul 30, 2017 at 7:27 PM, Ramsay Jones
>>
>> You actually don't need to introduce CHECKER_FLAGS.
>> You can just do:
> 
> Ah, I see what you mean here. You want to distinguish
> CFLAGS for gcc, CHECKER_FLAGS for sparse specific
> flags.

Err, ... well, yes and no! :-D

The main idea is to separate the 'additional' flags passed to
sparse for the $(CHECKER) target - not necessarily for sparse
specific flags.

In this case, for example, -W[no]-vla is also a gcc flag, viz:

  $ make CFLAGS=-Wno-vla pre-process.sc
  Makefile:69: Your system does not have libxml, disabling c2xml
  Makefile:82: Your system does not have libgtk2, disabling test-inspect
  Makefile:102: Your system does not have llvm, disabling sparse-llvm
       CHECK    pre-process.c
  $ 

  $ rm pre-process.o
  $ make CFLAGS=-Wno-vla pre-process.o
  Makefile:69: Your system does not have libxml, disabling c2xml
  Makefile:82: Your system does not have libgtk2, disabling test-inspect
  Makefile:102: Your system does not have llvm, disabling sparse-llvm
       CC       pre-process.o
  $ 

  $ rm pre-process.o
  $ make CFLAGS=-Wvla pre-process.o
  Makefile:69: Your system does not have libxml, disabling c2xml
  Makefile:82: Your system does not have libgtk2, disabling test-inspect
  Makefile:102: Your system does not have llvm, disabling sparse-llvm
       CC       pre-process.o
  pre-process.c: In function ‘expand’:
  pre-process.c:712:9: warning: ISO C90 forbids variable length array ‘args’ [-Wvla]
    struct arg args[nargs];
           ^
  pre-process.c: In function ‘dump_macro’:
  pre-process.c:2019:9: warning: ISO C90 forbids variable length array ‘args’ [-Wvla]
    struct token *args[nargs];
           ^
  $ 

So, yes, I initially didn't have the $(CHECKER_FLAGS) and simply
had the following addition:

  $ git diff
  diff --git a/Makefile b/Makefile
  index 64146db..8e4b0ae 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -198,6 +198,8 @@ endif
 
   c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
  +pre-process.sc: CFLAGS += -Wno-vla
  +
   %.o: %.c $(LIB_H)
          $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
  $ 

... which works just as well. [Note that gcc and sparse have a
different default for -Wvla].

Also, note that we are using cgcc for checker, so non-gcc flags
should never get to gcc anyway (or we have a bug).

So, if you prefer not to introduce another variable, I would be
equally fine with that. However, bear in mind that you will have
to remember to add -Wno-vla manually to CFLAGS if you invoke make
with CFLAGS on the command line.

ATB,
Ramsay Jones

