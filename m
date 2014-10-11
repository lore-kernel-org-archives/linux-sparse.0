From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Sat, 11 Oct 2014 20:57:25 +0100
Message-ID: <54398BA5.6050005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:46235 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751006AbaJKT52 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Oct 2014 15:57:28 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Passing the '-Wsparse-error' to cgcc can cause that option to be
passed to the C compiler (usually gcc), if the given source file
does not provoke any sparse warnings, which in turn results in
a failure to compile that file.

In order to avoid passing this sparse option to the compiler, we
add the '-Wsparse-error' option to the regular expression check
in the 'check_only_option' function.

In addition, we replace the plain call to 'die' when sparse exits
with non-zero status (maybe due to -Wsparse-error), with a simple
'exit 1'. This suppresses an 'Died at ./cgcc line 86.' message on
exit from cgcc.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

The following shows the error/fix:

    $ pwd
    /home/ramsay/sparse
    $ cat -n hello.c
         1	#include <stdio.h>
         2=09
         3	int main(void)
         4	{
         5		printf("Hello, world!\n");
         6		return 0;
         7	}
    $ CHECK=3D./sparse ./cgcc hello.c
    $ echo $?
    0
    $ CHECK=3D./sparse ./cgcc -Wsparse-error hello.c
    cc: error: unrecognized command line option =E2=80=98-Wsparse-error=
=E2=80=99
    $ echo $?
    1
    $=20

Note gcc complaining about the unknown option.
Now edit hello.c so that we generate a sparse warning ...

    $ cat -n hello.c
         1	#include <stdio.h>
         2=09
         3	int f(void)
         4	{
         5		return 42;
         6	}
         7=09
         8	int main(void)
         9	{
        10		printf("Hello, world!\n");
        11		return 0;
        12	}
    $ CHECK=3D./sparse ./cgcc hello.c
    hello.c:3:5: warning: symbol 'f' was not declared. Should it be sta=
tic?
    $ echo $?
    0
    $ CHECK=3D./sparse ./cgcc -Wsparse-error hello.c
    hello.c:3:5: error: symbol 'f' was not declared. Should it be stati=
c?
    Died at ./cgcc line 86.
    $ echo $?
    1
    $=20

After this patch:

    with the original hello.c ...

    $ CHECK=3D./sparse ./cgcc hello.c
    $ echo $?
    0
    $ CHECK=3D./sparse ./cgcc -Wsparse-error hello.c
    $ echo $?
    0
    $=20

    with the modified hello.c ...

    $ CHECK=3D./sparse ./cgcc hello.c
    hello.c:3:5: warning: symbol 'f' was not declared. Should it be sta=
tic?
    $ echo $?
    0
    $ CHECK=3D./sparse ./cgcc -Wsparse-error hello.c
    hello.c:3:5: error: symbol 'f' was not declared. Should it be stati=
c?
    $ echo $?
    1
    $=20

ATB,
Ramsay Jones


 cgcc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index 8ee8da1..8e38174 100755
--- a/cgcc
+++ b/cgcc
@@ -83,7 +83,7 @@ if ($do_check) {
=20
     print "$check\n" if $verbose;
     if ($do_compile) {
-	system ($check) =3D=3D 0 or die;
+	system ($check) =3D=3D 0 or exit 1;
     } else {
 	exec ($check);
     }
@@ -101,7 +101,7 @@ exit 0;
=20
 sub check_only_option {
     my ($arg) =3D @_;
-    return 1 if $arg =3D~ /^-W(no-?)?(default-bitfield-sign|one-bit-si=
gned-bitfield|cast-truncate|bitwise|typesign|context|undef|ptr-subtract=
ion-blows|cast-to-as|decl|transparent-union|address-space|enum-mismatch=
|do-while|old-initializer|non-pointer-null|paren-string|return-void|des=
ignated-init|sparse-all)$/;
+    return 1 if $arg =3D~ /^-W(no-?)?(default-bitfield-sign|one-bit-si=
gned-bitfield|cast-truncate|bitwise|typesign|context|undef|ptr-subtract=
ion-blows|cast-to-as|decl|transparent-union|address-space|enum-mismatch=
|do-while|old-initializer|non-pointer-null|paren-string|return-void|des=
ignated-init|sparse-all|sparse-error)$/;
     return 1 if $arg =3D~ /^-v(no-?)?(entry|dead)$/;
     return 0;
 }
--=20
2.1.0
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
