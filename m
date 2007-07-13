From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 7/8] rewrite type_difference()
Date: Fri, 13 Jul 2007 19:19:05 +0100
Message-ID: <20070713181904.GC21668@ftp.linux.org.uk>
References: <E1I9PCp-0000FJ-5s@ZenIV.linux.org.uk> <1184350603.2616.47.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44805 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760278AbXGMSTG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 14:19:06 -0400
Content-Disposition: inline
In-Reply-To: <1184350603.2616.47.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Jul 13, 2007 at 11:16:43AM -0700, Josh Triplett wrote:
> On Fri, 2007-07-13 at 18:45 +0100, Al Viro wrote:
> > --- a/evaluate.c
> > +++ b/evaluate.c
> > @@ -621,92 +621,145 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
> > 
> >  static void examine_fn_arguments(struct symbol *fn);
> > 
> > -const char * type_difference(struct symbol *target, struct symbol *source,
> > -	unsigned long target_mod_ignore, unsigned long source_mod_ignore)
> > +#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
> > +
> > +const char *type_difference(struct ctype *c1, struct ctype *c2,
> > +	unsigned long mod1, unsigned long mod2)
> [...]
> > --- a/symbol.h
> > +++ b/symbol.h
> > @@ -245,7 +245,7 @@ extern struct symbol_list *translation_unit_used_list;
> > 
> >  extern void access_symbol(struct symbol *);
> > 
> > -extern const char * type_difference(struct symbol *target, struct symbol *source,
> > +extern const char * type_difference(struct ctype *c1, struct ctype *c2,
> >  	unsigned long target_mod_ignore, unsigned long source_mod_ignore);
> 
> You didn't update the third and fourth arguments in this prototype.

Do you want their renaming as a followup patch or as a resend?  (Or just
rename them in the patch or upon commit - it won't clash with any later
changes).
