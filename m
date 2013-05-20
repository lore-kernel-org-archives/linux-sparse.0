From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Mon, 20 May 2013 19:42:53 +0100
Message-ID: <519A6EAD.8070700@ramsay1.demon.co.uk>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org> <5197387E.5030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:50995 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756068Ab3ETSog (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 May 2013 14:44:36 -0400
In-Reply-To: <5197387E.5030000@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Chris Li wrote:
> On 05/18/2013 12:38 AM, Christopher Li wrote:
>> I guess the rules is that parenthesized string can appear in
>> any place where string was allowed.
>=20
>=20
> I create an incremental patch to address the issue. Please
> check if that works for you.

Unfortunately not. :(

In my git repo, I just happen to be on the pu branch:

  $ pwd
  /home/ramsay/git
  $ git describe
  v1.8.3-rc3-347-gac05152
  $=20

Using an older version of sparse (I don't know exactly which version;
although I have had a patch to add --version for some years, I wasn't
actually using a version with it applied!).

  $ make sparse >psp-out0 2>&1
  $ grep warning psp-out0 | wc -l
  7
  $ grep error psp-out0 | wc -l
  0
  $=20

Note that the severn warnings all relate to the glibc headers using
an transparent union for the various sockaddr types, for example:

      SP connect.c
  connect.c:272:40: warning: incorrect type in argument 2 (invalid type=
s)
  connect.c:272:40:    expected union __CONST_SOCKADDR_ARG [usertype] _=
_addr
  connect.c:272:40:    got struct sockaddr *ai_addr

Installing a new version of sparse:

  $ sparse --version
  v0.4.5-rc1
  $ make sparse >psp-out1 2>&1
  $ grep warning psp-out1 | wc -l
  9
  $ grep error psp-out1 | wc -l
  1
  $ diff psp-out0 psp-out1
  77a78
  > notes-merge.c:111:9: warning: too long initializer-string for array=
 of char
  111a113
  > sha1_file.c:54:9: warning: too long initializer-string for array of=
 char
  152a155
  > compat/regex/regex_internal.c:926:1: error: symbol 're_string_conte=
xt_at' redeclared with different type (originally declared at compat/re=
gex/regex_internal.h:434) - different modifiers
  $=20

Note that the two new warnings are fixed by my first patch and the
error is the second regression that I mentioned.

So, now introduce an "parenthesized string initializer", thus:

  $ vim gettext.h
  $ git diff
  diff --git a/gettext.h b/gettext.h
  index 7671d09..d11a413 100644
  --- a/gettext.h
  +++ b/gettext.h
  @@ -63,6 +63,6 @@ const char *Q_(const char *msgid, const char *plu, =
unsigned lo
   }
  =20
   /* Mark msgid for translation but do not translate it. */
  -#define N_(msgid) msgid
  +#define N_(msgid) (msgid)
  =20
   #endif
  $ make sparse >psp-out2 2>&1
  $ grep warning psp-out2 | wc -l
  31
  $ grep error psp-out2 | wc -l
  2
  $=20

The new warnings all look like this:

  $ grep warning psp-out2 | head -3
  branch.c:216:1: warning: too long initializer-string for array of cha=
r
  branch.c:218:1: warning: too long initializer-string for array of cha=
r
  branch.c:220:1: warning: too long initializer-string for array of cha=
r
  $=20

The additional error is a simple syntax error:

  $ rm builtin/log.o
  $ make builtin/log.o
      CC builtin/log.o
  builtin/log.c:42: error: called object =91"git log [<options>] [<revi=
sion range>] [[--] <path>...]\012"=92 is not a function
  make: *** [builtin/log.o] Error 1
  $ make builtin/log.sp
      SP builtin/log.c
  builtin/log.c:42:9: error: not a function <noident>
  $=20

Now install a version of sparse with my three patches applied:

  $ sparse --version
  v0.4.5-rc1-3-g14eceaa
  $ make sparse >psp-out3 2>&1
  $ grep warning psp-out3 | wc -l
  7
  $ grep error psp-out3 | wc -l
  2
  $=20

So, all of the additional "too long initializer-string" warnings
are no longer issued.

Now add your additional patch on top:

  $ sparse --version
  v0.4.5-rc1-4-g5ef4e35
  $ make sparse >psp-out4 2>&1
  $ grep warning psp-out4 | wc -l
  177
  $ grep error psp-out4 | wc -l
  2
  $=20

All of the additional warnings, look like:

  $ grep warning psp-out4 | head -3
  archive.c:14:9: warning: excessive elements in array initializer
  archive.c:221:39: warning: excessive elements in array initializer
  attr.c:327:9: warning: excessive elements in array initializer
  $=20

Note that the warnings don't all involve the use of the gettext
'N_' macro. Also, many (I haven't checked them all) are actually
arrays of 'char *' (_not_ array of char). For example, from the
above list, archive.c:221 looks like this:

        const char *paths[] =3D { path, NULL };

HTH

ATB,
Ramsay Jones




--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
