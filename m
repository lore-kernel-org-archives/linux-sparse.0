From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Sparse Ctags
Date: Fri, 08 Dec 2006 03:49:38 -0500
Message-ID: <45792722.3030007@garzik.org>
References: <20061208022705.GA18370@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49359 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425201AbWLHItm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Dec 2006 03:49:42 -0500
In-Reply-To: <20061208022705.GA18370@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Christopher Li wrote:
> Here is my attempt to write a Ctags base on sparse.
> It depend on the result from actually preprocessing the C source file.
> It can handle the tags from macro expansion.
> 
> It works well enough for me to locate "int32_t" and "clear_token_alloc".
> 
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Hey, cool.  One of my long-term projects is to implement the POSIX 
utilities[1], and ctags is on the list[2] of utilities I want to implement.

I was hoping that I, or someone else, could take libsparse and use it to 
provide a ctags(1) utility.  Other utilities I hope can be implemented 
include cflow[3] and cxref[4].  And c99(1), of course ;-)

	Jeff


[1] git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/posixutils.git
[2] http://www.opengroup.org/onlinepubs/009695399/idx/utilities.html
[3] http://www.opengroup.org/onlinepubs/009695399/utilities/cflow.html
[4] http://www.opengroup.org/onlinepubs/009695399/utilities/cxref.html
