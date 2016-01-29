From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] sparse: add support for static assert
Date: Fri, 29 Jan 2016 17:15:56 +0100
Message-ID: <20160129161554.GA730@macbook.lan>
References: <1452551482-1250-1-git-send-email-lrichard@redhat.com>
 <20160125184804.GA43341@macpro.local>
 <67630678.27333596.1453992809485.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34082 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcA2QQA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Jan 2016 11:16:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so10748552wmp.1
        for <linux-sparse@vger.kernel.org>; Fri, 29 Jan 2016 08:15:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <67630678.27333596.1453992809485.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jan 28, 2016 at 09:53:29AM -0500, Lance Richardson wrote:
> ----- Original Message -----
> > On Mon, Jan 11, 2016 at 05:31:22PM -0500, Lance Richardson wrote:
> > 
> > 
> > Hi,
> > 
> > I don't understand why tha parsing part have changed so much since v1.
> 
> I discovered as I was adding additional test cases that the NS_TYPEDEF
> approach was causing sizeof to report a zero size for structures with
> embedded _Static_assert(); as part of processing NS_TYPEDEF within
> a structure for _Static_assert(), a unnamed field with unknown size
> was being attached to the structure definition.
> 
> So I decided to take a different approach, one that hopefully makes
> more sense than handling _Static_assert() via NS_TYPEDEF. 
> 
> Apologies for not providing these details in the v2 commit log. 

OK, I understand.
Yes, it's certainly worth to add that in the patch description.

> > > +struct s2 {
> > > +	char c;
> > > +	_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
> > > +};
> > 
> > This succeed but
> > 	struct s2 {
> > 		char c;
> > 		_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
> > 		char d;
> > 		_Static_assert(sizeof(struct s2) == 2, "struct sizeof");
> > 	};
> > succeed also wich seems certainly very odd.
> > 
> 
> Yes, I believe they should both fail with something like "invalid use of
> sizeof on incomplete type".

> 
> I think it's a bug.
> 

Absolutely.
 
> 
> OK, I'll post a v3 with the invalid test case removed. Thanks for looking
> at this.
> 
>    Lance

Good.
Please also add the explanation about the parsing in the patch description.

Luc 
