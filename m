From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v6 00/27] x86: PIE support and option to extend KASLR randomization
Date: Thu, 31 Jan 2019 14:42:21 -0800
Message-ID: <CAJcbSZE890YgtEv_Z9A3kPukQzmZmgo0xM=pruMB3uTziBFwMw@mail.gmail.com>
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131214038.GI28234@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-hardening-return-15068-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20190131214038.GI28234@char.us.oracle.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>Steven Rostedt <r>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jan 31, 2019 at 1:41 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:07AM -0800, Thomas Garnier wrote:
> > There has been no major concern in the latest iterations. I am interested on
> > what would be the best way to slowly integrate this patchset upstream.
>
> One question that I was somehow expected in this cover letter - what
> about all those lovely speculative bugs? As in say some one hasn't
> updated their machine with the Spectre v3a microcode - wouldn't they
> be able to get the kernel virtual address space?

Yes they would be.

>
> In effect rendering all this hard-work not needed?

Only if we think Spectre bugs will never be fixed.
