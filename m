From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Date: Tue, 15 May 2018 22:14:08 +0000
Message-ID: <C571168E-D627-4D32-B504-DCD56D50D5C5@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
Content-Language: en-US
Content-ID: <4AC4BC090489D04AA61B53FA42BF2395@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-sparse@vger.kernel.org

Nadav Amit <namit@vmware.com> wrote:

> This patch-set deals with an interesting yet stupid problem: code that
> does not get inlined despite its simplicity.
>=20
> I find 5 classes of causes:
>=20
> 1. Inline assembly blocks in which code and data are added to
> alternative sections. The compiler is oblivious to the content of the
> blocks and assumes their cost in space and time is proportional to the
> number of the perceived assembly "instruction", according to the number
> of newlines and semicolons. Alternatives, paravirt and other mechanisms
> are affected.
>=20
> 2. Inline assembly with redundant new-lines and semicolons. Similarly to
> (1) this code is considered "heavier" than it actually is.
>=20
> 3. Code with constant value optimizations. Quite a few parts of the
> kernel check whether a variable is constant (using
> __builtin_constant_p()) and perform heavy computations in that case.
> These computations are eventually optimized out so they do not land in
> the binary. However, the cost of these computations is also associated
> with the calling function, which might prevent inlining of the calling
> function. ilog2() is an example for such case.
>=20
> 4. Code that is marked with the "cold" attribute, including all the
> __init functions. Some may consider it the desired behavior.
>=20
> 5. Code that is marked with a different optimization levels. This
> affects for example vmx_vcpu_run(), inducing overheads of up to 10% on
> exit.
>=20
>=20
> This patch-set deals with some instances of first 3 classes.=20
>=20
> For (1) we insert an assembly macro, and call it from the inline
> assembly block.  As a result, the compiler sees a single "instruction"
> and assigns the more appropriate cost to the code.
>=20
> For (2) the solution is trivial: just remove the newlines.
>=20
> (3) is somewhat tricky. The proposed solution is to use
> __builtin_choose_expr() to check whether a variable is actually constant
> instead of using an if-condition or the C ternary operator.
> __builtin_choose_expr() is evaluated earlier in the compilation, so it
> allows the compiler to associate the right cost for the variable case
> before the inlining decisions take place.  So far so good.
>=20
> Still, there is a drawback. Since __builtin_choose_expr() is evaluated
> earlier, it can fail to recognize constants, which an if-condition would
> recognize correctly.  As a result, this patch-set only applies it to the
> simplest cases.
>=20
> Overall this patch-set slightly increases the kernel size (my build was
> done using localmodconfig + localyesconfig for the record):
>=20
>   text    data     bss     dec     hex filename
> 18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
> 18149210 10064048 2936832 31150090 1db500a ./vmlinux after (+0.06%)
>=20
> The patch-set eliminates many of the static text symbols:
> Before: 40033
> After:  39632   (-10%)

Oops. Should be -1%...=20
