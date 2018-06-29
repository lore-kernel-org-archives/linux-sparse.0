From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Fri, 29 Jun 2018 12:07:06 +0100
Message-ID: <20180629110706.37aqq6x4vhnblkb6@armageddon.cambridge.arm.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Paul Lawrence <paullawrence@google.com>, Linux Memory Management List <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Evgeniy Stepanov <eugen>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jun 28, 2018 at 08:56:41PM +0200, Andrey Konovalov wrote:
> On Thu, Jun 28, 2018 at 12:51 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Jun 26, 2018 at 03:15:10PM +0200, Andrey Konovalov wrote:
> >> 1. By using the Top Byte Ignore arm64 CPU feature, we can store pointer
> >>    tags in the top byte of each kernel pointer.
> >
> > [...]
> >
> > This is a change from the current situation, so the kernel may be
> > making implicit assumptions about the top byte of kernel addresses.
> >
> > Randomising the top bits may cause things like address conversions and
> > pointer arithmetic to break.
> >
> > For example, (q - p) will not produce the expected result if q and p
> > have different tags.
> 
> If q and p have different tags, that means they come from different
> allocations. I don't think it would make sense to calculate pointer
> difference in this case.

Well, there is a lot of pointer comparison in the kernel which means
pointer difference. Take is_vmalloc_addr() for example, even if your
patchset does not cover (IIUC) vmalloc() at the moment, this function
may be called with slab addresses. Presumably they would all fail the
check with a non-0xff tag but it's something needs understood. If you
later add support for vmalloc(), this test would fail (as would the
rb tree search in find_vmap_area(). Kmemleak would probably break as
well as it makes heavy use of rb tree.

Basically you need to be very clear about kernel pointer usage (with an
associated tag or type) vs address range it refers to and in most cases
converted to an unsigned long. See the other discussion on sparse, it
could potentially be useful if we can detect the places where a pointer
is converted to ulong and maybe hide such conversion behind a macro with
the arm64 implementation also clearing the tag.

-- 
Catalin
