From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 00/27] x86: PIE support and option to extend KASLR randomization
Date: Fri, 1 Feb 2019 08:59:21 +1300
Message-ID: <CAGXu5jLGFd2UY89bPm_WQvcsX+RDMg0XoJvuXwfknJrGxpn4Ng@mail.gmail.com>
References: <20190131192533.34130-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-hardening-return-15064-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
To: Thomas Garnier <thgarnie@chromium.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Steven
List-Id: linux-sparse@vger.kernel.org

On Fri, Feb 1, 2019 at 8:28 AM Thomas Garnier <thgarnie@chromium.org> wrote:
> These patches make the changes necessary to build the kernel as Position
> Independent Executable (PIE) on x86_64. A PIE kernel can be relocated below
> the top 2G of the virtual address space. It allows to optionally extend the
> KASLR randomization range from 1G to 3G. The chosen range is the one currently
> available, future changes will allow the kernel module to have a wider
> randomization range.

This also lays the groundwork for doing compilation-unit-granularity
KASLR, as Kristen has been working on. With PIE working, the
relocations are more sane and boot-time reordering becomes possible
(or at least, it becomes the same logically as doing the work on
modules, etc).

-- 
Kees Cook
