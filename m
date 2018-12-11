From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 00/25] kasan: add software tag-based mode for arm64
Date: Tue, 11 Dec 2018 13:44:57 -0800
Message-ID: <20181211134457.2eff4a98b13ceda564ab9b37@linux-foundation.org>
References: <cover.1544099024.git.andreyknvl@google.com>
        <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
        <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
        <20181211160018.GA12597@edgewater-inn.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211160018.GA12597@edgewater-inn.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kste>
List-Id: linux-sparse@vger.kernel.org

On Tue, 11 Dec 2018 16:00:19 +0000 Will Deacon <will.deacon@arm.com> wrote:

> > Yes, that was the intention of sending v13. Should have I sent a
> > separate patch with v12->v13 fixes instead? I don't know what's the
> > usual way to make changes to the patchset once it's in the mm tree.

I usually convert replacement patches into deltas so people can see
what changed.  In this case it got messy so I dropped v12 and remerged
v13 wholesale.
