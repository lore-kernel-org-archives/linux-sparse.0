From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 15:41:39 +0100
Message-ID: <1226414499.29562.35.camel@spike.firmix.at>
References: <20081111135816.GA25986@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:4154 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741AbYKKOm0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 09:42:26 -0500
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id mABEgELk015289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Tue, 11 Nov 2008 15:42:14 +0100
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id mABEgDsw015285
	for <linux-sparse@vger.kernel.org>; Tue, 11 Nov 2008 15:42:13 +0100
In-Reply-To: <20081111135816.GA25986@logfs.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: linux-sparse@vger.kernel.org, 505177@bugs.debian.org

On Tue, 2008-11-11 at 14:58 +0100, J=C3=B6rn Engel wrote:
[...]
> So what is the right solution to this problem?  Call "gcc --version" =
and
> parse the (deliberately hard) output?  Or make a copy of the gcc head=
ers

There is `gcc -dumpversion`. But it doesn't help if your compiler is
from e.g. /opt/gcc-4.1.2 (where mine usually are).
And `which`, `type -all`, and similar also doesn't really help as the
reported pathname can be actually the ccache binary ....

So you want to use the output of
----  snip  ----
gcc -v -E - </dev/null 2>&1 >/dev/null | sed -n -e '/^#include <\.\.\.>=
 search starts here:/,/^End of search list\./s/^ \(.*\)/\1/p'
----  snip  ----
which also seems to work with non-standard paths (like /opt) and ccache
in between.

	Bernd

PS: The core of the above line is from
    http://sourceware.org/ml/crossgcc/2006-12/msg00038.html. The quite
    trivial `sed` filter is by me.
--=20
=46irmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
