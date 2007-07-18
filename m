From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Booleans, what a wonderful type!
Date: Wed, 18 Jul 2007 03:25:19 +0100
Message-ID: <20070718022519.GT21668@ftp.linux.org.uk>
References: <1184723019.469d704b6111b@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33062 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482AbXGRCZU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jul 2007 22:25:20 -0400
Content-Disposition: inline
In-Reply-To: <1184723019.469d704b6111b@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

On Wed, Jul 18, 2007 at 03:43:39AM +0200, ricknu-0@student.ltu.se wrote:
> Good morning to you all!
> 
> As most of you do not know, I am on Google's SoC
> <http://code.google.com/soc/2007/sparse/appinfo.html?csaid=CB0974F67B64AD0C> to
> add the ability to suggestions when booleans could/should be used.

Er...  Of _course_ booleans are values.  And yes, you can say true + false.
Guaranteed to evaluate to int, value of expression being 1.  It's perfectly
correct C99.  Same as true + true is guaranteed to be 2 (int, again); assigning
that to _Bool variable is guaranteed to give 1, aka true (see the rules
for conversion to _Bool).

Now, sparse handling of _Bool sucks in quite a few places (e.g. conversion
to it is not reduction modulo 2, it's comparison with 0), but I wonder if
that's what you have in mind...
