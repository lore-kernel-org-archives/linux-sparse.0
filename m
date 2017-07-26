From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse warnings on GENMASK + arm32
Date: Wed, 26 Jul 2017 09:47:15 -0400
Message-ID: <CANeU7Qme-sAvpFhuaA-YjRoCu_-zyySVpnYuSTYjZoM9D64PYQ@mail.gmail.com>
References: <20170726013020.GL2146@codeaurora.org> <1000702648.38599568.1501075981880.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1000702648.38599568.1501075981880.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Wed, Jul 26, 2017 at 9:33 AM, Lance Richardson <lrichard@redhat.com> wrote:
> Hmm, it seems sparse is incorrectly taking ~0UL to be a 64-bit value
> while BITS_PER_LONG is (correctly) evaluated to be 32.
>
> #define GENMASK(h, l) \
>         (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>
What is the sizeof(unsigned long) in ARM 32 bit world?

~0UL has the type of "unsigned long", I assume BITS_PER_LONG
is just plain "int"? Using sparse -E should be able to get the expression
after the macro expression.

The kernel compile invoke sparse directly. That is the assumption
that the host gcc has the same type size as the target gcc.
That is no longer true if you have cross compiler.

If you want to have sparse understand the proper architecture difference,
the current practices is using cgcc to handle the architecture specific
macros.

you can try to invoke the kernel building with: CHECK="cgcc -no-compile".
Warning: I haven't try that myself, it might not work as expected.

In the long run, I do wish sparse can implement the proper handling of
the architecture specific stuff by itself without go through of cgcc.

Chris
