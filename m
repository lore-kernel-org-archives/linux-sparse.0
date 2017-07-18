From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH V2 0/4] Adding selfcheck target
Date: Tue, 18 Jul 2017 17:31:06 +0100
Message-ID: <06ed63c5-f73f-e3ff-91d4-a72fddd5b990@ramsayjones.plus.com>
References: <CANeU7Q=pWm7VHmg_Tb+7K1dd-y86D9bQnX3_KJNO16fGHj2N7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:37665 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdGRQbJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 12:31:09 -0400
In-Reply-To: <CANeU7Q=pWm7VHmg_Tb+7K1dd-y86D9bQnX3_KJNO16fGHj2N7Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>



On 18/07/17 03:51, Christopher Li wrote:
> This is  the updated version of the selfcheck.
> 
> Merge some change submit by Ramsay Jones.
> I also fix some warning report by selfcheck. That is the 4th path.
> 
> This is the current selfcheck warning on Linux:
> 
>      CHECK    pre-process.c
> pre-process.c:712:25: warning: Variable length array is used.
> pre-process.c:2019:28: warning: Variable length array is used.

I have the obvious fix for these, but it has potential performance
problems (but, since I haven't done the timing tests, I don't know
if it is a problem or not). ;-)

Another option, of course, is to (like in git) add a 'SPARSE_FLAGS'
so that we can set '-Wno-vla' when checking the 'pre-process.sc'
file, something like:

pre-process.sc: SPARSE_FLAGS += '-Wno-vla'

%.sc: %.c sparse
        $(QUIET_CHECK) $(CHECKER) $(SPARSE_FLAGS) -c $(ALL_CFLAGS) $<

... or something like that.

>      CHECK    symbol.c
>      CHECK    lib.c
> lib.c:194:6: error: symbol 'error_die' redeclared with different type
> (originally declared at lib.h:98) - different modifiers
> lib.c:203:6: error: symbol 'die' redeclared with different type
> (originally declared at lib.h:94) - different modifiers
> 
> This one is hard to fix. It is reporting the difference in NORETURN attribute.

I have a fix (well, *workaround*) for these. I have to do the same in
git. (*hush*, nobody has yet noticed that it is a sparse bug). ;-)

Ignoring the 'memset byte count' warning, the only real warning left
(but _only_ if you build with the NO_REGEX build variable set) is an
example of this warning in the 'compat regex code'. Actually, that
particular warning is about the use of the 'pure' attribute, but it
is treated the same way as NORETURN. A simple test file:

  $ cat -n test.c
     1	int func(int a) __attribute__ ((pure));
     2	
     3	__attribute__ ((pure))
     4	int func(int a)
     5	{
     6		return 0;
     7	}
  $ 

  $ cgcc -no-compile test.c
  test.c:4:5: error: symbol 'func' redeclared with different type (originally declared at test.c:1) - different modifiers
  $ 

I have been meaning to fix this up for years ... :-P

> The NORETURN should not be a modifier, it is an attribute.
> The other issue here is that, sparse haven't handle merging the
> difference instance
> of the incremental declare properly.

Correct, something else I've been meaning to do.

> 
> I also have this:
>      CHECK    sparse-llvm.c
> /usr/include/bits/mathinline.h:134:55: warning: obsolete struct
> initializer, use C99 syntax
> /usr/include/bits/mathinline.h:146:59: warning: obsolete struct
> initializer, use C99 syntax
> /usr/include/bits/mathinline.h:153:64: warning: obsolete struct
> initializer, use C99 syntax
> 
> That is a system header file which I can't fix in sparse.

Hmm, I don't see these at all. In fact on my system (Linux Mint 18.2)
that file is at '/usr/include/x86_64-linux-gnu/bits/mathinline.h'.
(So you probably don't have multi-lib).

ATB,
Ramsay Jones


