From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 00/18] khwasan: kernel hardware assisted address sanitizer
Date: Wed, 5 Sep 2018 14:55:34 -0700
Message-ID: <CAKwvOdn7fG0ykS5jjKMJsDmFoV7T3g6p=YucVLxrKgewhMT=Fw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org, LKML
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 5, 2018 at 2:10 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> > (Kernel HardWare assisted Address SANitizer).
>
> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
> Is that a fair commentary on what has been happening, or have people
> been remiss in sending and gathering such things?
>

I'm anxious to use these for Pixel Android devices.  Looks like the
series has been aggregating changes from valuable feedback.  Maybe if
the ARM maintainers and KASAN maintainers could Ack or Nack these, we
could decide to merge these or what needs more work?

-- 
Thanks,
~Nick Desaulniers
