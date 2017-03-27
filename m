From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 17:53:17 +0100
Message-ID: <b3629c23-28e6-370d-0716-787e34a8f854@ramsayjones.plus.com>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
 <20170327010342.vd34svh3kee43qir@macpro.local>
 <444abf20-b5ef-664a-fed4-ebfd8969e1da@ramsayjones.plus.com>
 <CAExDi1TwkQj4JcmxqLkG868H2QDEr87=xYHKH0sMY=AXjrEb4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:46982 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdC0Qxk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 12:53:40 -0400
In-Reply-To: <CAExDi1TwkQj4JcmxqLkG868H2QDEr87=xYHKH0sMY=AXjrEb4A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 27/03/17 17:10, Luc Van Oostenryck wrote:
> On Mon, Mar 27, 2017 at 5:27 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>> So, I looked in the debugger and 'bits_in_long' and 'bits_in_pointer'
>> are set correctly, but __LONG_MAX__ is being printed with an LL suffix,
>> so, this fixes it for me:
>>
>> $ git diff
>> diff --git a/lib.c b/lib.c
>> index 272d2c8..502c264 100644
>> --- a/lib.c
>> +++ b/lib.c
>> @@ -834,7 +834,7 @@ static void predefined_macros(void)
>>         add_pre_buffer("#define __CHECKER__ 1\n");
>>
>>         val = (1ULL << (bits_in_long-1)) - 1;
>> -       add_pre_buffer("#weak_define __LONG_MAX__ %#llxLL\n", val);
>> +       add_pre_buffer("#weak_define __LONG_MAX__ %#llxL\n", val);
>>         add_pre_buffer("#weak_define __SIZEOF_POINTER__ %d\n", bits_in_pointer/8);
>>  }
>>
>> $
>>
>> Not a proper fix, but ...
> 
> Well, actually it is the proper fix as __LONG_MAX__ is supposed to be
> a 'long' and not a 'long long'.
> 
>> Ah, I've just noticed you have sent some patches. ;-)
>>
>> I will take a look and let you know.
> 
> OK, thanks.
> It should be OK as I new tested it on a 32bit machine but
> another environment is always good for testing.

OK, so I tested the 5 patch series + the v2 patch that you sent
out on Linux 64bit, Linux 32bit and cygwin 64bit.

I applied the patches on top of the current 'sparse-next' branch:

  $ git branch -v
    chrisl-master   ce18a90 sparse: update __builtin_object_size() prototype
    master          fbbfc73 simplify float-to-float casts that doesn't change size
    mingw           9e96dd5 test-suite: Add -b option to ignore CR at eol on MinGW
    sparse-next     f7817f0 llvm: cleanup of output_[ptr]cast()
  * sparse-next-tmp df7cd04 fix expansion of integers to floats

  $ git log --oneline sparse-next..
  df7cd04 fix expansion of integers to floats
  83de8c4 do not depends on limits.h to test __CHAR_BIT__
  ac9f7b4 fix test validation/div.c
  153d5cf predefine __SIZEOF_INT__ & friends
  a3a916c predefine __INT_MAX__ and friends
  26a0a0a fix test for cast to bool on 32bit machines
  $ 

On Linux 64bit, I get:

  $ make check
  ...
  Out of 214 tests, 205 passed, 9 failed (9 of them are known to fail)
  39 tests were disabled
  $ 

On Linux 32bit, I get:

  $ make check
  ...
       TEST     call-inlined (call-inlined.c)
  error: actual output text does not match expected output text.
  error: see call-inlined.c.output.* for further investigation.
  --- call-inlined.c.output.expected	2017-03-27 16:57:23.438683323 +0100
  +++ call-inlined.c.output.got	2017-03-27 16:57:23.442685323 +0100
  @@ -15,14 +15,14 @@
   bas:
   .L6:
   	<entry-point>
  -	add.64      %r16 <- "abc", $1
  -	ret.64      %r16
  +	add.32      %r16 <- "abc", $1
  +	ret.32      %r16
 
 
   qus:
   .L9:
   	<entry-point>
  -	add.64      %r21 <- messg, $1
  -	ret.64      %r21
  +	add.32      %r21 <- messg, $1
  +	ret.32      %r21
 
 
       TEST     call-variadic (call-variadic.c)
  error: actual output text does not match expected output text.
  error: see call-variadic.c.output.* for further investigation.
  --- call-variadic.c.output.expected	2017-03-27 16:57:23.482705323 +0100
  +++ call-variadic.c.output.got	2017-03-27 16:57:23.486707323 +0100
  @@ -1,14 +1,14 @@
   foo:
   .L0:
   	<entry-point>
  -	push.64     "msg %c: %d %d/%ld %ld/%p %p\n"
  +	push.32     "msg %c: %d %d/%ld %ld/%p %p\n"
   	push.32     $120
   	push.32     %arg2
   	push.32     $7
  -	push.64     %arg3
  -	push.64     $0
  -	push.64     %arg4
  -	push.64     $0
  +	push.32     %arg3
  +	push.32     $0
  +	push.32     %arg4
  +	push.32     $0
   	call.32     %r5 <- print
   	ret.32      %r5
 
  ...
  Out of 214 tests, 203 passed, 11 failed (9 of them are known to fail)
  39 tests were disabled
  Makefile:213: recipe for target 'check' failed
  make: *** [check] Error 1
  $ 

And on cygwin 64bit, I get:

  $ tail test-out-tmp
       TEST     Varargs bogus warning regression test #1 (varargs1.c)
       TEST     wide character constants (wide.c)
       TEST     Woverride-init-def (Woverride-init-def.c)
       TEST     Woverride-init-no (Woverride-init-no.c)
       TEST     Woverride-init-yes (Woverride-init-yes.c)
       TEST     warn-unknown-attribute (Wunknown-attribute-def.c)
       TEST     warn-unknown-attribute-no (Wunknown-attribute-no.c)
       TEST     warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
  Out of 253 tests, 235 passed, 18 failed (9 of them are known to fail)
  make: *** [Makefile:213: check] Error 1
  $ 

Note that the 9 unexpected failures on cygwin are due to the same
'llvm tool problems' that we discussed before. ie the new tests added
in these patches all pass.

Hope that helps.

ATB,
Ramsay Jones

