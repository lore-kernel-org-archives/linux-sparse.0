From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 14:58:17 +0100
Message-ID: <20081111135816.GA25986@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lazybastard.de ([212.112.238.170]:47198 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022AbYKKN60 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 08:58:26 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: 505177@bugs.debian.org

Sparse doesn't work for me when compiling userspace code.  Others have
experienced the same, so I refer to someone else's description of the
symptom:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D505177

On my system, sparse tries several headers in order, neither of which
exists:
open("/usr/include/stddef.h", O_RDONLY) =3D -1 ENOENT (No such file or =
directory)
open("/usr/local/include/stddef.h", O_RDONLY) =3D -1 ENOENT (No such fi=
le or directory)
open("/usr/lib/gcc/i486-linux-gnu/4.1.2/include/stddef.h", O_RDONLY) =3D=
 -1 ENOENT (No such file or directory)

Not a big surprise when looking at the headers that do exist:
Galway:/usr/lib/gcc/i486-linux-gnu# ll
total 20
drwxr-xr-x 4 root root 4096 2008-07-01 08:42 3.4.6
drwxr-xr-x 4 root root 4096 2007-09-23 17:59 4.0.4
drwxr-xr-x 3 root root 4096 2008-06-26 00:20 4.1
lrwxrwxrwx 1 root root    3 2007-09-23 20:57 4.1.3 -> 4.1
drwxr-xr-x 3 root root 4096 2008-07-13 11:06 4.2
lrwxrwxrwx 1 root root    3 2008-07-01 08:42 4.2.4 -> 4.2
drwxr-xr-x 4 root root 4096 2008-09-30 16:27 4.3
lrwxrwxrwx 1 root root    3 2008-07-01 08:42 4.3.1 -> 4.3
lrwxrwxrwx 1 root root    3 2008-08-08 18:18 4.3.2 -> 4.3

So why does sparse try 4.1.2 and not 4.1.3 or 4.3.2 or any other
variant?
joern@Galway:/usr/src/kernel/sparse$ cat pre-process.h
#define GCC_INTERNAL_INCLUDE "/usr/lib/gcc/i486-linux-gnu/4.1.2/include=
"

Ah, it is hard-coding the path.

So what is the right solution to this problem?  Call "gcc --version" an=
d
parse the (deliberately hard) output?  Or make a copy of the gcc header=
s
and ship them as /usr/lib/sparse/0.4.1/...?

J=C3=B6rn

--=20
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
