From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 18 Jun 2009 13:13:38 -0700
Message-ID: <4A3A9FF2.1070607@oracle.com>
References: <20090618192058.GB14086@uranus.ravnborg.org> <4A3A96E2.5080504@garzik.org> <4A3A9C2A.8030906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:40478 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZFRUSF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 16:18:05 -0400
In-Reply-To: <4A3A9C2A.8030906@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Jeff Garzik wrote:
> Jeff Garzik wrote:
>> sparse -does- serve as "libsparse" to a few independent projects, and
>> the current sparse/kernel has clear benefits for those projects.  Being 
> 
>         ^^^^
> 
> "current sparse/kernel separation"

Yes, sparse is a general-purpose tool (can be used by lots of apps),
unlike tools/perf/, which is strictly for Linux kernel use.

git is also a user of sparse, and there are plenty of git developers who
are not kernel developers.

-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
