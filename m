From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
Date: Thu, 6 Sep 2018 11:05:43 +0100
Message-ID: <20180906100543.GI3592@arm.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kst>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> 
> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> > (Kernel HardWare assisted Address SANitizer).
> 
> We're at v6 and there are no reviewed-by's or acked-by's to be seen. 
> Is that a fair commentary on what has been happening, or have people
> been remiss in sending and gathering such things?

I still have concerns about the consequences of merging this as anything
other than a debug option [1]. Unfortunately, merging it as a debug option
defeats the whole point, so I think we need to spend more effort on developing
tools that can help us to find and fix the subtle bugs which will arise from
enabling tagged pointers in the kernel.

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/596077.html
