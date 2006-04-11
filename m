From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] sparse: gcc 4.1 warnings
Date: Tue, 11 Apr 2006 02:10:44 -0700
Message-ID: <20060411091044.GA4359@taniwha.stupidest.org>
References: <20060408041419.GA8943@havoc.gtf.org> <20060410132157.4AF15C000E2@dunnock.rentec.com> <443AF8A4.2090007@garzik.org> <20060411085602.GA11643@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:50005 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932364AbWDKJKr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Apr 2006 05:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20060411085602.GA11643@wohnheim.fh-wedel.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Jeff Garzik <jeff@garzik.org>, Morten Welinder <terra@gnome.org>, linux-sparse@vger.kernel.org

On Tue, Apr 11, 2006 at 10:56:02AM +0200, J?rn Engel wrote:

> And yes, this is really obnoxious.  I have read code before that
> constantly does
> 	(void) this(...);
> 	(void) that(...);
> and didn't like it much.  Ignoring the issue and fixing the code
> checker instead might be a better idea.

why not leave it just as it is?

making code ugly and unreadable because some random very of gcc is
being stilly doesn't seem ideal
