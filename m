From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 3/4] x86/fpu: Fix __user annotations
Date: Fri, 29 Mar 2019 20:25:25 +0100
Message-ID: <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
References: <20190329163047.223508-1-jannh@google.com> <20190329163047.223508-3-jannh@google.com>
 <20190329180329.hl3t7a43sg3sshsf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329180329.hl3t7a43sg3sshsf@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Qiaowei Ren <qiaowei.ren@intel.com>
List-Id: linux-sparse@vger.kernel.org

+sparse list

On Fri, Mar 29, 2019 at 7:03 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Mar 29, 2019 at 05:30:46PM +0100, Jann Horn wrote:
> > In save_xstate_epilog(), use __user when type-casting userspace pointers.
> >
> > In setup_sigcontext() and x32_setup_rt_frame(), perform explicit __force
> > casts for converting userspace pointers to unsigned long; put_user_ex()
> > already performs a cast, but without __force, which is required by sparse
> > for conversions from userspace pointers to numbers.
>
> ...
>
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 08dfd4c1a4f9..e13cd972f9af 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
> >               put_user_ex(regs->ss, &sc->ss);
> >  #endif /* CONFIG_X86_32 */
> >
> > -             put_user_ex(fpstate, &sc->fpstate);
> > +             put_user_ex((unsigned long __force)fpstate, &sc->fpstate);
>
> The __force here is not needed and in fact meaningless as the address
> space annotations and checks only concern pointers. By casting a
> pointer to an unsigned long, all type info is lost anyway and thus
> no address-space checks are performed. It's a bit like such casts
> always have an implicit __force already included.

Oooh, it's a sparse bug.

So, without this, sparse complains:

  CHECK   arch/x86/kernel/signal.c
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression

Apparently it's significant that the user pointer is stored as a
__u64, and __u64 is defined as unsigned long long.

By reducing this to a small testcase, I arrived at this:

sparse-master$ nl jannh-typeof-number.c
     1 #define __user __attribute__((noderef, address_space(1)))
     2 static unsigned long a(void __user *fpstate) {
     3   return (unsigned long long)fpstate;
     4 }
     5 static unsigned long b(void __user *fpstate) {
     6   return (unsigned long)fpstate;
     7 }
     8 static unsigned long c(void __user *fpstate) {
     9   return (unsigned int)fpstate;
    10 }
sparse-master$ ./sparse -Wall jannh-typeof-number.c
jannh-typeof-number.c:3:11: warning: cast removes address space
'<asn:1>' of expression
jannh-typeof-number.c:9:11: warning: cast removes address space
'<asn:1>' of expression
sparse-master$

I'll have a look at sparse and try to come up with a patch if I can
figure out what's going wrong.
