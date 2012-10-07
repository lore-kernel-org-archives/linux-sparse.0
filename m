From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 03/10] compiler-gcc{3,4}.h: Use GCC_VERSION macro
Date: Sun, 07 Oct 2012 15:21:27 -0500
Message-ID: <5071E447.8030404@att.net>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com> <1349466169-20637-3-git-send-email-daniel.santos@pobox.com> <20121006231041.GB3278@liondog.tnic> <5071C9AE.2010106@att.net> <20121007194259.GA25313@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm5-vm0.bullet.mail.ac4.yahoo.com ([98.139.52.68]:26936 "HELO
	nm5-vm0.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750760Ab2JGUV3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 16:21:29 -0400
In-Reply-To: <20121007194259.GA25313@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 10/07/2012 02:42 PM, Borislav Petkov wrote:
> On Sun, Oct 07, 2012 at 01:27:58PM -0500, Daniel Santos wrote:
>>> Did I miss something again? This "error" preprocessor function is
>>> commented out here? Why?
>> We'll have to ask Andrew.  Maybe so he can test on those versions of gcc?
>>
>> commit d3ffe64a1dbcfe18b57f90f7c01c40c93d0a8b92
>> Author: Andrew Morton <akpm@linux-foundation.org>
>> Date:   Fri Sep 28 00:02:42 2012 +0000
>>
>>     a
>>    
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
>> index 934bc34..997fd8a 100644
>> --- a/include/linux/compiler-gcc4.h
>> +++ b/include/linux/compiler-gcc4.h
>> @@ -5,7 +5,7 @@
>>  /* GCC 4.1.[01] miscompiles __weak */
>>  #ifdef __KERNEL__
>>  # if __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ <= 1
>> -#  error Your version of gcc miscompiles the __weak directive
>> +//#  error Your version of gcc miscompiles the __weak directive
>>  # endif
>>  #endif
>
> Ah, interesting. I think akpm has been redoing -mm couple times recently
> so you probably caught a temporary thing.

I was guessing something like that, but I figured he had a reason for
doing it so I didn't dare ask the master! :)

>
>> I can provide you a version of these patches rebased against Linus if
>> you like, which I am using to test since the -mm & -next trees aren't
>> working on my machine (hardware, .config and/or LVM/RAID setup). I
>> haven't put Walken's patches underneath them however.
>
> Nah, not necessary. I'd simply wait after the merge window closes and
> everything settles down and then crank out a patchset against one of
> the major trees (say -mm, linus or -next) so we can agree on the final
> versions. AFAICT, the general design is fine - it's just the details
> that need to be hammered out with precision.
>
> Thanks.
If I had more time & energy for this part, I would try to find all uses
of BUILD_BUG_ON with __builtin_const_p, remove the __OPTIMIZE__ check
from BUILD_BUG_ON, put my BUILD_BUG_ON_NON_CONST macros back into this
patch set and adjust any other code in the kernel to not fail
un-optimized.  Also, I would figure out the reason for this commented
out check (arch/powerpc/kvm/timing.h:52):

    /* The BUILD_BUG_ON below breaks in funny ways, commented out
     * for now ... -BenH
    BUILD_BUG_ON(!__builtin_constant_p(type));
    */

and correct it with the appropriate new macro.  However, one of my
biggest problems is staying on task, perhaps partially due to having
ADHD.  In fact, *this* project (the generic red-black trees) got started
when I was exploring the possibilities of running parts of Wine in the
kernel, when I was dismayed by the lack of genericity in the kernel's
red-black tree code, so it's actually a tangent! :)  Don't get me wrong,
I don't regret it.  It has been a marvelous adventure in the
possibilities of the C language on modern compilers.  But after I finish
this up, I plan on writing up a paper on the "C metaprogramming"
techniques I seem to have discovered and then getting back to my Wine
project.  There are many other nify compile-time tricks that I
discovered in the exploration process that I didn't need to use here,
but which are worth documenting.

So basically, I know that I need to try to get this thing wrapped up.

Daniel
