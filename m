From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 1 Dec 2006 13:19:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011309480.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
 <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org> <45705D79.6000107@am.sony.com>
 <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org> <4570954F.70302@knosof.co.uk>
 <20061201210011.GE3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:28045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161748AbWLAVTq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 16:19:46 -0500
In-Reply-To: <20061201210011.GE3078@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Derek M Jones <derek@knosof.co.uk>, Geoff Levand <geoffrey.levand@am.sony.com>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>



On Fri, 1 Dec 2006, Al Viro wrote:
> 
> "C++ way of doing things" is hardly an endorsement.  _IF_ we are changing
> the way enum works, might as well do it sanely and have the type of
> enumeration constant same as that of expression initializing it (with
> usual implicit initializers).  But yes, that explicitly changes semantics -
> enum { A = 0L, B, C }; will have A, B and C long, not int.  Direct
> contradiction with C90/C99...

Well, the C++ definition at least means that enumerated names have the 
same types _after_ the enumaration is closed (ie the example I sent out 
will at least give the same value for the sizeof() of everything).

So the C++ definition is a lot saner than what gcc does now.

On the other hand, I do agree that "keeping the enumerated type the same 
as the initializer expression type" is _also_ a sane situation. And it's 
better than the C++ situation in the sense that at least the sizes are 
_consistent_ (which C++ is not - the size AT DEFINITION time is 
potentially different from the size AFTER the definition).

So in the C++ world, you have the odd situation that

	enum strange {
		one = (char) 1,
		other = sizeof(one),
	};

we will actually end up with

	other != sizeof(one)

AFTER the declaration (because when "other" got its value, "one" had a 
type of "char", but _after_ the declaration, "one" will have a type of 
"size_t" or "int" or whatever, because the final type of "one" depends on 
the type of the enumerator.

So the C++ definition is really odd, but it's better than what gcc does, 
because at least all the values end up having a common type at the end.

The version where all the values _keep_ their types all the time, and you 
can force them to be whatever you want (by just making sure the 
initializer expression has the right type) is the most flexible one and at 
least doesn't have inconsistencies like the above example, but it's 
neither what gcc nor the C++ standard (or any older C standard, for that 
matter) actually says.

Anyway, because of all this, enum types are a mess. sparse warns if you 
can't fit it in an "int", which is the traditional and fairly dependable 
old C behaviour, and basically says "extended integer types for enums are 
flaky as hell - warn about them!"

		Linus
