From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 23:46:56 +0100
Message-ID: <20101011224656.GN19804@ZenIV.linux.org.uk>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
 <20101009205930.GA4684@feather>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37446 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0JKWq7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 18:46:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, Oct 12, 2010 at 12:33:32AM +0200, Tomas Klacko wrote:

> Great. I am posting my current status (as a patch) so that you can comment on it
> and that I can refine it further.

ehh...  Use of capitalized variable names is a Bad Idea(tm).  Especially
since you are doing that well outside of headers, so even compatibility
with Straustrups's Mistake does not serve as a reason.

> -#define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
> +#define CHECK_TYPE(head,ptr)		(void)((void*)&(ptr) == (void*)&(head)->list[0])

WTF?  You do realize that it defeats the only purpose of this thing?
