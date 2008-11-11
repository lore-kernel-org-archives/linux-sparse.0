From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 23:32:15 +0100
Message-ID: <20081111223215.GA30224@logfs.org>
References: <20081111135816.GA25986@logfs.org> <1226412106.4478.5.camel@johannes.berg> <20081111141459.GB25986@logfs.org> <20081111201328.GA10073@artemis.corp> <20081111202849.GD25986@logfs.org> <118833cc0811111300q4e7571f5o2a56a652f9a941e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lazybastard.de ([212.112.238.170]:55202 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbYKKWc0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 17:32:26 -0500
Content-Disposition: inline
In-Reply-To: <118833cc0811111300q4e7571f5o2a56a652f9a941e9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: Pierre Habouzit <madcoder@debian.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, 505177@bugs.debian.org

On Tue, 11 November 2008 16:00:21 -0500, Morten Welinder wrote:
>=20
> The problem is not the header files, but that we need to ensure that =
the
> proper include path is set up.
>=20
> This is needed because sparse currently tries to mimic some
> indeterminate gcc version in terms of predefines.  A similar solution
> would be needed to mimic any other compiler.  We obviously need
> a default path for system headers somehow.
>=20
> In this case, we could probably get away with accepting a definition
> of GCC_INTERNAL_INCLUDE on the command line and use that in
> preference over whatever is in pre-process.h

That doesn't strike me as an improvement.  I have a workaround, which i=
s
to create a symlink in /usr/lib/gcc/i486-linux-gnu/ that matches what
sparse expects.  If I had to set GCC_INTERNAL_INCLUDE on every
invocation, I'd consider that worse than my current workaround.

Either sparse gets smart enough to find the headers [1] or it ships its
own set.  Anything else will continue to fail on one machine or another=
=2E

[1] Bernd Petrovitsch sent me this neat one-liner in a private mail:
gcc -v -E - </dev/null 2>&1 >/dev/null | sed -n -e '/^#include <\.\.\.>=
 search starts here:/,/^End of search list\./s/^ \(.*\)/\1/p

We could add that to cgcc to set additional include paths.

J=C3=B6rn

--=20
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
