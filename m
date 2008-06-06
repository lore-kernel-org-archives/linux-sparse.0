From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 20:15:59 +0200
Message-ID: <20080606181559.GA5999@informatik.uni-freiburg.de>
References: <20080606123434.GA23323@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36057 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969AbYFFTAR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 15:00:17 -0400
Content-Disposition: inline
In-Reply-To: <20080606123434.GA23323@lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

Christoph Hellwig wrote:
> When trying to compile xfsprogs (from oss.sgi.com/projects/xfs)
>=20
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ CC=3D~/bin/cgcc ./configure
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ make
A problem might be that make doesn't "know" that you want to use cgcc.
If your configure is created with a recent autoconf, you should try to
run:

	./configure CC=3D~/bin/cgcc
	make

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsin%28pi%2F2%29
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
