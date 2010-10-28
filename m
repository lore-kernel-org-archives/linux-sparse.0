From: Sven Eckelmann <sven.eckelmann-Mmb7MZpHnFY@public.gmane.org>
Subject: "wrong count at exit" after spin_lock/_unlock pair
Date: Thu, 28 Oct 2010 12:03:43 +0200
Message-ID: <201010281203.46522.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1575344.vSG0leIoSf";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Return-path: <b.a.t.m.a.n-bounces-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:b.a.t.m.a.n-request-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: b.a.t.m.a.n-bounces-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org
Errors-To: b.a.t.m.a.n-bounces-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org
To: linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: b.a.t.m.a.n-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

--nextPart1575344.vSG0leIoSf
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I use sparse (cgcc) with different kernel versions to do some quick checks =
on=20
the batman-adv kernel module. I noticed that my change from UP to SMP kerne=
l=20
generated some 'weird' warnings regarding a 'context imbalance' which I=20
couldn't find, but went away when switching from spin_(un)lock to=20
spin_(un)lock_bh - something which doesn't make sense in my mind.

I am not quite sure if this is linux-headers or sparse related - so I try t=
o=20
post it here first. I choose 2.6.32 because it is the latest long stable=20
kernel and will be used in by Debian Squeeze.

My current test was done like that (on debian squeeze i386):
=2D----------------------------------------------------------
$ cd $MY_v2.6.32
$ make mrproper
$ make allnoconfig
$ grep -v 'CONFIG_MODULES is not set' .config > .config.tmp; mv .config.tmp=
 \
 .config
$ grep -v 'CONFIG_NET is not set' .config > .config.tmp; mv .config.tmp \
 .config
$ grep -v 'CONFIG_SMP is not set' .config > .config.tmp; mv .config.tmp \
 .config
$ grep -v 'CONFIG_MODULE_UNLOAD is not set' .config > .config.tmp; mv \
 .config.tmp .config
$ echo 'CONFIG_MODULES=3Dy' >> .config
$ echo 'CONFIG_NET=3Dy' >> .config
$ echo 'CONFIG_SMP=3Dy' >> .config
$ echo 'CONFIG_MODULE_UNLOAD=3Dy' >> .config
$ echo 'xy'|make menuconfig
$ make prepare
$ make modules


$ mkdir test
$ cd test
$ cat << EOF > Makefile
obj-m +=3D test.o
test-y +=3D main.o
EOF
$ cat << EOF > main.c
#include <linux/module.h>
#include <linux/spinlock.h>

static DEFINE_SPINLOCK(testlock);

static int __init test_init(void)
{
        spin_lock(&testlock);
        spin_unlock(&testlock);
        return 0;
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);
EOF


$ make CC=3Dcgcc -C $MY_v2.6.32/linux-next M=3D$(pwd) modules         =20
make: Entering directory `$MY_v2.6.32'
  CC [M]  $MY_v2.6.32/testmodule/main.o
$MY_v2.6.32/test/main.c:6:19: warning: context imbalance in 'test_init' -=20
wrong count at exit
  LD [M]  $MY_v2.6.32/test/test.o
  Building modules, stage 2.
  MODPOST 1 modules
  LD [M]  $MY_v2.6.32/test/test.ko
make: Leaving directory `$MY_v2.6.32'
=2D----------------------------------------------------------

The sparse version was v0.4.3. It was obtained from git and and build using=
=20
the current Debian squeeze tools provided by build-essential. It was run fr=
om=20
the build dir by specifying it in $PATH

$ export PATH=3D$MY_SPARSE_CHECKOUT:$PATH

Best regards,
	Sven

--nextPart1575344.vSG0leIoSf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMyUqBAAoJEF2HCgfBJntGq38QAMx7z4FgX+zQfuCGxGXLd/Es
K9MkSitY/ifFPaOqAYnLCd1tX8jtNw2aFoxi7zslvpRM+ei33iwtMaz/GPuE0Fzg
OF92E7SptpreaYQOwj3ZD+E0JuQjkSCCrqai7STwQT3EQX74PoyWzhb+1FnknGTL
FNyhTyxnHE9zQuQ2XbnQe6xsOVsxjVKKTgyqQPa3rWIBzfZhiOSXMPc/1aLDuhoL
+Zh2EJCVMxkBHNoppDUP63EwQE0Ax99VrTn+wWMLWQ8NBMfeHDvFCHZ8g/Hz1+5X
TTlcbzCsakhwr3LG8qQE6oGZ20IMDyKRWSNgf6bUNskJyGWVI+gPVKj8jUzLC7Ff
qU7adE4ymm+yosg0+bTseyuuuy5cZ+nJtAYg2+Q9I75HAGOHbqXNLSKHHs9dbqS+
PfjfO1WZ5wDF5Ry5SdjxZIAeDxmks9AeGRPTGbcXGr5SNSF5kJmKVDQBF3GVmnKu
pziGePgzLe5KrUypLYEcZqOiE6kB+GXUad/MbzsEOqBDym3AMlSL664bTR8O0rL3
V+xpjJWfhlLGNb7fKoMSt9KcPQ0j6WmtWg651boKUosrtQ+ZSSINUXE5fr8WPH0s
hJRrkouxqcZHtBdevgstLS+auSiny9+g8NE8X+Iqr+nTtccdqk2NYIV7J8DZxWys
cNZeq37BkZC6++4vM57L
=V/7C
-----END PGP SIGNATURE-----

--nextPart1575344.vSG0leIoSf--
