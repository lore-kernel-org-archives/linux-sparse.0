From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Hard-coded gcc header path
Date: Wed, 12 Nov 2008 00:10:17 +0100
Message-ID: <1226445017.3331.19.camel@gimli.at.home>
References: <20081111135816.GA25986@logfs.org>
	 <1226412106.4478.5.camel@johannes.berg> <20081111141459.GB25986@logfs.org>
	 <20081111201328.GA10073@artemis.corp> <20081111202849.GD25986@logfs.org>
	 <118833cc0811111300q4e7571f5o2a56a652f9a941e9@mail.gmail.com>
	 <20081111223215.GA30224@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:5511 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbYKKXKf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 18:10:35 -0500
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id mABNANex002886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 12 Nov 2008 00:10:23 +0100
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id mABNAMgI002881
	for <linux-sparse@vger.kernel.org>; Wed, 12 Nov 2008 00:10:22 +0100
In-Reply-To: <20081111223215.GA30224@logfs.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: Morten Welinder <mwelinder@gmail.com>, Pierre Habouzit <madcoder@debian.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, 505177@bugs.debian.org

On Die, 2008-11-11 at 23:32 +0100, J=C3=B6rn Engel wrote:
[...]
> Either sparse gets smart enough to find the headers [1] or it ships i=
ts
> own set.  Anything else will continue to fail on one machine or anoth=
er.

I don't think that shipping a copy of .h files from one gcc version wil=
l
seriously help people using `pcc` (or any other compiler).
But I'm probably missing something here.

> [1] Bernd Petrovitsch sent me this neat one-liner in a private mail:
> gcc -v -E - </dev/null 2>&1 >/dev/null | sed -n -e '/^#include <\.\.\=
=2E> search starts here:/,/^End of search list\./s/^ \(.*\)/\1/p
>=20
> We could add that to cgcc to set additional include paths.

And there probably are similar ones for `pcc` or others.

	Bernd
--=20
=46irmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
