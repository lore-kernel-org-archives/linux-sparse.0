From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Wed, 27 Jun 2018 16:08:00 -0700
Message-ID: <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@l>
List-Id: linux-sparse@vger.kernel.org

On Tue, 26 Jun 2018 15:15:10 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> This patchset adds a new mode to KASAN [1], which is called KHWASAN
> (Kernel HardWare assisted Address SANitizer).
> 
> The plan is to implement HWASan [2] for the kernel with the incentive,
> that it's going to have comparable to KASAN performance, but in the same
> time consume much less memory, trading that off for somewhat imprecise
> bug detection and being supported only for arm64.

Why do we consider this to be a worthwhile change?

Is KASAN's memory consumption actually a significant problem?  Some
data regarding that would be very useful.

If it is a large problem then we still have that problem on x86, so the
problem remains largely unsolved?

> ====== Benchmarks
> 
> The following numbers were collected on Odroid C2 board. Both KASAN and
> KHWASAN were used in inline instrumentation mode.
> 
> Boot time [1]:
> * ~1.7 sec for clean kernel
> * ~5.0 sec for KASAN
> * ~5.0 sec for KHWASAN
> 
> Slab memory usage after boot [2]:
> * ~40 kb for clean kernel
> * ~105 kb + 1/8th shadow ~= 118 kb for KASAN
> * ~47 kb + 1/16th shadow ~= 50 kb for KHWASAN
> 
> Network performance [3]:
> * 8.33 Gbits/sec for clean kernel
> * 3.17 Gbits/sec for KASAN
> * 2.85 Gbits/sec for KHWASAN
> 
> Note, that KHWASAN (compared to KASAN) doesn't require quarantine.
> 
> [1] Time before the ext4 driver is initialized.
> [2] Measured as `cat /proc/meminfo | grep Slab`.
> [3] Measured as `iperf -s & iperf -c 127.0.0.1 -t 30`.

The above doesn't actually demonstrate the whole point of the
patchset: to reduce KASAN's very high memory consumption?
