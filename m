From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v4 6/9] compiler.h, bug.h: Prevent double error messages
 with BUILD_BUG{,_ON}
Date: Wed, 31 Oct 2012 00:34:45 -0500
Message-ID: <5090B875.7030902@att.net>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com> <1351457835-7553-6-git-send-email-daniel.santos@pobox.com> <20121030161933.GD28499@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm1.access.bullet.mail.sp2.yahoo.com ([98.139.44.128]:32609
	"EHLO nm1.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751942Ab2JaFe2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Oct 2012 01:34:28 -0400
In-Reply-To: <20121030161933.GD28499@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On 10/30/2012 11:19 AM, Borislav Petkov wrote:
> On Sun, Oct 28, 2012 at 03:57:12PM -0500, danielfsantos@att.net wrote=
:
>> Prior to the introduction of __attribute__((error("msg"))) in gcc 4.=
3,
>> creating compile-time errors required a little trickery.
>> BUILD_BUG{,_ON} uses this attribute when available to generate
>> compile-time errors, but also uses the negative-sized array trick fo=
r
>> older compilers, resulting in two error messages in some cases.  The
>> reason it's "some" cases is that as of gcc 4.4, the negative-sized a=
rray
>> will not create an error in some situations, like inline functions.
>>
>> This patch replaces the negative-sized array code with the new
>> __compiletime_error_fallback() macro which expands to the same thing
>> unless the the error attribute is available, in which case it expand=
s to
>> do{}while(0), resulting in exactly one compile-time error on all
>> versions of gcc.
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> ---
>>  include/linux/bug.h      |    4 ++--
>>  include/linux/compiler.h |    7 +++++++
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bug.h b/include/linux/bug.h
>> index 03259d7..da03dc1 100644
>> --- a/include/linux/bug.h
>> +++ b/include/linux/bug.h
>> @@ -57,13 +57,13 @@ struct pt_regs;
>>   * track down.
>>   */
>>  #ifndef __OPTIMIZE__
>> -#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(conditi=
on)]))
>> +#define BUILD_BUG_ON(condition) __compiletime_error_fallback(condit=
ion)
>>  #else
>>  #define BUILD_BUG_ON(condition)						\
>>  	do {								\
>>  		extern void __build_bug_on_failed(void)			\
>>  			__compiletime_error("BUILD_BUG_ON failed");	\
>> -		((void)sizeof(char[1 - 2*!!(condition)]));		\
>> +		__compiletime_error_fallback(condition);		\
>>  		if (condition)						\
>>  			__build_bug_on_failed();			\
> If we're defining a fallback, shouldn't it come second? I.e.:
>
> 		if (condition)
> 			__build_bug_on_failed();
> 		__compiletime_error_fallback(condition);
>
> Also, the error message from __build_bug_on_failed is much more
> informative:
>
> arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=99=
:
> arch/x86/kernel/cpu/amd.c:486:2: error: call to =E2=80=98__build_bug_=
on_failed=E2=80=99 declared with attribute error: BUILD_BUG_ON failed
> make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/x86/kernel/cpu/] Error 2
>
> than
>
> arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=99=
:
> arch/x86/kernel/cpu/amd.c:486:2: error: size of unnamed array is nega=
tive
> make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/x86/kernel/cpu/] Error 2
Yes, the __build_bug_on_failed message is much more informative.  This
will only increase with these patches.  For example, the line

BUILD_BUG_ON(sizeof(*c) !=3D 4);

emits this error:

arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=99=
:
arch/x86/kernel/cpu/amd.c:486:2: error: call to
=E2=80=98__build_bug_on_failed_486=E2=80=99 declared with attribute err=
or: BUILD_BUG_ON
failed: sizeof(*c) !=3D 4
make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
make: *** [arch/x86/kernel/cpu/amd.o] Error 2

It's true that there is some redundancy in there as well as the
gibberish line number embedded in the function name, but the end of the
line spits out the exact statement that failed.

But as far as rather the fallback is first or the __compiletime_error
function is a matter of asthetics, since it's really an either/or
situation.  Either the __build_bug_on_failedxxx function will be
declared with __attribute__((error(message))) and the fallback will
expand to a no-op, or the fallback will produce code that (presumably
always?) breaks the build.  For insurance, a link-time error will occur
if the fallback code fails to break the build.

Realistically, a single macro could be defined in compiler*.h that
encapsulates the entirety of this mechanism and only exposes a "black
box" macro, that will simply expand to something that breaks the build
in the most appropriate fashion based upon the version of gcc.  In
essence, the new BUILD_BUG_ON_MSG macro attempts to fill that roll.
>
> Finally, you need to do:
>
> 	bool __cond =3D !!(condition);
>
> and use __cond so that condition doesn't get evaluated multiple times
> (possibly with side effects).
>
> Thanks.
Big problem!  Very good catch, thank you!  All good programmers know no=
t
use expressions that can have side effects in an assert-type macro, but
this it should certainly be as dummy proof as possible.  That will forc=
e
others to get a really *really* good dummy if they want to break it!

Thank you for this! I suppose another justification for having a single
"black box" macro that does this in one place and addresses all of thes=
e
tricky issues.

I guess I'll fix it up (and address the emails on the other patches) an=
d
do a v5 then for the whole set? (is that the right way to resubmit with
these corrections?)

Thanks
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
