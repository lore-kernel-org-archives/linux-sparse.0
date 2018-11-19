From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v11 00/24] kasan: add software tag-based mode for arm64
Date: Mon, 19 Nov 2018 17:32:02 +0000
Message-ID: <20181119173202.7pcxp5osupdw4t5t@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com>
 <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Vishwath Mohan <vishwath@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>D
List-Id: linux-sparse@vger.kernel.org

On Mon, Nov 19, 2018 at 06:28:57PM +0100, Andrey Konovalov wrote:
> On Mon, Nov 19, 2018 at 6:26 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > Changes in v11:
> > - Rebased onto 9ff01193 (4.20-rc3).
> > - Moved KASAN_SHADOW_SCALE_SHIFT definition to arch/arm64/Makefile.
> > - Added and used CC_HAS_KASAN_GENERIC and CC_HAS_KASAN_SW_TAGS configs to
> >   detect compiler support.
> > - New patch: "kasan: rename kasan_zero_page to kasan_early_shadow_page".
> > - New patch: "arm64: move untagged_addr macro from uaccess.h to memory.h".
> > - Renamed KASAN_SET_TAG/... macros in arch/arm64/include/asm/memory.h to
> >   __tag_set/... and reused them later in KASAN core code instead of
> >   redefining.
> > - Removed tag reset from the __kimg_to_phys() macro.
> > - Fixed tagged pointer handling in arm64 fault handling logic.
> 
> Hi Mark and Catalin,

Hi Andrey,

> I've addressed your comments, please take a look.

Catalin and I have just returned from Linux Plumbers and are ctaching up
with things. I do intend to look at this, but it may take me a short
while before I can.

Thanks,
Mark.
