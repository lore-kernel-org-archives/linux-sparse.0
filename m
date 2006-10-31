From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Official releases?
Date: Tue, 31 Oct 2006 10:37:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610311030370.25218@g5.osdl.org>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>
 <20061031170824.GC23354@redhat.com> <1162318761.3785.3.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:14046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423776AbWJaSiX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 Oct 2006 13:38:23 -0500
In-Reply-To: <1162318761.3785.3.camel@zod.rchland.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org



On Tue, 31 Oct 2006, Josh Boyer wrote:
>
> Yes, but you don't keep them all laying around forever.  You keep about
> a week's worth right?

If each tar-ball contains the git version, at least you can get back to 
it..

Anyway, I suspect it would be better if people didn't consider me the 
maintainer for sparse, simply because it does the things I really cared 
about, and as a result I'm not really very active.

How about talking to Josh Triplett, who maintains a tree at

	git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git

with gitk at

	http://www.kernel.org/git/?p=linux/kernel/git/josh/sparse.git;a=summary

and see if he wouldn't mind making "real" releases.

		Linus
