From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Sparse RFC
Date: Tue, 27 Mar 2007 14:04:45 +0200
Message-ID: <20070327120445.GD12178@informatik.uni-freiburg.de>
References: <1174915776.1142.21.camel@localhost.localdomain> <4607F19B.6080303@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47636 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753804AbXC0Mxs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Mar 2007 08:53:48 -0400
Content-Disposition: inline
In-Reply-To: <4607F19B.6080303@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Darren Jenkins <darrenrjenkins@gmail.com>
Cc: Derek M Jones <derek@knosof.co.uk>, Sparse mailing list <linux-sparse@vger.kernel.org>

Hi Darren,


Derek M Jones wrote:
> Darren,

> >I have been playing around with the sparse code, and was thinking of
> >adding a few of the checks that my company uses from other code
> >checkers, starting with checking that macro arguments have brackets
> >around them. (Because this is the test my/other code most often fail=
s)

> This is a useful check.  However, you need to make sure that
> cases where the presence of () have no impact are not flagged
> if the parameter is always used in such contexts.  Otherwise the
> noise can be excessive.

> >2) For the macro argument checking would it be better if I checked f=
or
> >either a bracket or low precedence operator on both sides of the
> >argument ? like either a comma or a type of assignment operator? it
> >would not be a foolproof check then but would seem more sensible to =
me,
> >and might be more acceptable to users.
You have to consider ## and #, too.  E.g. look at
include/linux/stringify.h, or SOCKCALL_WRAP in include/linux/net.h

BTW, SOCKCALL_WRAP is funny anyhow, because the last two arguments are
supposed to be function arguments (resp. their type list).

Best regards
Uwe


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5%2B7
