From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] Makefile: suppress error message from shell
Date: Tue, 21 Jul 2009 22:50:15 +0100
Message-ID: <4A663817.8040503@ramsay1.demon.co.uk>
References: <4A6233D0.1060502@ramsay1.demon.co.uk>	 <20090719140316.GB25417@feather> <70318cbf0907201321y26cba10h2d77d7ae02d86090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:61623 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756269AbZGUV4l (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 17:56:41 -0400
In-Reply-To: <70318cbf0907201321y26cba10h2d77d7ae02d86090@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
>> On Sat, Jul 18, 2009 at 09:42:56PM +0100, Ramsay Jones wrote:
>>> In particular, on systems which do not have 'pkg-config' installed,
>>> every invocation of make issues the following message:
>>>
>>>     /bin/sh: pkg-config: command not found
>>>
>>> Suppress the message by redirecting stderr to the bit-bucket.
> 
> Applied.
> 
> Thanks

Thanks.

Hmm, I noticed that you edited the "subject line" when you applied
the patch; namely s/shell/pkg-config/.

I find this a little puzzling, since the error message *is* issued
by the shell and is definitely *not* issued by pkg-config... which
is kinda the point... ;-)

ATB,
Ramsay Jones


