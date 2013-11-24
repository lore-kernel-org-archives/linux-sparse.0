From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 21:52:50 +0100
Message-ID: <1385326370.23961.9.camel@jlt4.sipsolutions.net>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
	 <1385322581.23961.5.camel@jlt4.sipsolutions.net>
	 <20131124202851.GF19762@tassilo.jf.intel.com> <20131124204555.GA13012@leaf>
	 <1385326137.23961.8.camel@jlt4.sipsolutions.net>
	 (sfid-20131124_214905_361728_F87A65B7)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35214 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab3KXUwy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 15:52:54 -0500
In-Reply-To: <1385326137.23961.8.camel@jlt4.sipsolutions.net> (sfid-20131124_214905_361728_F87A65B7)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andi Kleen <ak@linux.intel.com>, Wei Yongjun <weiyj.lk@gmail.com>, linux-sparse@vger.kernel.org

On Sun, 2013-11-24 at 21:48 +0100, Johannes Berg wrote:
> On Sun, 2013-11-24 at 12:45 -0800, Josh Triplett wrote:
> > On Sun, Nov 24, 2013 at 12:28:51PM -0800, Andi Kleen wrote:
> > > > Well, sparse is clearly "right", for all it cares it might very well be
> > > > static, but it seems this is necessary for something in the kernel and
> > > > we clearly can't forward-declare it in a header file. Perhaps we can add
> > > > some annotation to say
> > > > "__attribute__((yes_I_know_but_really_dont_want_this_to_be_static))" to
> > > > suppress this warning? This is getting annoying to me as well :-)
> > > 
> > > We could do something like
> > > 
> > > typeof(foo); 
> > > 
> > > in the macro. Not sure if that would make sparse happy.
> > 
> > If you're just looking to mollify sparse,
> 
> I am, pretty much, since now I get a ton of output and have to either
> grep it or dig through it... :)
> 
> > the easiest way is to
> > put a prototype of the symbol right before the symbol itself.
> 
> Oh, right, good point, thanks Josh. Andi, do you want to do that?
> Otherwise I can post a patch.

The below seems to mollify sparse, but all the attributes make my head
spin so I'm not sure it's really what we need.

--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -59,6 +59,7 @@ extern struct module __this_module;
 	static const char __kstrtab_##sym[]			\
 	__attribute__((section("__ksymtab_strings"), aligned(1))) \
 	= VMLINUX_SYMBOL_STR(sym);				\
+	extern const struct kernel_symbol __ksymtab_##sym;	\
 	__visible const struct kernel_symbol __ksymtab_##sym	\
 	__used							\
 	__attribute__((section("___ksymtab" sec "+" #sym), unused))	\


johannes

