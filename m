From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH 1/5] kbuild: LLVMLinux: Add Kbuild support for building
 kernel with Clang
Date: Mon, 10 Mar 2014 23:58:16 -0700
Message-ID: <531EB408.2070707@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com> <1393376923-21892-2-git-send-email-behanw@converseincode.com> <20140309215834.GA29655@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41092 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbaCKG6U (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Mar 2014 02:58:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so8403954pab.38
        for <linux-sparse@vger.kernel.org>; Mon, 10 Mar 2014 23:58:19 -0700 (PDT)
In-Reply-To: <20140309215834.GA29655@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, =?ISO-8859-1?Q?Jan-Simon_M=F6ller?= <dl9pf@gmx.de>, Mark Charlebois <charlebm@gmail.com>

On 03/09/14 14:58, Sam Ravnborg wrote:
> On Tue, Feb 25, 2014 at 05:08:39PM -0800, behanw@converseincode.com w=
rote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> Add support to toplevel Makefile for compiling with clang, both for
>> HOSTCC and CC. Use cc-option to prevent gcc option from breaking cla=
ng, and
>> from clang options from breaking gcc.
>>
>> Clang 3.4 semantics are the same as gcc semantics for unsupported fl=
ags. For
>> unsupported warnings clang 3.4 returns true but shows a warning and =
gcc shows
>> a warning and returns false.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Signed-off-by: Jan-Simon M=F6ller <dl9pf@gmx.de>
>> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
>> Cc: PaX Team <pageexec@freemail.hu>
>> ---
>>   Makefile | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 831b36a..c4ab30d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -247,6 +247,15 @@ HOSTCXX      =3D g++
>>   HOSTCFLAGS   =3D -Wall -Wmissing-prototypes -Wstrict-prototypes -O=
2 -fomit-frame-pointer
>>   HOSTCXXFLAGS =3D -O2
>>  =20
>> +ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
>> +HOSTCOMPILER :=3D clang
>> +HOSTCFLAGS  +=3D -Wno-unused-value -Wno-unused-parameter \
>> +		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
>> +else
>> +HOSTCOMPILER :=3D gcc
>> +endif
>> +export HOSTCOMPILER
> I see no use of HOSTCOMPLIER anywhere in this patchset not in the ker=
nel. Can we drop this?
Actually, we're not using it anymore, though we were at one point. We'l=
l=20
drop it.

>> +
>>   # Decide whether to build built-in, modular, or both.
>>   # Normally, just do built-in.
>>  =20
>> @@ -323,6 +332,12 @@ endif
>>  =20
>>   export quiet Q KBUILD_VERBOSE
>>  =20
>> +ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
>> +COMPILER :=3D clang
>> +else
>> +COMPILER :=3D gcc
>> +endif
>> +export COMPILER
> Likewise - COMPILER seems unsued- can it be dropped?
We use COMPILER a lot in upcoming patches. :(

It's here in order to be available early so that the other patches can=20
use it. I hope that's okay.

>> # Look for make include files relative to root of kernel src
>>   MAKEFLAGS +=3D --include-dir=3D$(srctree)
>> @@ -382,7 +397,7 @@ KBUILD_CFLAGS   :=3D -Wall -Wundef -Wstrict-prot=
otypes -Wno-trigraphs \
>>   		   -fno-strict-aliasing -fno-common \
>>   		   -Werror-implicit-function-declaration \
>>   		   -Wno-format-security \
>> -		   -fno-delete-null-pointer-checks
>> +		   $(call cc-option,-fno-delete-null-pointer-checks,)
>>   KBUILD_AFLAGS_KERNEL :=3D
>>   KBUILD_CFLAGS_KERNEL :=3D
>>   KBUILD_AFLAGS   :=3D -D__ASSEMBLY__
>> @@ -620,9 +635,24 @@ else
>>   endif
>>   KBUILD_CFLAGS +=3D $(stackp-flag)
>>  =20
>> +ifeq ($(COMPILER),clang)
> Except that COMPILER is used here. But this does not warrant the expo=
rt.
Like I said. It is used in at least 4 other patches which are unrelated=
=20
to kbuild... Well, okay, one in the arm portion of kbuild.

I don't actually like using it, and would prefer not to, but we needed=20
the equivalent of an "#ifdef __clang__" in the Makefiles for various=20
reasons. :(

>> +KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
> Is this really needed today?
> https://bugzilla.mozilla.org/show_bug.cgi?id=3D717713 suggest that th=
is is default.
>
>> +KBUILD_CPPFLAGS +=3D $(call cc-option,-Wno-unknown-warning-option,)
> https://bugzilla.mozilla.org/show_bug.cgi?id=3D731316 seems to sugges=
t this is default
These haven't always been the defaults. I will check on when they becam=
e=20
defaults, retest, and reply back.

Though thanks for pointing this out! Very thorough. :)

>> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-variable)
>> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specif=
ier)
>> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
> Is it really justified to disable these warnings?
> # of warnign for a defconfig build would be a nice figure to judge fr=
om.
To be honest, the number one complaint we get from kernel devs who've=20
tried clang is that there are too many warnings. We don't want to turn=20
them off, but merely to stem the tide for now so as not to put people=20
off. The idea is to turn them on once we've had time to address the=20
warnings more fully. I'd quite like to see all (most) of the clang=20
warnings on by default eventually. Does that make sense?

However, the unused-variable warning will likely need to stay on IMHO.=20
There are quite a few things in the kernel which create variables which=
=20
are intended to be optimized away (last I checked). gcc doesn't complai=
n=20
about this, but clang get's very noisy about it.

Though if the consensus is to have more warnings on by default, I'm=20
happy to oblige.

>> +# Quiet clang warning: comparison of unsigned expression < 0 is alw=
ays false
>> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
> Same with this.
Actually, if is my understanding that comparing signed and unsigned=20
values are considered valid in the kernel code. Certainly I've seen man=
y=20
patches rejected which were trying to fix "tautological compare errors"=
=2E

>> +# CLANG uses a _MergedGlobals as optimization, but this breaks modp=
ost, as the
>> +# source of a reference will be _MergedGlobals and not on of the wh=
itelisted names.
>> +# See modpost pattern 2
>> +KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
> Should we fix modpost?
We looked at doing this, but the symbol name compares in modpost seem=20
like a Good Idea (tm). By using _MergedGlobals you lose information=20
which modpost relies on. I think modpost can catch more potential=20
problems by not using clang merged globals. But I'll easily be swayed b=
y=20
someone who knows better. :)

Thanks for the feedback,

Behan

--=20
Behan Webster
behanw@converseincode.com

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
