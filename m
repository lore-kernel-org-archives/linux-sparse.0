From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
Date: Mon, 17 Dec 2018 12:38:47 -0800
Message-ID: <20181217123847.492b9ae4934bd0d95b0bbbdc@linux-foundation.org>
References: <cover.1544099024.git.andreyknvl@google.com>
        <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
        <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
        <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
        <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
        <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@>
List-Id: linux-sparse@vger.kernel.org

On Mon, 17 Dec 2018 20:33:42 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> > Curiosity, did you try your patches with SLUB red zoning enabled?
> > Since the area used for the Redzone is just after the payload, aligning the
> > object_size independently from the allocator could have side effects, at least
> > if I understand well how the mechanism works.
> >
> > Setting ARCH_SLAB_MINALIGN should avoid this as well.
> >
> > What do you think?
> 
> Sounds good to me.
> 
> Andrew, how should proceed with this? Send another fixup patch or
> resend the whole series?

It depends on how extensive the changes are.  I prefer a fixup, but at
some point it's time to drop it all and start again.
