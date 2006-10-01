From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 10:58:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011056090.3952@g5.osdl.org>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
 <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org> <20061001172253.GX29920@ftp.linux.org.uk>
 <20061001172911.GY29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:46822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932142AbWJAR6n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 13:58:43 -0400
In-Reply-To: <20061001172911.GY29920@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org



On Sun, 1 Oct 2006, Al Viro wrote:
>
> PS: "fouled(le16)" is exactly "int, and if you narrow it to 16bit, it'd
> better be le16".  We could separate that from type information, but hey,
> if we want to carry reference to some type + indication that we do have
> that reference + int as type, we might as well introduce a type node
> saying "I'm int, might be base_type".  Which is exactly what I've done...

Ok, I'm convinced.

The "fouled" bit may be a special case, but it's less of a special case 
than I thought. In fact, it could be used as a preliminary kind of "expand 
this op to int" that would entirely replace the explicit "implicit cast" 
we do now. 

(Although doing the implicit C casts as _explicit_ casts in sparse does 
have a lot of advantages, and avoids us having to test for things, so I'm 
not convinced we would want to actually expand "fouled" bit usage past the 
bitwise ops).

So I'll pull your tree.

Thanks,

		Linus
