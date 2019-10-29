From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: detecting misuse of of_get_property
Date: Tue, 29 Oct 2019 14:37:57 +0100
Message-ID: <20191029133756.qpqk5vf6txapqm35@ltop.local>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
 <20191029114750.a7inago2vd2o4lzl@ltop.local>
 <20191029125519.GA1705@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191029125519.GA1705@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Oct 29, 2019 at 03:55:19PM +0300, Dan Carpenter wrote:
> On Tue, Oct 29, 2019 at 12:47:50PM +0100, Luc Van Oostenryck wrote:
> > On Tue, Oct 29, 2019 at 01:50:58PM +0300, Dan Carpenter wrote:
> > > +static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
> > > +{
> > > +	struct expression *left = expr->left;
> > > +	struct symbol *type;
> > > +
> > > +	type = get_type(left);
> > > +	if (!type || type->type != SYM_PTR)
> > > +		return;
> > > +	type = get_base_type(type);
> > > +	if (type_bits(type) == 8)
> > > +		return;
> > > +	if (type->type == SYM_RESTRICT)
> > > +		return;
> > 
> > Wouldn't this also silently accept assignments to any bitwise
> > type: __le32, __be16, ... ? 
> 
> It does, yes.  I'm not sure how big of an issue that is...

Probably not much if it's just a one shot for Rasmus and
probably not much more otherwise.

> I always
> just throw a check together and test it before I decide if it's worth
> investing more time into it.

Sure, but I was thinking about false negatives here.

Regards,
-- Luc
