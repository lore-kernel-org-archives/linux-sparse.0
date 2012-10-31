From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v4 6/9] compiler.h, bug.h: Prevent double error messages
 with BUILD_BUG{,_ON}
Date: Wed, 31 Oct 2012 11:38:48 -0500
Message-ID: <50915418.2030607@att.net>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com> <1351457835-7553-6-git-send-email-daniel.santos@pobox.com> <20121030161933.GD28499@liondog.tnic> <5090B875.7030902@att.net> <20121031110609.GD16410@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm26.access.bullet.mail.mud.yahoo.com ([66.94.237.91]:48754
	"EHLO nm26.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933209Ab2JaQic (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Oct 2012 12:38:32 -0400
In-Reply-To: <20121031110609.GD16410@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On 10/31/2012 06:06 AM, Borislav Petkov wrote:
> On Wed, Oct 31, 2012 at 12:34:45AM -0500, Daniel Santos wrote:
>> Yes, the __build_bug_on_failed message is much more informative.  Th=
is
>> will only increase with these patches.  For example, the line
>>
>> BUILD_BUG_ON(sizeof(*c) !=3D 4);
>>
>> emits this error:
>>
>> arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=
=99:
>> arch/x86/kernel/cpu/amd.c:486:2: error: call to
>> =E2=80=98__build_bug_on_failed_486=E2=80=99 declared with attribute =
error: BUILD_BUG_ON
>> failed: sizeof(*c) !=3D 4
>> make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
>> make: *** [arch/x86/kernel/cpu/amd.o] Error 2
>>
>> It's true that there is some redundancy in there as well as the
>> gibberish line number embedded in the function name, but the end of =
the
>> line spits out the exact statement that failed.
> I guess that's as good as it gets. But it's fine IMO, it tells you
> exactly what you need to know.
Yeah, that's what I'm thinking as well.  Of course, I'm *always* happy
for somebody to come up with a superior solution! :)
>
>> But as far as rather the fallback is first or the __compiletime_erro=
r
>> function is a matter of asthetics, since it's really an either/or
>> situation.  Either the __build_bug_on_failedxxx function will be
>> declared with __attribute__((error(message))) and the fallback will
>> expand to a no-op, or the fallback will produce code that (presumabl=
y
>> always?) breaks the build.  For insurance, a link-time error will oc=
cur
>> if the fallback code fails to break the build.
> Right, but my suggestion was to have the more informative message alw=
ays
> trigger first, if possible and if gcc supports it (practically, more
> and more systems will be upgrading gcc which has the error attribute
> with time) and have the less informative one be the more seldom one. =
The
> "fallback" naming is just a minor issue.
>
> This way, the error message would be precise on most modern toolchain=
s.
> Older toolchains will issue something about negative array size, whic=
h
> is not really helpful so one would have to fire up an editor and
> actually look at the code :).

lol! :)  Yeah, this is exactly how it should be behaving at this point,
although it's not too clear with the "fallback" macro being defined
elsewhere that it's doing nothing when the error attribute is
available.  I suppose this is another reason to move the whole mechanis=
m
to compiler*.h or add some comments to clarify what's going on.
>> Realistically, a single macro could be defined in compiler*.h that
>> encapsulates the entirety of this mechanism and only exposes a "blac=
k
>> box" macro, that will simply expand to something that breaks the bui=
ld
>> in the most appropriate fashion based upon the version of gcc.  In
>> essence, the new BUILD_BUG_ON_MSG macro attempts to fill that roll.
> Yes.

Hmmm, this gets tricky.  So I think you are talking about a single
function-like macro that will create the built-time error.  As I see it=
,
we'll need to move the entirety of __BUILD_BUG_INTERNAL (with the doubl=
e
evaluation of condition fixed) into compiler*.h, even if we change the
name of the macro.  The alternatives are to a.) further spitting out th=
e
pieces of it into separate little macros (like
__compiletime_error_fallback), which I'm not fond of or b.) allow bug.h
to hold details about compiler functionality, which doesn't seem right
at all.  Let me play with this some and see what I can figure out.

>
>> I guess I'll fix it up (and address the emails on the other patches)
>> and do a v5 then for the whole set? (is that the right way to resubm=
it
>> with these corrections?)
> Well, you could wait a couple of days first to gather feedback from
> other people and then resend. This way you give chance to people to t=
ake
> a look without them seeing too many versions of the patchset and gett=
ing
> confused.
>
> What I always do is send out the patchset, collect and discuss change=
s,
> add in the required changes and test it while the discussions go on.
> After they settle down (and they do in a couple of days, in most case=
s)
> I then send out the newly tested version out.
>
> That whole exercise takes more or less a week if you're doing other
> stuff in between :)

Ahh, helpful guidelines, thanks so much! :)
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
