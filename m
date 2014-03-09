From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/5] kbuild: LLVMLinux: Add Kbuild support for building
 kernel with Clang
Date: Sun, 9 Mar 2014 22:58:34 +0100
Message-ID: <20140309215834.GA29655@ravnborg.org>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
 <1393376923-21892-2-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393376923-21892-2-git-send-email-behanw@converseincode.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: behanw@converseincode.com
Cc: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Tue, Feb 25, 2014 at 05:08:39PM -0800, behanw@converseincode.com wro=
te:
> From: Behan Webster <behanw@converseincode.com>
>=20
> Add support to toplevel Makefile for compiling with clang, both for
> HOSTCC and CC. Use cc-option to prevent gcc option from breaking clan=
g, and
> from clang options from breaking gcc.
>=20
> Clang 3.4 semantics are the same as gcc semantics for unsupported fla=
gs. For
> unsupported warnings clang 3.4 returns true but shows a warning and g=
cc shows
> a warning and returns false.
>=20
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Signed-off-by: Jan-Simon M=F6ller <dl9pf@gmx.de>
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Cc: PaX Team <pageexec@freemail.hu>
> ---
>  Makefile | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 831b36a..c4ab30d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -247,6 +247,15 @@ HOSTCXX      =3D g++
>  HOSTCFLAGS   =3D -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer
>  HOSTCXXFLAGS =3D -O2
> =20
> +ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
> +HOSTCOMPILER :=3D clang
> +HOSTCFLAGS  +=3D -Wno-unused-value -Wno-unused-parameter \
> +		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
> +else
> +HOSTCOMPILER :=3D gcc
> +endif
> +export HOSTCOMPILER
I see no use of HOSTCOMPLIER anywhere in this patchset not in the kerne=
l. Can we drop this?

> +
>  # Decide whether to build built-in, modular, or both.
>  # Normally, just do built-in.
> =20
> @@ -323,6 +332,12 @@ endif
> =20
>  export quiet Q KBUILD_VERBOSE
> =20
> +ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
> +COMPILER :=3D clang
> +else
> +COMPILER :=3D gcc
> +endif
> +export COMPILER
Likewise - COMPILER seems unsued- can it be dropped?

> =20
>  # Look for make include files relative to root of kernel src
>  MAKEFLAGS +=3D --include-dir=3D$(srctree)
> @@ -382,7 +397,7 @@ KBUILD_CFLAGS   :=3D -Wall -Wundef -Wstrict-proto=
types -Wno-trigraphs \
>  		   -fno-strict-aliasing -fno-common \
>  		   -Werror-implicit-function-declaration \
>  		   -Wno-format-security \
> -		   -fno-delete-null-pointer-checks
> +		   $(call cc-option,-fno-delete-null-pointer-checks,)
>  KBUILD_AFLAGS_KERNEL :=3D
>  KBUILD_CFLAGS_KERNEL :=3D
>  KBUILD_AFLAGS   :=3D -D__ASSEMBLY__
> @@ -620,9 +635,24 @@ else
>  endif
>  KBUILD_CFLAGS +=3D $(stackp-flag)
> =20
> +ifeq ($(COMPILER),clang)
Except that COMPILER is used here. But this does not warrant the export=
=2E

> +KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
Is this really needed today?
https://bugzilla.mozilla.org/show_bug.cgi?id=3D717713 suggest that this=
 is default.

> +KBUILD_CPPFLAGS +=3D $(call cc-option,-Wno-unknown-warning-option,)
https://bugzilla.mozilla.org/show_bug.cgi?id=3D731316 seems to suggest =
this is default


> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-variable)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifi=
er)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
Is it really justified to disable these warnings?
# of warnign for a defconfig build would be a nice figure to judge from=
=2E

> +# Quiet clang warning: comparison of unsigned expression < 0 is alwa=
ys false
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
Same with this.

> +# CLANG uses a _MergedGlobals as optimization, but this breaks modpo=
st, as the
> +# source of a reference will be _MergedGlobals and not on of the whi=
telisted names.
> +# See modpost pattern 2
> +KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
Should we fix modpost?


	Sam
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
