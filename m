From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Style checking
Date: Thu, 3 May 2007 18:34:53 +0200
Message-ID: <20070503163452.GA21333@informatik.uni-freiburg.de>
References: <c38fc0de0704300030x6ab610acge10482904056d1db@mail.gmail.com> <46378276.8060307@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:40481 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031363AbXECRPD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2007 13:15:03 -0400
Content-Disposition: inline
In-Reply-To: <46378276.8060307@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Mike Goodwin <mike.goodwin@cantab.net>, linux-sparse@vger.kernel.org

Hello,

Josh Triplett wrote:
> In addition to the warnings you suggest, I'd love to see a warning fo=
r "Header
> not self-contained": a header does not #include all the headers it ne=
eds, and
> instead relied on the inclusion of another header first.
IIRC X oblige you to use a certain order of #include's, and there might
be some headers in the linux kernel that are not self-contained on
purpose.  But this should not stop you (or anyone else) to implement
such checks :-)

The other way round is interesting, too:  "Header included but unused."
This could be used to speed up rebuilds if build dependencies are
auto-generated.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+degree+celsius+in+kelvin
