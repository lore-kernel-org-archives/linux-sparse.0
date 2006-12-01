From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes 0)
Date: Fri, 1 Dec 2006 21:00:11 +0000
Message-ID: <20061201210011.GE3078@ftp.linux.org.uk>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be> <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org> <45705D79.6000107@am.sony.com> <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org> <4570954F.70302@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:26846 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161374AbWLAVAR
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 16:00:17 -0500
Content-Disposition: inline
In-Reply-To: <4570954F.70302@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Geoff Levand <geoffrey.levand@am.sony.com>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>

On Fri, Dec 01, 2006 at 08:49:19PM +0000, Derek M Jones wrote:
> The C++ Standard explicitly supports enumeration constants not
> having type int.  See sentence 858 of
> http://www.coding-guidelines.com/cbook/cbook1_0b.pdf
> for a discussion of the issues (plus some other sentences).
> 
> C compiler vendors, at least those who extend the language, are more
> likely to want to follow the C++ rules (which are documented) than the
> gcc rules (which are poorly documented).
> 
> The C++ way of doing things is also likely to be followed by vendors
> whose C compiler is enabled by a command line switch on their C++
> compiler (eg, at least one vendor based in Seattle).

"C++ way of doing things" is hardly an endorsement.  _IF_ we are changing
the way enum works, might as well do it sanely and have the type of
enumeration constant same as that of expression initializing it (with
usual implicit initializers).  But yes, that explicitly changes semantics -
enum { A = 0L, B, C }; will have A, B and C long, not int.  Direct
contradiction with C90/C99...
