From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 01 Dec 2006 13:17:08 -0800
Message-ID: <45709BD4.80505@am.sony.com>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be> <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org> <45705D79.6000107@am.sony.com> <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org> <Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:13758 "EHLO
	outbound5-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161782AbWLAVRP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 16:17:15 -0500
In-Reply-To: <Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>

Linus Torvalds wrote:
> Btw, try this stupid program, to see just how _strange_ gcc enums are.. A 
> sizeof of the enum is not the same as the size of the individual entries. 

Yes, interesting.  I think your comment regarding compatibility with other
compilers is the convincing one.

Another way is to change the encoding of the value such that it fits into
the range of an enum.  For this particular case, the values are actually
for a field in the high 3 bits, so I can just do the shift when the value
is used.

-Geoff
