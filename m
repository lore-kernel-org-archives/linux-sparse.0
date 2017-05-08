From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v6] sparse: add support for _Static_assert
Date: Mon, 8 May 2017 19:45:52 -0400 (EDT)
Message-ID: <114460729.6035755.1494287152942.JavaMail.zimbra@redhat.com>
References: <20170508211543.20681-1-lrichard@redhat.com> <20170508232509.j77fpn3ffof5tppd@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdEHXpy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 May 2017 19:45:54 -0400
In-Reply-To: <20170508232509.j77fpn3ffof5tppd@desk.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

> From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: linux-sparse@vger.kernel.org
> Sent: Monday, 8 May, 2017 7:25:10 PM
> Subject: Re: [PATCH v6] sparse: add support for _Static_assert
> 
> On Mon, May 08, 2017 at 05:15:43PM -0400, Lance Richardson wrote:
> > This patch introduces support for the C11 _Static_assert() construct.
> 
> For me, it's fine.
> I just have a small remarks (see below).
>  
> > @@ -1945,13 +1953,17 @@ static struct token *declaration_list(struct token
> > *token, struct symbol_list **
> >  static struct token *struct_declaration_list(struct token *token, struct
> >  symbol_list **list)
> >  {
> >  	while (!match_op(token, '}')) {
> > -		if (!match_op(token, ';'))
> > -			token = declaration_list(token, list);
> > -		if (!match_op(token, ';')) {
> > -			sparse_error(token->pos, "expected ; at end of declaration");
> > -			break;
> > +		if (match_ident(token, &_Static_assert_ident))
> > +			token = parse_static_assert(token, NULL);
> 
> I find it better with a 'continue' here
> 
> > +		else {
> 
> so, this 'else' become unneeded and there is no
> more needs to move the previous content of the loop
> (which help a lot when reviewing patches or when
> digging in the history).
> 
> -- Luc
> 

That does seem better. I'll wait a bit for any further feedback from
Chris and post a new spin.

Thanks,

   Lance
