From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 13:37:27 +0900
Message-ID: <20070526043727.GQ2547@daikokuya.co.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <20070526034409.GO2547@daikokuya.co.uk> <20070526042219.GR4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7484 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751731AbXEZEgk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 00:36:40 -0400
Content-Disposition: inline
In-Reply-To: <20070526042219.GR4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al Viro wrote:-

> On Sat, May 26, 2007 at 12:44:09PM +0900, Neil Booth wrote:
>  
> > Perhaps not overloading the "+" node; reserve that for arithmetic types.
> > Have a ptr_add, (maybe) ptr_sub, and ptr_diff operations.
> 
> Making the scaling a part of operation?  It means interesting logics
> at later stages, though...

Yes.  Should be handlable in one place during the lowering phase
(linearize? - I'm not too familiar with what sparse does after
parsing).

If you do make the scaling explicit in the IR, then in-line with
my belief that the IR should make all implicit operations explicit,
the multiplication would be on two operands of the same type, with
explicit casts wherever necessary.  I think having the extra nodes
and a sane IR is much better to having a non-orthogonal IR of fewer
nodes full of special cases (look at the mess GCC has with the latter).

Neil.
