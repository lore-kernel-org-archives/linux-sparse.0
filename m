From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Sun, 10 Jun 2007 00:56:30 +0200
Message-ID: <20070609225630.GC3008@uranus.ravnborg.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:48449 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbXFIWz2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2007 18:55:28 -0400
Content-Disposition: inline
In-Reply-To: <466A5204.6060200@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Junio C Hamano <junkio@cox.net>, GIT Mailing-list <git@vger.kernel.org>, linux-sparse@vger.kernel.org

> 
> Also, you might consider just using cgcc to run both GCC and Sparse.  That
> would handle the issue of target-specific CFLAGS, by ensuring that Sparse and
> GCC always see the same CFLAGS.

Is this the recommended way?
I that case I suggest that someone looks into the linux kernel part
and change it to use this method.

	Sam
