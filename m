From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Wed, 8 Aug 2018 17:27:53 +0100
Message-ID: <20180808162752.GA26592@arm.com>
References: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
 <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com>
 <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
 <20180803092312.GA17798@arm.com>
 <CACT4Y+bCen+ccU8awYyx_Tw14JNZhaP4D-jNq-WZy7itW+vpYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+bCen+ccU8awYyx_Tw14JNZhaP4D-jNq-WZy7itW+vpYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
List-Id: linux-sparse@vger.kernel.org

On Fri, Aug 03, 2018 at 11:42:32AM +0200, Dmitry Vyukov wrote:
> On Fri, Aug 3, 2018 at 11:23 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Aug 01, 2018 at 06:52:09PM +0200, Dmitry Vyukov wrote:
> >> On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > Thanks for tracking these cases down and going through each of them. The
> >> > obvious follow-up question is: how do we ensure that we keep on top of
> >> > this in mainline? Are you going to repeat your experiment at every kernel
> >> > release or every -rc or something else? I really can't see how we can
> >> > maintain this in the long run, especially given that the coverage we have
> >> > is only dynamic -- do you have an idea of how much coverage you're actually
> >> > getting for, say, a defconfig+modules build?
> >> >
> >> > I'd really like to enable pointer tagging in the kernel, I'm just still
> >> > failing to see how we can do it in a controlled manner where we can reason
> >> > about the semantic changes using something other than a best-effort,
> >> > case-by-case basis which is likely to be fragile and error-prone.
> >> > Unfortunately, if that's all we have, then this gets relegated to a
> >> > debug feature, which sort of defeats the point in my opinion.
> >>
> >> Well, in some cases there is no other way as resorting to dynamic testing.
> >> How do we ensure that kernel does not dereference NULL pointers, does
> >> not access objects after free or out of bounds? Nohow. And, yes, it's
> >> constant maintenance burden resolved via dynamic testing.
> >
> > ... and the advantage of NULL pointer issues is that you're likely to see
> > them as a synchronous exception at runtime, regardless of architecture and
> > regardless of Kconfig options. With pointer tagging, that's certainly not
> > the case, and so I don't think we can just treat issues there like we do for
> > NULL pointers.
> 
> Well, let's take use-after-frees, out-of-bounds, info leaks, data
> races is a good example, deadlocks and just logical bugs...

Ok, but it was you that brought up NULL pointers, so there's some goalpost
moving here. And as with NULL pointers, all of the issues you mention above
apply to other architectures and the majority of their configurations, so my
concerns about this feature remain.

> > If you want to enable khwasan in "production" and since enabling it
> > could potentially change the behaviour of existing code paths, the
> > run-time validation space doubles as we'd need to get the same code
> > coverage with and without the feature being enabled.
> 
> This is true for just any change in configs, sysctls or just a
> different workload. Any of this can enable new code, exiting code
> working differently, or just working with data in new states. And we
> have tens of thousands of bugs, so blindly deploying anything new to
> production without proper testing is a bad idea. It's not specific to
> HWASAN in any way. And when you enable HWASAN you actually do mean to
> retest everything as hard as possible.

I suppose I'm trying to understand whether we have to resort to testing, or
whether we can do better. I'm really uncomfortable with testing as our only
means of getting this right because this is a non-standard, arm64-specific
option and I don't think it will get very much testing in mainline at all.
Rather, we'll get spurious bug reports from forks of -stable many releases
later and we'll actually be worse-off for it.

> And in the end we do not seem to have any action points here, right?

Right now, it feels like this series trades one set of bugs for another,
so I'd like to get to a position where this new set of bugs is genuinely
more manageable (i.e. detectable, fixable, preventable) than the old set.
Unfortunately, the only suggestion seems to be "testing", which I really
don't find convincing :(

Could we do things like:

  - Set up a dedicated arm64 test farm, running mainline and with a public
    frontend, aimed at getting maximum coverage of the kernel with KHWASAN
    enabled?

  - Have an implementation of KHWASAN for other architectures? (Is this even
    possible?)

  - Have a compiler plugin to clear out the tag for pointer arithmetic?
    Could we WARN if two pointers are compared with different tags?
    Could we manipulate the tag on cast-to-pointer so that a mismatch would
    be qualifier to say that pointer was created via a cast?

  - ...

?

Will
