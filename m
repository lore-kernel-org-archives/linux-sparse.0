From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
Date: Wed, 7 Nov 2018 16:56:21 +0100
Message-ID: <CAAeHK+yRAVo5S1Fb__uzK=drpXRBuB8-KvL8yQL8sfUG-Tr1Mw@mail.gmail.com>
References: <cover.1541525354.git.andreyknvl@google.com> <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
 <20181107145922.GD2623@brain-police> <CAAeHK+zNgv9WxRpf7N3gmsLYGL6oUALAnyerMzeYZUz1LhoUuA@mail.gmail.com>
 <20181107153456.GE2623@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107153456.GE2623@brain-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Vishwath Mohan <vishwath@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard
List-Id: linux-sparse@vger.kernel.org

On Wed, Nov 7, 2018 at 4:34 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> I would like the patches that touch code under arch/arm64/ to be reviewed by
> somebody from the arm64 community. Since the core parts have already been
> reviewed, I was suggesting that you could split them out so that they are
> not blocked by the architecture code. Is it not possible to preserve the
> existing KASAN behaviour for arm64 with the core parts merged? I figured it
> must be, since you're not touching any other architectures here and they
> assumedly continue to function correctly.

It's possible to split out the core mm part, but it doesn't make much
sense to merge it separately from the arm64 changes.

> However, if you'd rather keep everything together, please can we give it a
> couple of weeks so we can at least get the architecture bits reviewed? Most
> people are out at LPC next week (and I'm at another conference this week).

OK, sounds good!

Catalin, could you take a look at the arm64 specific changes?
