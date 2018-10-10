From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 14:21:12 -0500
Message-ID: <20181010192111.GD29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <gcc-return-197402-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
To: Nadav Amit <namit@vmware.com>
Cc: Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-sparse@vger.kernel.org

Hi Nadav,

On Wed, Oct 10, 2018 at 04:31:41PM +0000, Nadav Amit wrote:
> at 7:53 AM, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > How does this look?
>=20
> It looks good to me in general. I have a couple of reservations, but I
> suspect you will not want to address them:
>=20
> 1. It is not backward compatible, requiring a C macro to wrap it, as the=
=20
> kernel might be built with different compilers.

How *could* it be backward compatible?  There should be an error or at least
a warning if the compiler does not support this, in general.

For the kernel, the kernel already has plenty of infrastructure to support
this (compiler.h etc.)  For other applications it is quite trivial, too.

> 2. It is specific to asm.

Yes, and that is on purpose.

> I do not have in mind another use case (excluding
> the __builtin_constant_p), but it would be nicer IMHO to have a builtin
> saying =E2=80=9Cignore the cost of this statement=E2=80=9D for the matter=
 of optimizations.

That is a hundred or a thousand times more work to design and implement
(including testing etc.)  I'm not going to do it, but feel free to try
yourself!


Segher
