From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 1 Dec 2006 12:50:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com> <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
 <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org> <45705D79.6000107@am.sony.com>
 <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:57216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S936562AbWLAUuo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 15:50:44 -0500
In-Reply-To: <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>



On Fri, 1 Dec 2006, Linus Torvalds wrote:
> 
> But at times, some of the gcc extensions aren't necessarily that well 
> defined or thought out, or simply not worth it. The extended type system 
> for enums in gcc is just basically messy, and it doesn't really offer you 
> anything important.

Btw, try this stupid program, to see just how _strange_ gcc enums are.. A 
sizeof of the enum is not the same as the size of the individual entries. 

Notice also how the size of the enum entry is _not_ tied to the type of 
the expression it had, but literally to its _value_. The size of "one" 
ends up being 4, even though it was initialized with a "1ll" value.

So with gcc-enums, you CANNOT get a sane type result.

In contrast, if you want sane types, you could easily do

	#define one (1ull)
	#define other (0x10000ull)
	#define strange (0x100000000ull)

and they'd all have the same type (and having the same type means that 
they act the same in expressions - you get the same expression type in 
mixing these values, _unlike_ the insane gcc enum cases)

		Linus

---
enum hello {
	one = 1ll,
	other = 0x10000,
	bigval = 0x1000000000000ll,
};

int main(int argc, char **argv)
{
	printf("%zu %zu %zu %zu\n",
		sizeof(enum hello),
		sizeof(one),
		sizeof(other),
		sizeof(bigval));
	return 0;
}
