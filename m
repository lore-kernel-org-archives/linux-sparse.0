From: Brett Nash <nash@fst.net>
Subject: Re: Booleans, what a wonderful type!
Date: Wed, 18 Jul 2007 12:40:21 +1000
Message-ID: <1184726421.29594.4.camel@baboon.fluffyspider.com.au>
References: <1184723019.469d704b6111b@portal.student.luth.se>
	 <20070718021907.GS21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 218-214-60-232.people.net.au ([218.214.60.232]:39355 "EHLO
	sealpup.fluffyspider.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752289AbXGRDIY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jul 2007 23:08:24 -0400
In-Reply-To: <20070718021907.GS21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: ricknu-0@student.ltu.se, linux-sparse@vger.kernel.org

On Wed, 2007-07-18 at 03:19 +0100, Al Viro wrote:

> Yes, and AFAICS uses of va_start()/va_end() in sparse are correct.  If you
> see any broken one - yell.

As an aside; how hard is to get sparse to check for this?

Would the general lock structure do enough with the right declaration of
va_start/va_end?   

	Regards,
	nash
