From: terra@gnome.org (Morten Welinder)
Subject: Re: [PATCH] sparse: gcc 4.1 warnings
Date: Mon, 10 Apr 2006 09:21:57 -0400 (EDT)
Message-ID: <20060410132157.4AF15C000E2@dunnock.rentec.com>
References: <20060408041419.GA8943@havoc.gtf.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from centaur.rentec.com ([216.223.240.8]:19073 "EHLO
	centaur.rentec.com") by vger.kernel.org with ESMTP id S1750869AbWDJNWS
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Apr 2006 09:22:18 -0400
In-reply-to: <20060408041419.GA8943@havoc.gtf.org> (message from Jeff Garzik
	on Sat, 8 Apr 2006 00:14:19 -0400)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: jeff@garzik.org
Cc: linux-sparse@vger.kernel.org


This doesn't look quite right.

So it looks like gcc 4.1 complains over non-used values that are the
result of a cast.  That feels obnoxious, but in this case maybe you
could try just casting to void in add_ptr_list -- is the value ever
used?

Morten
