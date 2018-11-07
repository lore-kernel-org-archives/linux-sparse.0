From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
Date: Wed, 7 Nov 2018 14:59:23 +0000
Message-ID: <20181107145922.GD2623@brain-police>
References: <cover.1541525354.git.andreyknvl@google.com>
 <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Vishwath Mohan <vishwath@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Wed, Nov 07, 2018 at 03:56:03PM +0100, Andrey Konovalov wrote:
> On Tue, Nov 6, 2018 at 6:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > This patchset adds a new software tag-based mode to KASAN [1].
> > (Initially this mode was called KHWASAN, but it got renamed,
> >  see the naming rationale at the end of this section).
> 
> [...]
> 
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Hi Andrew,
> 
> This patchset has now been reviewed-by KASAN maintainers. Could you
> take a look and consider taking this into the -mm tree?

I would much prefer to take the arm64 parts (which still need to be reviewed
by Catalin afaict) via the arm64 tree, so please can you split those out
separately?

Will
