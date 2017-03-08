From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: sparse-next assertion failures on cygwin
Date: Wed, 8 Mar 2017 01:38:10 +0000
Message-ID: <a0ec1103-5ae3-2dee-9715-1d839e11ca58@ramsayjones.plus.com>
References: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com>
 <20170307063558.4itvt4mh327py6ls@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:56193 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbdCHBoU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 20:44:20 -0500
In-Reply-To: <20170307063558.4itvt4mh327py6ls@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>



On 07/03/17 06:35, Luc Van Oostenryck wrote:
> On Mon, Mar 06, 2017 at 10:17:36PM +0000, Ramsay Jones wrote:
>> So, this looks like a cygwin specific toolchain problem. I also assumed that
>> the 'backend/loop.c' test had the same problem (but I admit to never having
>> checked properly!).
>>
>> ...
>>
>> So, again, this seems like a cygwin specific llvm tool problem.
>>
>> ...
>>    
>>         TEST     Loops (backend/loop.c)
>>    error: actual error text does not match expected error text.
>>    error: see backend/loop.c.error.* for further investigation.
>>    --- backend/loop.c.error.expected	2017-03-06 21:57:27.695953300 +0000
>>    +++ backend/loop.c.error.got	2017-03-06 21:57:30.636386100 +0000
>>    @@ -0,0 +1,2 @@
>>    +assertion "ctype" failed: file "sparse-llvm.c", line 312, function: val_to_value
>>    +.././sparsec: line 35:  8900 Aborted                 (core dumped) $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
> 
> That's surprising as it appears that you have linearized code that is
> different that what we have on Linux (one of the type/symbol is NULL).

No, the linearized code is exactly the same on Linux and cygwin.
(checked with both diff and sha1sum).

> It whould be very interesting to:
> 1) show the result of test-linearize on the file

$ ./test-linearize validation/backend/loop.c
foo:
.L0:
	<entry-point>
	phisrc.32   %phi4(y) <- $0
	br          .L4

.L4:
	phi.32      %r1(y) <- %phi4(y), %phi5(y)
	setlt.32    %r2 <- %r1(y), $1000
	cbr         %r2, .L1, .L5

.L1:
	call.32     %r4 <- bar, %arg1
	add.32      %r7 <- %r1(y), %r4
	phisrc.32   %phi5(y) <- %r7
	br          .L4

.L5:
	ret.32      %r1(y)


$ 

> 2) replace the assert with a check followed with a dump of the
>    offending pseudo (show_pseudo()) and ideally the corresponding
>    instruction (show_instruction()).

<show_pseudo>: $0
<show_instruction>: phisrc.32   %phi4(y) <- $0     (%r1(y))

> No, nothing like that on Linux.

It seems Christopher is seeing the same thing. (He didn't say that
he saw it on Linux, but ...).

Are you sure you are running/testing the sparse-next branch (which
is currently at commit ab8076b83d ("llvm: fix output_op_[ptr]cast()",
05-03-2017)?

It would come as no surprise (I guess) that 'git bisect' fingers
commit 0c12ac32af ("llvm: fix translation of PSEUDO_VALs into a
ValueRefs", 05-03-2017).

ATB,
Ramsay Jones


