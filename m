From: Marco Elver <elver@google.com>
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Date: Thu, 28 May 2020 09:59:00 +0200
Message-ID: <20200528075900.GA236442@google.com>
References: <202005280727.lXn1VnTw%lkp@intel.com>
 <20200527235442.GC1805@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200527235442.GC1805@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com, arnd@arndb.de, will@kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, 28 May 2020, Borislav Petkov wrote:

> On Thu, May 28, 2020 at 07:39:31AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git loc=
king/kcsan
> > head:   a5dead405f6be1fb80555bdcb77c406bf133fdc8
> > commit: a5dead405f6be1fb80555bdcb77c406bf133fdc8 [12/12] compiler_types=
=2Eh: Optimize __unqual_scalar_typeof compilation time
> > config: i386-randconfig-s002-20200527 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
> >         git checkout a5dead405f6be1fb80555bdcb77c406bf133fdc8
> >         # save the attached .config to linux build tree
> >         make W=3D1 C=3D1 ARCH=3Di386 CF=3D'-fdiagnostic-prefix -D__CHEC=
K_ENDIAN__'
> >=20
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> I'll say.
>=20
> Looking at the subject, that broke the 0day bot too. :-)
>=20
> /me trims it.
>=20
> Looks like we need __CHECKER__ ifdeffery somewhere but it is too late
> for me to think straight so tomorrow...

Ouch. The below should be all we need, assuming it's the best we can do
for sparse right now.

Thanks,
-- Marco

------ >8 ------

=46rom: Marco Elver <elver@google.com>
Date: Thu, 28 May 2020 09:43:13 +0200
Subject: [PATCH] compiler_types.h: Use unoptimized __unqual_scalar_typeof f=
or
 sparse

If the file is being checked with sparse, use the unoptimized version of
__unqual_scalar_typeof(), since sparse does not support _Generic.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a529fa263906..c1ee20812a8c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,7 +246,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
-#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(_=
_CHECKER__)
 /*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
--=20
2.27.0.rc0.183.gde8f92d652-goog
