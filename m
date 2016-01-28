From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v2] sparse: add support for static assert
Date: Thu, 28 Jan 2016 09:53:29 -0500 (EST)
Message-ID: <67630678.27333596.1453992809485.JavaMail.zimbra@redhat.com>
References: <1452551482-1250-1-git-send-email-lrichard@redhat.com> <20160125184804.GA43341@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52441 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230AbcA1Oxa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jan 2016 09:53:30 -0500
In-Reply-To: <20160125184804.GA43341@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

----- Original Message -----
> On Mon, Jan 11, 2016 at 05:31:22PM -0500, Lance Richardson wrote:
> 
> 
> Hi,
> 
> I don't understand why tha parsing part have changed so much since v1.
> Is it because I said
>    > It seems a bit strange to me to use NS_TYPEDEF, as this is unrelated
>    > types.
>    > OTOH, the other namespaces deosn't seems better suited,
>    > and yes C11 define this as sort of declaration, so ...
> or because something related to handling it inside structs and unions or
> for some other reason?
> 
> If because of the NS_TYPEDEF thing, sorry if I wasn't clear but I really
> think
> it was fine, just that at first sight I found it strange.
> If because the structs & unions, please explain why is it needed, what was
> wrong
> with v1 and is fine now.

I discovered as I was adding additional test cases that the NS_TYPEDEF
approach was causing sizeof to report a zero size for structures with
embedded _Static_assert(); as part of processing NS_TYPEDEF within
a structure for _Static_assert(), a unnamed field with unknown size
was being attached to the structure definition.

So I decided to take a different approach, one that hopefully makes
more sense than handling _Static_assert() via NS_TYPEDEF. 

Apologies for not providing these details in the v2 commit log. 
> 
> 
> > diff --git a/validation/static_assert.c b/validation/static_assert.c
> > new file mode 100644
> > index 0000000..d3da954
> > --- /dev/null
> > +++ b/validation/static_assert.c
> ...
> > +struct s2 {
> > +	char c;
> > +	_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
> > +};
> 
> This succeed but
> 	struct s2 {
> 		char c;
> 		_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
> 		char d;
> 		_Static_assert(sizeof(struct s2) == 2, "struct sizeof");
> 	};
> succeed also wich seems certainly very odd.
> 

Yes, I believe they should both fail with something like "invalid use of
sizeof on incomplete type".

> However it's not a problem with your patch but because of:
> 1) sparse is fine with the evaluation of sizeof(struct ...) while the struct
>    is not yet completed (which is maybe usefull but certainly can also be
>    considered as a bug)

I think it's a bug.

> 2) those assertions are evaluated at parse time and not at some later time.
>    My first thought was that we really should move the checking of those
>    assertions at a later time, maybe after linearization and by introducing
>    a new operation for it (like OP_ASSERT or so).
>    But this is not a solution for the assertions inside structs & unions.
>    I'll add a separate test case showing the problem and it's probably better
>    to not put this test in your test cases.
> 

OK, I'll post a v3 with the invalid test case removed. Thanks for looking
at this.

   Lance

> Regards,
> Luc
> 
