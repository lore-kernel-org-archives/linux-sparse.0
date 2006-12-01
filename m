From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 1 Dec 2006 15:55:01 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0612011553100.30940@pademelon.sonytel.be>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
 <20061201143940.GB3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from vervifontaine.sonytel.be ([80.88.33.193]:57806 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S1759298AbWLAOzC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 09:55:02 -0500
In-Reply-To: <20061201143940.GB3078@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org

On Fri, 1 Dec 2006, Al Viro wrote:
> On Fri, Dec 01, 2006 at 03:25:08PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 21 Nov 2006, Geoff Levand wrote:
> > > +enum ps3_vendor_id {
> > > +	PS3_VENDOR_ID_NONE = 0,
> > > +	PS3_VENDOR_ID_SONY = 0x8000000000000000UL,
> > > +};
> > 
> > I've just ran `make C=1' (PPC in 64-bit mode, and sparse is called with -m64),
> > and noticed that sparse (cloned from
> > git://git.kernel.org/pub/scm/devel/sparse/sparse.git a few minutes ago)
> > complains about the second value with:
> > 
> > | warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> > 
> > Section 6.7.2.2.4 of C99 says:
> > 
> > | Each enumerated type shall be compatible with char, a signed integer type, or
> > | an unsigned integer type. The choice of type is implementation-defined, but
> > | shall be capable of representing the values of all the members of the
> > | enumeration.
> 
> FWIW, that code is *not* valid C99; note that all enumeration members must
> fit the range of int (see 6.7.2.2.2).  What you quote speaks about the

You're right. I missed that one.

> IOW, you are using a gccism in an area where gcc is bloody inconsistent
> in the set of bugs it shows in different versions.

Hmmm...

> Generally safe way is to split the anonymous huge enum members into
> single-element enums and pray that gcc will at least stay consistent
> in handling of those.

Or fall back to #defines, which is what we were trying to avoid in the first
place (i.e. group related values together in enums)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
